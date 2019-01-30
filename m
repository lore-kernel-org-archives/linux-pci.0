Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC4C282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB67218AF
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548889077;
	bh=dljX2IjZ2AopFQu0FcO5DQYp4hbyd6lVs1kdmPB31mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uDv4vT9FPmiC3ldoWq69/ff2q384CLO7vMGnf+QWdSCEA17h/DfFBiV0cX9D6SmCO
	 Gr1XFMhASsuAJR2eOC6UiHiE3SiJtC74qOLkCU2t1Viw4OyDKWTu0N4tOZXeci9ovN
	 kRm3Eng1t2vaEsgPzVV0Iwx+0Td/mRDm10FUObiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfA3W54 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfA3W54 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 17:57:56 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB622084C;
        Wed, 30 Jan 2019 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548889075;
        bh=dljX2IjZ2AopFQu0FcO5DQYp4hbyd6lVs1kdmPB31mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/dVAsH9q4Q1h13i0M9uEoaidmTQCkkC64MINH6nUQMMSYlHLNT8nB30S0G4tVEDe
         nQBsSMaO3xsJFtWPYa7XJpn7lmw78ckWcgBRBneV21VbJbVIEDU7NQvN0EXznScRx6
         8SH0Q52t1XoNK8iKEzAKtOJxE128mLbvKl1ocWKc=
Date:   Wed, 30 Jan 2019 16:57:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI/ACPI: Improve _OSC control request granularity
Message-ID: <20190130225752.GL229773@google.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-3-git-send-email-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540483292-24049-3-git-send-email-asierra@xes-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 25, 2018 at 11:01:32AM -0500, Aaron Sierra wrote:
> This patch reorganizes negotiate_os_control() to be less ASPM-centric in
> order to:
> 
>     1. allow other features (notably AER) to work without enabling ASPM
>     2. better isolate feature-specific tests for readability/maintenance

I really like this idea; thanks for working it up!

> Each feature (ASPM, PCIe hotplug, SHPC hotplug, and AER) now has its own
> inline function for setting its _OSC control requests.
> 
> Part of making this function more generic, required eliminating a test
> for overall success/failure that previously caused two different types
> of messages to be printed. Now, printed messages are streamlined to
> always show requested _OSC control versus what was granted.
> 
> Previous output (success):
> 
>   acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
> 
> Previous output (failure):
> 
>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>   acpi PNP0A08:00: _OSC: platform willing to grant []
> 
> Now:
> 
>   acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
>   acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/acpi/pci_root.c | 118 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 85 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index eb9f14e..9685aba 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -53,9 +53,10 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  }
>  
>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> -				| OSC_PCI_ASPM_SUPPORT \
> -				| OSC_PCI_CLOCK_PM_SUPPORT \
>  				| OSC_PCI_MSI_SUPPORT)
> +#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
> +				| OSC_PCI_ASPM_SUPPORT \
> +				| OSC_PCI_CLOCK_PM_SUPPORT)
>  
>  static const struct acpi_device_id root_device_ids[] = {
>  	{"PNP0A03", 0},
> @@ -421,6 +422,72 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> +static inline bool __osc_have_support(u32 support, u32 required)
> +{
> +	return ((support & required) == required);
> +}

I'm not really a fan of function names with leading underscores, except
maybe for "raw" things that don't acquire locks.

> +static inline int __osc_set_aspm_control(struct acpi_pci_root *root,
> +					 u32 support, u32 *control)
> +{
> +	if (!IS_ENABLED(CONFIG_PCIEASPM) ||
> +	    !__osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT))
> +		return -ENODEV;
> +
> +	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +		    OSC_PCI_EXPRESS_LTR_CONTROL |
> +		    OSC_PCI_EXPRESS_PME_CONTROL;

I think this would be more readable if we could avoid the double
negatives, e.g.,

  if (IS_ENABLED(CONFIG_PCIEASPM) &&
      __osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT)) {
          *control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
                      OSC_PCI_EXPRESS_LTR_CONTROL |
                      OSC_PCI_EXPRESS_PME_CONTROL;
          return 0;
  }

  return -ENODEV;

