Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:65178 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751814AbbD3I0K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2015 04:26:10 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <jg1.han@samsung.com>, <bhelgaas@google.com>,
	<Minghuan.Lian@freescale.com>, <fabrice.gasnier@st.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 0/2] PCI: designware: improve iATU programming and usage
Date: Thu, 30 Apr 2015 16:22:27 +0800
Message-ID: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
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

Changes since v1:
- remove outbound iATU programming for IO in dw_pcie_host_init, since it can
  be done by berlin_pcie_{rd|wr}_other_conf() latter.
- only do outbound iATU programming for MEM if pp->ops->rd_other_conf is not
  set. Thank Fabrice Gasnier to point out "some platforms doesn't have support
  for ATU"

Jisheng Zhang (2):
  PCI: designware: consolidate outbound iATU programming functions
  PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM

 drivers/pci/host/pcie-designware.c | 142 ++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 82 deletions(-)

-- 
2.1.4

