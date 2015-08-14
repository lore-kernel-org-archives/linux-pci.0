Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38622 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbbHNOlP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Aug 2015 10:41:15 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: arm64/powerpc: Fix parsing of linux,pci-probe-only
Date: Fri, 14 Aug 2015 15:41:05 +0100
Message-Id: <1439563268-13418-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci-host-generic driver parses the linux,pci-probe-only property,
and assumes that it will have a boolean parameter.

Turns out that the Seattle DTS file has a naked "linux,pci-probe-only"
property, which leads to the driver dereferencing some unsuspecting
memory location. Nothing really bad happens (we end up reading some
other bit of DT, fortunately), but that not a reason to keep it this
way.

The first patch fixes the driver not to do silly things, and simply
give a warning when this happens. The powerpc code from where this
code was lifted is also fixed in a second patch.

Finally, the bad property is removed from the Seatle DTS, because it
is simply not necessary (it actually prevents me from using SR-IOV,
which otherwise runs fine without the probe-only thing).

Marc Zyngier (3):
  PCI: pci-host-generic: Fix lookup of linux,pci-probe-only property
  powerpc: PCI: Fix lookup of linux,pci-probe-only property
  arm64: dts: Drop linux,pci-probe-only from the Seattle DTS

 arch/arm64/boot/dts/amd/amd-overdrive.dts |  1 -
 arch/powerpc/platforms/pseries/setup.c    | 15 ++++++++++-----
 drivers/pci/host/pci-host-generic.c       | 15 ++++++++++-----
 3 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.1.4

