Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41E6C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 21:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B020818
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 21:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msqam9xP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBEVHQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:07:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33205 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfBEVHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 16:07:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so8359580otl.0;
        Tue, 05 Feb 2019 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bX5c/IHariKbWDtOy9vwnPRcHZRF2HQ3KvFzvmtkQHw=;
        b=msqam9xPD+7C7AW0xPyZrga9UTmvuNOvUEoCRg7Sc+ixtZX+6k8yf/jOoebZgzW0AM
         3twGfyrTtOAm/t4JdskPZmTRARRWPIPujDzX824Rcj8IZi22zPVfIRrBh1EO8tjOKeOs
         h4baASuUZaqEHN3yW7TotlM/14IKkTULqsZzE4c/AaK3HoHYfKeZGTmhGSe3nrMTrjwa
         cKKZVG4Cgd4wzZbMiBiXOvEG8nrhG2RL5wxeHK0D8ZHUNdSq8IuvWmQzL5SvmxGsVF+5
         3/BDsLRl3ebgwVHs96SjmWwZvmBOhfQeT0jIOoYsW3q4CIrnSQQXdc2nDTOU8OpbEhdy
         +6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bX5c/IHariKbWDtOy9vwnPRcHZRF2HQ3KvFzvmtkQHw=;
        b=Y6kDmbYJ64bf0rOzI0iEBlglU5cTXldmjl5qt2ti6VrCIPMSLkJKKE+iB5ffdeVnk4
         +p4FXPioMbngk25S0XfN2u8Rgo3u08Dk1LSqZ8tL99y8SW6rjjlaAZj9wfbyGs60oaAn
         6UZiWvmgr6xl21b8H+g4yLYyymduR4q8DIJBYBcPLFjWZhrvll9wkmPG/YzxIrsWwYVu
         A6pm1LGnScxKqFfWgleGdxKlVBgeJkAu2cHJMkI2YPi0zaznmzC/OccisXEpaAc2adxW
         4wjIzMYbJhka/K+Ud3vizNtQKVto1kMxNTE9iP14+jLCr0t5c6m80xIivE2CcpmUAm5A
         4FbA==
X-Gm-Message-State: AHQUAuY7fjxM6dWoq3i0PzkSau2WHUrhdEwbKAatlXicFUbqmYf4gWnb
        agv4o3SxYw/AYHpE8AA0fJ0=
X-Google-Smtp-Source: AHgI3Ib0vMnhDuuugn4UoJQo0BvLDyXtlYT7oFA/LkdFhCiq5ADYJA9SFpTtd/UralSYI2KBr5owqA==
X-Received: by 2002:aca:4155:: with SMTP id o82mr3774992oia.172.1549400834519;
        Tue, 05 Feb 2019 13:07:14 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id c9sm9864252otb.38.2019.02.05.13.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 13:07:13 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Tue,  5 Feb 2019 15:06:56 -0600
Message-Id: <20190205210701.25387-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
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
and shutdown of is not needed.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Following some discussion in
"PCI: hotplug: Erroneous removal of hotplug PCI devices" [1]
It became apparent that we can't fully rely presence detect changed
as an indicator to shutdown a device. And in PCIe 4.0 the "logical OR"
requirement is going away, so we can use a way to slightly  decouple
presence detect and link active.

I think the approach here is the simplest, and least likely to
interfere with other mis-behaving hardware (in the PCIe 3.0 sense).

[1] https://www.spinics.net/lists/linux-pci/msg79564.html

 drivers/pci/hotplug/pciehp_ctrl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..ea0dd3e956be 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -220,13 +220,23 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
+		if (present && link_active &&
+		   !(events & PCI_EXP_SLTSTA_DLLSC)) {
+			mutex_unlock(&ctrl->state_lock);
+			ctrl_warn(ctrl, "Hardware bug: Presence state came up after link");
+			return;
+		}
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (events & PCI_EXP_SLTSTA_DLLSC)
-- 
2.19.2

