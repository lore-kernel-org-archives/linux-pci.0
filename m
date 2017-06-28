Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39859 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdF1Cal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2017 22:30:41 -0400
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Build failure in -next due to 'PCI: versatile: Convert PCI scan API
 to pci_scan_root_bus_bridge()'
Message-ID: <113c3ec2-152d-de17-e05e-ade4fe76b7d8@roeck-us.net>
Date: Tue, 27 Jun 2017 19:30:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
drivers/pci/host/pci-versatile.c:131:38: error: 'dev' undeclared
   bridge = devm_pci_alloc_host_bridge(dev, 0);

Was this code ever compiled, much less tested ?

Guenter
