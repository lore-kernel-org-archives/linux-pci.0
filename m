Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61300 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756751Ab2LNSTf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Dec 2012 13:19:35 -0500
Date: Fri, 14 Dec 2012 10:19:11 -0800
From: Greg Rose <gregory.v.rose@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Donald Dutile <ddutile@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
Message-ID: <20121214101911.00002f59@unknown>
In-Reply-To: <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
	<CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 14 Nov 2012 12:46:57 -0800
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Mon, Nov 5, 2012 at 1:20 PM, Donald Dutile <ddutile@redhat.com>
> wrote:
> > Currently, VF enablement by SRIOV-capable PCIe devices is done
> > in driver-specific module parameters.  If not setup in modprobe
> > files, it requires admin to unload & reload PF drivers with number
> > of desired VFs to enable.  Additionally, the enablement is system
> > wide: all devices controlled by the same driver have the same
> > number of VFs enabled.  Although the latter is probably desired,
> > there are PCI configurations setup by system BIOS that may not
> > enable that to occur.
> >
> > Two files are created if a PCIe device has SRIOV support:
> > sriov_totalvfs -- cat-ing this file returns the maximum number
> >                   of VFs a PCIe device supports.
> > sriov_numvfs -- echo'ing a positive number to this file enables
> >                 & configures this number of VFs for this given PCIe
> >                 device.
> >              -- echo'ing 0 to this file disables and deconfigures
> >                 all VFs for this given PCIe device.
> >              -- cat-ing this file will return the number of VFs
> >                 currently enabled on this PCIe device.
> >
> > VF enable and disablement is invoked much like other PCIe
> > configuration functions -- via a registered callback in the driver,
> > i.e., probe, release, etc.  In this case, sriov_configure
> >
> > PATCH v1->v2:
> > -- incorporate more feedback from Ben Hutchings.
> > -- (hopefully) correct From & Signed-by for Yinghai Lu's patches
> > (1/8 & 2/8)
> >
> > RFC V3->PATCH:
> > -- incorporate feedback from Ben Hutchings.
> > -- clean up poor RFC patches & sanitize through checkpatch.pl
> >
> > RFC v2->v3:
> > -- change the file names to reflect the names used in the SRIOV spec
> > -- change to a single file for enable & disable;
> >    change driver interface to a single interface.
> > -- add more informative messages on failures
> > -- add a core method that a driver can invoke to modify
> >    the totalvfs reported & supported by a driver.
> > -- a set of patches for ixgbe provided by Greg Rose to use the
> >    new interfaces; the last patch modified from the original
> >    two file, enable/disable interface to the current single file
> >    enable/disable. Greg will eventually post the final version
> >    of these patches via Intel's usual process for driver patches.
> >    Provided here as an example, and enable other SRIOV drivers
> >    to see how adoption of the interface can be added.
> >
> > RFC v1->v2:
> > This patch is based on previous 2 patches by Yinghai Lu
> > that cleaned up the vga attributes for PCI devices under sysfs,
> > and uses visibility-checking group attributes as recommended by
> > Greg K-H.
> >
> > Signed-off-by: Donald Dutile <ddutile@redhat.com>
> > ---
> >  drivers/pci/iov.c       |  48 ++++++++++++++++
> >  drivers/pci/pci-sysfs.c | 179
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
> > drivers/pci/pci.h       |   2 + drivers/pci/probe.c     |   1 +
> >  include/linux/pci.h     |  11 ++++
> >  5 files changed, 230 insertions(+), 11 deletions(-)
> 
> I applied patches 1-4 to my pci/don-sriov patch, and they appeared in
> next-20121114.
> 
> I am still expecting a Documentation/ABI update, but I wanted to get
> the functional patches merged now because there will only be one more
> -next release until 11/26, which will probably be after -rc7.
> 
> I'm expecting patches 5-8 to be posted via some other mechanism as
> mentioned in those patches.
> 
> Thanks!
> 
> Bjorn

Now that the merge has occurred I find that there is a small bug in
which a return code with a positive value isn't handled and thus an
error is generated even though no error occurred.  Please consider this
patch as a fix.

Thanks,

- Greg

pci: Fix return code

From: Greg Rose <gregory.v.rose@intel.com>

The return code from the sriov configure function was only returned if it
was less than zero indicating an error.  This caused the code to fall
through to the default return of an error code even though the sriov
configure function has returned the number of VFs it created - a positive
number indicating success.


Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
---

 drivers/pci/pci-sysfs.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 05b78b1..2722a33 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -461,9 +461,10 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 					 "Only %d VFs enabled\n",
 					 num_vfs_enabled);
 				return count;
-			} else if (num_vfs_enabled < 0)
-				/* error code from driver callback */
+			} else {
+				/* Return error code or number of VFs */
 				return num_vfs_enabled;
+			}
 		} else if (num_vfs == pdev->sriov->num_VFs) {
 			dev_warn(&pdev->dev,
 				 "%d VFs already enabled; no enable action taken\n",


