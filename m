Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbdFFXKU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jun 2017 19:10:20 -0400
Date: Tue, 6 Jun 2017 18:10:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 5/5] drm/amdgpu: resize VRAM BAR for CPU access v2
Message-ID: <20170606231019.GC12672@bhelgaas-glaptop.roam.corp.google.com>
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
 <1494348547-1465-6-git-send-email-deathsimple@vodafone.de>
 <20170601201430.GC12257@bhelgaas-glaptop.roam.corp.google.com>
 <72e061a5-9684-06e2-3021-80de8ca97bd7@vodafone.de>
 <20170602202631.GA1452@bhelgaas-glaptop.roam.corp.google.com>
 <779a883a-265a-ae04-b0cd-8cb3599f0dc0@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <779a883a-265a-ae04-b0cd-8cb3599f0dc0@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 06, 2017 at 01:51:11PM +0200, Christian König wrote:
> Am 02.06.2017 um 22:26 schrieb Bjorn Helgaas:
> >On Fri, Jun 02, 2017 at 11:32:21AM +0200, Christian König wrote:
> >>Hi Bjorn,
> >>
> >>sorry for not responding earlier and thanks for picking this thread
> >>up again.
> >>
> >>Am 01.06.2017 um 22:14 schrieb Bjorn Helgaas:
> >>>[+cc ADMGPU, DRM folks]
> >>>
> >>>On Tue, May 09, 2017 at 06:49:07PM +0200, Christian König wrote:
> >>>>[SNIP]
> >>>>+/**
> >>>>+ * amdgpu_resize_bar0 - try to resize BAR0
> >>>>+ *
> >>>>+ * @adev: amdgpu_device pointer
> >>>>+ *
> >>>>+ * Try to resize BAR0 to make all VRAM CPU accessible.
> >>>>+ */
> >>>>+void amdgpu_resize_bar0(struct amdgpu_device *adev)
> >>>>+{
> >>>>+	u64 space_needed = roundup_pow_of_two(adev->mc.real_vram_size);
> >>>>+	u32 rbar_size = order_base_2(((space_needed >> 20) | 1)) -1;
> >>>>+	u16 cmd;
> >>>>+	int r;
> >>>>+
> >>>>+	/* Free the doorbell mapping, it most likely needs to move as well */
> >>>>+	amdgpu_doorbell_fini(adev);
> >>>>+	pci_release_resource(adev->pdev, 2);
> >>>>+
> >>>>+	/* Disable memory decoding while we change the BAR addresses and size */
> >>>>+	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
> >>>>+	pci_write_config_word(adev->pdev, PCI_COMMAND,
> >>>>+			      cmd & ~PCI_COMMAND_MEMORY);
> >>>>+
> >>>>+	r = pci_resize_resource(adev->pdev, 0, rbar_size);
> >>>>+	if (r == -ENOSPC)
> >>>>+		DRM_INFO("Not enough PCI address space for a large BAR.");
> >>>>+	else if (r && r != -ENOTSUPP)
> >>>>+		DRM_ERROR("Problem resizing BAR0 (%d).", r);
> >>>>+
> >>>>+	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> >>>>+
> >>>>+	/* When the doorbell BAR isn't available we have no chance of
> >>>>+	 * using the device.
> >>>>+	 */
> >>>>+	BUG_ON(amdgpu_doorbell_init(adev));

> >>> From the PCI core perspective, it would be much cleaner to do the BAR
> >>>resize before the driver calls pci_enable_device().  If that could be
> >>>done, there would be no need for this sort of shutdown/reinit stuff
> >>>and we wouldn't have to worry about issues like these.  The amdgpu
> >>>init path is pretty complicated, so I don't know whether this is
> >>>possible.
> >>I completely agree on this and it is actually the approach I tried first.
> >>
> >>There are just two problems with this approach:
> >>1. When the amdgpu driver is loaded there can already be the VGA
> >>console, Vesa or EFI driver active for the device and displaying the
> >>splash screen.
> >>
> >>When we resize and most likely relocate the BAR while those drivers
> >>are active it will certainly cause problems.
> >>
> >>What amdgpu does before trying to resize the BAR is kicking out
> >>other driver and making sure it has exclusive access to the
> >>hardware.
> >I don't understand the problem here yet.  If you need to enable the
> >device, then disable it, resize, and re-enable it, that's fine.
> 
> The issue is we never enable the device ourself in amdgpu, except
> for some rare cases during resume.
> 
> In most of the cases we have to handle this is the primary display
> device which is enabled by either the BIOS, VGA console, VesaFB or
> EFIFB. Amdgpu just kicks out whatever driver was responsible for the
> device previously and takes over.
> 
> I could of course do the disable/resize/reenable dance, but I would
> rather want to avoid that.
> 
> The hardware is most likely already displaying a boot splash and we
> want to transit to the desktop without any flickering (at least
> that's the long term goal). Completely disabling the device to do
> this doesn't sounds like a good idea if we want that.
> 
> >The important thing I'm looking for is that the resize happens before
> >a pci_enable_device(), because pci_enable_device() is the sync point
> >where the PCI core enables resources and makes them available to the
> >driver.  Drivers know that they can't look at the resources before
> >that point.  There's a little bit of text about this in [1].
> 
> Yeah, I understand that. But wouldn't it be sufficient to just
> disable memory decoding during the resize?
> 
> I can easily guarantee that the CPU isn't accessing the BAR during
> the time (we need to do this for changing the memory clocks as
> well), but I have a bad gut feeling completely turning of the device
> while we are still displaying stuff.

pci_disable_device() doesn't turn off the device; it only disables bus
mastering (and some of the arch-specific pcibios_disable_device()
implementations do a little more).  But it's certainly the wrong
direction -- it disables DMA, which has nothing to do with the BAR
decoding we're interested in.

What if the driver did something like this:

  pci_disable_decoding(dev, IORESOURCE_MEM);
  pci_release_resource(dev, 2);
  pci_resize_bar(dev, bar, size);
  pci_assign_resources(dev);
  pci_enable_decoding(dev, IORESOURCE_MEM);

That would require adding pci_enable/disable_decoding() to the driver
API, along with the requirement that the driver discard and remap
some resources after pci_enable_decoding().  I think
pci_enable_decoding() would look much like the existing
pci_enable_resources() except taking a resource type instead of a
bitmask.

I would *prefer* if we released and reassigned all resources, because
then the core has complete flexibility to move things around, and it's
easy to document that pci_assign_resources() means you have to
reread/remap everything.

If the driver only releases specified BARs, the pci_assign_resources()
interface becomes "you need to reread/remap the BAR you resized, plus
any other BARs you released".  It's a little more complicated to
describe and more dependent on previous driver actions.

But releasing only the specified BAR will make your life easier and
help with the fact that multiple drivers might be using the same BAR
(I have to raise my eyebrows at that), so I think I'm OK with it.  And
it would also side-step the "can't restore previous state" problem.

It's an "interesting" asymmetry that pci_enable_device() turns on BAR
decoding but doesn't touch bus mastering, while pci_disable_device()
turns off bus mastering but doesn't touch BAR decoding.

Bjorn
