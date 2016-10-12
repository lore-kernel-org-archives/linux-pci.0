Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754898AbcJLN77 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:59:59 -0400
Subject: [PATCH v2 0/4] PCI: qcom: Cleanups
To: Stanimir Varbanov <svarbanov@mm-sol.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:59:54 -0500
Message-ID: <20161012135859.30144.30808.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  - Remove platform drvdata because it appears unused (we called
    platform_set_drvdata() but not platform_get_drvdata()).

  - Remove redundant struct members.

Nothing here should change the behavior of the driver.

Changes from v1:
  I dropped the following patch because it was a lot of churn for
  questionable benefit:
    PCI: qcom: Name private struct pointer "qcom" consistently

---

Bjorn Helgaas (4):
      PCI: qcom: Remove unused platform data
      PCI: qcom: Remove redundant struct qcom_pcie.dbi
      PCI: qcom: Remove redundant struct qcom_pcie.dev
      PCI: qcom: Reorder struct qcom_pcie


 drivers/pci/host/pcie-qcom.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)
