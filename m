Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:45687 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaAUCwE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 21:52:04 -0500
MIME-Version: 1.0
In-Reply-To: <20140121020042.29941.qmail@science.horizon.com>
References: <CAJtEV7bkfB=REaJkf+jb33_2h=_5YoZogQNw4SKmmWwZcF8NZA@mail.gmail.com>
	<20140121020042.29941.qmail@science.horizon.com>
Date: Tue, 21 Jan 2014 10:52:03 +0800
Message-ID: <CAJtEV7YBr69iHHFZ7PNzZH_Hhu5HuM0ifOnzhr+GyzGqgErT4g@mail.gmail.com>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
From: Andrew Cooks <acooks@gmail.com>
To: George Spelvin <linux@horizon.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	linux-ide@vger.kernel.org,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 21, 2014 at 10:00 AM, George Spelvin <linux@horizon.com> wrote:
> New recipient: Alex Williamson, who added the pci_get_dma_source()
> quirk that resembles this one.
>
> Alex, Andrew is working on a patch to fix some more buggy
> PCIe devices like the Ricoh ones that you added a quirk for.
>
> His current patch can be found at
>
> https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22
>
> Ir only works on Intel IOMMUs, and sort of duplicates the functionality
> of your quirk.
>
> Obviously, I hate the duplication and would like to fold them together,
> but there are a few fundamental differences.

Hang on! The existing quirk only worked for vfio groups last time I
checked and didn't actually solve the problem for using the device on
the host.

Alex had done a bunch of work to support requester id quirks (see
http://marc.info/?l=linux-pci&m=137357663626523&w=3), but that seems
blocked.

> Most notably, Andrew's patch enables the incorrect requester ID
> *in addition to* the correct one.  I'm not sure if this is necessary,
> but it seems like a nice defensive feature in case the vendor fixes
> the problem in a minor rev, and the ability is also needed by PCIe
> phantom function support,
>
> The other thing is that pci_get_dma_source returns a pci_dev, but
> Andrew's patch deals with devices which use requester IDs which
> don't correspond to existing PCI devices at all:
>
> - Marvell SATA controllers which exist only as devid 00.0, but generate
>   request devids of 00.1.  (The latter function might be PATA support
>   on chips which support that.)

No, I can prove that both .0 and .1 are used on the 9172 controller,
depending on which of the two SATA port(s) is(are) in use. If you have
the same hardware, I suggest you verify this.

> - Mellanox 26428 Infiniband controllers which also only provide one
>   function, but use a source devid of 00.6
> - An LSI MegaRAID SAS 2078 PCI-X controller that is device 0e.0, but
>   generates request devids of 08.0
> - An Adaptec RAID controller ie 0e.0 that makes requests as 01.0.
>
> My thought for implementing Andrew's version was to add an 8-bit devfn_quirk
> field to struct pci_dev that contains the delta to the devfn that will
> appear in the source requester ID.
>
> (By using a delta rather than the target value, the default value of 0
> means "no quirk".)
>
> This would be initialized at boot time using a standard PCI quirk,
> avoiding the need for linearly searching potentially long device lists
> every time an IOMMU mapping is set up.
>
> (Even if I only use a single-bit flag, that would avoid the list
> searching for all the non-buggy devices.)
>
>
> But I'm not quite sure what the locking rules are on the whole swap_pci_ref
> business.  Or if the Ricoh devices have to be handled more carefully
> because multiple functions need to arbitrate over the IOMMU tables
> for function 0.

The Ricoh firewire function simply uses the wrong requester ID. The
other functions work correctly. Remapping only the firewire specific
function of the multifunction device (as in my patch) fixes the
problem.

a.
