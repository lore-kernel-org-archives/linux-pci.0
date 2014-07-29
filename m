Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:56384 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaG2Hwa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jul 2014 03:52:30 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <Jordan_Hargrave@Dell.com>,
	<keith.busch@intel.com>, <jon.mason@intel.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] Update device mps when doing pci hotplug
Date: Tue, 29 Jul 2014 16:17:40 +0800
Message-ID: <1406621860-11967-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
	Keith Busch and jordan hargrave reported the same issue about
mps issue after pci device hot add. It seems that more firmware
set device mps >=256B default. So can you pick up this patch to fix
this issue temporarily.

Yijing Wang (1):
  PCI: update device mps when doing pci hotplug

 drivers/pci/probe.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

