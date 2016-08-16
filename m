Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Helen Koike <helen.koike@collabora.co.uk>
To: hch@infradead.org, mlin@kernel.org, fes@google.com,
	keith.busch@intel.com, rlnelson@google.com, axboe@fb.com,
	digitaleric@google.com, tytso@mit.edu, mikew@google.com,
	monish@google.com
Cc: Helen Koike <helen.koike@collabora.co.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Subject: [PATCH v3 RFC 0/2] Virtual NVMe device optimization
Date: Mon, 15 Aug 2016 22:41:18 -0300
Message-Id: <cover.1471308889.git.helen.koike@collabora.co.uk>
In-Reply-To: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please, check commit "nvme: improve performance for virtual NVMe devices" for more details
Commit "PCI: Add Google device ID" only adds a new id in pci_ids.h

Patches are based in the linux-block/for-next branch and available here:
https://github.com/helen-fornazier/opw-staging/commits/nvme/dev

Helen Koike (1):
  PCI: Add Google device ID

Rob Nelson (1):
  nvme: improve performance for virtual NVMe devices

 drivers/nvme/host/Kconfig  |  11 ++++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/pci.c    |  29 ++++++++++-
 drivers/nvme/host/vdb.c    | 125 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/vdb.h    | 118 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h       |  17 ++++++
 include/linux/pci_ids.h    |   2 +
 7 files changed, 301 insertions(+), 2 deletions(-)
 create mode 100644 drivers/nvme/host/vdb.c
 create mode 100644 drivers/nvme/host/vdb.h

-- 
1.9.1
