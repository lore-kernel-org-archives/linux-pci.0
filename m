Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB214C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A94821871
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 07:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pGkKxMMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfCOH3z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:29:55 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33576 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfCOH3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2019 03:29:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C0844CF5
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2019 07:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id edQsg0NRqirt for <linux-pci@vger.kernel.org>;
        Fri, 15 Mar 2019 02:29:53 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 98F7FCDE
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2019 02:29:53 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id k5so6396281ioh.13
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2019 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xy7x4Tgo9JSLzKOlvBWwqGv6Hh3KCpHu92BvLfEbekw=;
        b=pGkKxMMcYTA+4ibgxCnLx3W8wdAHRV1er6127G3dsauH1uTrUPmdElNm/U53Xnv/m9
         Aq6H5VTWKKJFBNG05qI2/i6KKs6BAwAFH5Qp+X9VtQX1owC2SK8uPjwnIa3bU/VK5xF7
         03lqNgaMOhQlz1cb13nPWbEmpDWQaP055L86zCHVecQsInq20oGNIW1ZPzHrHqAEobGo
         UbGToY6JbdKUTz65+GwN27aFmDtJhwtUudKTuWijC20r0FJw9tYgf/RQCHSqmGcVENLK
         Ns7GRgEjs6sRuZNMTemG8WuvD/Ew78cnEJClbmhC0ampct/hWFxS1qQqtQeZIEqeCITG
         PvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xy7x4Tgo9JSLzKOlvBWwqGv6Hh3KCpHu92BvLfEbekw=;
        b=XtKKFtGae65SdRZo3YpeWFMXsMXGiFjLJE4XcIaZjqRkP/FAcPlMGatbcJE0kWktfX
         P0pz2kkbbVtpOUP3Ocxozoagk/Ii37+cwrfHJOT99AvDeljbDs2LN/gXXDAlEjWENw6h
         XVXvcF0p7GUUBsHY9v5sz3ftx9l82pUP9Ybo8t/c5fILgUSIZT50fBnaJn2xn501hc1R
         0+t+R1x6epY5cMVeag6uh3/ES5gb6UMqASU+2do/MOXow9Z0axWV53yg+dtxSlT31XZ/
         J3nNRJgqngGL+xSEd6IbgTUT9TrVeUCdc9g8Q6aNmNelLuntR0kz0Orq6Abzh5KUtMZu
         itRQ==
X-Gm-Message-State: APjAAAVbMbJtK9Xe5LDzc3gmC7yaxeJbwWumArXNOmNc7GLErH3dju91
        /AMMnPxwxUBZWsvlcK1fAx0/fC+63o+UR+Oz+2zm9oSjsApSfDlISmNLkgInq9+ljc9KYqBewp4
        wTQbk98jX3fEyF2kWAyQt0Ax3
X-Received: by 2002:a5e:dc0a:: with SMTP id b10mr1444094iok.34.1552634992979;
        Fri, 15 Mar 2019 00:29:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzl50u4ZAT7SceUFXRHgS2olfobWPi+m3ACkND+tAi5+oYptGH2ujwQCrlgZG3TMPNPwtsNjw==
X-Received: by 2002:a5e:dc0a:: with SMTP id b10mr1444077iok.34.1552634992742;
        Fri, 15 Mar 2019 00:29:52 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id o141sm707418ito.14.2019.03.15.00.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 00:29:52 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: pcie-rcar: fix a potential NULL pointer dereference
Date:   Fri, 15 Mar 2019 02:29:43 -0500
Message-Id: <20190315072943.22923-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
References: <CAMuHMdX=XwxVFb1eLupmyHBOMBGzB+=RXxcUCH9D-J1+YKiq5w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case __get_free_pages fails and returns NULL, the fix returns
-ENOMEM and releases resources to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
V2 removes the error message.
---
 drivers/pci/controller/pcie-rcar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c8febb009454..71e55995c058 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -929,6 +929,10 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		err = -ENOMEM;
+		goto err;
+	}
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-- 
2.17.1

