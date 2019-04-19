Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A0EC282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048C20821
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 19:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHSxBoQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfDSTL1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:11:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37840 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDSTL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 15:11:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so4621101oif.4;
        Fri, 19 Apr 2019 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2drH5CEdV46g6LB3v7o+zWjzFiQ1J6IZVvI0w9yvfU=;
        b=ZHSxBoQYrfU2dxsZQQqGxEZIyuA/1ek2/MFLecIqgFx1YVTsIP1xTRAzqDe1FixNTk
         6oOpOY0LOoSy01zsOWAnSZBy31/aVodErLKBfOW8kwt5sCTEotXvPDi8smtzRHNRBccz
         xdBrXE9d2jALCY2HN+7VLz57ASGGC29AjNO01j8W8Gz8r1qeGhzfVhiCmDUO+DD752cW
         oANhKwSxUnFgV1OXppWWyIXFI4GsMGRqV57HXkB4YVFyrCNIs5s4edPJm0hhECeUGtDe
         lYqYzXzXqeqE5z94/cNOL7boK3DrsSgypEHV7A6vs/G52lrrnZ1dPDw2JlIz031XSHsd
         0Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2drH5CEdV46g6LB3v7o+zWjzFiQ1J6IZVvI0w9yvfU=;
        b=sNv6uWkfwR+za4y5LIDaOW6tpiYwQF6rQLr1DUk5SBLUUFFsZoGkPuxhyNR/AfGSgs
         K3oKKLNRxVoBbCvIaDxJRqMYx1xdtyaRq76pZs01qhnRHl9Rw1D4XmiRhcbwZE00+SgX
         tZqw3ZJaesdWDwbosCvhvjuVfxZapEaYgpy4StzN24sWE9Q8LnuhKyZjAWhnmIUURg2v
         9WaW99i2KOPLcjEmpzQUPn/dc38N1mJNzZiVvSJqDRHvYGxOvrbZmZLs1/6RrPWHV+/I
         ToOelK/Yyw2YDUPNriZZ9KRyx29/mV9cIo52X5bO95j9lfMrdFAdLRbqIqCRHDUnysz9
         8WdA==
X-Gm-Message-State: APjAAAWQ1BbrVNARgJwM1l7pQA1zBucXTTmv2jCrHIYND1Eb8A3YUWHb
        X0I1IG9Mpco/d5Zae9BAUNhYv1TNIUA=
X-Google-Smtp-Source: APXvYqzZSMLoPPohOVoFI1SE6z3j9BzvEfCXlMxQrZidqZZZsN8fjNejYaNz3qfb1i3TGQiVl+C5dw==
X-Received: by 2002:aca:fd93:: with SMTP id b141mr2017782oii.153.1555687402034;
        Fri, 19 Apr 2019 08:23:22 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y9sm1981723otk.20.2019.04.19.08.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 08:23:21 -0700 (PDT)
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
Subject: [PATCH v3 3/4] PCI: hotplug: Wait for PDS when in-band presence is disabled
Date:   Fri, 19 Apr 2019 10:22:25 -0500
Message-Id: <20190419152238.12251-4-mr.nuke.me@gmail.com>
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

When inband presence is disabled, PDS may come up at any time, or not
at all. PDS being low may indicate that the card is still mating, and
we could expect contact bounce to bring down the link as well.

It is reasonable to assume that most cards will mate in a hotplug slot
in less than a second. Thus, when we know PDS only reflects
out-of-band presence, it's worthwhile to wait the extra second and
make sure the card is properly mated before loading the driver.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 078d78a7437d..6cd2c4fb4edb 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -240,6 +240,25 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	return found;
 }
 
+static void pcie_wait_for_presence(struct pci_dev *pdev)
+{
+	int timeout = 1000;
+	bool pds;
+	u16 slot_status;
+
+	while(true) {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		pds = !!(slot_status & PCI_EXP_SLTSTA_PDS);
+		if (pds || timeout <= 0)
+			break;
+		msleep(10);
+		timeout -= 10;
+	}
+
+	if (!pds)
+		pci_info(pdev, "Presence Detect state not set in 1000 msec\n");
+}
+
 int pciehp_check_link_status(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
@@ -249,6 +268,9 @@ int pciehp_check_link_status(struct controller *ctrl)
 	if (!pcie_wait_for_link(pdev, true))
 		return -1;
 
+	if (ctrl->inband_presence_disabled)
+		pcie_wait_for_presence(pdev);
+
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));
 
-- 
2.20.1

