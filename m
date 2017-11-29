Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kelvin Cao <kelvin.cao@microsemi.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:28:42 -0700
Message-Id: <20171129172844.21468-1-logang@deltatee.com>
Subject: [PATCH 0/2] Switchtec Updates
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Blease accept the following two patches. The first adds a couple more
device IDs for the Switchtec driver. The second adds a new event type
for it to report.

Thanks,

Logan

Kelvin Cao (1):
  switchtec: Add device IDs for PSX 24xG3 and PSX 48xG3

Logan Gunthorpe (1):
  switchtec: Added Global Fabric Manager Server (GFMS) event

 drivers/pci/switch/switchtec.c       | 3 +++
 include/linux/switchtec.h            | 3 +++
 include/uapi/linux/switchtec_ioctl.h | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

--
2.11.0
