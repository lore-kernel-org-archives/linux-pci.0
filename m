Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.54]:55395 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3K2N6H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 08:58:07 -0500
From: =?UTF-8?q?Bj=C3=B8rn=20Erik=20Nilsen?= <ben@datarespons.no>
To: jg1.han@samsung.com
Cc: marex@denx.de, pratyush.anand@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, kishon@ti.com, Mohit.KUMAR@st.com,
	ajay.khandelwal@st.com, tharvey@gateworks.com,
	Eric.Nelson@boundarydevices.com, troy.kisky@boundarydevices.com,
	=?UTF-8?q?Bj=C3=B8rn=20Erik=20Nilsen?= <ben@datarespons.no>
Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
Date: Fri, 29 Nov 2013 14:35:23 +0100
Message-Id: <1385732125-28630-1-git-send-email-ben@datarespons.no>
In-Reply-To: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset address Marek Vasut's comments on the previous
patches. I decided to split into two separate commits as they are
unrelated.

Bjørn Erik Nilsen (2):
  PCI: designware: Fix crash in dw_msi_teardown_irq
  PCI: designware: Remove redundant call to pci_write_config

 drivers/pci/host/pcie-designware.c | 57 +++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 16 deletions(-)

-- 
1.8.4.4

