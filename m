Return-Path: <SRS0=x16U=4C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AA4C3B1A5
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F13246F8
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697120;
	bh=+wD6czIUhxuJuyD9X9uh5dT1pP9vh8/2qPEPFFBPEDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CFho7lhKRIuPYhVs5v20ShLPwou1M8fY52M2o5XxYyc4AwCs9/y9uum5igKtS7Ecg
	 v4PoRlHvEi5Knk9C4EWnIW+2D4BT9dKNgjW1DCHb2RJaG+tQnXK0tQuqwFsej2Vi3n
	 SpxJ39LZv+9Quge/mTATuoQpxJd3VixIKNJJU/a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404809AbgBNQSj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404806AbgBNQSi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 11:18:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40AAF24703;
        Fri, 14 Feb 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697117;
        bh=+wD6czIUhxuJuyD9X9uh5dT1pP9vh8/2qPEPFFBPEDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czmuyAiU+Dej8ONA63AieFFoP71ypPpVrbr+QcLSIfTs2M98v4wew+euRRNF+Ab0f
         RfwOr8yUBUqV59GBw0URJJTmZv4wnvv2wWnehi9B1ys7CMEaSVlzgqmd30KFoRjdpL
         bAoLfBo5LZ523+YtUB/cVL2S0LCrE0fiDja6E9FU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 064/186] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
Date:   Fri, 14 Feb 2020 11:15:13 -0500
Message-Id: <20200214161715.18113-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 8c386cc817878588195dde38e919aa6ba9409d58 ]

In the implementation of pci_iov_add_virtfn() the allocated virtfn is
leaked if pci_setup_device() fails. The error handling is not calling
pci_stop_and_remove_bus_device(). Change the goto label to failed2.

Fixes: 156c55325d30 ("PCI: Check for pci_setup_device() failure in pci_iov_add_virtfn()")
Link: https://lore.kernel.org/r/20191125195255.23740-1-navid.emamdoost@gmail.com
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 0fd8e164339c3..0dc646c1bc3db 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -179,6 +179,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 failed2:
 	sysfs_remove_link(&dev->dev.kobj, buf);
 failed1:
+	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
 	pci_stop_and_remove_bus_device(virtfn);
 failed0:
-- 
2.20.1

