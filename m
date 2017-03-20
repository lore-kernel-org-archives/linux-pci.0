Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:56954 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbdCTRbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 13:31:22 -0400
To: <marc.zyngier@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Help: MSI DWC connecting with a MSIx Endpoint
Message-ID: <85bfa77f-6cd0-a669-c940-7fa7d9fb17a3@synopsys.com>
Date: Mon, 20 Mar 2017 17:30:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark,

I am facing a challenge in a setup I must bring up that is composed by a
Synopsys Root Complex connected to a MSIx-only Endpoint from Mellanox.
The endpoint probe fails because it is not capable of enabling msix.

In order to get more info about it, I added some debug messages to the msix
enable process and got the following:

MSIX DBG[mlx5_enable_msix]: Num. EQs: 256
MSIX DBG[mlx5_enable_msix]: Num. Vectors: 4
MSIX DBG[mlx5_enable_msix]: Min. Num. Vectors: 4
MSIX DBG[mlx5_enable_msix]: Num. Online CPUs: 1
MSIX DBG[mlx5_enable_msix]: MLX5_EQ_VEC_COMP_BASE: 3
MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 0
MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 1
MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 2
MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 3
MSIX DBG[mlx5_enable_msix]: Enabling PCI MSIX Range
MSIX DBG[__pci_enable_msix_range]: Enabling MSIX [Nvec: 4, Affinity: 0]
MSIX DBG[__pci_enable_msix]: NVec: 4
MSIX DBG[__pci_enable_msix]: Num. Entries: 64
MSIX DBG[__pci_enable_msix]: Checking invalid entries
MSIX DBG[msix_capability_init]: Ensure MSI is disable
MSIX DBG[msix_capability_init]: Getting MSIX Capability
MSIX DBG[msix_capability_init]: Mapping MSIX Capability Region
MSIX DBG[msix_capability_init]: Setup Entries
MSIX DBG[msix_setup_entries]: Configuring MSIX entry 0
MSIX DBG[msix_setup_entries]: Configuring MSIX entry 1
MSIX DBG[msix_setup_entries]: Configuring MSIX entry 2
MSIX DBG[msix_setup_entries]: Configuring MSIX entry 3
MSIX DBG[msix_capability_init]: Setup IRQS
MSIX DBG[pci_msi_setup_msi_irqs]: Inside!
MSIX DBG[arch_setup_msi_irqs]: Inside!
MSIX DBG[msix_capability_init]: Failed pci_msi_setup_msi_irqs
MSIX DBG[mlx5_enable_msix]: Enabling PCI MSIX Range, result: -22
mlx5_core 0000:01:00.0: enable msix failed

The conclusion I came up was that the msix setup in the endpoint fails because
in the pcie-designware-host.c we are rejecting msix as you can see here:

/* MSI-X interrupts are not supported */
if (type == PCI_CAP_ID_MSIX)
        return -EINVAL;

Did you ever came across this problem?

Thanks,
Joao
