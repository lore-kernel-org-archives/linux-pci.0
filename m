Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeEJWCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 18:02:32 -0400
Subject: [PATCH 0/2] PCI: Trivial quirks cleanup
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 17:02:07 -0500
Message-ID: <152598966396.232453.4857977081192851257.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Trivial reorganization (move quirk infrastructure to the top) and
whitespace/comment style cleanup for consistency.  No functional change
intended.

---

Bjorn Helgaas (2):
      PCI: Reorder quirks infrastructure code
      PCI: Clean up whitespace in quirks.c


 drivers/pci/quirks.c |  978 +++++++++++++++++++++++++-------------------------
 1 file changed, 485 insertions(+), 493 deletions(-)
