Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0470FC282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DD72081B
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 04:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BH7MEAHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBEE56 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:57:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfBEE55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Feb 2019 23:57:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so959932pfo.7
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 20:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CvsOfmdnx/kGSP+y2pshV+nztFcf8oschdz3BhhBLcE=;
        b=BH7MEAHi9Y7eIBfnhT+6PKYg0oAZwodIMJhZcr+D3HMg3H5NPSk/fFDDHsaW+FxB0e
         uAt8heCv7PNQUAyDyDCEaIQxhQuSnQGN4Ua8gksS/htVSrkzhZNA5PYTf3RATXSPOnla
         Kd+4bNsa88QqfhzDdP6HCclwmvePpznrP2nwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CvsOfmdnx/kGSP+y2pshV+nztFcf8oschdz3BhhBLcE=;
        b=geEEzqWoLW+VQscvUHCeM2CANt0AqKGImYzMB+2TyAk7/QAJsvXn9gW149RdDRpcc8
         elcg8DsY27EsULj+MdGdqHHHeh622/IxhLtRLIfn9etY0Wwd4F+p6YfwDbU9HKDX/G4n
         P2SB+1Hxc6VIl1fZo9MKCdo3DLjLLSKdl9Y23L/ZyTWJ7f/xPON/3Egm8+EPKWECadhh
         lkVyCmukEvf5QZYiAYx6LBpE/knFBigvDG847hFl3NaNVP0Gnu+nfEGgXbXx9QSCtmvE
         +c41OuKJIAX33rx9kAy8QLXBrK5f8HnHi9Z+akNTNxzNlps2/YrzrE6YZCuuySBRZdEE
         tzcQ==
X-Gm-Message-State: AHQUAubMS1fCJqgDRQEORCgpGynrK31tev+jpC6EBg7ciXFUauIYCPjE
        MIU0a6C0zVTX8Lb6o9e6teJ/4w==
X-Google-Smtp-Source: AHgI3IZOd+Yy8XwlMjNM7ZcU7/tQlr5XkCibvzSkHSgRy6opaR9tz/xWq7z8KZKLwIIBkTYCjBQ/2A==
X-Received: by 2002:a63:1a5f:: with SMTP id a31mr2787490pgm.335.1549342676220;
        Mon, 04 Feb 2019 20:57:56 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r76sm2895164pfb.69.2019.02.04.20.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 20:57:55 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/2] Add IPROC PCIe new features
Date:   Tue,  5 Feb 2019 10:27:02 +0530
Message-Id: <1549342622-9929-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549342622-9929-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set extends support of new IPROC PCIe host controller features
 - Add CRS state check using controller register status flags
 - Add 32bit outbound window mapping configuration

This patch set is based on Linux-5.0-rc2.

Changes from v1:
  - Addressed Bjorn Helgaas comments.
  - Removed set order mode patch from patchset.

Srinath Mannam (2):
  PCI: iproc: Add CRS state check in config read
  PCI: iproc: Add PCIe 32bit outbound memory configuration

 drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4

