cmake_minimum_required(VERSION 3.10)
project(linux_driver)

set(LINUX_KERNEL_DIR /home/jwd/linux/imx6ull/linux_kernal/nxp_linux/linux-imx-rel_imx_4.1.15_2.1.0_ga_alientek)

include_directories(
    ${LINUX_KERNEL_DIR}/include
    ${LINUX_KERNEL_DIR}/arch/arm/include
    ${LINUX_KERNEL_DIR}/arch/arm/include/generated
)
