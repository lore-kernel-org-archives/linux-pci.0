Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129BFC282CE
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97862084E
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 09:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THH7bnU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfDMJNB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:13:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34344 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfDMJNB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Apr 2019 05:13:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so2130670wmf.1
        for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2019 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgoy6MzCDFZksLCgPm3ckOOZ7Ci44vWIX+S6sDXfwtE=;
        b=THH7bnU4SYdsW+nlDC3l2IWUKe+799vy8ZhAWGWkuE4NdWGELhW1hGZGnH2h+zKli9
         RDt3ROucCSVPGU+vcHRk816hgSlv4QKSLPfXpuG7QLmzaZPK3409czBuPQEnr90jiFTq
         eYJ758DidU8+CzsIr7Y2LAG+LW1zpks8HoVH+b5ILPNgkTQ+VbBy/TIUIvK9h0Jvp68j
         2Dit2BjqNI+xL2+1l0ZM0btxQmjpzouU4BLRV2usxsLtLPrWR83bYcrwDMhWe4J7I/ip
         h0NjFb7PTTqu5qI/tC3y4d46sqCwNUFef6EdXgYazlCHTi6qXO4StILE23FiGnhVEOC/
         UvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgoy6MzCDFZksLCgPm3ckOOZ7Ci44vWIX+S6sDXfwtE=;
        b=V21REP8tjiXB6CCe3lFZ8hhZJOWhFnWqMSuWLfLjYzQBHn5YJBVaRdCKRE4DvZhjQX
         6SQmbWjuO+1qUh9tfLRyR1jUQYkHQ/vDHDjraZEXuqGLJrPU5nzjdK0OCtP1I1yHSN35
         8POwvqLhUrKe4TOFc8UArpEIBptLfN5BbLD0GHxUnjjct3+PdYwm8jJVymcOZfEiedfb
         GfienobGIswvFFpATArumPzG4nkUstJWASuTot5CLi+YnUhCXGl8r9EtOI/s+75V7kET
         6XTp5qDEyiSZpc6JYPeIO+K8mzXlL4PrZiKjMB4ynudzY/ofUILm9WgCzXpIMYrF81pL
         N06A==
X-Gm-Message-State: APjAAAV1ZO9ZlfRY/Q9xGKbT97JtFTUgZy7y/OCRc+XZbYRa1vgnhSU6
        pHQz9oHwt9oIazHuq7vokO+AuG/u
X-Google-Smtp-Source: APXvYqxlqqqr1XS0e8qAaAKwmJlJeu5IV+hLvUOqM9X8PZWdfH9ZYY8tJaWjS3Z25TBXdkthLcQ4vQ==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr13847192wmi.65.1555146778999;
        Sat, 13 Apr 2019 02:12:58 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:6509:80dd:f4f:5628? (p200300EA8BD45700650980DD0F4F5628.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:6509:80dd:f4f:5628])
        by smtp.googlemail.com with ESMTPSA id v190sm16259208wme.18.2019.04.13.02.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:12:58 -0700 (PDT)
Subject: [PATCH RFC 2/3] PCI/ASPM: allow to re-enable Clock PM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Message-ID: <41cc300f-0bb8-4b25-5b58-37ad335ed4af@gmail.com>
Date:   Sat, 13 Apr 2019 11:11:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So far Clock PM can't be re-enabled once it has been disabled with a
call to pci_disable_link_state(). Reason is that clkpm_capable is
reset. Change this by adding a clkpm_disable field similar to
aspm_disable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pcie/aspm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 511f3e018..7847be38e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -65,6 +65,7 @@ struct pcie_link_state {
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
 	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
+	u32 clkpm_disable:1;		/* Clock PM disabled */
 
 	/* Exit latencies */
 	struct aspm_latency latency_up;	/* Upstream direction exit latency */
@@ -162,8 +163,11 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 
 static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 {
-	/* Don't enable Clock PM if the link is not Clock PM capable */
-	if (!link->clkpm_capable)
+	/*
+	 * Don't enable Clock PM if the link is not Clock PM capable
+	 * or Clock PM is disabled
+	 */
+	if (!link->clkpm_capable || link->clkpm_disable)
 		enable = 0;
 	/* Need nothing if the specified equals to current state */
 	if (link->clkpm_enabled == enable)
@@ -193,7 +197,8 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 	link->clkpm_enabled = enabled;
 	link->clkpm_default = enabled;
-	link->clkpm_capable = (blacklist) ? 0 : capable;
+	link->clkpm_capable = capable;
+	link->clkpm_disable = blacklist ? 1 : 0;
 }
 
 static bool pcie_retrain_link(struct pcie_link_state *link)
@@ -1105,10 +1110,9 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		link->aspm_disable |= ASPM_STATE_L1_2_MASK;
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
-	if (state & PCIE_LINK_STATE_CLKPM) {
-		link->clkpm_capable = 0;
-		pcie_set_clkpm(link, 0);
-	}
+	if (state & PCIE_LINK_STATE_CLKPM)
+		link->clkpm_disable = 1;
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	mutex_unlock(&aspm_lock);
 	if (sem)
 		up_read(&pci_bus_sem);
-- 
2.21.0


