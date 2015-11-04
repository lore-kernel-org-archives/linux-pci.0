Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:24264 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754388AbbKDN5x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Nov 2015 08:57:53 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	Magnus <magnus.damm@gmail.com>
Subject: PCIe host controller behind IOMMU on ARM
Date: Wed, 4 Nov 2015 13:57:48 +0000
Message-ID: <PS1PR06MB11807CBE8EB2AC6B0158D2B5F52A0@PS1PR06MB1180.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am trying to hook up a PCIe host controller that sits behind an IOMMU,
but having some problems.

I'm using the pcie-rcar PCIe host controller and it works fine without
the IOMMU, and I can attach the IOMMU to the controller such that any calls
to dma_alloc_coherent made by the controller driver uses the iommu_ops
version of dma_ops.

However, I can't see how to make the endpoints to utilise the dma_ops that
the controller uses. Shouldn't the endpoints inherit the dma_ops from the
controller? Any pointers for this?

Thanks
Phil

