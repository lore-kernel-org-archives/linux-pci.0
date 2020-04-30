Return-Path: <SRS0=q/mj=6O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F21C47253
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3120870
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="j8ZT0729"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgD3TA4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:00:56 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:56070 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgD3TAx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 15:00:53 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 4E3F730C0CE;
        Thu, 30 Apr 2020 11:55:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 4E3F730C0CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588272934;
        bh=u71I4sWw1v2y+pty1vu/EYKCS2yJyi1NZITvH6WpKXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8ZT07291ncyNHTMtsjtrVMN9OntI2+TmIFKNBbbjN0ks5OZPL3oqcPAGqbjaDhMh
         6Ic2MuypgSzX6zCO6NZGzhHuYwWn+JQONYTlsTEoFH5vmayN/xtj/GH9xSkjdkvb5q
         MvBcWq2vaT6ockbquWU2wR48D719nmg+wzQ0hKfI=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id DCE93140069;
        Thu, 30 Apr 2020 11:55:40 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] dt-bindings: PCI: brcmstb: New prop 'brcm,aspm-en-l0s'
Date:   Thu, 30 Apr 2020 14:55:21 -0400
Message-Id: <20200430185522.4116-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430185522.4116-1-james.quinlan@broadcom.com>
References: <20200430185522.4116-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

For various reasons, the L0s component of ASPM is intentionally
disabled.  Specifying the 'brcm,aspm-en-l0s' property enables it.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 77d3e81a437b..b3e43597b89c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -56,6 +56,10 @@ properties:
     description: Indicates usage of spread-spectrum clocking.
     type: boolean
 
+  brcm,aspm-en-l0s:
+    description: Enables ASPM L0s savings; off by default.
+    type: boolean
+
 required:
   - reg
   - dma-ranges
-- 
2.17.1

