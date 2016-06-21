Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0064.outbound.protection.outlook.com ([65.55.169.64]:27920
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751398AbcFUJKt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 05:10:49 -0400
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 0/2] PCI: altera: fix link retrain 
Date: Tue, 21 Jun 2016 16:53:11 +0800
Message-ID: <1466499193-1987-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This 2 patches fix the issue before and after retrain link.

Ley Foon Tan (2):
  PCI: altera: check link status before retrain link
  PCI: altera: Polling for link up status after retrain the link

 drivers/pci/host/pcie-altera.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

-- 
1.8.2.1

