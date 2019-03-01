Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CEC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258502087E
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ftctYG7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfCAEwe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:52:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41005 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfCAEwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 23:52:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so18884064eds.8
        for <linux-pci@vger.kernel.org>; Thu, 28 Feb 2019 20:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dibQmzoAhua9BBy0yrVtjdJwkYRx2DMsB8DfNc2Zs5Q=;
        b=ftctYG7L54HsSifKS/S1aMyXmZ3gqsSMUCfGFpkEJfG1vlzN8eFy2lZMjbemLmgkD3
         oHnJHdKF/AvWQLBbk32AJcb0O4cA+lXP1DRj78b7THv6v8XSg9+QFXU8neoXd0w/0iaW
         L2SiHV1RwDMVIrRHsMl521kuvbkTCJmk+sgYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dibQmzoAhua9BBy0yrVtjdJwkYRx2DMsB8DfNc2Zs5Q=;
        b=QlYhyPY7O8/dlHX71FNm2m17sg9QTk1o5EP2K04wpPl7qGU/qIVu2X+tmZS60I2PT6
         zUTCyZ1f1rsRstVqMJhaYN8OSNis63MMqpSR1KLQKxQiKSJ+qfK1KCXiDQmgk4zY8ye5
         1qz5kyJHJ2g43MZ6o62G2HTqoDAZwdZ9Imi4/OIsWt64GvlmOKVTUn60/DdEGUwDb4Q7
         EuX107j62Zx5rKDWqWpDGoOixj3PRC1VOAXkokH4ecJ2N3C9MeCqt2FAc6P04ECcCASg
         5W0Y2fruV41JB1ZrvXxLACGsXlCj6xTGl4L2X3g47w0MqHOl2trAJF1C/lO1MCuPjUd6
         j18g==
X-Gm-Message-State: APjAAAUtwpuxiyVJS3KzqmJgL/+DYJJMMJcG/oSa2BlQ0M9/hhLdMmTe
        s9mstLoGCN4uBIWwTUse/fDAvw==
X-Google-Smtp-Source: APXvYqyAas+wArwZaK9+S7Mqtur/bVq5/Kf5COqk6ItyxMAFPfgl6HFbIST/9DbrJE7V0ymkXMdKAA==
X-Received: by 2002:a50:8529:: with SMTP id 38mr2581777edr.161.1551415952312;
        Thu, 28 Feb 2019 20:52:32 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s24sm4300931edd.23.2019.02.28.20.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 20:52:31 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 0/2] Add IPROC PCIe new features
Date:   Fri,  1 Mar 2019 10:22:14 +0530
Message-Id: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set extends support of new IPROC PCIe host controller features
 - Add CRS check using controller register status flags
 - Add outbound window mapping configuration for 32-bit I/O region

This patch set is based on Linux-5.0-rc2.

Changes from v3:
  - Addressed Lorenzo Pieralisi comments.

Changes from v2:
  - Based on Lorenzo Pieralisi comments, commit logs are expanded.

Changes from v1:
  - Addressed Bjorn Helgaas comments.
  - Removed set order mode patch from patchset.

Srinath Mannam (2):
  PCI: iproc: Add CRS check in config read
  PCI: iproc: Add outbound configuration for 32-bit I/O region

 drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4

