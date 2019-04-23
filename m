Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE677C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8779C218FC
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 21:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556055533;
	bh=zlxJ1tukSLQQU5TfXIRgzzp22Xini9DlTE0pPHr7nSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vVQPaqpSwVG5JksJREB9297AMyC5Xd0Tx5dGvc1KQsY/1Nv58gHExiGj6aI9OPug8
	 STzLbMeXj4qiR3tI/b0gkxTfKRvn+Q83hyYhWdpEQjCx7+ZdcNtM4127oEeAdlni1L
	 F4k/xEmm/ebdIPcTiSibK8HLcvqMqckSe5LZKfEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDWViw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfDWViw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 17:38:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB9F218D3;
        Tue, 23 Apr 2019 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556055531;
        bh=zlxJ1tukSLQQU5TfXIRgzzp22Xini9DlTE0pPHr7nSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7q1MNzV+F/cuT/gL7XlsHK++mDIH4Knj0eDf7+G0ojEsChC3ukNtk7QOkrO/EB4k
         TKgrDnoMHEqLL7VwyvhSYtBdsJAZfBGFQS9pGH5HyVv0JHOnDIYq1BtgCddjfJecg/
         z/NZicr8Z0eoc1COkubZzxws3g5uFcV0zlBx7wrI=
Date:   Tue, 23 Apr 2019 16:38:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] PCI/ACPI: Advertise HPX type 3 support via _OSC
Message-ID: <20190423213850.GG14616@google.com>
References: <20190307213834.5914-1-mr.nuke.me@gmail.com>
 <20190315192947.13807-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315192947.13807-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 15, 2019 at 02:29:40PM -0500, Alexandru Gagniuc wrote:
> _OSC now has a way to inform firmware that OS has the capability to
> interpret HPX type 3 tables. Since ACPI 6.3 deprecated _OSC specifics,
> these are now part of the PCI Firmware Specification.
> 
> The following is the document describing the changes:
> ECN:	_HPX and PCIe Completion Timeout related _OSC Enhancements
> Date:	September 12, 2018
> Affected Document: PCI Firmware Specification, Rev. 3.2
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to pci/hotplug for v5.2, thanks!

> ---
> 
> This patch is designed to go on top of the following series
> "PCI: ACPI: Implement support for _HPX Type 3 tables"
> 	https://lkml.org/lkml/2019/3/7/790
> 
> Although the patch can technically be applied independently, it
> doesn't make sense without the rest of the series.
> 
> The HPX3 capability bit, to my understanding, is designed to be
> informational. i.e. Setting or not setting it would not affect whether
> firmware would export HPX3 tables. It may have implications in FFS
> systems, where FW might need to make sure things like the completion
> timeout value is set correctly throughout the tree.
> 
> My understanding is that firmware will prefer to set these with HPX3,
> in lieu of firing up SMM on hotplug and other events. Firmware can use
> the HPX3 support bit to know how to proceed.
> 
>  drivers/acpi/pci_root.c | 2 ++
>  include/linux/acpi.h    | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 707aafc7c2aa..0bee23893297 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -145,6 +145,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
>  	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
>  	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
>  	{ OSC_PCI_MSI_SUPPORT, "MSI" },
> +	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-type3" },
>  };
>  
>  static struct pci_osc_bit_struct pci_osc_control_bit[] = {
> @@ -446,6 +447,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  	 * PCI domains, so we indicate this in _OSC support capabilities.
>  	 */
>  	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
> +	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
>  	if (pci_ext_cfg_avail())
>  		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
>  	if (pcie_aspm_support_enabled())
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 87715f20b69a..028c138b9082 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -508,7 +508,8 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
>  #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
>  #define OSC_PCI_MSI_SUPPORT			0x00000010
> -#define OSC_PCI_SUPPORT_MASKS			0x0000001f
> +#define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
> +#define OSC_PCI_SUPPORT_MASKS			0x0000011f
>  
>  /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
>  #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
> -- 
> 2.19.2
> 
