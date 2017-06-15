Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:12:22 -0600
Message-Id: <20170615201224.5371-1-logang@deltatee.com>
Subject: [PATCH 0/2] Switchtec Changes for v4.13
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Can you please queue up these two minor changes for v4.13?

Thanks,

Logan

Logan Gunthorpe (2):
  switchtec: running status flag to fw partition info ioctl
  switchtec: add device ids for additional switchtec products

 drivers/pci/switch/switchtec.c       | 40 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/switchtec_ioctl.h |  3 +++
 2 files changed, 41 insertions(+), 2 deletions(-)

--
2.11.0
