Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41302 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbcCKPNS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 10:13:18 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6E4D5201F5
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 15:13:17 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B2CE2201B4
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 15:13:16 +0000 (UTC)
Subject: [PATCH 0/2] PCI: Clean up pci_create_attr()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Mar 2016 09:13:13 -0600
Message-ID: <20160311151137.31298.19101.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are both pretty trivial: fix a memory leak in the unlikely event
sysfs_create_bin_file() fails, and simplify the code by returning
allocation error immediately, which unindents the mainline code.

These are on my pci/resource branch, and I intend them for v4.6.

---

Bjorn Helgaas (2):
      PCI: Don't leak memory if sysfs_create_bin_file() fails
      PCI: Simplify pci_create_attr() control flow


 drivers/pci/pci-sysfs.c |   51 +++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)
