Return-Path: <SRS0=a/OH=RK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2120BC43381
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 21:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E280420854
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 21:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWgBwmg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCGViw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:38:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41556 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGViw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2019 16:38:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so15511013otk.8;
        Thu, 07 Mar 2019 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKsceA5iPCGK4z0HB5rNefLzAM6T95Spw0/oJusSaSU=;
        b=DWgBwmg9h1UrYHrZB4v4iJgtwpbDTYN0WNxk/UhNfi5AvWhtRIv0/j3alKGn93OLtF
         1CnhSjDKtbKoI/hm+6ygKZXIwCNVWHCe+fTXC/dEaMYI0dB63sRVS3VdWhD7bYJjsg6U
         tqtslSouGHumlQFgpv9+jtW4oArLD635pIsf31bdLU7Tusn/7oz/z7ZKmglN+K1L2L12
         Q9SuQS0iNxukGWhCvvj+mWEPtE1ZmPhthx47ZIt4V1C6qDZ5sL4GLK4Sfh3gxUJlWlmp
         zdB7RaNJMhgSdpBYtQwVt22iIHsbDsJ3u1p+yZ37/zBPcFu37T4MELFM3WYg413GM30B
         Nlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKsceA5iPCGK4z0HB5rNefLzAM6T95Spw0/oJusSaSU=;
        b=FEO6OxIofofaI8Z7lGz5nb3XTyCVAIzBBhkabLpKZym73LMlECx+vyxBgGptmorajM
         3X1lp8QsIDNO7m8eKCW0bOG6GYW/fd7ri1B9RGcv+6xNCeWMHQ94+/eZ0BFKfJsqppna
         9RaJBoZucqcLzrhoJew/xGcPYtRkltZ0R8nytvcw5NArEUiAqm1muzlBk0N+JuDJsWyS
         vcg7ki8V3msCLWt7PXeF6ZBMynKDoZbkGL0uMj3WoOYndRJkMToHF/YGSuxlubeJqdq6
         y/GZeG/nw+IJvpef+pNpLcFebu1paOaIbEz0SESjdEbd8ZZPh2WXanbeThWgSrp8AZFD
         MTaw==
X-Gm-Message-State: APjAAAUAX5kJ3jV6Iv/J7SMEL31v/pJqxMN+6XwaAwA3cPs4frrpeXGS
        hDxddA9S75ALnZSgxpNvUGM=
X-Google-Smtp-Source: APXvYqxPzRNqaNMMCWI7TPJ5CvdBbZDZ/yZTulu9kh+77YAHKoL56s96OIVdwtvoa4rk1NkH9UerGw==
X-Received: by 2002:a05:6830:116:: with SMTP id i22mr9430537otp.280.1551994731246;
        Thu, 07 Mar 2019 13:38:51 -0800 (PST)
Received: from nuclearis2-1.lan ([2601:2c1:8501:182d::cdd])
        by smtp.gmail.com with ESMTPSA id p188sm2352205oia.58.2019.03.07.13.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 13:38:50 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 1/3] PCI / ACPI: Do not export pci_get_hp_params()
Date:   Thu,  7 Mar 2019 15:38:25 -0600
Message-Id: <20190307213834.5914-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307213834.5914-1-mr.nuke.me@gmail.com>
References: <20190307213834.5914-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is only used within drivers/pci, and there is no reason to make
it available outside of the PCI core.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci-acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..b25e5fa9d1c9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -366,7 +366,6 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
-- 
2.19.2

