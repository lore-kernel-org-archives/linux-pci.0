Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:58474 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaIXCpW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 22:45:22 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v4 0/3] MSI cleanup update
Date: Wed, 24 Sep 2014 11:09:31 +0800
Message-ID: <1411528171-1927-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v3->v4: fix the build error under powerpc, I missed to replace
		its __read_msi_msg() in last patch.

Yijing Wang (3):
  MSI/powerpc: Use __read_msi_msg() instead of read_msi_msg()
  PCI/MSI: Remove unused function read_msi_msg()
  PCI/MSI: Rename __read_msi_msg() to read_msi_msg()

 arch/powerpc/platforms/pseries/msi.c |    2 +-
 arch/x86/pci/xen.c                   |    2 +-
 drivers/pci/msi.c                    |    9 +--------
 include/linux/msi.h                  |    3 +--
 4 files changed, 4 insertions(+), 12 deletions(-)

