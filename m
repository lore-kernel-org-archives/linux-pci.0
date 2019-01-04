Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B927C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 09:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075452184B
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 09:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v54FwiM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfADJIq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:08:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45283 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADJIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 04:08:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so31155000edb.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2019 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rro8edKkspDsyyMgwTCAKGZP90S23S8Mpy2HGaolC+U=;
        b=v54FwiM+HJcwereFzem42m0Q+PUWYc4Qmcn7F742Drr8zKDSFetWKWaIS8mNrC4hCd
         JA0z4EdreTPJSu9d/t9SMUCZFh+XNi2hD0eQNk/fqiis9v3HXjE72gbSDszWY/cPlvIB
         w5vnVZHNn4AbopXwoWVJocDQVE76agb8d1OHVujkRpnhvcpWinQ0vR2/JhVDYy+UeeTv
         /jewQ02JTz0ueomyhWOqlOxdk6s4ztjabHbM1mluh5SEurEtF53+yBn/Hrke2iS1XERy
         E/8AvLWa7Cni+3LCcHr9KiqbFjPHOUK2W89RxNZ9ojWRERkGI9pMKE4REJVTe3fm/4ny
         /KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rro8edKkspDsyyMgwTCAKGZP90S23S8Mpy2HGaolC+U=;
        b=R9HmySy94f8QzrI/aQOwxVliDklc3PMSgjuLfBAIl4EfdbAB042zg5iakLAfPHcxi8
         UXtdkCX1qY2VmoN+xK/YWTfUARNAHvTAWwnSeQr+8+dF7vtW4RhfatWKUSIECc6FMsbn
         mGYon6/+woOnAl0Ly2LSR0EzqmIxYcmpUscKfP8CBm2Z1l3Jx1MAgQSVFjjmXU5hLuro
         mXP9LcI2l36b1bnwsLHJUiHX46i7HNYi+ov1aS5cqznIzkfu4lf0Fp19tTnDbjVFmaMW
         QopFCgqrulJG7Le73vM6gfEOFopQUmVcpFLXm4PVzl0vGgqZH5CzKC2oNlTkmUrTmjVu
         IG0w==
X-Gm-Message-State: AA+aEWaZjZ3QIqAMFu4lZy1Gmu+5NpenltKLENK7AqhRkf3lf4DUyM+h
        hUSb8Zp1oOdZ95iWTK0Rnar6BA==
X-Google-Smtp-Source: AFSGD/UmoQlwTyOTfvgUi0Sh3vYYxytT7a1XJGMaK3OTpwLWlOcSUl+erzLqGAnERmwCnAgXqCMZTg==
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr38740333eji.106.1546592924349;
        Fri, 04 Jan 2019 01:08:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id o37sm24706587edc.32.2019.01.04.01.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 01:08:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     bhelgaas@google.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] PCI: amlogic: fix build failure due to missing linux/gpio/consumer.h header
Date:   Fri,  4 Jan 2019 09:08:37 +0000
Message-Id: <1546592917-27846-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When building on x86, I got the following build failure:
drivers/pci/controller/dwc/pci-meson.c: In function ‘meson_pcie_assert_reset’:
drivers/pci/controller/dwc/pci-meson.c:290:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(mp->reset_gpio, 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep
drivers/pci/controller/dwc/pci-meson.c: In function ‘meson_pcie_probe’:
drivers/pci/controller/dwc/pci-meson.c:540:19: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
  mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                   ^~~~~~~~~~~~~~
                   devm_gpio_free
drivers/pci/controller/dwc/pci-meson.c:540:48: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
  mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                                                ^~~~~~~~~~~~~
                                                GPIOF_INIT_LOW

This is due to the missing linux/gpio/consumer.h header

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 241ebe0c4505..e35e9eaa50ee 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
-- 
2.19.2

