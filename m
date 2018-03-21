Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753777AbeCUVhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 17:37:23 -0400
Date: Wed, 21 Mar 2018 16:37:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jay Fang <f.fangjian@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Support PCIe 4.0 data rate(16.0 GT/s)
Message-ID: <20180321213721.GG38649@bhelgaas-glaptop.roam.corp.google.com>
References: <1520846012-8294-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520846012-8294-1-git-send-email-f.fangjian@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 05:13:32PM +0800, Jay Fang wrote:
> PCIe 4.0 provides an effective 16.0 GT/second/lane/direction of raw
> bandwidth. Current PCI driver does not support this new feature.
> For example, when you read a PCIe 4.0 EP's link data rate by sysfs, it
> will return "Unknown speed", not the expected "16.0 GT/s".
> 
> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> Reviewed-by: Dongdong Liu <liudongdong3@huawei.com>

Applied to pci/enumeration for v4.17, thanks!

> ---
>  drivers/pci/pci-sysfs.c       | 6 ++++++
>  drivers/pci/probe.c           | 2 +-
>  drivers/pci/slot.c            | 1 +
>  include/linux/pci.h           | 1 +
>  include/uapi/linux/pci_regs.h | 2 ++
>  5 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index eb6bee8..7dc5be5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -168,6 +168,9 @@ static ssize_t max_link_speed_show(struct device *dev,
>  		return -EINVAL;
>  
>  	switch (linkcap & PCI_EXP_LNKCAP_SLS) {
> +	case PCI_EXP_LNKCAP_SLS_16_0GB:
> +		speed = "16 GT/s";
> +		break;
>  	case PCI_EXP_LNKCAP_SLS_8_0GB:
>  		speed = "8 GT/s";
>  		break;
> @@ -213,6 +216,9 @@ static ssize_t current_link_speed_show(struct device *dev,
>  		return -EINVAL;
>  
>  	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
> +	case PCI_EXP_LNKSTA_CLS_16_0GB:
> +		speed = "16 GT/s";
> +		break;
>  	case PCI_EXP_LNKSTA_CLS_8_0GB:
>  		speed = "8 GT/s";
>  		break;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef53774..86bf045 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -592,7 +592,7 @@ const unsigned char pcie_link_speed[] = {
>  	PCIE_SPEED_2_5GT,		/* 1 */
>  	PCIE_SPEED_5_0GT,		/* 2 */
>  	PCIE_SPEED_8_0GT,		/* 3 */
> -	PCI_SPEED_UNKNOWN,		/* 4 */
> +	PCIE_SPEED_16_0GT,		/* 4 */
>  	PCI_SPEED_UNKNOWN,		/* 5 */
>  	PCI_SPEED_UNKNOWN,		/* 6 */
>  	PCI_SPEED_UNKNOWN,		/* 7 */
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index d10f556..191893e 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -76,6 +76,7 @@ static const char *pci_bus_speed_strings[] = {
>  	"2.5 GT/s PCIe",	/* 0x14 */
>  	"5.0 GT/s PCIe",	/* 0x15 */
>  	"8.0 GT/s PCIe",	/* 0x16 */
> +	"16.0 GT/s PCIe",	/* 0x17 */
>  };
>  
>  static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5adabe2..44ce439 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -259,6 +259,7 @@ enum pci_bus_speed {
>  	PCIE_SPEED_2_5GT		= 0x14,
>  	PCIE_SPEED_5_0GT		= 0x15,
>  	PCIE_SPEED_8_0GT		= 0x16,
> +	PCIE_SPEED_16_0GT		= 0x17,
>  	PCI_SPEED_UNKNOWN		= 0xff,
>  };
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 0c79eac..c1c4109 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -520,6 +520,7 @@
>  #define  PCI_EXP_LNKCAP_SLS_2_5GB 0x00000001 /* LNKCAP2 SLS Vector bit 0 */
>  #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
>  #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
> +#define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
> @@ -547,6 +548,7 @@
>  #define  PCI_EXP_LNKSTA_CLS_2_5GB 0x0001 /* Current Link Speed 2.5GT/s */
>  #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
>  #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
> +#define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
>  #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
>  #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
>  #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
> -- 
> 2.7.4
> 
