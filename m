Return-Path: <SRS0=dqeQ=TU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523FC04AAC
	for <linux-pci@archiver.kernel.org>; Mon, 20 May 2019 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65820815
	for <linux-pci@archiver.kernel.org>; Mon, 20 May 2019 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGnU4Tek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfETNRx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 May 2019 09:17:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETNRx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 09:17:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so7210462pfa.10;
        Mon, 20 May 2019 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D9M/M2T3Rq8qtCDChAbOi+aqSufBlSPfODs6++Et7Xc=;
        b=pGnU4TekWP/LCapQEn6fgC5nH9uKsqOe8kk/0r8JU7LUXtj7nSQrEo5qbrg3mc/YLn
         zNZEgQyAcZq76DgVnwCp3I4vfOD/UPIkb7lMJ8FGmH+fpU1HHNaWN1cD6SDjQxvx8ocR
         J+ADURnF3GjaRNMI7Nb+l8scGjGCGvk4Zm+RClq9ON5Ru/g9GCqpjPttd7roP8JHN2i8
         hGOB2RP8cVGDh0WCGr/LpIP5YWoamOdTcd/r8qqZgA0lv1deP1ZLVwJwxLWEbxDi+5Rl
         fVjTLXSma+AJaNHCiwDVNP4auyxLhL5+9G/GaKaR8VFaD8EjGOj+IXVyUNhptFOiqaq3
         Qnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D9M/M2T3Rq8qtCDChAbOi+aqSufBlSPfODs6++Et7Xc=;
        b=aLdQWtMTf4BaHDnYkPYzbhOcxx1eTcTdaaH1iw6q9K3DpReReD97nIwlDCVqfAN9ah
         tEPnc2S0dRe5l68xzxkdp/tVZa+N1JgI5sUTtnROYHsVg/OCj92QIvecUgjG/i2Z2WNb
         e/lRp6z4kJj7m5TT1Aiqil2PZ1ZPYou9KC3y8OtIcGe/rXvjzNvpKaDWF/fcEDokOyeu
         mHn+/+p/YtdinaYPPLV3oyFqlbBPajDen3acGJsSUkHL90SLIyrMSYQzzq8JdlbZQEy7
         orY0sthNtkd/L0uQgBI7SE6nsLma0yCqbU7vtU44v0LEz+i1t+mL+0FiIxWfQ3lkuDel
         WHqA==
X-Gm-Message-State: APjAAAW0ZxHLfmu4BVgtuaOli7jXDB3LKu2vpNJLTaHBfk7US7i+isWK
        0iWdpWNVnTKz65wgPKrshqs=
X-Google-Smtp-Source: APXvYqxbFTs17yLE40Srkn3Egq5bzs3E3ybbE6o0Z9fc9rRAMHklc9PzwU+Fgsc+SnAQ8jstG19ihg==
X-Received: by 2002:a62:585:: with SMTP id 127mr60151821pff.231.1558358272474;
        Mon, 20 May 2019 06:17:52 -0700 (PDT)
Received: from e69a04389.et15sqa.tbsite.net ([106.11.237.203])
        by smtp.gmail.com with ESMTPSA id b186sm20954819pga.5.2019.05.20.06.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 06:17:51 -0700 (PDT)
From:   Hao Zheng <mowendugu@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Zheng <mowendugu@gmail.com>, Quan Xu <quan.xu0@gmail.com>
Subject: [PATCH 1/1] PCI/IOV: Fix VF0 cached config space size for other VFs
Date:   Mon, 20 May 2019 21:17:24 +0800
Message-Id: <1558358244-35832-1-git-send-email-mowendugu@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the pcie_cap field before getting the config space size for
other VFs. Otherwise, the config space size of other VFs are error
set to 256, while the size of VF0 is 4096.

Signed-off-by: Hao Zheng <mowendugu@gmail.com>
Signed-off-by: Quan Xu <quan.xu0@gmail.com>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 3aa115e..239fad1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -133,6 +133,7 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
 			     &physfn->sriov->subsystem_device);
 
+	set_pcie_port_type(virtfn);
 	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
 }
 
-- 
1.8.3.1

