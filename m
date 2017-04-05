Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-pci@vger.kernel.org
Cc: robh@kernel.org, toshi.kani@hpe.com, shawn.lin@rock-chips.com,
        briannorris@chromium.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, bhelgaas@google.com, dtor@chromium.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v4 0/1] Fix memory leak in of_pci_get_host_bridge_resources
Date: Wed,  5 Apr 2017 10:15:20 +0800
Message-Id: <1491358521-17834-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In of_pci_get_host_bridge_resources, we alloced some struct resource
variables, and they would cause memory leak since no where to free them.

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
