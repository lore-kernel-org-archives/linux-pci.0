Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:45604 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbbBBPhe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 10:37:34 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so17044964obc.11
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 07:37:34 -0800 (PST)
Date: Mon, 2 Feb 2015 09:37:27 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	"'stable@vger.kernel.org'" <stable@vger.kernel.org>,
	"Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	"'myron.stowe@redhat.com'" <myron.stowe@redhat.com>
Subject: Re: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check
Message-ID: <20150202153727.GA5176@google.com>
References: <48F2A65D5838B34AA5C81AB195ED2D5F932489A2@EXHQ1.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48F2A65D5838B34AA5C81AB195ED2D5F932489A2@EXHQ1.corp.stratus.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
> Fixes: 1278998f8ff6 ("PCI: Work around Stratus ftServer broken PCIe hierarchy (fix DMI check)")
> Cc: <stable@vger.kernel.org>
> Cc: Myron Stowe <myron.stowe@redhat.com>

Applied to for-linus for v3.19, thanks!

> ---
>  arch/x86/pci/common.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 7b20bcc..2fb3847 100644
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
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
