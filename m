Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD91C4360F
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB1721773
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx+JsQtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfBTBU5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:20:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40348 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBTBU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 20:20:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id v20so5519205otk.7;
        Tue, 19 Feb 2019 17:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqGwsJuXZUfRqc7YK5FaZmF1KQuNiz1aXzMjLa/CYEk=;
        b=Qx+JsQtmwUB6aqqH8XS09WIpZeGseOj/YWe0q/1CwIF+OaFhOFECYZ82n5VICZwdoh
         yYQt0BgQeArGGAsnevX2tAC180A1INMInrg0qx4S3EWNgS5GcTRj1eCjuF42ODa1Jnc8
         bEGI+RWwQAGXcMXGxrbSO+zr27cffqXVIXy2R+/10YM4bb8ex8ubmHHWJacTCfIYjBIg
         yOUd5LNqtAGBrofjEVm7+uQvPPCa930vOWwUkoHU95h1OnvNB2RYJm3uwVKU5LKKHju7
         HVa+KsBYK4SGI/XNCohTFhl3vEkOP2yjoUNLanFZdVbcVZyPtocpSoRTXbM+ejlshK/N
         wYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqGwsJuXZUfRqc7YK5FaZmF1KQuNiz1aXzMjLa/CYEk=;
        b=H0Uo25iwOtTkjL/MXQiTRW0yxYBPP1tyvQbrNnJcKGfmKn5IcqHt+wiM2xGG3EEEJT
         jDs6ZiC5tIu7ViemPOTNqs1y05BsM543kcjP0KafDHOOEEzzDqs+l9U4IznmVoBcGqMT
         BWNOG64MU99M+IAbstRnjDIFn04nAQ2SetNulTUy5k9w9I9agprEBuST5K1sUnmq82Lm
         jy67a4ZIaGLJXyUJlfAm9tJJpdQWKYAaPnx4qjt587GNqa8oGb35E2jhrz/kRUhOXyIS
         zaXYLlcUuHPQDLrfnkkEe6XHmpWHr01IMu6BpQcpm7Ei4GG6bJzczDLwVRnmiqEVp5Hy
         AIVQ==
X-Gm-Message-State: AHQUAuZ8c0KLdmdjUnAzhtXHlyGr3buZk8rWn2lmNy+Csmbpi2NnE46Z
        9OxpSMBIl3uikkJ1slGq3R4=
X-Google-Smtp-Source: AHgI3Ia4802Wa4Yq6LCQYYuE7ZZzi5mcB+1nDYYc/GdK9mVacMj4V9/mpUoBx5Cmcta3Nh/xmYsM1Q==
X-Received: by 2002:a9d:7544:: with SMTP id b4mr19045866otl.326.1550625655787;
        Tue, 19 Feb 2019 17:20:55 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d67sm8000424oig.36.2019.02.19.17.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:20:55 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/4] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Tue, 19 Feb 2019 19:20:28 -0600
Message-Id: <20190220012031.10741-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190220012031.10741-1-mr.nuke.me@gmail.com>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCIe 3.0, the presence detect state is a logical OR of
in-band and out-of-band presence. With this, we'd expect the presence
state to always be asserted when the link comes up.

Not all hardware follows this, and it is possible for the presence to
come up after the link. In this case, the PCIe device would be
erroneously disabled and re-probed. It is possible to distinguish
between a delayed presence and a card swap by looking at the DLL state
changed bit -- The link has to come down if the card is removed.

Thus, for a device that is probed, present and has its link active, a
lack of a link state change event guarantees we have the same device,
and shutdown is not needed.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..28965995ebb9 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -213,6 +213,21 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
 }
 
+static bool is_delayed_presence_up_event(struct controller *ctrl, u32 events)
+{
+	bool present, link_active;
+
+	if (!ctrl->inband_presence_disabled)
+		return false;
+
+	present = pciehp_card_present(ctrl);
+	link_active = pciehp_check_link_active(ctrl);
+
+	if (!present || !link_active || events & PCI_EXP_SLTSTA_DLLSC)
+		return false;
+
+	return true;
+}
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	bool present, link_active;
@@ -220,13 +235,22 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
+	 * When the card is swapped, we also expect a change in link state,
+	 * without which, it's likely presence became high after link-active.
 	 */
 	mutex_lock(&ctrl->state_lock);
+	present = pciehp_card_present(ctrl);
+	link_active = pciehp_check_link_active(ctrl);
 	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&ctrl->button_work);
 		/* fall through */
 	case ON_STATE:
+		if (is_delayed_presence_up_event(ctrl, events)) {
+			mutex_unlock(&ctrl->state_lock);
+			ctrl_dbg(ctrl, "Presence state came up after link");
+			return;
+		}
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (events & PCI_EXP_SLTSTA_DLLSC)
-- 
2.19.2

