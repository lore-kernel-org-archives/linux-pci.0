Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:45812 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051Ab3LKKrl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 05:47:41 -0500
Message-ID: <52A842A7.1030605@st.com>
Date: Wed, 11 Dec 2013 16:17:03 +0530
From: Rajeev kumar <rajeev-dlh.kumar@st.com>
MIME-Version: 1.0
To: Mohit KUMAR <mohit.kumar@st.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>
Subject: Re: [PATCH 10/12] SPEAr13xx: defconfig: Update
References: <cover.1386752447.git.mohit.kumar@st.com> <3bc935718da3e0118c57ebee80c1363aac4a48a5.1386752447.git.mohit.kumar@st.com>
In-Reply-To: <3bc935718da3e0118c57ebee80c1363aac4a48a5.1386752447.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/11/2013 3:08 PM, Mohit KUMAR wrote:
> Enable EABI, OEABI, VFP and NFS configs in default configuration file for
> SPEAr13xx.
>
> Enable PCIe support for SPEAr13xx.
>
> Signed-off-by: Pratyush Anand<pratyush.anand@st.com>
> Signed-off-by: Mohit Kumar<mohit.kumar@st.com>
> Cc: Mohit Kumar<mohit.kumar@st.com>
> Cc: Viresh Kumar<viresh.linux@gmail.com>
> Cc: spear-devel@list.st.com
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm/configs/spear13xx_defconfig |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
> index 82eaa55..83882c0 100644
> --- a/arch/arm/configs/spear13xx_defconfig
> +++ b/arch/arm/configs/spear13xx_defconfig
> @@ -11,13 +11,24 @@ CONFIG_ARCH_SPEAR13XX=y
>   CONFIG_MACH_SPEAR1310=y
>   CONFIG_MACH_SPEAR1340=y
>   # CONFIG_SWP_EMULATE is not set
> +CONFIG_PCI_MSI=y
> +CONFIG_PCIE_SPEAR13XX=y
>   CONFIG_SMP=y
>   # CONFIG_SMP_ON_UP is not set
>   # CONFIG_ARM_CPU_TOPOLOGY is not set
> +CONFIG_AEABI=y
> +CONFIG_OABI_COMPAT=y
>   CONFIG_ARM_APPENDED_DTB=y
>   CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_VFP=y
>   CONFIG_BINFMT_MISC=y
>   CONFIG_NET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +CONFIG_NET_IPIP=y
>   CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>   CONFIG_MTD=y
>   CONFIG_MTD_OF_PARTS=y
> @@ -27,6 +38,7 @@ CONFIG_MTD_NAND=y
>   CONFIG_MTD_NAND_FSMC=y
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_SIZE=16384
> +CONFIG_BLK_DEV_SD=y
>   CONFIG_ATA=y
>   # CONFIG_SATA_PMP is not set
>   CONFIG_SATA_AHCI_PLATFORM=y
> @@ -66,6 +78,7 @@ CONFIG_USB=y
>   # CONFIG_USB_DEVICE_CLASS is not set
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_STORAGE=y
>   CONFIG_MMC=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SPEAR=y
> @@ -84,6 +97,8 @@ CONFIG_VFAT_FS=m
>   CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
>   CONFIG_TMPFS=y
>   CONFIG_JFFS2_FS=y
> +CONFIG_NFS_FS=y
> +CONFIG_ROOT_NFS=y

Its better to enable CONFIG_FUSE_FS also in case you want to work with 
fully functional NFS in userspace.

~Rajeev

>   CONFIG_NLS_DEFAULT="utf8"
>   CONFIG_NLS_CODEPAGE_437=y
>   CONFIG_NLS_ASCII=m

