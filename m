Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50121 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaBLTKu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 14:10:50 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so10995024obc.36
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 11:10:48 -0800 (PST)
Received: from localhost ([172.16.48.185])
        by mx.google.com with ESMTPSA id qh4sm55025159obc.4.2014.02.12.11.10.47
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 11:10:47 -0800 (PST)
Subject: [PATCH 0/4] Minor miscellaneous cleanups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Feb 2014 12:10:46 -0700
Message-ID: <20140212190949.5459.46330.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are minor cleanups I'm planning for v3.15.

---

Bjorn Helgaas (4):
      PCI: Remove unnecessary list_empty(&pci_pme_list) check
      x86/PCI: Remove unnecessary local variable initialization
      x86/PCI: Reword comments
      x86/PCI: Fix function definition whitespace


 arch/x86/pci/acpi.c |   30 ++++++++++++------------------
 drivers/pci/pci.c   |   40 +++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 39 deletions(-)
