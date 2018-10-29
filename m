Return-Path: <SRS0=pUIZ=NJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DADC0044C
	for <linux-pci@archiver.kernel.org>; Mon, 29 Oct 2018 21:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D420827
	for <linux-pci@archiver.kernel.org>; Mon, 29 Oct 2018 21:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb6mz380"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8D420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeJ3F5S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeJ3F5S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Oct 2018 01:57:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE8220657;
        Mon, 29 Oct 2018 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540847213;
        bh=opvLBWY5/RA0bH+ET5kTMklUGuaRZf7d4eGqIjnY544=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xb6mz380sQa7Sli0mBdiVIfK7nk0tN9tcPmjQoZY/c98TgQ35WydBIFyMDSp5iH3e
         3J3i4xo4wYjqQEkdcaZbgyh4xpk8WF0Fs23aVHM38RwdKT+Y/z2P44ZepgD0VmKGGU
         lKUyIf6IZebTVxfiGlvwBzd4P6cX5IOx+oQ2qupE=
Date:   Mon, 29 Oct 2018 16:06:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Message-ID: <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Len, Tony, Borislav, Tyler, Christoph, linux-acpi, LKML]

On Fri, Oct 26, 2018 at 02:19:04PM -0600, Jon Derrick wrote:
> Add a bit in pci_host_bridge to indicate to leave the System Error
> Interrupts as configured by the pre-boot environment. Propagate this to
> the AER driver which disables System Error Interrupts.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 7 +++++--
>  include/linux/pci.h    | 3 +++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 83180ed..6a4af63 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,6 +1360,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>  static void aer_enable_rootport(struct aer_rpc *rpc)
>  {
>  	struct pci_dev *pdev = rpc->rpd;
> +	struct pci_host_bridge *host;
>  	int aer_pos;
>  	u16 reg16;
>  	u32 reg32;
> @@ -1369,8 +1370,10 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
>  
>  	/* Disable system error generation in response to error messages */
> -	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> -				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
> +	host = pci_find_host_bridge(pdev->bus);
> +	if (!host->no_disable_sys_err)
> +		pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> +					   SYSTEM_ERROR_INTR_ON_MESG_MASK);

If I squint hard enough this sort of makes sense, but it also makes me
confused about the normal APEI firmware-first model works.

In the NON-firmare-first case, firmware isn't involved in handling AER
errors.  The Linux AER driver fields an interrupt from a Root Port,
reads AER log registers, etc.

In the normal APEI firmware-first case, when the hardware reports an
AER event, I think firmware gets control first, and *it* reads the AER
log registers, packages them up, and generates an interrupt to the OS,
which reads the packaged error state from the firmware via the HEST.

If I understand this special Intel VMD firmware-first case correctly,
firmware gets control first, reads the AER log registers, and
synthesizes what looks to the OS like a normal AER interrupt.  The
Linux AER driver gets what it thinks is an interrupt from a Root Port,
and it reads AER log registers from the hardware just like it does in
the NON-firmware-first case.

My confusion is about how we manage the mechanism by which the
firmware gets control first.  In the Intel VMD case, it looks like
firmware fields the System Errors controlled by the Root Control
register of Root Ports.  This patch adds some framework so we know not
to touch something set up by firmware.

But in the normal APEI firmware-first case, we disable those System
Errors in the Root Control registers, so firmware must get control
some other way.

How does the OS know what mechanism the firmware uses, so it can make
sure to preserve it?  This patch might be part of the solution, but it
seems pretty ad hoc, and of course it does nothing for the APEI
firmware-first case.  How does firmware get control in that case?

>  	aer_pos = pdev->aer_cap;
>  	/* Clear error status */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6925828..6fcfab4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -484,6 +484,9 @@ struct pci_host_bridge {
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
> +	unsigned int	no_disable_sys_err:1;	/* Don't disable system
> +						   error interrupts */
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 1.8.3.1
> 
