Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AC9C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98A020659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 20:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8boeAWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANUlo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:41:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42713 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfANUlo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 15:41:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so432337wrx.9;
        Mon, 14 Jan 2019 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kh2F4pMOFwFuAAQJLLTxrbaIzUyiTQtNdJuRQypsGJU=;
        b=M8boeAWlDh1B8nhFah77FSZHP1dAHMzXsPeXUy94wXr2ojksFhG1l+KoWpVFsZs33I
         /S0g0UrpDDF4f6xJV8q7ZMnoL39y8Q67ap0EbtnlfzSB1BAWQrIRio3VMb2+6pOFy2Oe
         PZMwqTzSCRxjaqWgmMZiBnI1jPBug2Y5AgConAPUen1c84Mw9JZq564eUyCLe34ut4H3
         9WAf4XoZB5EfoB0rytLcduQdLHwb6FnwKqgZwUmOcX2yXweep5ZhY25J2QXMyLMG5iNR
         Ly2A5cHB5Nk0EHYdxUU2daVJxUu+MbBXAtIT0QH1gum4QAm25Wq5xnp+x8oFHzi4DH5p
         DQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Kh2F4pMOFwFuAAQJLLTxrbaIzUyiTQtNdJuRQypsGJU=;
        b=Wpct8/ZWxHtkqw6sDaBHH97MdDn5sNhQbhBiCZeg3XbRZDAVQD/DpjSo5S8A5K+wEx
         WkS665JisFUfsmec4OhtNNEvGXuMGk5d4YPvro6G6Y5doUkFnhNLyBmbHp1rr3IhsT6W
         Ih4+CuFrps/LrJxf6qL3z5QeHgf3qlQ1w5r3nbg2QUaveCx0Z2bTvrqKntBsVjGCZEbA
         +mk5lfXgRxvUYAxeYaBdBSrY3qa3BLYan/+zMgZC/Ap/VAa2sKsiuZtTb0TfiXWBlFJB
         uI4vHYyyd2IGg/qhBd77JpB3/SbrH8sieIjwxB1ScF6mwp8+v7QGCo5YLEJrX478r8IG
         H/sw==
X-Gm-Message-State: AJcUukeJc1jCPDD3Z05jv1ysxxMsaA+VeqNvQ0BQl3S+AjU9KgneicVB
        qBftsF6DDAXr0jGtoofyS4Y=
X-Google-Smtp-Source: ALg8bN7f9O4PYFEnbI6LJVeMZG9al4viuuKW7RjV1f0yVi3pYEOPFU3VbO3m48GSxW0W8tKx7j89Yw==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr228782wrd.294.1547498502061;
        Mon, 14 Jan 2019 12:41:42 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id y13sm54296260wrw.85.2019.01.14.12.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:41:41 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 5C8B011422AD; Mon, 14 Jan 2019 21:41:40 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:41:36 +0100
Message-Id: <20190114204137.21094-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

In this particular case change a ‘:’ with either a ‘-’ or a ‘,’
so as to match the regular expression expected by GCC.

This commit remove the following warnings:

  drivers/pci/pci.c:861:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/pci/pci.c:2261:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..94069fc35e91 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -861,7 +861,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
 			need_restore = true;
-		/* Fall-through: force to D0 */
+		/* Fall-through - force to D0 */
 	default:
 		pmcsr = 0;
 		break;
@@ -2260,7 +2260,7 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		case PCI_D2:
 			if (pci_no_d1d2(dev))
 				break;
-			/* else: fall through */
+			/* else, fall through */
 		default:
 			target_state = state;
 		}
-- 
2.19.2

