Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A6ECDE3B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 23:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CDB21470
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWDzInSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CDB21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeJRG7l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbeJRG7k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 02:59:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FFC620869;
        Wed, 17 Oct 2018 23:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539817304;
        bh=1TFrluOwtDsMkX2fl2WDmmxj/TBUtlQz4r7/xV43LS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWDzInSXI9GdfW9K3ArPORIq3tsV7NMgU7+3wl2pg2g65Dy1BDAuEmll2jqW5ddAC
         5QSvgS1nkLPunTKKqeT3cLT5/MPdbLFGoOhw/4TRuVWicPPkf2MshjCep1Ti96lrmy
         byli5uELGifMbE23BY5oOrJ1KeeUgNrOilMpSAzM=
Date:   Wed, 17 Oct 2018 18:01:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/2] PCI/VMD: Set up firmware-first if capable
Message-ID: <20181017230140.GI5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
 <1539650888-3792-3-git-send-email-jonathan.derrick@intel.com>
 <20181017140733.GA6674@e107981-ln.cambridge.arm.com>
 <1539800189.18190.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539800189.18190.10.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Jon, whatever you're using to respond is inserting line breaks in the
patch itself, which makes it really hard to read.  I often rewrap the
text so it fits in a reasonable line length, but that's a disaster for
the code parts.]

On Wed, Oct 17, 2018 at 06:16:34PM +0000, Derrick, Jonathan wrote:
> On Wed, 2018-10-17 at 15:12 +0100, Lorenzo Pieralisi wrote:
> > On Mon, Oct 15, 2018 at 06:48:08PM -0600, Jon Derrick wrote:
> > > The VMD endpoint device exposes a domain of root ports and any
> > > downstream devices attached to that hierarchy. VMD domains
> > > consisting of the root ports and downstream devices are not
> > > represented in the ACPI tables and _OSC is unsupported. Because
> > > of this non-standard way of signaling firmware-first enabling on
> > > the root ports, the VMD device instead advertises support for
> > > firmware-first on the root ports by setting its interface bit to
> > > 0x1.
> > > 
> > > When firmware-first is enabled on a VMD domain, the driver sets
> > > up the root port control registers to generate SMI system
> > > interrupts to firmware on errors. System firmware will handle
> > > the error as it sees fit, then passes back control to VMD with a
> > > synthesized MSI message.

Does this synthesized MSI look like an AER interrupt?  How does AER
work in this case?  If you're using the usual "firmware-first" model,
AER needs to get the error data from firmware via the ACPI APEI
framework, but I don't see anything here that tells the AER code to
use that instead of reading the AER registers directly.

Or maybe you're implementing something that's sort of *like* the ACPI
"firmware-first" model but without using any of that framework?  E.g.,
the VMD Root Port system errors cause SMIs, the firmware handles the
SMI, the OS regains control (knowing nothing of the SMI) and handles
what it thinks is a "normal" AER interrupt and reads and clears the
AER registers directly.

If you're doing something like the above, the changelog should
definitely outline that, because using "firmware-first" in this
special VMD-only way that is nothing like the ACPI usage is going to
cause confusion.

