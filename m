Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40922 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932614AbcJLKzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Oct 2016 06:55:12 -0400
Date: Wed, 12 Oct 2016 13:54:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: shawn.lin@rock-chips.com
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [bug report] PCI: rockchip: Add Rockchip PCIe controller support
Message-ID: <20161012105434.GA21452@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Shawn Lin,

The patch e77f847df54c: "PCI: rockchip: Add Rockchip PCIe controller
support" from Sep 3, 2016, leads to the following static checker
warning:

	drivers/pci/host/pcie-rockchip.c:552 rockchip_pcie_init_port()
	warn: mask and shift to zero

drivers/pci/host/pcie-rockchip.c
   549  
   550          /* Check the final link width from negotiated lane counter from MGMT */
   551          status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
   552          status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
   553                            PCIE_CORE_PL_CONF_LANE_MASK);

Presumably we should be shifting by PCIE_CORE_PL_CONF_LANE_SHIFT but
this still looks all kind of jumbled up.

   554          dev_dbg(dev, "current link width is x%d\n", status);
   555  

regards,
dan carpenter
