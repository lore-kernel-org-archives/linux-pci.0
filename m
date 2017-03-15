Return-Path: <SRS0=p8WW=2Y=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=p8WW=2Y=semihalf.com=tn@kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	Lorenzo.Pieralisi@arm.com,
	robert.richter@caviumnetworks.com,
	ddaney@caviumnetworks.com,
	Vadim.Lomovtsev@caviumnetworks.com,
	rafael@kernel.org
Cc: Sunil.Goutham@cavium.com,
	geethasowjanya.akula@gmail.com,
	linu.cherian@cavium.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH 0/2] ThunderX external PCI fixes for legacy&new ACPI firmware
Date: Wed, 15 Mar 2017 08:49:13 +0100
Message-Id: <1489564155-3881-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

This patch series update ThunderX PEM driver to be able to boot with legacy
and new ACPI firmware:
1. New firmware uses registered Cavium harware ID "CAV", but kernel instead
   uses "THRX". Fix kernel to use "CAV".
2. Legacy firmware misses PEM quirks information so for this case kernel
   should not assume anything from FW and figure out PEM resources on its own.

Fix this all together in the following branch:
git@github.com:semihalf-nowicki-tomasz/linux.git (thunderx-pci-legacy-fw-v1)

Tomasz Nowicki (2):
  PCI: Use Cavium assigned hardware ID for ThunderX host controller
  PCI: Add legacy firmware support for Cavium ThunderX host controller

 drivers/pci/host/pci-thunder-pem.c | 58 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

-- 
2.7.4
