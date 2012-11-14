Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54167 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933092Ab2KNWAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Nov 2012 17:00:19 -0500
From: "Rose, Gregory V" <gregory.v.rose@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Donald Dutile <ddutile@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v2] PCI SRIOV device enable and disable via sysfs
Date: Wed, 14 Nov 2012 22:00:16 +0000
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A072D588BF2@ORSMSX106.amr.corp.intel.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
 <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
In-Reply-To: <CAErSpo7OS=iuVFDnBEDz8Bx4GmVisw=UGvuv27OgU6JOeZHhrw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, November 14, 2012 12:47 PM
> To: Donald Dutile
> Cc: linux-pci@vger.kernel.org; yuvalmin@broadcom.com;
> bhutchings@solarflare.com; Rose, Gregory V; yinghai@kernel.org;
> davem@davemloft.net
> Subject: Re: [PATCH v2] PCI SRIOV device enable and disable via sysfs
> 
> On Mon, Nov 5, 2012 at 1:20 PM, Donald Dutile <ddutile@redhat.com> wrote:
> > Currently, VF enablement by SRIOV-capable PCIe devices is done in
> > driver-specific module parameters.  If not setup in modprobe files, it
> > requires admin to unload & reload PF drivers with number of desired
> > VFs to enable.  Additionally, the enablement is system wide: all
> > devices controlled by the same driver have the same number of VFs
> > enabled.  Although the latter is probably desired, there are PCI
> > configurations setup by system BIOS that may not enable that to occur.
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
> > -- (hopefully) correct From & Signed-by for Yinghai Lu's patches (1/8
> > & 2/8)
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
> > This patch is based on previous 2 patches by Yinghai Lu that cleaned
> > up the vga attributes for PCI devices under sysfs, and uses
> > visibility-checking group attributes as recommended by Greg K-H.
> >
> > Signed-off-by: Donald Dutile <ddutile@redhat.com>
> > ---
> >  drivers/pci/iov.c       |  48 ++++++++++++++++
> >  drivers/pci/pci-sysfs.c | 179
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  drivers/pci/pci.h       |   2 +
> >  drivers/pci/probe.c     |   1 +
> >  include/linux/pci.h     |  11 ++++
> >  5 files changed, 230 insertions(+), 11 deletions(-)
> 
> I applied patches 1-4 to my pci/don-sriov patch, and they appeared in
> next-20121114.
> 
> I am still expecting a Documentation/ABI update, but I wanted to get the
> functional patches merged now because there will only be one more -next
> release until 11/26, which will probably be after -rc7.
> 
> I'm expecting patches 5-8 to be posted via some other mechanism as
> mentioned in those patches.

I have patches ready to post to netdev but we'll need to coordinate with Dave because they won't compile with these patches.

- Greg

> 
> Thanks!
> 
> Bjorn
