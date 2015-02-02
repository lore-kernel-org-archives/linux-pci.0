Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41992 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbbBBDhy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 1 Feb 2015 22:37:54 -0500
Message-ID: <1422848269.2491.19.camel@zim.stowe>
Subject: Re: [PATCH] PCI: Add NEC ftServer variants to PCIe DMI check
From: Myron Stowe <mstowe@redhat.com>
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	"'stable@vger.kernel.org'" <stable@vger.kernel.org>,
	"Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	"'myron.stowe@redhat.com'" <myron.stowe@redhat.com>
Date: Sun, 01 Feb 2015 20:37:49 -0700
In-Reply-To: <48F2A65D5838B34AA5C81AB195ED2D5F932489A2@EXHQ1.corp.stratus.com>
References: <48F2A65D5838B34AA5C81AB195ED2D5F932489A2@EXHQ1.corp.stratus.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-01-30 at 19:45 +0000, Richardson, Charlotte wrote:
> Hi, Myron -
> 
> commit 1278998f8ff6 missed the NEC variants of the ftServers.
> We'll need this in RHEL7/6, but can you shepherd this patch upstream first?

Hi Charlotte:

Sure, looks like you've already done the work so I keep tabs on Bjorn's
bringing it in and then handle the back-ports to RHEL.

Please open RHEL BZs for both 6 and 7 if this has not already been done
and let me know what the BZ #s for each are so I can assign them to
myself (just send me the info to my redhat address, no need to pollute
the upstream lists with RHEL specifics).

Myron
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


