Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0116.outbound.protection.outlook.com ([157.56.110.116]:37216
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751070AbaIVJpB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Sep 2014 05:45:01 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<l.stach@pengutronix.de>
Subject: 
Date: Mon, 22 Sep 2014 17:01:36 +0800
Message-ID: <1411376498-14653-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Subject: [PATCH RFC]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl sabresd/sabreauto.

- enable pcie on imx6qdl sabresd and sabreauto boards.
- enable pcie on imx6sx sdb board.

[PATCH RFC 1/2] PCI: imx6: enable pcie on imx6qdl sabresd and
[PATCH RFC 2/2] PCI: imx6: add imx6sx pcie support
