Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:6416 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbaE2HCP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 03:02:15 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 0/3] cleanup unnecessary checking for pci_bus_add_device()
Date: Thu, 29 May 2014 15:01:03 +0800
Message-ID: <1401346866-11648-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Yijing Wang (3):
  PCI: remove the unnecssary checking for pci_bus_add_device
  platform/x86: remove the unnecessary checking for pci_bus_add_device
  edac: remove the unnecessary checking for pci_bus_add_device

 drivers/edac/i82875p_edac.c         |    7 +------
 drivers/pci/bus.c                   |    6 +-----
 drivers/pci/iov.c                   |    2 +-
 drivers/platform/x86/asus-wmi.c     |    3 +--
 drivers/platform/x86/eeepc-laptop.c |    3 +--
 include/linux/pci.h                 |    2 +-
 6 files changed, 6 insertions(+), 17 deletions(-)


