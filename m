Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.138]:35229 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdDEC3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2017 22:29:16 -0400
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-pci@vger.kernel.org
Cc: robh@kernel.org, toshi.kani@hpe.com, shawn.lin@rock-chips.com,
        briannorris@chromium.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, bhelgaas@google.com, dtor@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v5 0/1] Fix memory leak in of_pci_get_host_bridge_resources
Date: Wed,  5 Apr 2017 10:28:21 +0800
Message-Id: <1491359303-1385-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In of_pci_get_host_bridge_resources, we alloced some struct resource
variables, and they would cause memory leak since no where to free them.

Changes in v5:
Fix some careless compile errors.

Changes in v4:
Use IORESOURCE_AUTO to mark struct resources which could be copied.

Changes in v3:
Add some comments.

Changes in v2:
Don't change the resource_list_create_entry's behavior.

Jeffy Chen (1):
  of/pci: Fix memory leak in of_pci_get_host_bridge_resources

 drivers/of/of_pci.c | 51 ++++++++++++++++++---------------------------------
 drivers/pci/bus.c   |  7 ++++++-
 2 files changed, 24 insertions(+), 34 deletions(-)

-- 
2.1.4
