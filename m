Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:59892 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbdLCVPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Dec 2017 16:15:43 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix docs build error after source file removed
Message-ID: <5fc71be8-e465-211d-757f-457a8054673c@infradead.org>
Date: Sun, 3 Dec 2017 13:15:39 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

The pci/htirq.c file was removed so remove it from the documentation
file also.

Error: Cannot open file ../drivers/pci/htirq.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/pci/htirq.c' failed with return code 2

Fixes: fd2fa6c18b72 ("x86/PCI: Remove unused HyperTransport interrupt support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/driver-api/pci.rst |    3 ---
 1 file changed, 3 deletions(-)

--- lnx-415-rc2.orig/Documentation/driver-api/pci.rst
+++ lnx-415-rc2/Documentation/driver-api/pci.rst
@@ -25,9 +25,6 @@ PCI Support Library
 .. kernel-doc:: drivers/pci/irq.c
    :export:
 
-.. kernel-doc:: drivers/pci/htirq.c
-   :export:
-
 .. kernel-doc:: drivers/pci/probe.c
    :export:
 
