Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p01c12o144.mxlogic.net ([208.65.145.67]:47137 "EHLO
	p01c12o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbBBPix convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 10:38:53 -0500
From: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
To: "'Bjorn Helgaas'" <bhelgaas@google.com>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	"'stable@vger.kernel.org'" <stable@vger.kernel.org>,
	"Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	"'myron.stowe@redhat.com'" <myron.stowe@redhat.com>
Subject: RE: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check
Date: Mon, 2 Feb 2015 15:38:12 +0000
Message-ID: <48F2A65D5838B34AA5C81AB195ED2D5F93248CB9@EXHQ1.corp.stratus.com>
References: <48F2A65D5838B34AA5C81AB195ED2D5F932489A2@EXHQ1.corp.stratus.com>
 <20150202153727.GA5176@google.com>
In-Reply-To: <20150202153727.GA5176@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks!

-----Original Message-----
From: Bjorn Helgaas [mailto:bhelgaas@google.com] 
Sent: Monday, February 02, 2015 10:37 AM
To: Richardson, Charlotte
Cc: 'linux-pci@vger.kernel.org'; 'stable@vger.kernel.org'; Lawrence, Joe; 'myron.stowe@redhat.com'
Subject: Re: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check

On Fri, Jan 30, 2015 at 07:45:02PM +0000, Richardson, Charlotte wrote:
> Hi, Myron -
> 
> commit 1278998f8ff6 missed the NEC variants of the ftServers.
> We'll need this in RHEL7/6, but can you shepherd this patch upstream first?
> Thanks!
> 
> /Charlotte
> 
> -->8--
> 
> From 64a19253432e87b2293d3b8ee323e8b8ac63395d Mon Sep 17 00:00:00 2001
> From: Charlotte Richardson <charlotte.richardson@stratus.com>
> Date: Fri, 30 Jan 2015 12:58:31 -0500
> Subject: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check.
> 
> NEC OEMs the same platforms as Stratus does, which have multiple 
> devices on some PCIe buses under downstream ports.
> 
> Signed-off-by: Charlotte Richardson <charlotte.richardson@stratus.com>
> Fixes: 1278998f8ff6 ("PCI: Work around Stratus ftServer broken PCIe 
> hierarchy (fix DMI check)")
> Cc: <stable@vger.kernel.org>
> Cc: Myron Stowe <myron.stowe@redhat.com>

Applied to for-linus for v3.19, thanks!

> ---
>  arch/x86/pci/common.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c index 
> 7b20bcc..2fb3847 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -448,6 +448,22 @@ static const struct dmi_system_id pciprobe_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ftServer"),
>  		},
>  	},
> +        {
> +                .callback = set_scan_all,
> +                .ident = "Stratus/NEC ftServer",
> +                .matches = {
> +                        DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> +                        DMI_MATCH(DMI_PRODUCT_NAME, "Express5800/R32"),
> +                },
> +        },
> +        {
> +                .callback = set_scan_all,
> +                .ident = "Stratus/NEC ftServer",
> +                .matches = {
> +                        DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> +                        DMI_MATCH(DMI_PRODUCT_NAME, "Express5800/R31"),
> +                },
> +        },
>  	{}
>  };
>  
> --
> 1.8.3.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
