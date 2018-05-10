Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752569AbeEJWJJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 May 2018 18:09:09 -0400
Subject: [PATCH 0/2] PCI: Trivial quirks cleanup
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 17:09:06 -0500
Message-ID: <152599011048.234504.9006188618412032582.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Sorry for the repost; network hiccup here.]

Trivial reorganization (move quirk infrastructure to the top) and
whitespace/comment style cleanup for consistency.  No functional change
intended.

---

Bjorn Helgaas (2):
      PCI: Reorder quirks infrastructure code
      PCI: Clean up whitespace in quirks.c


 drivers/pci/quirks.c |  978 +++++++++++++++++++++++++-------------------------
 1 file changed, 485 insertions(+), 493 deletions(-)
