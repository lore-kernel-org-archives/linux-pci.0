Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=iiy+=DB=huawei.com=liudongdong3@kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <rjw@sisk.pl>, <linux-pci@vger.kernel.org>
CC: <stable@vger.kernel.org>, <linuxarm@huawei.com>,
        Dongdong Liu
	<liudongdong3@huawei.com>
Subject: [PATCH V2 0/2] PCI/portdrv: Fix switch devctrl error report enable
Date: Tue, 5 Dec 2017 17:50:36 +0800
Message-ID: <1512467438-42850-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

PATCH 1/2 is to fix switch upstream/downstream port error report.
PATCH 2/2 is to make AER device configuration more reasonable.
Delete the upstream/downstream port AER configuraion in PATCH 2/2,
but if firmware does not enable upstream/downstream port error reporting, 
it seems current no place to enable them, so PATCH 2/2 need more
suggestion. Please see the commit log for more information. 

Changes from v1:
- Rebase on v4.15-rc2.
- Modify the change log.
- Add PATCH 2/2.

Dongdong Liu (2):
  PCI/portdrv: Fix switch devctrl error report enable
  PCI/AER: Fix AER device configuration

 drivers/pci/pcie/aer/aerdrv.c   | 49 ++++-------------------------------------
 drivers/pci/pcie/portdrv_core.c |  4 +++-
 2 files changed, 7 insertions(+), 46 deletions(-)

-- 
1.9.1
