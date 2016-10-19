Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:5291
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751543AbcJSFWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Oct 2016 01:22:50 -0400
Subject: Intel H81 Chipset PCIe configuration question
References: <2cc60cd1-bab1-a086-2326-7ce161b8f083@ou.edu>
 <efdbf332-841c-7617-efd1-facf785472fd@ou.edu>
 <20160926155018.GL14311@csclub.uwaterloo.ca>
 <68936975-5496-0e0d-5137-d48575e8ec0d@ou.edu>
 <20160929142424.GB14309@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        yinghai Lu <yinghai@kernel.org>,
        Blackmagic Developer Support <developer@blackmagicdesign.com>
To: linux-pci@vger.kernel.org
From: Steve Kenton <skenton@ou.edu>
Message-ID: <fa73b278-6f8c-5ccc-a9dc-b7076f1a9271@ou.edu>
Date: Tue, 18 Oct 2016 21:50:22 -0500
MIME-Version: 1.0
In-Reply-To: <20160929142424.GB14309@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A while back I posted about a motherboard network controller that
disappeared when the firmware on a PCIe card was upgraded which
converted the card from a 32-bit BAR to a 64-bit BAR. That seems to be a
BIOS bug rather than a kernel issue. But, I would really like to be able
to upgrade the systems in the field so I'm still chasing the BIOS issue
and I'm puzzled by a programming issue when configuring the PCIe
settings of the Intel 8-Series/C220 chipset. I'm hoping someone here can
shine a bit of light on it. The device of interest is the Realtek Lan at
1c.5 which is "Port6" in Intel nomencature.
http://www.intel.com/content/www/us/en/chipsets/8-series-chipset-pch-datasheet.html

The BIOS has an ME-Disable option so I disabled the Intel Management
Engine and then used flashrom to create an 8MB "oem.bin" image of the
bios. At the beginning of oem.bin is an SPI Flash Descriptor Signature
0FF0A55Ah so I used the coreboot ifdtool program to dump the SPI Flash
Descriptor information below. It appears to be both valid and sane. In
particular, soft strap 9 (PCHSTRP9:  0x30540580) looks like it sets all
the PCIe lanes to an x1 configuration. On the other hand "lspci -s 1c.5
xxx" shows the Link Capabilities Register (LCAP: 0x06323C12) which means
Port5 with x2 lanes, Port6 disabled and Ports7/8 (which do not exist on
the H81 SKU) as x1 lanes. This is the working configuration so something
strange is going on. To the best of my understanding it is not possible
to change the port width and override the soft strap settings in ROM by
rewriting any chipset registers. Anybody have any ideas how the BIOS
could be doing this?

After the firmware is upgraded on the card the the motherboard network
controller disappears from lspci output and the bridge reports an x0
width link status instead of the x1 width previously shown with the
working configuration. Very odd.

Steve Kenton


LnkCap:	Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
<1us, L1 <16us
ClockPM- Surprise- LLActRep+ BwNot+
LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive-
BWMgmt- ABWMgmt-

$ lspci -tv
-[0000:00]-+-00.0  Intel Corporation 4th Gen Core Processor DRAM Controller
           +-01.0-[01]----00.0  Blackmagic Design Intensity Pro 4K
           +-02.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor Integrated Graphics Controller
           +-03.0  Intel Corporation Xeon E3-1200 v3/4th Gen Core
Processor HD Audio Controller
           +-14.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB xHCI
           +-1a.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB EHCI #2
           +-1b.0  Intel Corporation 8 Series/C220 Series Chipset High
Definition Audio Controller
           +-1c.0-[02]--
           +-1c.5-[03]----00.0  Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
           +-1d.0  Intel Corporation 8 Series/C220 Series Chipset Family
USB EHCI #1
           +-1f.0  Intel Corporation C220 Series Chipset Family H81
Express LPC Controller
           +-1f.2  Intel Corporation 8 Series/C220 Series Chipset Family
6-port SATA Controller 1 [AHCI mode]
           \-1f.3  Intel Corporation 8 Series/C220 Series Chipset Family
SMBus Controller

sudo lspci -s 1c.5 -xxx >lspcis1c5xxxgood.txt

