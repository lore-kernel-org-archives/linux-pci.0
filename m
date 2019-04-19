Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF7C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C39222E9
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb3TGYRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfDSSS4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:18:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45618 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfDSSSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:18:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id y84so4512842oia.12;
        Fri, 19 Apr 2019 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/hLQpHGE1nTb+M+K/IecZnZNDziSOQqF73l6PGV8NA=;
        b=eb3TGYRVeXXq45nTJxEIkXv84cFepFfM6I8aTkKCCJiEw4XIPcVRBIvZlUaTor9TFr
         fbtxcIEgMAbsR2DLuSnu89mzpL7DBo1NjVKAnJW9EjKLrnVHoNwwzAEpft1UwVTvFnNF
         wnwvqzN7EtjpKDkYqQB/2sJwPLhNtxMFRejD/NVbUpsiBf8o00+C85mv58iD6jdYctWw
         T5MKgHrP2691rDocufwPvdr7hpe6xscjURezVg8PE/6ACVdAkro7kilyEeuXltWsndiB
         Fu1wOUJo1n+IWO5+u5AVeOo0t/cz3hTP/XWN+N1udv7058TESP7CcYpFUPh9YuIqUiuM
         FIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/hLQpHGE1nTb+M+K/IecZnZNDziSOQqF73l6PGV8NA=;
        b=gbJGwHi5IWqJ5R3QtXs8IlV1gKtq0ab1sMsVgrfHwTX8E2KSXlxJ0T17AK7A6PnAKw
         S3ZBYg5UX9GN2YEkUQ/6muy3/CdNqev0A6Y21E3L6iaVaI2/V7ublbR3zmy4QJ2Xmpf7
         QgfoATCsbvRSF8hlNCCqjYya5vk0ALYO9NuCMSD34H+CHgJkdErjwSPxIgBhNigscH5F
         8czYSKu3EeZtBynj72JGDkCoc0tbEWnStzbDFAqUMlyrlh9C7cFs/yt2vQQUb/PWVhIb
         hNpWLlJkaB6sJ4Z683x2zL3t7jAYGoS3gFNbLFuAtpGmLQvaarSKZ2DStpKPeidZJ26w
         1jRg==
X-Gm-Message-State: APjAAAUadPCMYijE/BgbCn0GpqfHk0En1u79RNYzlMkWwoPo3f9fHpPj
        fOIggfXcLaixWg2SirYwgaOMSDZPdT4=
X-Google-Smtp-Source: APXvYqyAvazz134UGdE3uY6fi6/ztybt+Do5+lqi/oxed7ssxuRXOJT3VwfxLlX0raAZgoCyHXZvHw==
X-Received: by 2002:aca:bf83:: with SMTP id p125mr2171074oif.47.1555687391478;
        Fri, 19 Apr 2019 08:23:11 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y9sm1981723otk.20.2019.04.19.08.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 08:23:11 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Fri, 19 Apr 2019 10:22:24 -0500
Message-Id: <20190419152238.12251-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419152238.12251-1-mr.nuke.me@gmail.com>
References: <20190419000148.GI126710@google.com>
 <20190419152238.12251-1-mr.nuke.me@gmail.com>
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
index 905282a8ddaa..d46724f0b4ce 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -217,6 +217,22 @@ void pciehp_handle_disable_request(struct controller *ctrl)
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
+
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	bool present, link_active;
@@ -224,6 +240,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
 	 * Even if it's occupied again, we cannot assume the card is the same.
+	 *
+	 * An exception is a delayed "Card present" after a "Link Up". This can
+	 * happen on controllers with in-band presence disabled.
 	 */
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
@@ -231,6 +250,11 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
2.20.1

