Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v4 0/3] pcie-designware: add iATU unroll feature
Date: Tue,  9 Aug 2016 17:35:31 +0100
Message-Id: <cover.1470758382.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

The new DWC PCIe Core version (4.80) implements iATU in a different way.
This new mechanism is called iATU Unroll Mode. The Core still supports
the "old" mechanism calling it Legacy Mode if configured to do so, but
the standard way will be using Unroll.
This patch adds the necessary support for the mechanism and makes
some minor improvements to the existent one.

Joao Pinto (3):
  pci: move definitions from header to pcie-designware.c
  pci: add iATU Unroll mechanism
  pcie-designware: fix typo

 drivers/pci/host/pcie-designware.c | 138 ++++++++++++++++++++++++++++++++-----
 drivers/pci/host/pcie-designware.h |   6 +-
 2 files changed, 122 insertions(+), 22 deletions(-)

-- 
1.8.1.5
