Return-Path: <SRS0=fb+J=4F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B7C35254
	for <linux-pci@archiver.kernel.org>; Mon, 17 Feb 2020 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED20C20725
	for <linux-pci@archiver.kernel.org>; Mon, 17 Feb 2020 12:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OX5QrzBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgBQMKu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:10:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10247 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgBQMKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:10:50 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4a82840000>; Mon, 17 Feb 2020 04:09:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Feb 2020 04:10:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Feb 2020 04:10:49 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Feb
 2020 12:10:49 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Feb 2020 12:10:49 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4a82c50000>; Mon, 17 Feb 2020 04:10:48 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>
CC:     <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 1/5] PCI: endpoint: Add core init notifying feature
Date:   Mon, 17 Feb 2020 17:40:32 +0530
Message-ID: <20200217121036.3057-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217121036.3057-1-vidyas@nvidia.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581941380; bh=ra8prAC24uwN71hLDTw6Lz3KDfpfzTwlg/Kk8dVUYH0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OX5QrzBk0o5LlH2ApxGF4T/RYHk2ixAdD8hl/HMPsbKu5GR0fF8hNYIHITIkr/SnY
         nPBnWDZ1CKQt40Aai6oLo1m6aMmlGbyWGV4QqMBP09esSBSoQxruoksl9xLqp6Zla8
         ecVhTrjNlx6CNE99wyZRMtG+905roGkZkGzUKEQS7it84tNqGitUNk9QoaFhKf3t24
         x17Sm9limr3HZfsl1OxFiyd2AthdM6xkZGxCfeKweafuUsaD5jCP8Qt9K/wl+br1LW
         GS4rFoiuB714fX04aRPStLwQAQ+kuHeCi2x1HwaO+WKPOdeg7IAdUNPNtrBgDinz8S
         p5wxmyvmIdfQg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new feature core_init_notifier for cores that can notify about
their availability for initialization (Ex:- Tegra194).

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V3:
* Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

V2:
* This is a new patch in this series

 include/linux/pci-epc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index ccaf6e3fa931..9ffe6bd081ae 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -120,6 +120,7 @@ struct pci_epc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
+	unsigned int	core_init_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
-- 
2.17.1

