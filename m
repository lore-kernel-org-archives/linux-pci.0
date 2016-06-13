Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51250 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424539AbcFMPsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 11:48:00 -0400
Date: Mon, 13 Jun 2016 10:47:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: vacation plans
Message-ID: <20160613154756.GC12221@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi everybody,

I plan to be on vacation from June 25 - July 17.  I don't know what
Linus has planned, but it's pretty typical to have seven RCs followed
by the release.  If he follows that schedule, the merge window would
open right after I return to work:

  June 12  v4.7-rc3
  ...
  July 10  v4.7-rc7 (projected)
  July 17  v4.7 release, merge window opens (projected)

I'd like to have as much of the v4.8 content as possible in -next and
ready to merge by June 24.  I may be able to handle some simple things
after July 17 and still get them in during the merge window, but I
don't like to add significant pieces that late.

Alex Williamson <alex.williamson@redhat.com> has agreed to help with
any issues that need to be resolved before v4.7 releases.  He's
welcome to get things ready for the v4.8 window, too, but he has his
own full-time job, so please don't impose on him unnecessarily.

My current to-do list is attached below.  All the obvious things for
v4.7 are already in my for-linus branch; let me know if there are
others.

Bjorn


  posted  v   #  s  author         description
  ------ --  --  -  -------------  -----------------------------------
  05/05       2  W  Christoph      IRQ vector alloc/free
  05/08  v2   2  W  Jayachandran   PCI_DEV_FLAGS_DMA_ALIAS_ROOT
  05/11  v5   1     Jonathan       PTM
  05/12       1     David          Fix __pci_bus_size_bridges
  05/12  v3         Yongji         mmap sub-page MMIO BARs
  05/13  v2  13     Lukas          Thunderbolt, runtime PM
  05/17  v2   2     Keith          VMD fixes
  05/17       2     Keith          SR-IOV NVMe fixes
  05/23       6     Amir           Thunderbolt
  05/23       1     Lukas          Broadcom reset quirk
  05/24       1     Mika           power on bridges before scanning
  05/24       1     Peter          power on bridges, nouveau lockup
  05/25       1     Mika           wait 50ms after bridge poweron
  06/02       4     Yongji         force all MMIO BARs to be page aligned
  06/02       6     Yongji         allow MSI-X table exposure
  06/02  v6   5  *  Mika           runtime PM for PCIe ports
  06/02       3     Tomasz         ECAM quirks
  06/02       1     Stefan         MVEBU window fix
  06/06       1     Koehrer        force page alignment
  06/06       4     Mika           DPC devm, module_port_service
  06/06      25     Bjorn          host bridge window resources
  06/07       6     Johannes       request/release regions
  06/08       1     Fabio          imx6 regulator
  06/08       1     Koehrer        alignment arg
  06/08  v2   2     Shawn          Rockchip driver
  06/08  v3   4     Lorenzo        PCI_PROBE_ONLY stuff
  06/08       1     Fabio          imx6 clocks
  06/09       1     Krzysztof      ARM revert
  06/09       4     Ilya           VFIO SRIOV stuff
  06/09       3     Bjorn          write-combining pgprot stuff
  06/10       1     Krzysztof      dma-mapping attrs
  06/10  v2   3     Thomas         Marvell aardvark controller driver

  (s: *=must, W=waiting on author, L=for-linus (for v4.7), T=trivial)
