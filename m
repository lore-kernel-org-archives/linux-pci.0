Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbbCRUNI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Mar 2015 16:13:08 -0400
Subject: [PATCH v2 0/6] vfio-pci: Misc enhancements
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, bsd@redhat.com,
	linux-kernel@vger.kernel.org
Date: Wed, 18 Mar 2015 14:13:07 -0600
Message-ID: <20150318200053.24807.74115.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v2:
 - Incorporate comments from Bandan and Bjorn for vfio-pci.ids option
 - Include necessary vgaarb change, already Ack'd by Dave
 - Rebase on top of my current next branch
 - Rename D3 disable parameter

There are really 3 separate features added in this series, the first
is to opt-out VGA devices from VGA arbitration if a) vfio VGA support
is disable, either via config or module optioni (new), and b) bridge
control of VGA resource routing is possible.  This means that if
multiple VGA devices are installed with the intention of using them
for device assignment without VGA, we can eliminate the effect they
have on host graphics.

The second feature is the addition of the "ids" module option, which
acts just like the option of the same name on pci-stub.  This makes it
easier to configure vfio-pci to statically claim certain devices.  By
either building vfio support into the kernel or using softdeps to
load vfio-pci before native drivers, this can make it much easier to
bind to devices which are only intended to be used through vfio, such
as those additional graphics cards.

Finally, when devices are bound to vfio-pci and unused, we can try to
put them into a low-power state.  This again feeds into that idea that
devices may be installed on the system only for use through vfio, and
that use may not be continuous.  This saves a few watts for some GPUs.
Thanks,

Alex

---

Alex Williamson (6):
      vgaarb: Stub vga_set_legacy_decoding()
      vfio-pci: Add module option to disable VGA region access
      vfio-pci: Add VGA arbiter client
      vfio-pci: Allow PCI IDs to be specified as module options
      vfio-pci: Remove warning if try-reset fails
      vfio-pci: Move idle devices to D3hot power state


 drivers/vfio/pci/vfio_pci.c |  179 +++++++++++++++++++++++++++++++++++++++----
 include/linux/vgaarb.h      |    5 +
 2 files changed, 167 insertions(+), 17 deletions(-)
