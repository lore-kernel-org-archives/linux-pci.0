Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CEC43441
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 23:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41B8214DA
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 23:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYXlKrNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41B8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJJGig (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 02:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeJJGig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Oct 2018 02:38:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB4F8214C4;
        Tue,  9 Oct 2018 23:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539127158;
        bh=KWQk309SzokYJucwqK3est9LplEvVQbjp3js5ZbIPJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYXlKrNMpx+WL4qaxuQu7jseiD8p91gLwFFrW6dMXW8g8dDbT/D6bQLtVfRIz6nYL
         jD6lrszgdT+HAHA7BQfEIrp0c0Sm8iQVi7ZoWPIvT5SRDL97jZycDIv5nDyxfaOHDa
         w9ijDh+xL3Q0BORIDxQNaDihdytyknxycWbvVvJg=
Date:   Tue, 9 Oct 2018 18:19:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hch@lst.de" <hch@lst.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Message-ID: <20181009231915.GC5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
 <20181009175632.GB5906@bhelgaas-glaptop.roam.corp.google.com>
 <1539114641.8364.34.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539114641.8364.34.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 09, 2018 at 07:51:58PM +0000, Derrick, Jonathan wrote:
> On Tue, 2018-10-09 at 12:56 -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 04, 2018 at 12:33:09PM -0600, Jon Derrick wrote:
> > > During probe, the port driver will disable error reporting and
> > > assumes it will be enabled later by the AER driver's
> > > pci_walk_bus() sequence.  This may not be the case for
> > > host-bridge enabled root ports, who will enable first error
> > > reporting on the bus during the root port probe, and then
> > > disable error reporting on downstream devices during subsequent
> > > probing of the bus.
> > 
> > I understand the hotplug case (see below), but help me understand
> > this "host-bridge enabled root ports" thing.  I'm not sure what
> > that means.
>
> Sorry for the confusion. I meant a device which doesn't expose the
> root ports with firmware but has to expose the root ports using
> pci_create_root_bus or similar methods. These methods use a host
> bridge aperture on the backend.

I guess the contrast you're making is between drivers/acpi/pci_root.c,
which claims ACPI PNP0A03 and PNP0A08 devices, and what I call the
"native" host bridge drivers, which normally claim DT platform devices
and know about the register layout and programming model of those
devices?

In both cases the PCI core has to know about the host bridge apertures
(the address ranges on the primary (upstream) side of the host bridge
that are translated to PCI addresses on the secondary (downstream)
side of the bridge).

I'm still not seeing the connection between the ACPI/native
distinction or the host bridge apertures and this AER enablement
issue.  But I think the problem has to do with the ordering between
enumeration and portdrv/AER driver binding.  See below.

> > We run pcie_portdrv_probe() for every root port, switch upstream
> > port, and switch downstream port, and it always disables error
> > reporting for the port:
> > 
> >   pcie_portdrv_probe          # pci_driver .probe
> >     pcie_port_device_register
> >       get_port_device_capability
> >         services |= PCIE_PORT_SERVICE_AER
> >         pci_disable_pcie_error_reporting
> >           # clear DEVCTL Error Reporting Enables
> > 
> > For root ports, we call aer_probe(), and it enables error reporting
> > for the entire tree below the root port:
> > 
> >   aer_probe                   # pcie_port_service .probe
> >     aer_enable_rootport
> >       set_downstream_devices_error_reporting(dev, true)
> >         pci_walk_bus(dev->subordinate, set_device_error_reporting)
> >           set_device_error_reporting
> >             if (Root Port || Upstream Port || Downstream Port)
> >               pci_enable_pcie_error_reporting
> >                 # set DEVCTL Error Reporting Enables
> > 
> > This is definitely broken for hot-added switches because
> > aer_probe() is the only place we enable error reporting, and it's
> > only run when we enumerate a root port, not when we hot-add things
> > below that root port.
> 
> I don't currently have the hardware to test hotplugging a switch,
> although I think it should be possible to test with Thunderbolt.
> Mika?  :)

It seems clear enough to me that this is broken; I don't think we need
more testing to confirm it.  Your scenario below looks like it's
probably from VMD, given the domain number, and the fact that the
timestamps look like they're after boot suggests that VMD is being
loaded as a module.

I think I can work out the order of events there:

  - register pcie_portdriver   # device_initcall
  - register aerdriver         # device_initcall, after portdrv
  - load VMD module
  - add VMD host bridge to domain 10000
  - 10000:00:00.0: enumerate VMD root port
  - 10000:00:00.0: bind portdrv, disable error reporting
  - 10000:00:00.0: bind aerdriver, enable error reporting for children
  - 10000:01:00.0: enumerate VMD switch upstream port
  - 10000:01:00.0: bind portdrv, disable error reporting
  - 10000:01:00.0: do not bind AER driver (because not a root port)
  - 10000:02:0x.0: enumerate VMD switch downstream ports
  - 10000:02:0x.0: bind portdrv, disable error reporting
  - 10000:02:0x.0: do not bind AER driver (not root ports)
  - 10000:06:00.0: enumerate NVMe endpoint
  - 10000:06:00.0: nvme driver enables error reporting

