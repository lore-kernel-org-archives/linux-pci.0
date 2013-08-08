Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:47165 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758103Ab3HHS3l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 14:29:41 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Fri, 9 Aug 2013 04:13:16 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	rostedt@goodmis.org, rjw@sisk.pl, lance.ortiz@hp.com,
	m.chehab@samsung.com
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add trace event for ghes memory error
Date: Thu,  8 Aug 2013 23:57:48 +0530
Message-Id: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds a new trace event for memory errors reported via APEI
generic hardware error source.

- Naveen

Naveen N. Rao (3):
  mce: acpi/apei: trace: Include PCIe AER trace event conditionally
  mce: acpi/apei: trace: Add trace event for ghes memory error
  mce: acpi/apei: trace: Enable ghes memory error trace event

 drivers/acpi/apei/cper.c               |  21 +++--
 drivers/pci/pcie/aer/aerdrv_errprint.c |   1 +
 include/trace/events/ras.h             | 159 ++++++++++++++++++++++++++++++++-
 3 files changed, 175 insertions(+), 6 deletions(-)

-- 
1.8.3.4

