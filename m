Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbcJDRk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Oct 2016 13:40:56 -0400
Date: Tue, 4 Oct 2016 12:40:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: ks_dw_pcie_initiate_link_train() question
Message-ID: <20161004174051.GE3449@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Murali,

This code looks suspicious.  Can you comment?

    void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
    {
        u32 val;

        /* Disable Link training */
        val = readl(ks_pcie->va_app_base + CMD_STATUS);
        val &= ~LTSSM_EN_VAL;
        writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);

Here we cleared the LTSSM_EN_VAL bit in "val", but then we add it
right back in before writing it back to CMD_STATUS.

That looks like a cut and paste error to me, but of course I don't
know the hardware.

        /* Initiate Link Training */
        val = readl(ks_pcie->va_app_base + CMD_STATUS);
        writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
    }


