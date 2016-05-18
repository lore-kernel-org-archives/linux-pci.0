Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27506 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbcERHKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 May 2016 03:10:01 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: mj@ucw.cz
Cc: bhelgaas@google.com, jonathan.yong@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] lspci: test case for PTM
Date: Wed, 18 May 2016 07:10:01 +0000
Message-Id: <1463555402-25414-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here are the requested test cases.
Generated against dummy config space with PTM bits.

Yong, Jonathan (1):
  lspci: Add test case for PTM

 tests/cap-ptm-1 | 292 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/cap-ptm-2 | 284 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 576 insertions(+)
 create mode 100755 tests/cap-ptm-1
 create mode 100755 tests/cap-ptm-2

-- 
2.7.3