> > > Because of this kernel pass-back, the driver does not disable
> > > the native AER port service driver attached to the VMD root
> > > ports, allowing for further kernel error handling if desired.
> > 
> > This patch looks more like a policy to detect whether the generic
> > Root Port system error reporting should be enabled or not, or at
> > least may be generalized as such.  It is contained in the VMD
> > driver - I would like to have Keith and Bjorn opinions before
> > merging it, see below.
>
> It is inherently a policy decision by the BIOS.
> 
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c
> > > index 46ed80f..9625dca 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -589,6 +589,7 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features)
> > >  	LIST_HEAD(resources);
> > >  	resource_size_t offset[2] = {0};
> > >  	resource_size_t membar2_offset = 0x2000, busn_start = 0;
> > > +	u8 interface;
> > >  
> > >  	/*
> > >  	 * Shadow registers may exist in certain VMD device ids
> > > which allow
> > > @@ -718,6 +719,35 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features)
> > >  	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> > >  	pci_rescan_bus(vmd->bus);
> > >  
> > > +	/*
> > > +	 * Certain VMD devices may request firmware-first error
> > > handling
> > > +	 * support on the domain. These domains are virtual and
> > > not described
> > > +	 * by ACPI and must be configured manually. VMD domains
> > > which utilize
> > > +	 * firmware-first may still require further kernel error
> > > handling, but
> > > +	 * the domain is intended to first interrupt upon error to
> > > system
> > > +	 * firmware before being passed back to the kernel. The
> > > system error
> > > +	 * handling bits in the root port control register must be
> > > enabled
> > > +	 * following the AER service driver configuration in order
> > > to generate
> > > +	 * these system interrupts.
> > > +	 *
> > > +	 * Because the root ports are not described by ACPI and
> > > _OSC is
> > > +	 * unsupported in VMD domains, the intent to use firmware-
> > > first error
> > > +	 * handling in the root ports is instead described by the
> > > VMD device's
> > > +	 * interface bit.
> > > +	 */
> > > +	pci_read_config_byte(vmd->dev, PCI_CLASS_PROG,
> > > &interface);
> > > +	if (interface == 0x1) {

The previous version [1] implemented this only for
PCI_DEVICE_ID_INTEL_VMD_28C0, but I guess you decided this is safe for
all VMD devices?

And there's still no spec that says "interface == 0x1" means
"firmware-first"?  I guess that's OK; it's VMD-specific code.  But
this doesn't seem to be the usual ACPI firmware-first situation, so I
suspect we need a different name and/or some comment/changelog
clarification.

[1] https://lore.kernel.org/linux-pci/1535675403-2903-2-git-send-email-jonathan.derrick@intel.com

> > > +		struct pci_dev *rpdev;
> > > +
> > > +		list_for_each_entry(rpdev, &vmd->bus->devices,
> > > bus_list) {
> > > +			if (rpdev->aer_cap)
> > 
> > This should be CONFIG_PCIEAER guarded but I would like to
> > understand its logic.
>
> I think we should consider allowing it for CONFIG_PCIEAER=n. The
> firmware should be able to try and manage the error even if it
> occurs when native aer isn't built-in. It would be worse in that
> respect if the error went left unchecked.
>
> > IIUC this assumes all devices in the root bus are root ports,
> > which is an VMD assumption I reckon.
>
> That's true for the VMD hardware so far. We don't expect any devices
> besides root ports on the root bus.
> 
> I would rather drop the dev->aer_cap check, but I can add a
> pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT check

That sounds sensible to me.  I think you want firmware to handle these
system errors regardless of what the kernel may do later, so this
shouldn't have anything to do with AER.

I think this patch relies on the AER driver binding to the Root Ports
(which clears the System Error Enable bits) before you set those bits
again here.  And I think that's a pretty safe assumption because the
AER driver cannot be a module, so portdrv/AER should always bind to
the Root Ports before pci_rescan_bus() returns:

  vmd_probe
    vmd_enable_domain
      pci_create_root_bus
      pci_rescan_bus
        pci_bus_add_devices
          ...
            aer_probe
              aer_enable_rootport
                pcie_capability_clear_word(..., PCI_EXP_RTCTL, ...)
      pcie_capability_set_word(..., PCI_EXP_RTCTL, ...)

It's a little ugly to loop through and touch these Root Ports after
they have been added because (a) that breaks hotplug scenarios (but I
assume it's impossible to hot-add a Root Port under an existing VMD)
and (b) the core or host drivers like VMD really shouldn't touch
devices that may have been claimed by other drivers (but we "know"
portdrv is the only driver involved here).

The ideal way would be to set these bits somewhere in the
pci_device_add() path as the Root Port is being enumerated, but
there's no good hook for VMD-specific code and we'd lose the ordering
with respect to aer_enable_rootport(), so that's not practical.

> > > +				pcie_capability_set_word(rpdev,
> > > PCI_EXP_RTCTL,
> > > +							 PCI_EXP_R
> > > TCTL_SECEE  |
> > > +							 PCI_EXP_R
> > > TCTL_SENFEE |
> > > +							 PCI_EXP_R
> > > TCTL_SEFEE);
> > 
> > I wonder whether this code should be part of the generic AER layer
> > (ie the PCIE port driver) rather than VMD specific, after all
> > that's part of the generic specifications, I do not know if we can
> > envisage an API that allow PCI controller drivers to
> > enable/disable system errors.

Maybe a bit in struct pci_host_bridge the VMD driver could set to say
"please don't disable my System Error interrupts"?  I assume the BIOS
sets them already and the only problem is that AER turns them off
again?

I'm not sure what _OSC has to do with this.  It doesn't sound like you
would want to use it to prevent the OS from using AER.

> I did consider this option first.  There's a call in aer.c to
> disable these bits, so the API need has precendence.
> 
> We would need this API reachable by vmd.c. It seems easiest to
> inline in pci.h.

> > > +		}
> > > +	}
> > > +
> > >  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus-
> > > >dev.kobj,
> > >  			       "domain"), "Can't create symlink to
> > > domain\n");
> > >  	return 0;
