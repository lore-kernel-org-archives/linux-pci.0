Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39812 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbbICMQh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Sep 2015 08:16:37 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/4] PCI: arm64/powerpc: Fix parsing of linux,pci-probe-only
Date: Thu,  3 Sep 2015 13:16:12 +0100
Message-Id: <1441282576-7304-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci-host-generic driver parses the linux,pci-probe-only property,
and assumes that it will have a boolean parameter.

Turns out that the Seattle DTS file has a naked "linux,pci-probe-only"
property, which leads to the driver dereferencing some unsuspecting
memory location. Nothing really bad happens (we end up reading some
other bit of DT, fortunately), but that not a reason to keep it this
way. Turns out that the Pseries code (where this code was lifted from)
may suffer from the same issue.

The first patch introduces a common (and fixed) version of that check
that can be used by drivers and architectures that require it. The two
following patches change the pci-host-generic driver and the powerpc
code to use it.

Finally, the bad property is removed from the Seatle DTS, because it
is simply not necessary (it actually prevents me from using SR-IOV,
which otherwise runs fine without the probe-only thing).

This has been tested on the offending Seattle board.

* From v2:
  - Use of_property_read_u32 to safely read the property (Rob)
  - Add a log message to indicate when we enable probe-only
    (probably quite useful for debugging)

* From v1:
  - Consolidate the parsing in of_pci.c (Bjorn)

Marc Zyngier (4):
  of/pci: Add of_pci_check_probe_only to parse "linux,pci-probe-only"
  PCI: pci-host-generic: Fix lookup of linux,pci-probe-only property
  powerpc: PCI: Fix lookup of linux,pci-probe-only property
  arm64: dts: Drop linux,pci-probe-only from the Seattle DTS

 arch/arm64/boot/dts/amd/amd-overdrive.dts |  1 -
 arch/powerpc/platforms/pseries/setup.c    | 14 ++------------
 drivers/of/of_pci.c                       | 31 +++++++++++++++++++++++++++++++
 drivers/pci/host/pci-host-generic.c       |  9 +--------
 include/linux/of_pci.h                    |  3 +++
 5 files changed, 37 insertions(+), 21 deletions(-)

-- 
2.1.4

