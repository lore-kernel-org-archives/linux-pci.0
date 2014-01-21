Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36685 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751543AbaAUCAq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 21:00:46 -0500
Date: 20 Jan 2014 21:00:42 -0500
Message-ID: <20140121020042.29941.qmail@science.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: acooks@gmail.com, alex.williamson@redhat.com, linux@horizon.com
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Cc: iommu@lists.linux-foundation.org, linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org
In-Reply-To: <CAJtEV7bkfB=REaJkf+jb33_2h=_5YoZogQNw4SKmmWwZcF8NZA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

New recipient: Alex Williamson, who added the pci_get_dma_source()
quirk that resembles this one.

Alex, Andrew is working on a patch to fix some more buggy
PCIe devices like the Ricoh ones that you added a quirk for.

His current patch can be found at

https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22

Ir only works on Intel IOMMUs, and sort of duplicates the functionality
of your quirk.

Obviously, I hate the duplication and would like to fold them together,
but there are a few fundamental differences.

Most notably, Andrew's patch enables the incorrect requester ID
*in addition to* the correct one.  I'm not sure if this is necessary,
but it seems like a nice defensive feature in case the vendor fixes
the problem in a minor rev, and the ability is also needed by PCIe
phantom function support,

The other thing is that pci_get_dma_source returns a pci_dev, but
Andrew's patch deals with devices which use requester IDs which
don't correspond to existing PCI devices at all:

- Marvell SATA controllers which exist only as devid 00.0, but generate
  request devids of 00.1.  (The latter function might be PATA support
  on chips which support that.)
- Mellanox 26428 Infiniband controllers which also only provide one
  function, but use a source devid of 00.6
- An LSI MegaRAID SAS 2078 PCI-X controller that is device 0e.0, but
  generates request devids of 08.0
- An Adaptec RAID controller ie 0e.0 that makes requests as 01.0.

My thought for implementing Andrew's version was to add an 8-bit devfn_quirk
field to struct pci_dev that contains the delta to the devfn that will
appear in the source requester ID.

(By using a delta rather than the target value, the default value of 0
means "no quirk".)

This would be initialized at boot time using a standard PCI quirk,
avoiding the need for linearly searching potentially long device lists
every time an IOMMU mapping is set up.

(Even if I only use a single-bit flag, that would avoid the list
searching for all the non-buggy devices.)


But I'm not quite sure what the locking rules are on the whole swap_pci_ref
business.  Or if the Ricoh devices have to be handled more carefully
because multiple functions need to arbitrate over the IOMMU tables
for function 0.

Can I request some sage guidance from someone with more experience in the
area?

Thank you!
