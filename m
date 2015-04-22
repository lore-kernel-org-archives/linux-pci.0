Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6467 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169AbbDVNBu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Apr 2015 09:01:50 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jg1.han@samsung.com>, <bhelgaas@google.com>,
	<Minghuan.Lian@freescale.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/2] PCI: designware: improve iATU programming and usage
Date: Wed, 22 Apr 2015 20:58:12 +0800
Message-ID: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The outbound iATU programming functions are similar, so PATCH1 consolidates
them into one.

Most transactions' type are cfg0 and MEM, so current iATU usage is not
balanced. PATCH2 adopts idea from Minghuan Lian <Minghuan.Lian@freescale.com>:

 http://www.spinics.net/lists/linux-pci/msg40440.html

to change the iATU allocation: iATU0 for cfg and IO, iATU1 for MEM.

Jisheng Zhang (2):
  PCI: designware: consolidate outbound iATU programming functions
  PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM

 drivers/pci/host/pcie-designware.c | 144 ++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 82 deletions(-)

-- 
2.1.4