00:1c.5 PCI bridge: Intel Corporation 8 Series/C220 Series Chipset
Family PCI Express Root Port #6 (rev d5)
00: 86 80 1a 8c 07 04 10 00 d5 00 04 06 10 00 81 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 e0 e0 00 00
20: c0 f7 c0 f7 01 f0 01 f0 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 03 02 10 00
40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 32 06 ==> 06323C12:
LCAP@4Ch–4Fh = 00000110 00 1 1 0 0 100 011 11 000001 0010 								Port6
from 1 x2 and 2 x1s: Port 5 (x2), Port 7 (x1) and Port 8 (x1)
50: 40 00 11 70 00 b2 2c 00 00 00 40 00 08 00 00 00 ==> 7011:
LSTS@52h–53h = 01 1 1 0 0 000001 0001 = x1 Negotiated Link Width NW
60: 00 00 00 00 17 08 00 00 00 04 00 00 00 00 00 00
70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 90 01 00 18 03 e0 fe 00 00 00 00 00 00 00 00
90: 0d a0 00 00 19 10 cf 7e 00 00 00 00 00 00 00 00
a0: 01 00 03 c8 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 01 42 18 00 00 08 80 11 0b 00 00 00 00
e0: 00 03 00 00 00 00 3c 88 11 00 00 00 00 00 00 00
f0: 50 00 00 00 40 00 00 0c b1 0f 06 08 b0 03 00 06 ==> 060003b0:
PECR4@FCh–FFh = 00 000110 00 00 0 000 00 00 00 11101100 00
							Root Port Configuration Strap RPC_STRAP ???

File oem.bin is 8388608 bytes
FLMAP0:    0x02040003
  NR:      2
  FRBA:    0x40
  NC:      1
  FCBA:    0x30
FLMAP1:    0x15100206
  ISL:     0x15
  FPSBA:   0x100
  NM:      2
  FMBA:    0x60
FLMAP2:    0x00210120
  PSL:     0x2101
  FMSBA:   0x200
FLUMAP1:   0x00001cdf
  Intel ME VSCC Table Length (VTL):        28
  Intel ME VSCC Table Base Address (VTBA): 0x000df0

ME VSCC table:
  JID0:  0x001730ef
    SPI Componend Device ID 1:          0x17
    SPI Componend Device ID 0:          0x30
    SPI Componend Vendor ID:            0xef
  VSCC0: 0x20052005
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x50
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x50
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID1:  0x001740ef
    SPI Componend Device ID 1:          0x17
    SPI Componend Device ID 0:          0x40
    SPI Componend Vendor ID:            0xef
  VSCC1: 0x20252025
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x50
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x50
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID2:  0x001720c2
    SPI Componend Device ID 1:          0x17
    SPI Componend Device ID 0:          0x20
    SPI Componend Vendor ID:            0xc2
  VSCC2: 0x20452045
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x50
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x50
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID3:  0x00177120
    SPI Componend Device ID 1:          0x17
    SPI Componend Device ID 0:          0x71
    SPI Componend Vendor ID:            0x20
  VSCC3: 0x20052005
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x50
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x50
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID4:  0x0017ba20
    SPI Componend Device ID 1:          0x17
    SPI Componend Device ID 0:          0xba
    SPI Componend Vendor ID:            0x20
  VSCC4: 0x20052005
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x50
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x50
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID5:  0x0000481f
    SPI Componend Device ID 1:          0x00
    SPI Componend Device ID 0:          0x48
    SPI Componend Vendor ID:            0x1f
  VSCC5: 0x20152015
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x06
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x06
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID6:  0x0000881f
    SPI Componend Device ID 1:          0x00
    SPI Componend Device ID 0:          0x88
    SPI Componend Vendor ID:            0x1f
  VSCC6: 0x20752075
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x06
    Lower Write Status Required:        No
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x06
    Upper Write Status Required:        No
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB
  JID7:  0x004b25bf
    SPI Componend Device ID 1:          0x4b
    SPI Componend Device ID 0:          0x25
    SPI Componend Vendor ID:            0xbf
  VSCC7: 0x200d200d
    Lower Erase Opcode:                 0x20
    Lower Write Enable on Write Status: 0x50
    Lower Write Status Required:        Yes
    Lower Write Granularity:            64 bytes
    Lower Block / Sector Erase Size:    4KB
    Upper Erase Opcode:                 0x20
    Upper Write Enable on Write Status: 0x50
    Upper Write Status Required:        Yes
    Upper Write Granularity:            64 bytes
    Upper Block / Sector Erase Size:    4KB

