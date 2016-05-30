Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52278 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933060AbcE3OSD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 May 2016 10:18:03 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 0/2] PCI: hv: fix a couple of issues in hv_pci_onchannelcallback()
Date: Mon, 30 May 2016 16:17:57 +0200
Message-Id: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

kmemleak helped me to identify a memory leak in hv_pci_onchannelcallback()
and while fixing it I stumbled upon an unrelated issue(s) there.

Vitaly Kuznetsov (2):
  PCI: hv: don't leak buffer in hv_pci_onchannelcallback()
  PCI: hv: handle all pending messages in hv_pci_onchannelcallback()

 drivers/pci/host/pci-hyperv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.5.5

