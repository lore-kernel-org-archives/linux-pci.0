Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:16243 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeEaKvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 06:51:15 -0400
Subject: Re: [PATCH v2 3/7] PCI: cadence: Update cdns_pcie_ep_raise_irq
 function signature
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <adouglas@cadence.com>, <jesper.nilsson@axis.com>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <4994f263efbf6a2cb952d3d9839fb3b1737efde9.1526576613.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <aa86d9b7-d715-2a21-6a94-be927e55b51b@ti.com>
Date: Thu, 31 May 2018 16:21:01 +0530
MIME-Version: 1.0
In-Reply-To: <4994f263efbf6a2cb952d3d9839fb3b1737efde9.1526576613.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
> Change cdns_pcie_ep_raise_irq() signature, namely the interrupt_num
> variable type from u8 to u16 to accommodate 2048 maximum MSI-X
> interrupts.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Alan Douglas <adouglas@cadence.com>

Do you want to add MSI-X support to cadence PCIe?

Thanks
Kishon
