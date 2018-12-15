Return-Path: <SRS0=lgj/=OY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6BC43387
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 01:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026CD206C0
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 01:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0HVO7Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeLOBv3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:51:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLOBv3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 20:51:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so7296526wmh.4;
        Fri, 14 Dec 2018 17:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eytp6S4CCsTnroWEVjtGUJzt6s+Tt0DF8TpdrSgEByM=;
        b=h0HVO7YytXrUltdpNPncPPrV25EGJ+3dNMTETaITsB95Th7MyOhIJi0jdHXzQte2AM
         ltoXdqTgo8kahvkkW1lYHJrkprjBVmt8AfKvLEKesV2qGuzdZSD+lQWmKljFH+a6PxR8
         q/iiirwvpXp5WkvOblYeCy+p4nuXsErnt14eVSceciNhJZOLqGTd7gv4Af++JZxnVOPN
         MFBS004Rx8IjtnrZPmqhbGd0rPMUi1tVVEJVGJ1XOo6UqXPb0/1O6Dm3prMtcZWpyEHS
         YuQLuRxrXDmgZydEbfHWGwYUeRIBux5Y3kIZf7Xvk7B+wR5DG9r7MLbQPrTMqtHTy1+f
         45cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eytp6S4CCsTnroWEVjtGUJzt6s+Tt0DF8TpdrSgEByM=;
        b=h7n45/WeAeTw4zFG+PdpWLpzNqXIie447ediGRKuK6ZqD0x+JXfFmwm7okfFCAX7nS
         dnbCeAWUSABDwy4Kzs5exWBY7LBDGNQYOjCxw/nK4CXzNyWXHvs0DP7qHF0pyaUA/SGW
         HgkUKV78AXl7DqoTJe3n5fq6K4xWm6j3dLugrGBiSVRCOe3Cbv2IaGDJ+siO0akFJx9l
         DNLK9+RnBHBE0ldA+rpMTYBFAjwzFvc6fr7B/BmQLO8AdkDuwvIqKmOhvJTDbye08Wle
         K7g/lZGAKck4kBNFCs3nxdSj71Bf7c9mG7FPzh9+fsIhCFDJFMfOhDbtHJSAOFgQW8C+
         5gGQ==
X-Gm-Message-State: AA+aEWasmTKDczyxjfZiM6NvHYAqnkNTlkm8GmvxAQZ9lXMXkDEdckGl
        dbd7EJRn73tk5RJ9/a3+mwU=
X-Google-Smtp-Source: AFSGD/Vuu7depUYfubc4xMapmX3505PmQd4YBYrgOF94Orplin97nCy/UQa78OugdUhaRlpqfJdAnQ==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr4837759wme.135.1544838686382;
        Fri, 14 Dec 2018 17:51:26 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t76sm9065024wme.33.2018.12.14.17.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 17:51:25 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] PCI: Remove unused attr variable in pci_dma_configure
Date:   Fri, 14 Dec 2018 18:49:01 -0700
Message-Id: <20181215014900.10308-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clang warns:

drivers/pci/pci-driver.c:1603:21: error: unused variable 'attr'
[-Werror,-Wunused-variable]

Commit e5361ca29f2f ("ACPI / scan: Refactor _CCA enforcement") removed
attr's use and replaced it with its assigned value so it is no longer
needed.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

The commit that causes this warning is in Christoph's dma-mapping tree
so I assume this will go there too (roll it into it if need be).

 drivers/pci/pci-driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1b58e058b13f..ea55444e6ead 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1600,7 +1600,6 @@ static int pci_dma_configure(struct device *dev)
 		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
-		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
 
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
-- 
2.20.0

