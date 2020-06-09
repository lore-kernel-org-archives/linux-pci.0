Return-Path: <SRS0=ztgn=7W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0470DC433DF
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jun 2020 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D667E2078C
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jun 2020 16:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9TPrgtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgFIQj5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbgFIQj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 12:39:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6DC03E97C
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 09:39:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so23124318ejb.4
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i0OZiuGZLiwe8FM0K4+TyUoQ9PQaKwBmSKhQqyCRuIQ=;
        b=K9TPrgtEHUN6XUVBMIiZD73BJRllR9e7xajx9ci84oiSjlSrVl03Pfsm0pQGijXTG5
         sM6cLRmKdFoUa+QZYJ6SaPtsuDIl+0Nlq86QIbP2WA9rgO3DnLfCPBnZAdCPd5d4kFKD
         eBqJUm6+eijM2PzCY4NRJn9iUnSchem7UThMWS/GAeFEqdc+Iiqb/eL4UlH/O97emlj0
         F9Ade5V9VLOM7/HQxg/xLcHKLSyBBx8ZLSI2zTu0NQ/9WC9BIwtwsM/g/mrXY2uKYYrD
         tqPJca27o4ja7xl9S07V3u6pQYRBh7gIJ3IGlQBDWpW+Wb0CiRrUe+LRy4pDJImzqC/5
         f8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i0OZiuGZLiwe8FM0K4+TyUoQ9PQaKwBmSKhQqyCRuIQ=;
        b=Klx3Egv6hibI7A1K3bBgsDl7z1GiAfqrwCJw3W6wiTlpmIpTza+zTfKT1vJ0MQz0AY
         P0doJ6qnmXKfKvtrqLgQjocUCYM/obWW/R6KZ9HWtsWyhiRyUj3v6b4/V4pc1lzCfoPB
         Ii/ods1oFxA2MN5sdRHwrH7nr3ibmBYPcu0/lBihcaoAMLBpnXqum6Z3K39VyQINDSOU
         +rZCZ3ff2rcuK7JwAxcGN5fGvfVL+uodVIbiOKmuOfOFISY8KrVkNHh46CNBZx8X3364
         DFZ+mP56R6w0dadjtorgb8e8marHQIXeixgLt9J3fE8sZ5FV9NZ6nCfruapyKVZffqAA
         Dx/A==
X-Gm-Message-State: AOAM531D5PSRMWSMcgp92TVRt1okLujTFOzkUOtT9ybHwUevAQ44+RlT
        eSz4pAhUtGrz8MgbHxijRgI=
X-Google-Smtp-Source: ABdhPJwD2uSQ7P+53vCanneVKhMUULLjaB3tjtfTO5P7Ur1vhRF5BiPcT2cW+8C2E/vY25nlRRlhww==
X-Received: by 2002:a17:906:9254:: with SMTP id c20mr27468665ejx.540.1591720794345;
        Tue, 09 Jun 2020 09:39:54 -0700 (PDT)
Received: from net.saheed (0526DA6B.dsl.pool.telekom.hu. [5.38.218.107])
        by smtp.gmail.com with ESMTPSA id ce25sm8822176edb.45.2020.06.09.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:39:53 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH 5/8] PCI: Convert PCIBIOS_ error codes to non-PCI generic error codes
Date:   Tue,  9 Jun 2020 17:39:47 +0200
Message-Id: <20200609153950.8346-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200609153950.8346-1-refactormyself@gmail.com>
References: <20200609153950.8346-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

pqi_set_pcie_completion_timeout() return PCIBIOS_ error codes which were
passed on down the call heirarchy from pcie capability accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on return value of pcie capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative non-PCI generic error values.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index cd157f11eb22..bd38c8cea56e 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7423,8 +7423,12 @@ static int pqi_ctrl_init_resume(struct pqi_ctrl_info *ctrl_info)
 static inline int pqi_set_pcie_completion_timeout(struct pci_dev *pci_dev,
 	u16 timeout)
 {
-	return pcie_capability_clear_and_set_word(pci_dev, PCI_EXP_DEVCTL2,
+	int rc;
+
+	rc = pcie_capability_clear_and_set_word(pci_dev, PCI_EXP_DEVCTL2,
 		PCI_EXP_DEVCTL2_COMP_TIMEOUT, timeout);
+
+	return pcibios_err_to_errno(rc);
 }
 
 static int pqi_pci_init(struct pqi_ctrl_info *ctrl_info)
-- 
2.18.2

