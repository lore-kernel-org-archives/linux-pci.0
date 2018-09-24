Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0031ECE560
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C6B20833
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 15:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C6B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeIXV12 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:27:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39680 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbeIXV11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 17:27:27 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5_tnEv_XDxvo; Mon, 24 Sep 2018 17:24:44 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC69500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:9500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A22731EC0118;
        Mon, 24 Sep 2018 17:24:44 +0200 (CEST)
Date:   Mon, 24 Sep 2018 17:24:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Message-ID: <20180924152448.GE20187@zn.tnic>
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 23, 2018 at 05:35:13PM +0800, Pu Wen wrote:
> As Hygon registered its PCI Vendor ID as a new one 0x1d94, and there
> are PCI Devices 0x1450/0x1463/0x1464 for Host bridge on Hygon Dhyana
> platform, so add Hygon Dhyana support to the PCI and north bridge
> subsystem by using the code path of AMD family 17h.
> 
> To prevent further checking PCI device ids which cannot happen both on
> Hygon and Intel platform, the function amd_gart_present should return
> if it's not a AMD CPU.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Reviewed-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/amd_nb.h |  3 +++
>  arch/x86/kernel/amd_nb.c      | 47 +++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c        |  6 ++++--
>  include/linux/pci_ids.h       |  2 ++
>  4 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index fddb6d2..1ae4e57 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -103,6 +103,9 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
>  
>  static inline bool amd_gart_present(void)
>  {
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		return false;
> +

What is that for?

Hygon doesn't have F15h so that function will return false there too...

... or is that because the qemu script you got from the 0day bot guys
uses -cpu kvm64 which is family 0xf:

[    0.214353] smpboot: CPU0: AMD Common KVM processor (family: 0xf, model: 0x6, stepping: 0x1)

?

and that makes amd_gart_present() say yes.

In that case, please make a *prepatch* which adds the vendor check to
both amd_gart_present() and early_is_amd_nb() and send it as a reply to
this message.

*Then*, do this patch ontop and also as a reply.

>  	/* GART present only on Fam15h, upto model 0fh */
>  	if (boot_cpu_data.x86 == 0xf || boot_cpu_data.x86 == 0x10 ||
>  	    (boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model < 0x10))
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index b481b95..dcc4130 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -61,6 +61,21 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{}
>  };
>  
> +static const struct pci_device_id hygon_root_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_ROOT) },
> +	{}
> +};
> +
> +const struct pci_device_id hygon_nb_misc_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
> +	{}
> +};
> +
> +static const struct pci_device_id hygon_nb_link_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F4) },
> +	{}
> +};
> +
>  const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
>  	{ 0x00, 0x18, 0x20 },
>  	{ 0xff, 0x00, 0x20 },
> @@ -197,12 +212,25 @@ int amd_cache_northbridges(void)
>  	u16 i = 0;
>  	struct amd_northbridge *nb;
>  	struct pci_dev *root, *misc, *link;
> +	const struct pci_device_id *root_ids = NULL;
> +	const struct pci_device_id *misc_ids = NULL;
> +	const struct pci_device_id *link_ids = NULL;
> +
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> +		root_ids = hygon_root_ids;
> +		misc_ids = hygon_nb_misc_ids;
> +		link_ids = hygon_nb_link_ids;
> +	} else {
> +		root_ids = amd_root_ids;
> +		misc_ids = amd_nb_misc_ids;
> +		link_ids = amd_nb_link_ids;
> +	}

Also, you can make this assignment differently:

	const struct pci_device_id *root_ids = amd_root_ids;
	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
	const struct pci_device_id *link_ids = amd_nb_link_ids;


	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
		root_ids = hygon_root_ids;
		misc_ids = hygon_nb_misc_ids;
		link_ids = hygon_nb_link_ids;
	}

This way the change is obvious and it is only for Hygon without
affecting the other vendors.

Ditto for the other assignment.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