The end state is that error reporting is enabled only for the root
port and the NVMe device, but not for the switch ports in between.

I think the critical ordering is the portdrv/AER driver registration
vs. the device enumeration.  If we enumerate the devices before
registering portdrv/AER (as is the typical case with ACPI host
bridges), when we register portdrv, we'll bind portdrv to all the
bridges *first*, which disables error reporting for all of them.

After that, we'll register the AER driver, which will be bound to all
the root ports and will enable error reporting for the subtrees below
them.

> > > A hotplugged port device may also fail to enable error reporting
> > > as the AER driver has already run on the root bus.  Check for
> > > these conditions and enable error reporting during portdrv
> > > probing.
> > > 
> > > Example case:
> > 
> > pcie_portdrv_probe(10000:00:00.0):
> > > [  343.790573] pcieport 10000:00:00.0:
> > > pci_disable_pcie_error_reporting
> > 
> > aer_probe(10000:00:00.0):
> > > [  343.809812] pcieport 10000:00:00.0:
> > > pci_enable_pcie_error_reporting
> > > [  343.819506] pci 10000:01:00.0: pci_enable_pcie_error_reporting
> > > [  343.828814] pci 10000:02:00.0: pci_enable_pcie_error_reporting
> > > [  343.838089] pci 10000:02:01.0: pci_enable_pcie_error_reporting
> > > [  343.847478] pci 10000:02:02.0: pci_enable_pcie_error_reporting
> > > [  343.856659] pci 10000:02:03.0: pci_enable_pcie_error_reporting
> > > [  343.865794] pci 10000:02:04.0: pci_enable_pcie_error_reporting
> > > [  343.874875] pci 10000:02:05.0: pci_enable_pcie_error_reporting
> > > [  343.883918] pci 10000:02:06.0: pci_enable_pcie_error_reporting
> > > [  343.892922] pci 10000:02:07.0: pci_enable_pcie_error_reporting
> > 
> > pcie_portdrv_probe(10000:01:00.0):
> > > [  343.918900] pcieport 10000:01:00.0:
> > > pci_disable_pcie_error_reporting
> > 
> > pcie_portdrv_probe(10000:02:00.0):
> > > [  343.968426] pcieport 10000:02:00.0:
> > > pci_disable_pcie_error_reporting
> > 
> > ...
> > > [  344.028179] pcieport 10000:02:01.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.091269] pcieport 10000:02:02.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.156473] pcieport 10000:02:03.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.238042] pcieport 10000:02:04.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.321864] pcieport 10000:02:05.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.411601] pcieport 10000:02:06.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.505332] pcieport 10000:02:07.0:
> > > pci_disable_pcie_error_reporting
> > > [  344.621824] nvme 10000:06:00.0: pci_enable_pcie_error_reporting
> 
> The main issue leading to this sequence of events is that the root
> port and tree is enumerated, then the tree has drivers attached
> in-order.  During driver probe, the root port services are attached
> which enables AER on the entire bus. Then the port's service drivers
> are attached, which disables AER during initialization.
> 
> It looks like I don't see this issue in the non-host-bridge case
> because this statement isn't executed:
>
> #ifdef CONFIG_PCIEAER
>         if (dev->aer_cap && pci_aer_available() &&
>             (pcie_ports_native || host->native_aer)) {
>                 services |= PCIE_PORT_SERVICE_AER;
> 
>                 /*
>                  * Disable AER on this port in case it's been enabled by the
>                  * BIOS (the AER service driver will enable it when necessary).
>                  */         
>                 pci_disable_pcie_error_reporting(dev);
>         }                                                              
> #endif

We should execute the statement above for all root ports, switch
upstream ports, and switch downstream ports, regardless of how they
were discovered.

I think the real issue is that if we register the drivers first, we
bind portdrv/AER to devices as they're enumerated.  But if we
enumerate the devices first, we bind portdrv to all of them first,
following by binding the AER driver to the root ports.  That ordering
difference explains the problem.

