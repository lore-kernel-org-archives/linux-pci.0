Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7927C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 00:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8022D21104
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 00:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLMGhSOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8022D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeK0LNK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeK0LNK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 06:13:10 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB1D2082F;
        Tue, 27 Nov 2018 00:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543277833;
        bh=qUjGnhia/ScEkmW99Y36vDUldkas3w8K/KmuAwZl3+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLMGhSOIQs8mylj9sKRKnB1giXbjVanFj4DpCbdGRlv3y23gdhh+O0zq59I+9MlXs
         oBR1q93+6q6VOdhq838fQj7if88s+MKzQX1x7VMAYBLeASLxcpdw/ZQ9Lxx1MpUpld
         MdvF3qtIZ+hd47za2f59/f5ddDLcx0zY9dMfgolw=
Date:   Mon, 26 Nov 2018 18:17:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Message-ID: <20181127001711.GC212532@google.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126111526.56340-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

On Mon, Nov 26, 2018 at 02:15:23PM +0300, Mika Westerberg wrote:
> Recent systems with Thunderbolt ports may support IOMMU natively.

This sentence doesn't make sense to me.  There's no logical connection
between having an IOMMU and having a Thunderbolt port.

> This means that the platform utilizes IOMMU to prevent DMA attacks
> over externally exposed PCIe root ports (typically Thunderbolt
> ports)

Nor this one.  The platform only uses the IOMMU to prevent DMA attacks
if the OS chooses to do that.

> The system BIOS marks these PCIe root ports as being externally facing
> ports by implementing following ACPI _DSD [1] under the root port in
> question:

There's no standard that requires this, so the best we can say is that
a system BIOS *may* mark externally facing ports with this mechanism.

I think it would make sense to say something like:

  A malicious PCI device may use DMA to attack the system.  An
  external Thunderbolt port is a convenient point to attach such a
  device.  The OS may use an IOMMU to defend against DMA attacks.

  Some BIOSes mark externally facing Root Ports with the this ACPI
  _DSD:

    ...

  If we find such a Root Port, mark it and all its children as
  "is_untrusted".  The rest of the OS may use this to prevent use of
  the device unless we have an IOMMU to prevent malicious DMA [I don't
  know your actual policy yet].

>   Name (_DSD, Package () {
>       ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
>       Package () {
>           Package () {"ExternalFacingPort", 1},
> 	  Package () {"UID", 0 }
>       }
>   })
> 
> To make it possible for IOMMU code to identify these devices, we look up
> for this property and mark all children devices (including the root port
> itself) with a new flag (->is_untrusted). This flag is meant to be used
> with all PCIe devices (not just Thunderbolt) that cannot be trusted in
> the same level than integrated devices and may need to put behind full
> IOMMU protection.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 18 ++++++++++++++++++
>  drivers/pci/probe.c     | 22 ++++++++++++++++++++++
>  include/linux/pci.h     |  8 ++++++++
>  4 files changed, 51 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8c7c4583b52d..4bdad32f62c8 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
>  	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
>  	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
>  		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> +	/* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> +	GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> +		  0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
>  };
>  
>  static const guid_t ads_guid =
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 921db6f80340..84233cf46fc2 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -789,6 +789,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +{
> +	u8 val;
> +
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +		return;
> +	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
> +		return;
> +
> +	/*
> +	 * These root ports expose PCIe (including DMA) outside of the
> +	 * system so make sure we treat them and everything behind as
> +	 * untrusted.
> +	 */
> +	dev->is_untrusted = val == 1;

Simpler to parse:

  if (val)
    dev->is_untrusted = 1;

> +}
> +
>  static void pci_acpi_setup(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -798,6 +815,7 @@ static void pci_acpi_setup(struct device *dev)
>  		return;
>  
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
> +	pci_acpi_set_untrusted(pci_dev);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
>  	if (!adev->wakeup.flags.valid)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5054a0..144623ae2e68 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1378,6 +1378,26 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	}
>  }
>  
> +static void set_pcie_untrusted(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
> +
> +	/*
> +	 * Walk up the device hierarchy and check for any upstream bridge
> +	 * that has is_untrusted set to true. In that case treat this one
> +	 * untrusted as well.
> +	 */
> +	parent = pci_upstream_bridge(dev);
> +	while (parent) {
> +		if (parent->is_untrusted) {
> +			dev->is_untrusted = true;
> +			break;
> +		}
> +
> +		parent = pci_upstream_bridge(parent);
> +	}

In what circumstance is this loop needed?  I expected this would be
sufficient:

  bridge = pci_upstream_bridge(dev);
  if (bridge && bridge->is_untrusted)
    dev->is_untrusted = true;

> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1638,6 +1658,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_untrusted(dev);
> +
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11c71c4ecf75..3fa73cc6cf68 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -396,6 +396,14 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	/*
> +	 * Devices marked being untrusted are the ones that can potentially
> +	 * execute DMA attacks and similar. They are typically connected
> +	 * through external ports such as Thunderbolt but not limited to
> +	 * that. When an IOMMU is enabled they should be getting full
> +	 * mappings to make sure they cannot access arbitrary memory.
> +	 */
> +	unsigned int	is_untrusted:1;

We have a mix of "is_X" and "X", but I think "untrusted" is sufficient
since "untrusted" is a perfectly good predicate all by itself, i.e.,

  if (dev->untrusted)

reads easily and makes good sense.

>  	unsigned int	__aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
> -- 
> 2.19.1
> 