Since the caller ignores the return values anyway, I wonder if this
could also work by *returning* the new mask bits instead of using
"control" as a reference parameter, e.g.,

  if (IS_ENABLED(...))
    return OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
           OSC_PCI_EXPRESS_LTR_CONTROL |
           OSC_PCI_EXPRESS_PME_CONTROL;

  return 0;

Then the calls would look like:

  control |= __osc_set_pciehp_control(root, support);
  control |= __osc_set_shpchp_control(root, support);
  ...

> +	return 0;
> +}
> +
> +static inline bool __osc_have_aspm_control(u32 control)
> +{
> +	u32 required = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +		       OSC_PCI_EXPRESS_LTR_CONTROL |
> +		       OSC_PCI_EXPRESS_PME_CONTROL;
> +
> +	return __osc_have_support(control, required);
> +}
> +
> +static inline void __osc_set_pciehp_control(struct acpi_pci_root *root,
> +					    u32 support, u32 *control)
> +{
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) ||
> +	    !__osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
> +		return;
> +
> +	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +		    OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +}
> +
> +static inline void __osc_set_shpchp_control(struct acpi_pci_root *root,
> +					    u32 support, u32 *control)
> +{
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC) ||
> +	    !__osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
> +		return;
> +
> +	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +		    OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +}
> +
> +static inline void __osc_set_aer_control(struct acpi_pci_root *root,
> +					 u32 support, u32 *control)
> +{
> +	if (!pci_aer_available() ||
> +	    !__osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
> +		return;
> +
> +	if (aer_acpi_firmware_first()) {
> +		dev_info(&root->device->dev, "PCIe AER handled by firmware\n");
> +		return;
> +	}
> +
> +	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
> +		    OSC_PCI_EXPRESS_AER_CONTROL;
> +}
> +
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  				 bool is_pcie)
>  {
> @@ -474,37 +541,25 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		return;
>  	}
>  
> -	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> -		decode_osc_support(root, "not requesting OS control; OS requires",
> -				   ACPI_PCIE_REQ_SUPPORT);
> -		return;
> -	}
> -
> -	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -		| OSC_PCI_EXPRESS_PME_CONTROL;
> -
> -	if (IS_ENABLED(CONFIG_PCIEASPM))
> -		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> -
> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +	control = 0;
> +	if (__osc_set_aspm_control(root, support, &control))
> +		*no_aspm = 1;
>  
> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> -		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +	__osc_set_pciehp_control(root, support, &control);
> +	__osc_set_shpchp_control(root, support, &control);
> +	__osc_set_aer_control(root, support, &control);
>  
> -	if (pci_aer_available()) {
> -		if (aer_acpi_firmware_first())
> -			dev_info(&device->dev,
> -				 "PCIe AER handled by firmware\n");
> -		else
> -			control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +	if (!control) {
> +		dev_info(&device->dev, "_OSC: not requesting OS control\n");
> +		return;
>  	}
>  
>  	requested = control;
> -	status = acpi_pci_osc_control_set(handle, &control,
> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> -	if (ACPI_SUCCESS(status)) {
> -		decode_osc_control(root, "OS now controls", control);
> +	acpi_pci_osc_control_set(handle, &control, 0);
> +	decode_osc_control(root, "OS requested", requested);
> +	decode_osc_control(root, "platform granted", control);
> +
> +	if (__osc_have_aspm_control(control)) {
>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>  			/*
>  			 * We have ASPM control, but the FADT indicates that
> @@ -514,11 +569,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
>  			*no_aspm = 1;
>  		}
> -	} else {
> -		decode_osc_control(root, "OS requested", requested);
> -		decode_osc_control(root, "platform willing to grant", control);
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> -			acpi_format_exception(status));
> +	} else if (!*no_aspm) {
> +		dev_info(&device->dev, "_OSC failed; disabling ASPM\n");
>  
>  		/*
>  		 * We want to disable ASPM here, but aspm_disabled
> -- 
> 2.7.4
> 
