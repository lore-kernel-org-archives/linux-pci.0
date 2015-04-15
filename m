Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0132.outbound.protection.outlook.com ([157.56.111.132]:15296
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932187AbbDOJqx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 05:46:53 -0400
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH v2 0/3] pci/designware: Add architecture-independent driver for Designware PCIe
Date: Wed, 15 Apr 2015 17:48:32 +0800
Message-ID: <1429091315-31891-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Synopsys Designware IP is shared with couples of platforms
under multiple architectures. The series of patches is to
provide basic architecture-independent Designware PCIe host
driver including ATU initialization and PCI OPS. Currently,
which supports arm and arm64 simultaneously.

I do not directly add arm64 support to pcie-designware.c, the
main reason is that it is hard to port other 5 platform PCIe
driver based on pcie-designware to the new implementation.
However, not changing those PCIe driver means the code for
arm32 must be remained.

I add a new file pcie-designware-base.c. Compared with
pcie-designware.c, there are main 3 differences.
1. It is a new implementation followed the latest PCIe
architecture-independent API without any code for specific
architecture.
2. There is no MSI chip code, which will be implemented in a 
separated file.
3. Improve ATU use - support more than 2 ATUs and use an exclusive
ATU to translate MEM transaction.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

-- 
1.9.1

