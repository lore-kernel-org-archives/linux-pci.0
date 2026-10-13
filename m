Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7039061C;
	Tue, 13 Oct 2026 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897512; cv=none; b=FM+ce/F2SM83IolsrMURB3NjTiE0oSNFMWS9SYgI+xLvTvvQCkpWx55+k9OHz4rxaUHSDRgBWcD8Jv/EvaugSPGFZxHDSwZlBCJW8yZw8lFXEdo+l0iN9ASUN92UHomHW1FrHEs5A98BX9X1LWvegmCIjQ12Evd5m/SNTlCTr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897512; c=relaxed/simple;
	bh=iMM7B07RGAhdaG88p2Fh3zxjjwLvilGYdYxyFUfcAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKinWMEuscuugqqTORUk5Cz8AlEAh8SiwbGHlzvyhu/5GpKisX7ClNAq2410HqAHsgcpAbvlKTUvPrLwHKQWAS2yBUr2YO/5AuFIXVqSEX21hfoEQ4IcPr40MXMsAp+o6hatNz59C0hHx/MOrj3f4Zhtix+JH1nq6ENWpjyQj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeDlZbp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeDlZbp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5621F000FF;
	Tue, 13 Oct 2026 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897510;
	bh=lLHjE0fqPkBa5+OY4qAIDHIlMMXd8D6vjn8edRHmed8=;
	h=From:To:Cc:Subject:Date;
	b=NeDlZbp0JaSoCy0ivQoadJLfj0V6aVvhElDLeyv/24cZDkjY9mFKpZc7bZWsL9T2v
	 bHtzXfBuDsbcMYuNDZP3o6Pq+4Z1WUhoFRYGUu4xbG3diTxVZvuTQDZiHxPiknxwlJ
	 SqLm6QX6fSDABwJsulaTjoSYL0s06Pk8nHLq9jL8GxV42VO5uZQs8yHpu1JLsJXWYU
	 dt/nTrRxwZIkcdrA50fnvvjFDFbOvRJrysvttKNjcBYqFCpxTEao5AeZ/STTTJdSHR
	 9FJrD+1kaQBlEsahi1I83ZFoJUCemEiV2jkYtR9pz4xmOc7Q5fKT1aPqVR595lOXR0
	 Fwy/9fpl9f7Fw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	mfd@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/53] MIPS: SGI-IP27: add support for the IP35 (Bedrock hub) machines
Date: Tue, 13 Oct 2026 15:16:20 +0200
Message-ID: <cover.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the SGI machines built around the Bedrock
hub (IP35), such as Fuel and Tezro, to the IP27 platform code.

Patches 1-5 fix the config space accessors and slot setup of the
Bridge, XBridge and PIC driver: device numbers past the last slot,
slots the PROM leaves unconfigured, the type 1 IOC3 write, posted
config writes and slots whose devio window the PROM maps elsewhere.

Patches 6-22 teach the IP27 code the Bedrock hub: detection, the node
address layout and register windows, the node id, CPU slots, memory
banks, both PIs and the kernel load address.

Patches 23-32 add the crossbar, bridge and I/O parts of these machines:
PXBow, XBridge, PIC and IOC4.

Patches 33-44 add the L1 system controller and what it provides, the
Origin 300 IO8 serial interrupts, the Odyssey graphics widget, the
KLCONFIG console and a topology package id per CPU.

Patches 45-47 add a libata driver for the IOC4 ATA/ATAPI controller,
which carries the DVD-ROM of Tezro and Origin 350 I-bricks. It drives
PIO4 and multiword DMA mode 2.

Patch 48 updates ip27_defconfig to the onboard hardware of these
machines, dropping add-in card drivers and enabling USB and PS/2
input. Patch 49 enables the IOC4 ATA driver in it.

Patches 50-53 add a driver for the Fuel and Tezro front-panel LEDs,
which the L1 sets, as white:status and red:fault. The red LED blinks
on panic, and a Tezro shows the OS state on its L1 display.

The series applies on top of "[PATCH v2] MIPS: SGI-IP27: print the NMI
dump on an nbcon console", which the NMI dump needs to reach the 8250
console.

