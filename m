Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33383 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbdE3RhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 13:37:19 -0400
From: Ashok Raj <ashok.raj@intel.com>
To: Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] Save and restore pci properties to support FLR
Date: Tue, 30 May 2017 09:25:47 -0700
Message-Id: <1496161549-167468-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resending Jean's patch so it can be included earlier than his large
SVM commits. Original patch https://patchwork.kernel.org/patch/9593891
was ack'ed by Bjorn. Let's commit these separately since we need
functionality earlier.

Resending this series as requested by Jean.

CQ Tang (1):
  PCI: Save properties required to handle FLR for replay purposes.

Jean-Philippe Brucker (1):
  PCI: Cache PRI and PASID bits in pci_dev

 drivers/pci/ats.c       | 88 ++++++++++++++++++++++++++++++++++++++++---------
 drivers/pci/pci.c       |  3 ++
 include/linux/pci-ats.h | 10 ++++++
 include/linux/pci.h     |  8 +++++
 4 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.7.4
