Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47019 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab3LSWB3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2013 17:01:29 -0500
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id rBJM1TCg030969
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2013 16:01:29 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id rBJM1TBt022666
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2013 16:01:29 -0600
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: pcie designware question
Date: Thu, 19 Dec 2013 22:01:28 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B70465DDAD@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am working to port my pcie driver to pcie-designware core driver. The pcie sub system
 on our platform  has 32 OUTBOUND regions and 2 INBOUND regions. In my current driver,
I use internal memory map of CPU to access the RC's config/application space as well EP's
config space. a 4K range is available to access the EP's config space. To allow write/read to
the EP's config space, the driver basically write the bus, device and function number to the
 application CFG_SETUP register and then access the corresponding EP's config register.

I have reviewed the designware.c code and the glue logic driver pci-exynos.c and couldn't
understand few things.

1. Our pcie ss is based on designware core and following addresses are not listed in our IP's
 data manual. Where is defined? It does show the rest of the offsets defined in
 drivers/pci/host/designware.c and 

#define PCIE_ATU_VIEWPORT               0x900
#define PCIE_ATU_REGION_INBOUND         (0x1 << 31)
#define PCIE_ATU_REGION_OUTBOUND        (0x0 << 31)
#define PCIE_ATU_REGION_INDEX1          (0x1 << 0)
#define PCIE_ATU_REGION_INDEX0          (0x0 << 0)
#define PCIE_ATU_CR1                    0x904
#define PCIE_ATU_TYPE_MEM               (0x0 << 0)
#define PCIE_ATU_TYPE_IO                (0x2 << 0)
#define PCIE_ATU_TYPE_CFG0              (0x4 << 0)
#define PCIE_ATU_TYPE_CFG1              (0x5 << 0)
#define PCIE_ATU_CR2                    0x908
#define PCIE_ATU_ENABLE                 (0x1 << 31)
#define PCIE_ATU_BAR_MODE_ENABLE        (0x1 << 30)
#define PCIE_ATU_LOWER_BASE             0x90C
#define PCIE_ATU_UPPER_BASE             0x910
#define PCIE_ATU_LIMIT                  0x914
#define PCIE_ATU_LOWER_TARGET           0x918
#define PCIE_ATU_BUS(x)                 (((x) & 0xff) << 24)
#define PCIE_ATU_DEV(x)                 (((x) & 0x1f) << 19)
#define PCIE_ATU_FUNC(x)                (((x) & 0x7) << 16)
#define PCIE_ATU_UPPER_TARGET           0x91C

2. My understanding is that the designware core currently support 2 OUTBOUND regions
and 2 INBOUND regions. Is this true? Is there a plan to support more than 2?
3. Is there a documentation explaining how the ATU handling code is designed? Basically
as I can't find ATU specific registers defined in the ss spec, I am not able to understand
this code. I do see the application space in our ss spec defining OUTBOUND INDEX/OFFSET
register to configure OUTBOUND regions and IB registers to define the INBOUND region.

4. What is the base address variable used to access RC's application register space? dbi_base
in struct pcie_port ? Also I am assuming this is used for accessing this space from internal
CPU bus and cfg0_base and cfg1_base for accessing it from pci bus. Is this right?

I am trying to figure this out myself, but if someone could explain these, that will be great!

Thanks.

Murali Karicheri
Linux Kernel, Software Development