Tested on SGI Fuel and Tezro, the Fuel with an LSI 53C1030 and an NVMe
drive behind a PCI-X-to-PCIe bridge in slots the PROM leaves
unconfigured, on a 4GB Tezro with an LSI SAS1064 on a PCI-X bus, and
for patch 5 also on an Octane. Patches 50-53 were tested on a Tezro
only, and patch 48 was only built.

On IP27 (Hub) machines:
- patch 22 moves the kernel up by 144KB, and the 144KB below it stays
  reserved and unused;
- with patch 26 SWIOTLB takes 64MB of node 0 on a multi-node Origin,
  and ZONE_DMA32 spans the first 2GB;
- the XBridge and PIC DMA address forms (patch 26) and the w1 change
  (patch 39) do nothing on a Hub with classic Bridges;
- patches 1-5 change the config space handling of its Bridges as well.

Given I have no IP27 boxes, none of this was booted on one.
ip27_defconfig builds at every patch, ip30_defconfig at every patch
that changes code it builds.

An XBridge or PIC on a Bedrock hub takes its board setup from the
first board part number the L1 reports that the setup table knows
(patch 35), so on a machine with several bricks every such bridge gets
that one board's setup.

Patch 42 registers the Odyssey graphics widget as the "sgi-odyssey"
platform device used by the Odyssey DRM driver, a separate series, and
passes it the master widget id as the "sgi,master-widget" property.

checkpatch reports "spaces required around that ':'" in patches 14 and
21 for the GAS numeric local labels 1: and 2: in assembler macros.

Changes in v2:
- New patches 1-5 (Bridge config space and slot fixes), 37 (Origin
  300 IO8 serial interrupts), 45-47 and 49 (IOC4 ATA/ATAPI), 48
  (ip27_defconfig update) and 50-53 (front-panel LEDs).
- Patch 15 (was 10): slot 0 takes master_nasid as its node, not 0.
- Patch 24 (was 19): also enables the SGI 1-wire master and the DS250x
  slave the Bridge probe waits for.
- Patch 25 (was 20): comment and message name the IOC3 on the 32-bit
  window behind an XBridge or PIC.
- Patch 26 (was 21), retitled (Christoph Hellwig): an XBridge or PIC
  device with a 64-bit DMA mask uses the 64-bit direct form with bit 55
  set, other devices the 32-bit window with SWIOTLB and ZONE_DMA32; a
  PIC bus in PCI-X mode uses the direct form only; the IOC3 and IOC4
  always use the window, with byte swapping off; an IOC3 or IOC4 MFD
  cell maps through its PCI parent.
- Patch 29 (was 24): the PIC slot count goes through bridge_nslots()
  from patch 1.
- Patch 30 (was 25): probe fails without a platform device id.
- Patch 31 (was 26): probe fails on a PCI id without variant data;
  const mfd_cell array; MAINTAINERS covers sgi-ioc3-serial.h; the IOC4
  register layout includes the ATA/ATAPI block; the IOC4 firmware
  revision is printed, and the serial ports need revision 62 or later;
  the PCI id is PCI_DEVICE_ID_SGI_IOC4, which patch 26 adds.
- Patch 36 (was 31): const mfd_cell array.
- Patch 38 (was 32): the random fallback address is set with
  eth_hw_addr_random().
- Patch 42 (was 36): passes the "sgi,master-widget" property.
- Patch 43 (was 37): the PROM's console baud rate is printed unsigned,
  so 38400 does not come out negative.
- mfd subjects capitalised; rebased onto v7.3-rc7 and the NMI v2 patch.
- v1: https://lore.kernel.org/all/cover.1790857966.git.kaloz@kernel.org/