OEM Section:
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Found Region Section
FLREG0:    0x00000000
  Flash Region 0 (Flash Descriptor): 00000000 - 00000fff
FLREG1:    0x07ff0400
  Flash Region 1 (BIOS): 00400000 - 007fffff
FLREG2:    0x03ff0001
  Flash Region 2 (Intel ME): 00001000 - 003fffff
FLREG3:    0x00007fff
  Flash Region 3 (GbE): 00fff000 - 00000fff (unused)
FLREG4:    0x00007fff
  Flash Region 4 (Platform Data): 00fff000 - 00000fff (unused)

Found Component Section
FLCOMP     0x24900044
  Dual Output Fast Read Support:       not supported
  Read ID/Read Status Clock Frequency: 50MHz
  Write/Erase Clock Frequency:         50MHz
  Fast Read Clock Frequency:           50MHz
  Fast Read Support:                   supported
  Read Clock Frequency:                20MHz
  Component 2 Density:                 512KB
  Component 1 Density:                 8MB
FLILL      0x00000000
  Invalid Instruction 3: 0x00
  Invalid Instruction 2: 0x00
  Invalid Instruction 1: 0x00
  Invalid Instruction 0: 0x00
FLPB       0x00000000
  Flash Partition Boundary Address: 0x000000

Found PCH Strap Section
PCHSTRP0:  0x0020d4a2
PCHSTRP1:  0x040001cf
PCHSTRP2:  0x00000000
PCHSTRP3:  0x00000000
PCHSTRP4:  0x00000000
PCHSTRP5:  0x00000000
PCHSTRP6:  0x00000000
PCHSTRP7:  0x00000000
PCHSTRP8:  0x00000000
PCHSTRP9:  0x30540580
PCHSTRP10: 0x00400000
PCHSTRP11: 0x00000000
PCHSTRP12: 0x00000000
PCHSTRP13: 0x00000000
PCHSTRP14: 0x00000000
PCHSTRP15: 0x0008c33e
PCHSTRP16: 0x00000000
PCHSTRP17: 0x00000002

Found Master Section
FLMSTR1:   0x0a0b0000 (Host CPU/BIOS)
  Platform Data Region Write Access: disabled
  GbE Region Write Access:           enabled
  Intel ME Region Write Access:      disabled
  Host CPU/BIOS Region Write Access: enabled
  Flash Descriptor Write Access:     disabled
  Platform Data Region Read Access:  disabled
  GbE Region Read Access:            enabled
  Intel ME Region Read Access:       disabled
  Host CPU/BIOS Region Read Access:  enabled
  Flash Descriptor Read Access:      enabled
  Requester ID:                      0x0000

FLMSTR2:   0x0c0d0000 (Intel ME)
  Platform Data Region Write Access: disabled
  GbE Region Write Access:           enabled
  Intel ME Region Write Access:      enabled
  Host CPU/BIOS Region Write Access: disabled
  Flash Descriptor Write Access:     disabled
  Platform Data Region Read Access:  disabled
  GbE Region Read Access:            enabled
  Intel ME Region Read Access:       enabled
  Host CPU/BIOS Region Read Access:  disabled
  Flash Descriptor Read Access:      enabled
  Requester ID:                      0x0000

FLMSTR3:   0x08080118 (GbE)
  Platform Data Region Write Access: disabled
  GbE Region Write Access:           enabled
  Intel ME Region Write Access:      disabled
  Host CPU/BIOS Region Write Access: disabled
  Flash Descriptor Write Access:     disabled
  Platform Data Region Read Access:  disabled
  GbE Region Read Access:            enabled
  Intel ME Region Read Access:       disabled
  Host CPU/BIOS Region Read Access:  disabled
  Flash Descriptor Read Access:      disabled
  Requester ID:                      0x0118

Found Processor Strap Section
????:      0x00000000
????:      0xffffffff
????:      0xffffffff
????:      0xffffffff
