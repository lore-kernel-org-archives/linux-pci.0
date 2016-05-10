Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:9894 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbcEJDP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 23:15:56 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: mj@ucw.cz
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	jonathan.yong@intel.com
Subject: [PATCH] lspci: Decode PTM Registers
Date: Tue, 10 May 2016 03:15:54 +0000
Message-Id: <1462850155-13790-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch allows lspci to decode Precision Time Measurement as per the PCI
Express 3.1 specification.

Yong, Jonathan (1):
  lspci: Decode Precision Time Measurement capabiltity

 lib/header.h |  1 +
 ls-ecaps.c   | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.7.3

