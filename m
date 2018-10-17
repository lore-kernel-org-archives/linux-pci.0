Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F53ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AEE214C2
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 14:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AEE214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJQWI5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:08:57 -0400
Received: from foss.arm.com ([217.140.101.70]:52432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeJQWI5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 18:08:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF9C80D;
        Wed, 17 Oct 2018 07:13:04 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95EFE3F59C;
        Wed, 17 Oct 2018 07:13:03 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:12:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 2/2] PCI/VMD: Set up firmware-first if capable
Message-ID: <20181017140733.GA6674@e107981-ln.cambridge.arm.com>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
 <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 06:48:08PM -0600, Jon Derrick wrote:
> The VMD endpoint device exposes a domain of root ports and any
> downstream devices attached to that hierarchy. VMD domains consisting of
> the root ports and downstream devices are not represented in the ACPI
> tables and _OSC is unsupported. Because of this non-standard way of
> signaling firmware-first enabling on the root ports, the VMD device
> instead advertises support for firmware-first on the root ports by
> setting its interface bit to 0x1.
> 
> When firmware-first is enabled on a VMD domain, the driver sets up the
> root port control registers to generate SMI system interrupts to
> firmware on errors. System firmware will handle the error as it sees
> fit, then passes back control to VMD with a synthesized MSI message.
> 
> Because of this kernel pass-back, the driver does not disable the native
> AER port service driver attached to the VMD root ports, allowing for
> further kernel error handling if desired.

This patch looks more like a policy to detect whether the generic
Root Port system error reporting should be enabled or not, or at
least may be generalized as such.

It is contained in the VMD driver - I would like to have Keith and Bjorn
opinions before merging it, see below.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 46ed80f..9625dca 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -589,6 +589,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	LIST_HEAD(resources);
>  	resource_size_t offset[2] = {0};
>  	resource_size_t membar2_offset = 0x2000, busn_start = 0;
> +	u8 interface;
>  
>  	/*
>  	 * Shadow registers may exist in certain VMD device ids which allow
> @@ -718,6 +719,35 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  	pci_rescan_bus(vmd->bus);
>  
> +	/*
> +	 * Certain VMD devices may request firmware-first error handling
> +	 * support on the domain. These domains are virtual and not described
> +	 * by ACPI and must be configured manually. VMD domains which utilize
> +	 * firmware-first may still require further kernel error handling, but
> +	 * the domain is intended to first interrupt upon error to system
> +	 * firmware before being passed back to the kernel. The system error
> +	 * handling bits in the root port control register must be enabled
> +	 * following the AER service driver configuration in order to generate
> +	 * these system interrupts.
> +	 *
> +	 * Because the root ports are not described by ACPI and _OSC is
> +	 * unsupported in VMD domains, the intent to use firmware-first error
> +	 * handling in the root ports is instead described by the VMD device's
> +	 * interface bit.
> +	 */
> +	pci_read_config_byte(vmd->dev, PCI_CLASS_PROG, &interface);
> +	if (interface == 0x1) {
> +		struct pci_dev *rpdev;
> +
> +		list_for_each_entry(rpdev, &vmd->bus->devices, bus_list) {
> +			if (rpdev->aer_cap)

This should be CONFIG_PCIEAER guarded but I would like to understand its
logic.

IIUC this assumes all devices in the root bus are root ports, which is
an VMD assumption I reckon.

> +				pcie_capability_set_word(rpdev, PCI_EXP_RTCTL,
> +							 PCI_EXP_RTCTL_SECEE  |
> +							 PCI_EXP_RTCTL_SENFEE |
> +							 PCI_EXP_RTCTL_SEFEE);

I wonder whether this code should be part of the generic AER layer (ie
the PCIE port driver) rather than VMD specific, after all that's part of
the generic specifications, I do not know if we can envisage an API that
allow PCI controller drivers to enable/disable system errors.

Thoughts ?

Lorenzo

> +		}
> +	}
> +
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>  	return 0;
> -- 
> 1.8.3.1
> 
