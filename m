Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85466C4151A
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3335220863
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 22:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548888833;
	bh=NzuS+MG33DEOM10pKtwDtAgfBO5NRSbCeEq9QzMpiqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTT/S1vuZpl9AE4Grgq7JHLFrG3mZfM9nlSYWfrVwo4mCFHdAO9TglHB8Dh3IvPGw
	 PJvNlt7IEpbdzTvmLNr8XXckEWlU3pBM0+6ZH48oIOI8Jbc72rctyswhhaL3eB00AL
	 ogiBXEIADUi+KvawsvE5bZm/MS8G/nw5sRvMGs2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfA3Wxw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:53:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfA3Wxw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jan 2019 17:53:52 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9B4218AF;
        Wed, 30 Jan 2019 22:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548888258;
        bh=NzuS+MG33DEOM10pKtwDtAgfBO5NRSbCeEq9QzMpiqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zadjk9nreaRVcVtlcrY6ptc/lB9ibHvuqJQio2J6vm8v3aEZJlFDa8rklqmuUTYdm
         ZvRHOblVWPMYDRDPFpjyD9M3CxoHg+Q3mhfdEKobPNGlhFijXezZ8b1k6R2HBp+wkx
         RX5elDjHRgkwU8JfH3nHaTbJIEUIHNu32s/724zY=
Date:   Wed, 30 Jan 2019 16:44:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/ACPI: Move _OSC test for native services to
 top
Message-ID: <20190130224415.GK229773@google.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-2-git-send-email-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540483292-24049-2-git-send-email-asierra@xes-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Aaron,

On Thu, Oct 25, 2018 at 11:01:31AM -0500, Aaron Sierra wrote:
> Move the simple test for when PCIe native services are disabled
> closer to the top, prior to where things get more complicated.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/acpi/pci_root.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 707aafc..eb9f14e 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -441,6 +441,12 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		return;
>  	}
>  
> +	if (pcie_ports_disabled) {
> +		dev_info(&device->dev,
> +			 "PCIe port services disabled; not requesting _OSC control\n");
> +		return;
> +	}

Today we always set "*no_aspm = 1" if _OSC fails, which means we later
call pcie_no_aspm().

After this patch, when pcie_ports_disabled is "true", we don't even try to
evaluate _OSC, and we will never set *no_aspm, so we will never call
pcie_no_aspm() when pcie_ports_disabled is "true", which happens in these
cases:

  1) CONFIG_PCIEPORTBUS is unset, or
  2) CONFIG_PCIEPORTBUS=y and we booted with "pcie_ports=compat"

Case 1) isn't a problem because pcie_no_aspm() is only implemented when
CONFIG_PCIEASPM=y, and CONFIG_PCIEASPM depends on CONFIG_PCIEPORTBUS, so in
this case today we only call the empty stub pcie_no_aspm() function.

But case 2) is a behavior change that seems unintended.

Even though CONFIG_PCIEASPM depends on CONFIG_PCIEPORTBUS, ASPM doesn't
actually *use* anything provided by PCIEPORTBUS, so I think the ASPM code
is still active and useful even when we boot with "pcie_ports=compat".

Whether CONFIG_PCIEASPM should depend on CONFIG_PCIEPORTBUS is another
question.  I tend to think maybe it should not, but that's an orthogonal
question.

>  	/*
>  	 * All supported architectures that use ACPI have support for
>  	 * PCI domains, so we indicate this in _OSC support capabilities.
> @@ -468,11 +474,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		return;
>  	}
>  
> -	if (pcie_ports_disabled) {
> -		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> -		return;
> -	}
> -
>  	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
>  		decode_osc_support(root, "not requesting OS control; OS requires",
>  				   ACPI_PCIE_REQ_SUPPORT);
> -- 
> 2.7.4
> 