> So I think re-enabling or strictly enabling error reporting is the
> correct course of action for hotplug support at the least. And doing
> it after port service driver probe is done and IRQs are requested
> should eliminate or reduce races with initialization, which is what
> above code snippet looks to be doing in the first place along with
> pcie_init_services.
> 
> > > 
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/pcie/portdrv_core.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pcie/portdrv_core.c
> > > b/drivers/pci/pcie/portdrv_core.c
> > > index 7c37d81..fdd953a 100644
> > > --- a/drivers/pci/pcie/portdrv_core.c
> > > +++ b/drivers/pci/pcie/portdrv_core.c
> > > @@ -343,6 +343,16 @@ int pcie_port_device_register(struct pci_dev *dev)
> > >       if (!nr_service)
> > >               goto error_cleanup_irqs;
> > >  
> > > +#ifdef CONFIG_PCIEAER
> > > +     /*
> > > +      * Enable error reporting for this port in case AER probing has already
> > > +      * run on the root bus or this port device is hot-inserted
> > > +      */
> > > +     if (dev->aer_cap && pci_aer_available() &&
> > > +         (pcie_ports_native || pci_find_host_bridge(dev->bus)->native_aer))
> > > +             pci_enable_pcie_error_reporting(dev);
> > > +#endif
> > 
> > I plan to apply this after we clarify the changelog a bit, but I
> > don't really like this patch because it (and the corresponding
> > code added by 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services
> > during port initialization")) seem a little out of place.
> >
> > The way I think this *should* work is that the PCI core should
> > arrange to handle AER interrupts when it enumerates the devices
> > that can generate them (Root Ports and Root Complex Event
> > Collectors), even before it enumerates the devices below the Root
> > Port.
>
> To add to this, I'm not the biggest fan of the current way of having
> AER enable notification for ports on the tree, but then having every
> other PCI driver enable their own notification. It seems
> inconsistent for the port driver to not do it.

I agree, this is sort of a mess.  It would be nice if the AER code
could take care of this for all devices relevant to AER.  But the
portdrv structure is such that it can only bind to *ports*, not to
endpoints.  So there's not really a good way for the current AER
service driver to get involved when an endpoint is discovered.

> > Then the PCI core could directly enable the AER interrupts on all
> > devices as it enumerates them.  I would envision both cases being
> > handled somewhere like pci_aer_init() in pci_init_capabilities().
> > 
> > This would also allow us to get rid of the
> > pci_enable_pcie_error_reporting() calls that are currently
> > sprinkled around in drivers, because that would be handled by the
> > core for all devices.
>
> I agree with you here. It seems to make the most sense to handle it
> inclusively and exclude devices as necessary.

Sorry for the wall of text above.  Here's a proposal for an alternate
way to solve this by doing more of it in the AER driver.  Obviously I
can't test this so I don't know if it will solve the problem for you.

commit 15a6711649915ca3e9d1086dc88ff4b616b99aac
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Oct 9 17:25:25 2018 -0500

    PCI/AER: Enable reporting for ports enumerated after AER driver registration
    
    Previously we enabled AER error reporting only for Switch Ports that were
    enumerated prior to registering the AER service driver.  Switch Ports
    enumerated after AER driver registration were left with error reporting
    disabled.
    
    A common order, which works correctly, is that we enumerate devices before
    registering portdrv and the AER driver:
    
      - Enumerate all the devices at boot-time
    
      - Register portdrv and bind it to all Root Ports and Switch Ports, which
        disables error reporting for these Ports
    
      - Register AER service driver and bind it to all Root Ports, which
        enables error reporting for the Root Ports and any Switch Ports below
        them
    
    But if we enumerate devices *after* registering portdrv and the AER driver,
    e.g., if a host bridge driver is loaded as a module, error reporting is not
    enabled correctly:
    
      - Register portdrv and AER driver (this happens at boot-time)
    
      - Enumerate a Root Port
    
      - Bind portdrv to Root Port, disabling its error reporting
    
      - Bind AER service driver to Root Port, enabling error reporting for it
        and its children (none, since we haven't enumerated them yet)
    
      - Enumerate Switch Port below the Root Port
    
      - Bind portdrv to Switch Port, disabling its error reporting
    
      - AER service driver doesn't bind to Switch Ports, so error reporting
        remains disabled
    
    Hot-adding a Switch fails similarly: error reporting is enabled correctly
    for the Root Port, but when the Switch is enumerated, the AER service
    driver doesn't claim it, so there's nothing to enable error reporting for
    the Switch Ports.
    
    Change the AER service driver so it binds to *all* PCIe ports, including
    Switch Upstream and Downstream Ports.  For Switch Ports, enable AER error
    reporting.
    
    Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
    Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 90b53abf621d..fe6c16461367 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1316,12 +1316,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
 
-	/*
-	 * Enable error reporting for the root port device and downstream port
-	 * devices.
-	 */
-	set_downstream_devices_error_reporting(pdev, true);
-
 	/* Enable Root Port's interrupt in response to error messages */
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1378,10 +1372,17 @@ static void aer_remove(struct pcie_device *dev)
  */
 static int aer_probe(struct pcie_device *dev)
 {
+	struct pci_dev *pdev = dev->port;
+	int type = pci_pcie_type(pdev);
 	int status;
 	struct aer_rpc *rpc;
 	struct device *device = &dev->device;
 
+	if (type == PCI_EXP_TYPE_UPSTREAM || type == PCI_EXP_TYPE_DOWNSTREAM) {
+		pci_enable_pcie_error_reporting(pdev);
+		return 0;
+	}
+
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
 		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
@@ -1439,7 +1440,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
