Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932294AbeAXXSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jan 2018 18:18:32 -0500
Date: Wed, 24 Jan 2018 16:18:31 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: geoff@hostfission.com
Cc: linux-pci@vger.kernel.org, suravee.suthikulpanit@amd.com,
        Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH] Restore PCI bridge configuration space on bridge reset
Message-ID: <20180124161831.771200b7@w520.home>
In-Reply-To: <745998038463da91584ef51dfc8ffcac@hostfission.com>
References: <0986ad77b71f3b8e0a17f79e238d1ebc@hostfission.com>
        <20180124141051.733f7b28@w520.home>
        <745998038463da91584ef51dfc8ffcac@hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 25 Jan 2018 09:28:59 +1100
geoff@hostfission.com wrote:

> On 2018-01-25 08:10, Alex Williamson wrote:
> > On Wed, 24 Jan 2018 19:02:33 +1100
> > geoff@hostfission.com wrote:
> >   
> >> According to PCI-to-PCI Bridge Architecture Specification 3.2.5.17  
> > 
> > Correction, rev 1.2 section 3.2.5.18, in reference to the secondary bus
> > reset bit in the bridge control register.
> >   
> 
> Thanks, I will make this correction if the patch is deemed valid re 
> below.
> Please excuse any confusing terminology/wording, I am still coming to
> terms with how PCI operates.
> 
> >> > The bridge’s secondary bus interface and any buffers between
> >> > the two interfaces (primary and secondary) must be initialized
> >> > back to their default state whenever this bit is set.  
> >> 
> >> Failure to observe this causes inability to access devices on the
> >> secondary bus
> >> on the AMD Threadripper platform after device reset when the device is
> >> being
> >> used for PCI passthrough with KVM.
> >> 
> >> The following patch corrects this by saving the pci state and 
> >> restoring
> >> it after
> >> the bus has been reset.  
> > 
> > How do configuration registers on the primary bus interface fall into
> > this requirement?  It's not very clear from the spec what these
> > "buffers" are and the secondary interface has no configuration
> > registers itself.  Figure 1-2 shows Transaction/Data Buffers which are
> > clearly separate from the Primary Interface Configuration Registers.
> > I'd tend to say this excerpt of the spec is describing a hardware
> > requirement, not a software requirement.  
> 
> These are not the configuration registers on the primary bus but on the
> secondary bus, in the case of a TR system a "PCIe GPP Bridge" device is
> created and the PCI device is placed under it. It is this bridge that
> needs it's configuration space rewritten.

There are no configuration registers on the secondary interface, see:

3.1.1 Type 0 Configuration Transaction Support

  A bridge only responds to Type 0 configuration transactions on its
  primary PCI interface when being configured. A bridge ignores Type 0
  configuration transactions that originate on the secondary interface
  of the bridge. Thus, the bridge does not implement IDSEL on its
  secondary interface. A Type 0 configuration transaction is used to
  configure the bridge and is not forwarded downstream by the bridge
  (from its primary to secondary interface). 

We interact with the bridge on the primary interface in order to reset
the secondary interface.

> Unless I am mistaken, currently pci.c is inconsistent with secondary
>   bus resets as it is. In `pci_reset_bus` the bus configuration space
>   is saved via `pci_bus_save_and_disable`, the bus is reset, and then
>   the configuration
> is reloaded using `pci_bus_restore`.

pci_reset_bus
  pci_bus_save_and_disable
  pci_bus_reset
    pci_bus_lock
    pci_reset_bridge_secondary_bus
      pcibios_reset_secondary_bus
        pci_reset_secondary_bus
    pci_bus_unlock
  pci_bus_restore

> `pci_try_reset_bus` is different again, in that it calls
> `pci_reset_bridge_secondary_bus` also.

pci_try_reset_bus
  pci_bus_save_and_disable
  if (pci_bus_trylock()) {
    pci_reset_bridge_secondary_bus
      pcibios_reset_secondary_bus
        pci_reset_secondary_bus
    pci_bus_unlock
  }
  pci_bus_restore

What's inconsistent here?
 
> In short, it is already happening under certain circumstances, but 
> because
> on TR the CPU view of the PCI configuration space seems to be cached,
>   it is
> unable to determine the changes and thus a blind re-write is required.

Hmm, we'd be in real trouble if the CPU is caching config space.  Seems
more like we just can't trust the read value of the bridge registers.
This "write only if read value doesn't match saved" comes from here:

commit 04d9c1a1100b6bdeffa7e1bfc30080bdac28e183
Author: Dave Jones <davej@redhat.com>
Date:   Tue Apr 18 21:06:51 2006 -0700

    [PATCH] PCI: Improve PCI config space writeback
    
    At least one laptop blew up on resume from suspend with a black screen due
    to a lack of this patch.  By only writing back config space that is
    different, we minimise the possibility of accidents like this.
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

It's unfortunate that we don't really have any more data than that, but
are we better off with something like:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c6864fdf4..f4f625a08094 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1117,7 +1117,7 @@ static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
        u32 val;
 
        pci_read_config_dword(pdev, offset, &val);
-       if (val == saved_val)
+       if (!(pdev->dev_flags & PCI_DEV_FLAGS_RESTORE_ALL) && (val == saved_val))
                return;
 
        for (;;) {

And a quirk to set that flag on these bridges?

> > I know that people have found that re-writing bridge registers on
> > threadripper solves the reset problem, but this seems like a bit of
> >   a stretch to attribute it to this spec statement.  Maybe it can be
> > handled via a quirk if AMD isn't planning to release firmware that
> > resolves this issue?  AMD...  Thanks,
> >   
> 
> I'd love to see this fixed in firmware/bios/microcode, etc... but as
>   the spec reads, it is unclear if this is a software or hardware
>   requirement, IMO
> it is a software requirement to reconfigure the configuration space
>   of the
> secondary bus, but my understanding of PCI at this time is quite new
>   so I
> am ready to accept a final decision by someone with more experience.

I can't bring myself to support that interpretation of the spec.  The
hardware is in an inconsistent state, the read value doesn't match the
internal logic, that's not normal.  That sounds like a "we need a quirk
to identify this device as untrusted for restore" kind of bug.  Thanks,

Alex
