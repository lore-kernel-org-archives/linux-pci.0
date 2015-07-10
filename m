Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50830 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbGJMl6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jul 2015 08:41:58 -0400
Message-ID: <559FBD91.9070803@arm.com>
Date: Fri, 10 Jul 2015 13:41:53 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Alexander Gordeev <agordeev@redhat.com>
CC: Tony Luck <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC Patch V1 11/12] genirq, PCI: Reorginize struct msi_desc
 to prepare for support of generic MSI
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com> <1436428847-8886-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-12-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gerry,

On 09/07/15 09:00, Jiang Liu wrote:
> Reorganize struct msi_desc so it could be reused by other MSI drivers.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  include/linux/msi.h |   41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 5f77e231f515..f6845bc83774 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -19,29 +19,30 @@ void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
>  
>  struct msi_desc {
> -	struct {
> -		__u8	is_msix	: 1;
> -		__u8	multiple: 3;	/* log2 num of messages allocated */
> -		__u8	multi_cap : 3;	/* log2 num of messages supported */
> -		__u8	maskbit	: 1;	/* mask-pending bit supported ? */
> -		__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit */
> -		__u16	entry_nr;	/* specific enabled entry */
> -		unsigned default_irq;	/* default pre-assigned irq */
> -	} msi_attrib;
> -
> -	u32 masked;			/* mask bits */
> -	unsigned int irq;
> -	unsigned int nvec_used;		/* number of messages */
> -	struct list_head list;
> +	struct list_head		list;
> +	unsigned int			irq;
> +	unsigned int			nvec_used;	/* number of messages */
> +	struct device *			dev;
> +	struct msi_msg			msg;		/* Last set MSI message */
>  
>  	union {
> -		void __iomem *mask_base;
> -		u8 mask_pos;
> +		struct {				/* For PCI MSI/MSI-X */
> +			u32 masked;			/* mask bits */
> +			struct {
> +				__u8	is_msix	: 1;
> +				__u8	multiple: 3;	/* log2 num of messages allocated */
> +				__u8	multi_cap : 3;	/* log2 num of messages supported */
> +				__u8	maskbit	: 1;	/* mask-pending bit supported ? */
> +				__u8	is_64	: 1;	/* Address size: 0=32bit 1=64bit */
> +				__u16	entry_nr;	/* specific enabled entry */
> +				unsigned default_irq;	/* default pre-assigned irq */
> +			} msi_attrib;
> +			union {
> +				u8	mask_pos;
> +				void __iomem *mask_base;
> +			};
> +		};

Is this union the location where you would expect some non-PCI MSI
infrastructure to store their own data? If that's the case, maybe a
small comment to that effect would be good, as it is not completely
obvious from looking at the data structure.

>  	};
> -	struct device *dev;
> -
> -	/* Last set MSI message */
> -	struct msi_msg msg;
>  };
>  
>  /* Helpers to hide struct msi_desc implementation details */
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
