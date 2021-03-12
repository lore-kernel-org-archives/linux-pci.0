Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39551C433E6
	for <linux-pci@archiver.kernel.org>; Fri, 12 Mar 2021 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1099B64FCE
	for <linux-pci@archiver.kernel.org>; Fri, 12 Mar 2021 14:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCLOBj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:01:39 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:42879 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhCLOBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 09:01:37 -0500
Date:   Fri, 12 Mar 2021 14:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1615557695; bh=6bdcrp8jEQRIYpIYmeR6zTGfcMfNI/RUbuD60AYfiWU=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=MsapHekvCsRYuYBJmOk0iwNl5ykMCr2ngPWgHMCw+ClwXi15eoC9qRhNc81DB+jzN
         t1v4kQN2APxDYeMOVvoJ3N/FkLrU6hOWpuGP8Z40aIQFMGnabkQE3BIk5XBfStkJQI
         58UtGs5qFMUdThykappT814MTpbx/ixnchSn0ww7+WeM/0lIVfXXKdRo3JCN7R42v8
         wBezVcudDB4LbyH0spoU5IOs+6PyJ3pj32035WoAAWsvK9d5qOer+631oz+UlGV5kK
         bpUTU13gDnlHqE7aEQ0p+0WserW6QUaiLbu/zuwbwz2eWyx7LCgKhoViFzu02qZmuN
         RfFMywdj4k9Ig==
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH RESEND] PCI: dwc: put struct dw_pcie::{ep,pp} into a union to reduce its size
Message-ID: <20210312140116.9453-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A single dw_pcie entity can't be a root complex and an endpoint at
the same time.
We can use this to reduce the size of dw_pcie by 80, from 280 to 200
bytes (on x32, guess more on x64), by putting the related embedded
structures (struct pcie_port and struct dw_pcie_ep) into a union.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 drivers/pci/controller/dwc/pcie-designware.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/con=
troller/dwc/pcie-designware.h
index 7247c8b01f04..ca8aeba548ab 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -266,8 +266,10 @@ struct dw_pcie {
 =09size_t=09=09=09atu_size;
 =09u32=09=09=09num_ib_windows;
 =09u32=09=09=09num_ob_windows;
-=09struct pcie_port=09pp;
-=09struct dw_pcie_ep=09ep;
+=09union {
+=09=09struct pcie_port=09pp;
+=09=09struct dw_pcie_ep=09ep;
+=09};
 =09const struct dw_pcie_ops *ops;
 =09unsigned int=09=09version;
 =09int=09=09=09num_lanes;
--
2.30.2


