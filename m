Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeE3RyL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:54:11 -0400
Subject: [PATCH v1 0/2] PCI/AER: Clean up minor logging issues
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Wed, 30 May 2018 12:54:10 -0500
Message-ID: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AER logging printed the plain 16-bit Requester ID straight out of the TLP,
which is hard to interpret, e.g., id=00e4 corresponds to what we normally
see as 00:1c.4 in dmesg or lspci.

Also, there's no need to print the vendor/device ID of the root port
reporting an error; we can easily find that from dmesg or lspci.

---

Bjorn Helgaas (2):
      PCI/AER: Decode Error Source Requester ID
      PCI/AER: Stop printing vendor/device ID


 drivers/pci/pcie/aer/aerdrv_errprint.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)
