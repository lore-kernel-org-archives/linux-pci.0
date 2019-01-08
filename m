Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750EEC43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE9B2087F
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 16:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfAHQ0N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:26:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44836 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfAHQYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 11:24:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68648209EF; Tue,  8 Jan 2019 17:24:45 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 08E24209C2;
        Tue,  8 Jan 2019 17:24:45 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 01/15] PCI: aardvark: Enlarge PIO timeout
Date:   Tue,  8 Jan 2019 17:24:26 +0100
Message-Id: <20190108162441.5278-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This delay has been proven to work until now, however, there is a
reproducible way to fail the driver probe because of it.

Adding the support for the PCIe gated peripheral clock that feeds the
Aardvark IP defers the Aardvark driver probe at boot time. The probe
functions calls pci_host_probe() at its end. This is where the timeout
(sometimes) resides, leading to a kernel panic the next time a
register is accessed. Here is the function call sequence:

    advk_pcie_probe()
    pci_host_probe()
    pci_scan_root_bus_bridge()
    pci_scan_child_bus_extend()
    pci_scan_bridge_extend()
    pci_scan_child_bus_extend()
    pci_scan_slot()
    pcie_aspm_init_link_state()
    pcie_aspm_cap_init()

pcie_aspm_cap_init() is in charge of doing the initial ASPM state
setup (PCIe Active-State Power Management). The logic at the top of
the function is:

    1/ Read upstream and downstream components' register state.
    2/ Configure the common clock before checking latencies.
    3/ Read again upstream and downstream component's register state.
    4/ ...

Experimentation shows that while 1/ always work, 3/ sometimes timeouts
when reading the downstream components' register state. Each read
operation is handled by the following sequence:

    pcie_capability_read_dword()
    pci_bus_read_config_dword()
    advk_pcie_rd_conf()

advk_pcie_rd_conf() just configures a few registers and polls on the
ISR bit before reading the value that has been retrieved through the
interconnect. The polling timeout of the ISR bit is set to 1ms. While
this value seems to fit most of the situations, in our case it is
sometimes crossed when reading PCI_EXP_LNKCAP (PCI link capacities)
from the downstream component. It has been measured that most of the
time that the read lasts longer than 1ms, it rises ~24ms. In my tests,
using twice this delay always works. The root cause and the reason why
the timeout only appearing when the probe is delayed is unknown
though.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 750081c1cb48..18120e312ae1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -175,7 +175,7 @@
 	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
 	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
 
-#define PIO_TIMEOUT_MS			1
+#define PIO_TIMEOUT_MS			50
 
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
-- 
2.19.1

