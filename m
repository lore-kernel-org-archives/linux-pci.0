Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org,
	jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jszhang@marvell.com, CARLOS.PALMINHA@synopsys.com,
	MiguelFalcao.Sousa@synopsys.com, Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v2 0/2] pcie-designware: add iATU unroll feature
Date: Fri, 22 Jul 2016 14:29:37 +0100
Message-Id: <cover.1469193895.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

The new DWC PCIe Core version (4.80) implements iATU in a different way.
This new mechanism is called iATU Unroll Mode. The Core still supports
the "old" mechanism calling it Legacy Mode if configured to do so, but
the standard way will be using Unroll.
This patch adds the necessary support for the mechanism and makes
some minor improvements to the existent one.

Joao Pinto (2):
  pcie-designware: add iATU Unroll feature
  pcie-designware: add core version

 drivers/pci/host/pcie-designware.c | 161 +++++++++++++++++++++++++++++++++----
 drivers/pci/host/pcie-designware.h |   6 +-
 2 files changed, 148 insertions(+), 19 deletions(-)

-- 
1.8.1.5
