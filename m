Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:57821 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeF2LMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 07:12:10 -0400
Date: Fri, 29 Jun 2018 13:12:07 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jespern@axis.com, shawn.lin@rock-chips.com,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/11] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
Message-ID: <20180629111207.GD4333@axis.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <90e6f3255f468103d41ab7f6b438ea3a78186e00.1529595907.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <90e6f3255f468103d41ab7f6b438ea3a78186e00.1529595907.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2018 at 05:01:27PM +0100, Gustavo Pimentel wrote:
> Change {cdns, dra7xx, artpec6, dw, rockchip}_pcie_ep_raise_irq() and
> pci_epc_raise_irq() signature, namely the interrupt_num variable type
> from u8 to u16 to accommodate 2048 maximum MSI-X interrupts.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Acked-by: Alan Douglas <adouglas@cadence.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
