Return-Path: <SRS0=S6xX=TR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251E8C04E84
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45C21726
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="igEfL8GX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OWCRqzld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfEQSsZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 May 2019 14:48:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfEQSsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 14:48:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4210A618FA; Fri, 17 May 2019 18:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118904;
        bh=szynDbiQZiC2P3ZZa2ZE5dH0th3Xmp6lVJejuhOsIns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igEfL8GXaAX5NWaZwSvTr88o2j/TJiP8FGRidcT9+sNYszsx89ufg+MaGBjZXSTWK
         rmHd8AevhmE8ieI8slNkBvEwYQ73U5UTw3KoUMTw1aJp9tadKGuBfwwr8yle3IoyBw
         q6rOnSAskrlwNVdOp1fDBsntUM5r4uVaTWkLCU8s=
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6534E618EA;
        Fri, 17 May 2019 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118898;
        bh=szynDbiQZiC2P3ZZa2ZE5dH0th3Xmp6lVJejuhOsIns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWCRqzldpIG0aetEHRflxj1Jken3IgDr27PBGDkFBQJ2CVV5W+gIFaPRV8NhSrr0K
         MSlxvDKDo5FtdvUKPoj5MU2LPuphGmSw+PEg6rWhfnt8kpf8AWyJ3oxf9RJH87zlgl
         yV5F8UY1eS6J8DlofloLUzyyZkt9Ai2AuA2SZ7iY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6534E618EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, joro@8bytes.org,
        robin.murphy@arm.com, will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: [RFC/PATCH 1/4] of: Export of_phandle_iterator_args() to modules
Date:   Fri, 17 May 2019 11:47:34 -0700
Message-Id: <1558118857-16912-2-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kernel modules may want to use of_phandle_iterator_args(),
so export it.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20e0e7e..8b9c597 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1388,6 +1388,7 @@ int of_phandle_iterator_args(struct of_phandle_iterator *it,
 
 	return count;
 }
+EXPORT_SYMBOL_GPL(of_phandle_iterator_args);
 
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

