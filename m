Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56484 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbdLDPJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Dec 2017 10:09:44 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 6/8] arch/sh: pcie-sh7786: adjust PCI MEM and IO regions
Date: Mon,  4 Dec 2017 16:09:05 +0100
Message-Id: <20171204150907.24345-7-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current definition of the PCIe IO and MEM resources for SH7786
doesn't match what the datasheet says. For example, for PCIe0
0xfe100000 is advertised by the datasheet as a PCI IO region, while
0xfd000000 is advertised as a PCI MEM region. The code currently
inverts the two.

The SH4A_PCIEPARL and SH4A_PCIEPTCTLR registers allow to define the
base address and role of the different regions (including whether it's
a MEM or IO region). However, practical experience on a SH7786 shows
that if 0xfe100000 is used for LEL and 0xfd000000 for IO, a PCIe
device using two MEM BARs cannot be accessed at all. Simply using
0xfe100000 for IO and 0xfd000000 for MEM makes the PCIe device
accessible.

It is very likely that this was never seen because there are two other
PCI MEM region listed in the resources. However, for different
reasons, none of the two other MEM regions are usable on the specific
SH7786 platform the problem was encountered. Therefore, the last MEM
region at 0xfe100000 was used to place the BARs, making the device
non-functional.

This commit therefore adjusts those PCI MEM and IO resources
definitions so that they match what the datasheet says. They have only
been tested with PCIe 0.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 8d7c328b1899..69da026682ba 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -41,73 +41,73 @@ static struct sh7786_pcie_hwops {
 
 static struct resource sh7786_pci0_resources[] = {
 	{
-		.name	= "PCIe0 IO",
+		.name	= "PCIe0 MEM 0",
 		.start	= 0xfd000000,
 		.end	= 0xfd000000 + SZ_8M - 1,
-		.flags	= IORESOURCE_IO,
+		.flags	= IORESOURCE_MEM,
 	}, {
-		.name	= "PCIe0 MEM 0",
+		.name	= "PCIe0 MEM 1",
 		.start	= 0xc0000000,
 		.end	= 0xc0000000 + SZ_512M - 1,
 		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
 	}, {
-		.name	= "PCIe0 MEM 1",
+		.name	= "PCIe0 MEM 2",
 		.start	= 0x10000000,
 		.end	= 0x10000000 + SZ_64M - 1,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.name	= "PCIe0 MEM 2",
+		.name	= "PCIe0 IO",
 		.start	= 0xfe100000,
 		.end	= 0xfe100000 + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
+		.flags	= IORESOURCE_IO,
 	},
 };
 
 static struct resource sh7786_pci1_resources[] = {
 	{
-		.name	= "PCIe1 IO",
+		.name	= "PCIe1 MEM 0",
 		.start	= 0xfd800000,
 		.end	= 0xfd800000 + SZ_8M - 1,
-		.flags	= IORESOURCE_IO,
+		.flags	= IORESOURCE_MEM,
 	}, {
-		.name	= "PCIe1 MEM 0",
+		.name	= "PCIe1 MEM 1",
 		.start	= 0xa0000000,
 		.end	= 0xa0000000 + SZ_512M - 1,
 		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
 	}, {
-		.name	= "PCIe1 MEM 1",
+		.name	= "PCIe1 MEM 2",
 		.start	= 0x30000000,
 		.end	= 0x30000000 + SZ_256M - 1,
 		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
 	}, {
-		.name	= "PCIe1 MEM 2",
+		.name	= "PCIe1 IO",
 		.start	= 0xfe300000,
 		.end	= 0xfe300000 + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
+		.flags	= IORESOURCE_IO,
 	},
 };
 
 static struct resource sh7786_pci2_resources[] = {
 	{
-		.name	= "PCIe2 IO",
+		.name	= "PCIe2 MEM 0",
 		.start	= 0xfc800000,
 		.end	= 0xfc800000 + SZ_4M - 1,
-		.flags	= IORESOURCE_IO,
+		.flags	= IORESOURCE_MEM,
 	}, {
-		.name	= "PCIe2 MEM 0",
+		.name	= "PCIe2 MEM 1",
 		.start	= 0x80000000,
 		.end	= 0x80000000 + SZ_512M - 1,
 		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
 	}, {
-		.name	= "PCIe2 MEM 1",
+		.name	= "PCIe2 MEM 2",
 		.start	= 0x20000000,
 		.end	= 0x20000000 + SZ_256M - 1,
 		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
 	}, {
-		.name	= "PCIe2 MEM 2",
+		.name	= "PCIe2 IO",
 		.start	= 0xfcd00000,
 		.end	= 0xfcd00000 + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
+		.flags	= IORESOURCE_IO,
 	},
 };
 
-- 
2.13.6
