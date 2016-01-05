Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50630 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbcAEWmZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jan 2016 17:42:25 -0500
Date: Tue, 5 Jan 2016 16:42:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Cc: linux-pci@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>,
	Minghuan.Lian@freescale.com
Subject: DesignWare ATU PCIE_ATU_TYPE_MEM usage
Message-ID: <20160105224222.GB23814@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

This code in dw_pcie_host_init() looks wrong:

    if (!pp->ops->rd_other_conf)
	    dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
				      PCIE_ATU_TYPE_MEM, pp->mem_base,
				      pp->mem_bus_addr, pp->mem_size);

    dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
    ...
    dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);

Evidently you need to program the ATU with PCIE_ATU_TYPE_MEM before
doing config accesses on the root bus?

If that's the case, what about other config accesses after these few
in dw_pcie_host_init()?  I don't see anything that changes the ATU
programming for things coming through dw_pcie_wr_conf().

I assume you need some sort of locking around this sequence:

    dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0, type, ...
    ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
    dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0, PCIE_ATU_TYPE_IO, ...

Are you relying on pci_lock?  If so, a comment to that effect would be
nice.

The whole ATU management looks pretty inefficient.  It's likely that
there'll be a whole sequence of operations where we don't need to
touch the ATU, but since we don't remember its current state, we
configure the whole thing from scratch each time, which is at least
eight register writes (plus a read for the new synchronization).

Bjorn
