Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252BEC47082
	for <linux-pci@archiver.kernel.org>; Mon, 31 May 2021 22:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BD260232
	for <linux-pci@archiver.kernel.org>; Mon, 31 May 2021 22:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEaWNk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 May 2021 18:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhEaWNj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 18:13:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D09C06174A;
        Mon, 31 May 2021 15:11:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e1so1556233pld.13;
        Mon, 31 May 2021 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw59jQnc+Uma0baDOULLtxudFXMhd44Brz/fTI3+KK4=;
        b=h/Gg08nBXnR+NAlEizOR5wFpKHRzB4VnrTv2o7OpQ5UH78vidsV6CfXyQbIhpAx42y
         wunLHz9/4YRny3R+sFpJ1LWKEg5/YW293+g+r3NICv30Z5h6+CckWjIuI8FKtsPtwlKI
         5V7DmdQ2LJd3f78yRAqllGgnCtnhqYxq79ljbICuQgWfsTj4YdOWYDP5q37lTZQrDmgl
         xZSFRnPs9+Lgz3/7XxCG9ZN96sl18Hv9Gd/UW06yQLBkiourrJg90O3mq/sWEdhoNuHZ
         /YILnPISLKlvjAuKfpeRs2I2abB4ceWwGe787jvAnSLtb3Af6w/hTlId51dGcjSz72yk
         GD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw59jQnc+Uma0baDOULLtxudFXMhd44Brz/fTI3+KK4=;
        b=BQ73+tvBdaqPlvgcXHoZcjBrqU8tNgq5tqQW+dS6OZRfjUItqvEfbIzieKSzynwzs6
         c7sh26x5h+vTmYG6Guy6dp4so7g22sypcJPfQGqmKO8c7OBcjtivxIAsaQtU9FHSx7pg
         HsuNnEUmaxgJvH4swo+iWzpUqxlXGFEIFlAdaoFoX5YzT1sSnGbfnGBzhvg43Fv4wfU+
         lBx9sgBywwqVB/3J5IgguPIUCFSKs9fjzl8s+kuWfNgOgH2+c3/mNOaSQxcNyGhdtR4b
         Sgil39la05KTKbtFaUpUc4DkobyOxV0H/7sSvkXaVE57hd0nAjxAmesmDRprDHsWh1FT
         OdhQ==
X-Gm-Message-State: AOAM532ErpMb3VytMnF1YPlYhHNwQKtFHxawGda9dYIzzuQi69C8sHu7
        OL5cczWMUHhdgOFh6xIZhIg=
X-Google-Smtp-Source: ABdhPJzdE3+QUCC1zBgJEn+QtXIkglsaGTRALpTVjmZGTBM3gLEPvN1m4rll/7NuFhyVg6LvlAT6kA==
X-Received: by 2002:a17:902:a70f:b029:ea:d4a8:6a84 with SMTP id w15-20020a170902a70fb02900ead4a86a84mr22665442plq.42.1622499118954;
        Mon, 31 May 2021 15:11:58 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id gz18sm308809pjb.19.2021.05.31.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:11:58 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v2 2/4] PCI: of: Relax the condition for warning about non-prefetchable memory aperture size
Date:   Tue,  1 Jun 2021 07:10:55 +0900
Message-Id: <20210531221057.3406958-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531221057.3406958-1-punitagrawal@gmail.com>
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
aperture size is > 32-bit") introduced a warning for non-prefetchable
resources that need more than 32bits to resolve. It turns out that the
check is too restrictive and should be applicable to only resources
that are limited to host bridge windows that don't have the ability to
map 64-bit address space.

Relax the condition to only warn when the resource size requires >
32-bits and doesn't allow mapping to 64-bit addresses.

Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e2e64c5c55cb..c2a57c61f1d1 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -574,7 +574,8 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 
 			if (!(res->flags & IORESOURCE_PREFETCH))
-				if (upper_32_bits(resource_size(res)))
+				if (!(res->flags & IORESOURCE_MEM_64) &&
+				    upper_32_bits(resource_size(res)))
 					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
 
 			break;
-- 
2.30.2

