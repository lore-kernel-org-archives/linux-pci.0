Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50863C10F00
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2076A206C0
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHrLdy3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCVCi7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:38:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39966 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCi7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:38:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id u10so653028wmj.5;
        Thu, 21 Mar 2019 19:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHCxIvDdxQb6gPnDJ6lurSWU6yyk4e/x/rzMANE5Lbg=;
        b=QHrLdy3jMhUT/GMqizEDXFSSOcb9a39cvClwyMuBtH6AtF37b6F0qr26vEpM+CCu48
         mKNWtu0L/xUKyIfKV6vmEGKtBqbrrKJm8xUouUEF6RfoPuEW6eIwkJremqA6ElDW+vxS
         iPUKP+NzT3bXBvhfrZFEHQUHTxY03yMM84ewt0oTSfBQ5++DJ2Ft4o7Jbdd+6kRSBTFR
         71LdwnrWj3j/uRv56UqjJmNSP1h0koSCfGIIecz6kHYUMXIHlaVd0Qiq3GAa3MixI+WS
         VwQCjHDvPEBTWWK+ufI4URCM6d5uBk98oxckm8tsH88pNZjJpXd01iDHtbRXygGUlHh/
         LfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHCxIvDdxQb6gPnDJ6lurSWU6yyk4e/x/rzMANE5Lbg=;
        b=CMzAX5/9OELHWiS+BDXgm+9Yqq6Wj8IVI3uaRZwboQRlwknaG2UHjsHcxqiqm6I17c
         PTXw2sRuSyFzVoWjhu1SbHnIgpiMKxVqCbrqJGQ8RaaWaCc54fJG8d0K0R4x8wBXca/F
         tlk419vgH2asIa539FubtHQLpeDEbafidGrgHfRQ7LQBKFhBWDiPgfdcUKJ4DZYlYTB9
         0PF+WHlxODLYvvBK62lsvGRJ2BpXNgnE0UomE1NBt1Ux6dPX6BE20DAPxFC3fUDugM1h
         sP30Q1FUaQB+lDnHhx7fc/ByT5T7sH8ACj2lc+ingJNBewXJQbJEiJLJFuaRSqVZtOwO
         TX7Q==
X-Gm-Message-State: APjAAAWTXn9AGRhIlqE+gpUJVvZLpycdFAfNhjunoiN99EW7CXw/1qQB
        Btr6Rb0r5LDQNLHhW/OqVRpOKcIS
X-Google-Smtp-Source: APXvYqwiogo+iIF5GqF8YHptj/vbiRoRfvjlwsEMawxk4I2yItn+WliiQnP+pmTrGMUxKO6Lo7eVAg==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr34109wme.24.1553222336242;
        Thu, 21 Mar 2019 19:38:56 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w18sm10432692wru.24.2019.03.21.19.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:38:55 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 5/6] PCI: rcar: Clean up debug messages
Date:   Fri, 22 Mar 2019 03:38:43 +0100
Message-Id: <20190322023844.18574-5-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322023844.18574-1-marek.vasut@gmail.com>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Drop useless casts from debug messages, they are no longer needed
due to the data type cleanup.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: - Bundle this patch with other cleanups before resending
    - Add R-B from Geert
---
 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 0ab05803bb70..989b7b73ed61 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -284,8 +284,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	else if (size == 2)
 		*val = (*val >> ((where & 2) << 3)) & 0xffff;
 
-	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)*val);
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, *val);
 
 	return ret;
 }
@@ -303,8 +303,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
-	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)val);
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, val);
 
 	if (size == 1) {
 		shift = (where & 3) << 3;
-- 
2.20.1

