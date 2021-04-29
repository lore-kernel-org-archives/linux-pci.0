Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64BC433ED
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 09:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4DF61458
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 09:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhD2JGW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:06:22 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42139 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhD2JGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 05:06:22 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1964C22239;
        Thu, 29 Apr 2021 11:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619687134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ntga0F5jzLwIrsdE1xblJLIehmMydXYFVT1ONFqdDI4=;
        b=Hsiv9ZLA8T0pOMQMp8jCjFB+D4n5Z+v8yNWzbkzyJsavPaZvfdkLSBnwp4+VDkHBdI+E9p
        VZ92QdFr7wyFcmeo86i8S1fRh7w5Xes1XbyOXSn5+KawFcydDjh8j5Xu9kidD61pf1QzmL
        t9emBw7zxsUL6sro49aNxV+Qum6unI8=
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH net v2 1/2] MAINTAINERS: remove Wingman Kwok
Date:   Thu, 29 Apr 2021 11:05:20 +0200
Message-Id: <20210429090521.554-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

His email bounces with permanent error "550 Invalid recipient". His last
email on the LKML was from 2015-10-22 on the LKML.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v1:
 - rebased to net

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 933a6f3c2369..04f4a2116b35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17975,7 +17975,6 @@ F:	drivers/regulator/lp8788-*.c
 F:	include/linux/mfd/lp8788*.h
 
 TI NETCP ETHERNET DRIVER
-M:	Wingman Kwok <w-kwok2@ti.com>
 M:	Murali Karicheri <m-karicheri2@ti.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.20.1