Imre Kaloz (53):
  MIPS: PCI: xtalk-bridge: refuse device numbers past the last slot
  MIPS: PCI: xtalk-bridge: assign slots the PROM leaves unconfigured
  MIPS: PCI: xtalk-bridge: write a type 1 IOC3 through the type 1 window
  MIPS: PCI: xtalk-bridge: flush config space writes
  MIPS: PCI: xtalk-bridge: reassign slots whose devio window maps
    elsewhere
  MIPS: Xtalk: guard the widget identification table from assembly
  MIPS: SGI-IP27: dump the NMI save areas the CPU scan recorded
  MIPS: SGI-IP27: add REMOTE_HUB_PI_S()/REMOTE_HUB_PI_L()
  MIPS: SGI-IP27: detect Bedrock hubs at boot
  MIPS: SGI-IP27: widen Kconfig for the Bedrock-based machines
  MIPS: SGI-IP27: fold the dead SN1 arm out of klconfig.h
  MIPS: SGI-IP27: choose the node address layout at runtime
  MIPS: SGI-IP27: add the Bedrock hub register windows
  MIPS: SGI-IP27: decode a Bedrock hub's node id and system size
  MIPS: SGI-IP27: put a Bedrock hub's boot CPU in slot 0
  MIPS: SGI-IP27: lay out node memory in 1GB banks on Bedrock hubs
  MIPS: SGI-IP27: reserve the bottom 64MB of node 0 on Bedrock hubs
  MIPS: SGI-IP27: route interrupt masks and slices through both PIs
  MIPS: SGI-IP27: address a CPU's own PI for NMI, IPI and RT counter
  MIPS: SGI-IP27: take a CPU's node from the CPU table in per_cpu_init()
  MIPS: SGI-IP27: resolve the mapped-kernel node shift at runtime
  MIPS: SGI-IP27: load the kernel at node offset 0x40000
  MIPS: SGI-IP27: xbow_probe(): recognize KLTYPE_PBRICK_XBOW
  MIPS: ip27_defconfig: enable the IOC3 MFD, its cell drivers and tg3
  net: ethernet: sgi: ioc3-eth: apply the DMA attributes only to 64-bit
    addresses
  MIPS: SGI-IP27: pick the XBridge and PIC DMA address form by mask
  MIPS: SGI-IP27: recognize the PXBow crossbar
  MIPS: PCI: xtalk-bridge: recognize the PIC widget's 64-bit-only
    registers
  MIPS: PCI: xtalk-bridge: match PIC's register-level differences
  rtc: m48t35: support the SGI IP35 timekeeper's 1968 year base
  mfd: ioc3: Add support for IOC4
  MIPS: SGI-IP27: dispatch the early console between IOC3 and IOC4
  MIPS: SGI-IP27: add L1 system controller support
  MIPS: SGI-IP27: wire the L1 into reset and the Ethernet address
  MIPS: PCI: xtalk-bridge: take the board part number from the L1
  mfd: ioc3: Add IP34 system-board entry to ioc3_infos[]
  mfd: ioc3: Cross the serial IRQs on the Origin 300 IO8
  net: ethernet: sgi: ioc3-eth: fall back to the platform MAC address
  MIPS: SGI-IP27: don't register a w1 master on an XBridge or PIC
  MIPS: SGI-IP27: report a Bedrock machine as SGI IP35
  MIPS: SGI-IP27: identify the machine by the L1 brick type
  MIPS: SGI-IP27: register the Odyssey graphics widget
  MIPS: SGI-IP27: take the console from the KLCONFIG header on IP35
  MIPS: SGI-IP27: give each CPU its own topology package id
  ata: add pata_sgiioc4 driver for the SGI IOC4 ATA/ATAPI controller
  mfd: ioc3: Add IOC4 ATA/ATAPI cell
  MAINTAINERS: add an entry for the SGI IOC4 ATA driver
  MIPS: ip27_defconfig: update for the onboard hardware
  MIPS: ip27_defconfig: enable pata_sgiioc4 and the DVD-ROM path
  MIPS: SGI-IP27: add L1 front-panel LED and display requests
  leds: Add driver for the SGI Fuel and Tezro front-panel LEDs
  MIPS: SGI-IP27: show the OS state on the Fuel and Tezro front panels
  MIPS: ip27_defconfig: enable the Fuel and Tezro front-panel LEDs

 MAINTAINERS                                   |   7 +
 arch/mips/Kconfig                             |  13 +-
 arch/mips/configs/ip27_defconfig              | 192 +---
 .../include/asm/mach-ip27/kernel-entry-init.h |  33 +-
 arch/mips/include/asm/pci/bridge.h            |  88 +-
 arch/mips/include/asm/sn/addrs.h              |  39 +-
 arch/mips/include/asm/sn/agent.h              |   5 +-
 arch/mips/include/asm/sn/arch.h               |   8 +
 arch/mips/include/asm/sn/intr.h               |  14 +-
 arch/mips/include/asm/sn/ioc4.h               | 143 +++
 arch/mips/include/asm/sn/klconfig.h           |  19 +-
 arch/mips/include/asm/sn/kldir.h              |   1 +
 arch/mips/include/asm/sn/l1.h                 |  38 +
 arch/mips/include/asm/sn/mapped_kernel.h      |   6 +-
 arch/mips/include/asm/sn/sn0/addrs.h          |   8 +-
 arch/mips/include/asm/sn/sn0/hub.h            |  37 +-
 arch/mips/include/asm/sn/sn0/hubni.h          |   3 +
 arch/mips/include/asm/sn/sn1/addrs.h          |  22 +
 arch/mips/include/asm/sn/sn1/hub.h            |  40 +
 arch/mips/include/asm/sn/sn1/kldir.h          |  14 +
 arch/mips/include/asm/xtalk/xwidget.h         |  11 +-
 arch/mips/pci/pci-xtalk-bridge.c              | 467 ++++++++-
 arch/mips/sgi-ip27/Makefile                   |   4 +-
 arch/mips/sgi-ip27/Platform                   |  11 +-
 arch/mips/sgi-ip27/ip27-berr.c                |   4 +-
 arch/mips/sgi-ip27/ip27-console.c             |  47 +-
 arch/mips/sgi-ip27/ip27-init.c                | 178 +++-
 arch/mips/sgi-ip27/ip27-irq.c                 |  17 +-
 arch/mips/sgi-ip27/ip27-l1.c                  | 884 ++++++++++++++++++
 arch/mips/sgi-ip27/ip27-memory.c              |  55 +-
 arch/mips/sgi-ip27/ip27-nmi.c                 |  54 +-
 arch/mips/sgi-ip27/ip27-reset.c               |  47 +-
 arch/mips/sgi-ip27/ip27-smp.c                 |  41 +-
 arch/mips/sgi-ip27/ip27-timer.c               |  12 +-
 arch/mips/sgi-ip27/ip27-xtalk.c               | 138 ++-
 drivers/ata/Kconfig                           |  10 +
 drivers/ata/Makefile                          |   1 +
 drivers/ata/pata_sgiioc4.c                    | 311 ++++++
 drivers/leds/Kconfig                          |  12 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-ip35.c                      | 144 +++
 drivers/mfd/ioc3.c                            | 455 ++++++++-
 drivers/net/ethernet/sgi/ioc3-eth.c           |  44 +-
 drivers/rtc/rtc-m48t35.c                      |  33 +-
 drivers/tty/serial/8250/8250_ioc3.c           |   5 +-
 include/linux/pci_ids.h                       |   1 +
 include/linux/platform_data/sgi-ioc3-serial.h |  13 +
 include/linux/platform_data/xtalk-bridge.h    |   2 +
 48 files changed, 3334 insertions(+), 398 deletions(-)
 create mode 100644 arch/mips/include/asm/sn/ioc4.h
 create mode 100644 arch/mips/include/asm/sn/l1.h
 create mode 100644 arch/mips/include/asm/sn/sn1/addrs.h
 create mode 100644 arch/mips/include/asm/sn/sn1/hub.h
 create mode 100644 arch/mips/include/asm/sn/sn1/kldir.h
 create mode 100644 arch/mips/sgi-ip27/ip27-l1.c
 create mode 100644 drivers/ata/pata_sgiioc4.c
 create mode 100644 drivers/leds/leds-ip35.c
 create mode 100644 include/linux/platform_data/sgi-ioc3-serial.h


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
prerequisite-patch-id: 642054c4c189f29a3f589a119d2311c20e395a23
-- 
2.47.3

