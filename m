Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42FAC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 20:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8353820659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 20:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA/bj1Ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfANUlq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:41:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANUlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 15:41:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so8273684wmh.0;
        Mon, 14 Jan 2019 12:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qMRlpE6a7Lpu7MMoDwefpxRhUpsgQYcb6piwu5JN2vE=;
        b=KA/bj1GeEWMvAgaUqfdtcJO8EKBdH2fcA6EXZRwQ3X5YJhBDVka7VHPnxBnLHhAVkg
         py+yGQhi0CxvJ3n8EeeV1Mbi5Cye5gXYXG/Kzucke7S2OHO2pCYqUaDz7JPJ2YXPxZZs
         5cRurdkFYeWMQEUr++eRBfIABF3oVWyMm9NKfM3T5t3UYFpN9fY5Qbuuns/Ki7purfn4
         MA/MDhuknR+Irg/IiZPwS0kZtw1j+oxR6EnO7PXQuzJa6lyGrQQyYzm2HBofJWuwJMWl
         TbukFivgFHTCz6o9VkrQK5TTUoPSGGXuRZwxBPS31p+LxcjAxoECpuUJFKTvUIa9OGQL
         3fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qMRlpE6a7Lpu7MMoDwefpxRhUpsgQYcb6piwu5JN2vE=;
        b=jFarJgy4Gkg0JqK+6GkTJ7M28Nw9Bq5bKRrwU/RzddxoJEbJpARhBrwpGwJ771I0wN
         FQFp0W57jmwE9JKenuv/eaHvQ+wA/X6eUCTothDlKquPPzjD/lphQg5uOTRFuG0TA+qn
         g6qK1uLMdnDlWAB2dQPRfK0S7TPikRQrn5BYm5+p/FkxpGBePBryFNabss2vs8X9KuEo
         ruoalkF7zV0eHXEZ/NjgsPFBUxSr8eQvuZvYCsMT4K3J5ulvq5MiqE36PDUul9OKaL11
         xdzQsEE3+2WF51fvcgdiEyg8xgiMJEmXf6AagzrdRBzcKE8Dxg7sdx/UQXZylrOtyhZ1
         7a/g==
X-Gm-Message-State: AJcUukfh8Ipo7brTL59Mpc7pCdA7dQmOvC3IJaNek/YbvoV8yfVdS9x3
        T5JodyAcTzS3Hl6IbkUQanZt4yd2
X-Google-Smtp-Source: ALg8bN60XjwZuaLtbNikxBWM7ZWxf6Zp1hcJ/EnMpfpq/HheQoyQoStqOTMH/0oKekQJQe4U23HD5A==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr682576wma.85.1547498503697;
        Mon, 14 Jan 2019 12:41:43 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id 124sm32291283wmh.22.2019.01.14.12.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:41:42 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 6C83711422D0; Mon, 14 Jan 2019 21:41:41 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:41:37 +0100
Message-Id: <20190114204137.21094-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114204137.21094-1-malat@debian.org>
References: <20190114204137.21094-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case change a ‘:’ with a ‘,’ so as to match the
regular expression expected by GCC.

This commit remove the following warning:

  drivers/pci/quirks.c:2138:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b0a413f3f7ca..9fabcef345ed 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2138,7 +2138,7 @@ static void quirk_netmos(struct pci_dev *dev)
 		if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 				dev->subsystem_device == 0x0299)
 			return;
-		/* else: fall through */
+		/* else, fall through */
 	case PCI_DEVICE_ID_NETMOS_9735:
 	case PCI_DEVICE_ID_NETMOS_9745:
 	case PCI_DEVICE_ID_NETMOS_9845:
-- 
2.19.2

