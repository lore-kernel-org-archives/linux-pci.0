Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:55203 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbaHOCtI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Aug 2014 22:49:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/3] Some MSI cleanup
Date: Fri, 15 Aug 2014 11:14:11 +0800
Message-ID: <1408072451-9853-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Yijing Wang (3):
  MSI: Use __get_cached_msi_msg() instead of get_cached_msi_msg()
  MSI: Use __read_msi_msg() instead of read_msi_msg()
  xen/MSI: Retrieve MSI msg from cached msi_desc->msg

 arch/ia64/kernel/msi_ia64.c          |    2 +-
 arch/ia64/sn/kernel/msi_sn.c         |    4 ++--
 arch/powerpc/platforms/pseries/msi.c |    2 +-
 arch/x86/kernel/apic/io_apic.c       |    2 +-
 arch/x86/pci/xen.c                   |    2 +-
 drivers/pci/msi.c                    |   18 ++----------------
 include/linux/msi.h                  |    6 ++----
 7 files changed, 10 insertions(+), 26 deletions(-)

