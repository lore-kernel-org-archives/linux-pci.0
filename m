Return-Path: <SRS0=4iR6=B5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E9C433DF
	for <linux-pci@archiver.kernel.org>; Wed, 19 Aug 2020 22:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3058E2067C
	for <linux-pci@archiver.kernel.org>; Wed, 19 Aug 2020 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597875608;
	bh=lNXZ7PvJ7N1kl5zV5SEMwxx1D2MJAz9PPZyOWrNHkh0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oqVakaJVOMSuKHNrIIc9vGN2Mmd02AR8+xRRI1ZepGqmtGe5OUF0MVyR9lnlFhGc1
	 yh18dUIxo4KD3l790wxHe5WKelnAWmDpv6mlo9wxs3318ajEF12PsWfB0W9NERHfSV
	 bo4uagYYf3SQOtSTfdWnGgy3isrP7CDXAsxaWxMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHSWUH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:20:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42465 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHSWUF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2020 18:20:05 -0400
Received: by mail-il1-f195.google.com with SMTP id t13so97779ile.9;
        Wed, 19 Aug 2020 15:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KogAhKQFuzVFR3hjho8v+uBbo1DBruDLjxQEcHZBLSM=;
        b=H0PpguvgMYN1A/usBybbdRMvuIqgo7qMQDjRUBH0qDUIT4nfven5xz05xKGP8akeMO
         LhrQjKxK5E6EJXxnZEzBsuA6OkzD/F73QZei2GlYFzLxofu76LAgeiSxFP/l239YLE4d
         XTL51zOD0sqDg0VyNYADgWSVFT0BRuERP9zdblAE/SQ4gImfMvVZsVk9ar4LcEqNVb93
         TGDTg95qeJN9t/jzqM2ftcQ77Tc3TF/9YpjKrox8yWQZ7pGfxzfgueTmlRA8RxpiP8E1
         AEtCqrcR6VXXn5u6GjSnsNXW5UPEPvxkFcFYol9uA0BIdsCrFv1lr00P2nGhblBuROch
         buFQ==
X-Gm-Message-State: AOAM531yMlttCq0PUH5WovodU2T75wCXRPYn3jI4C66klpY9WSOKNTot
        opm67GpMC/TPh4binf6D99ig4yZyIg==
X-Google-Smtp-Source: ABdhPJzo3vgF7M17/Gq9tv1lPa4QciBL6EMnDRoNGptYglnnix9p6pvTkCNl7YGWeI6VF3fWs304Ng==
X-Received: by 2002:a05:6e02:1088:: with SMTP id r8mr134585ilj.291.1597875604555;
        Wed, 19 Aug 2020 15:20:04 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id s26sm11051ioc.13.2020.08.19.15.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 15:20:03 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: intel,lgm-pcie: Fix matching on all snps,dw-pcie instances
Date:   Wed, 19 Aug 2020 16:20:02 -0600
Message-Id: <20200819222002.2059917-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The intel,lgm-pcie binding is matching on all snps,dw-pcie instances
which is wrong. Add a custom 'select' entry to fix this.

Fixes: e54ea45a4955 ("dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller")
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dilip Kota <eswara.kota@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
I'll take this via the DT tree.

Rob

 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
index 64b2c64ca806..a1e2be737eec 100644
--- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
@@ -9,6 +9,14 @@ title: PCIe RC controller on Intel Gateway SoCs
 maintainers:
   - Dilip Kota <eswara.kota@linux.intel.com>
 
+select:
+  properties:
+    compatible:
+      contains:
+        const: intel,lgm-pcie
+  required:
+    - compatible
+
 properties:
   compatible:
     items:
-- 
2.25.1

