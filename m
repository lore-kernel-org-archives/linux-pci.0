Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423AC433F4
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424D12086E
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ53WoKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424D12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeISULJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:09 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46956 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISULJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:09 -0400
Received: by mail-qt0-f195.google.com with SMTP id l42-v6so5237310qtf.13;
        Wed, 19 Sep 2018 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TLBiLM1mdu1HxR4W2fQf8NiJqsLvqjL8vfP6p3vMZ+w=;
        b=WZ53WoKUusbA3cHPVmaeu4I1DvIcIOmtdV6PfCRnqSjYtDObuE+Nc3N8sx1V8uR1q5
         /H/QAyXcWy3qRXdZ75wF2Od3gQHruAFvmPtPkpv+fCAwrczKJJz1yOXvjxXKToqlc/0+
         0OJ+csAnhvOvsPJz8iooWn5QDryrutjo9HBXK/k5WBSwDJAqNhjoXPQaG3N4nTcVxMJL
         JHthiMRJ6DttM5KBJBSbnpP5casJ8yqZ5ZwKB3IDmHDniokiP0/LX/EiY8hzFWWVPdDR
         fVURdenDFXnF/loyldrY4bnyXkpNvDCYxcRKGvFM66Fvoq7LnmNY09Bfe+maOQr1WIhZ
         4xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TLBiLM1mdu1HxR4W2fQf8NiJqsLvqjL8vfP6p3vMZ+w=;
        b=XWFjraTVHkF/6wi5trBvQ6zWYwb+bfT0qMO9uVJKGAJev2L5qyaZ49d8CI+Lt/JpkG
         /HqYuvD0ZsrsXje0O/l5E9b8eieHEIB9Fo+QsWfAJZLOIzvBegCYSosDU8mG17iTs6UC
         b1wa/+GBeeWR0cbiFSp0UOysAgP55byNWkClERpNI1QRCiHJSMhDZs4fU9XQarDzOPRt
         aA4KyW3tcJpCaQLAb1ywbGWGNdAqiiOgpSI5e/wbUPhl841Iw/ZR70dfoHjYvP8Eyqp3
         ti03ltRukQUOQXk0C7+8GymdRnLFL0npFwGMzFdijE1Gty10xUZNzDHsbAnBZy/k6mGf
         /BmQ==
X-Gm-Message-State: APzg51AleskXavr5TLF/Uwpbs73AOqJxZkJ1fOD/QtpNChnmOj4b4V+2
        g+vzeIeiJ+h279Sy47Cv2Fg78uxt
X-Google-Smtp-Source: ANB0Vdaoy/bMUe/Yab81ePa9h/gnrBVobMUqYgkmgHWY15T0tkCpyngXC68ZnraC7jDlxqOqgBwqHA==
X-Received: by 2002:ac8:1bf6:: with SMTP id m51-v6mr23892699qtk.143.1537367576468;
        Wed, 19 Sep 2018 07:32:56 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:32:55 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 02/12] dt-bindings: pci: add DT docs for Brcmstb PCIe device
Date:   Wed, 19 Sep 2018 10:31:57 -0400
Message-Id: <1537367527-20773-3-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919143157.pgQZ0Ep2WjWyo3gRoySKhM2sF-ge2pNjmmzjm70wA-Y@z>

The DT bindings description of the Brcmstb PCIe device is described.
This node can be used by almost all Broadcom settop box chips, using
ARM, ARM64, or MIPS CPU architectures.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
new file mode 100644
index 0000000..a1a9ad5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
@@ -0,0 +1,59 @@
+Brcmstb PCIe Host Controller Device Tree Bindings
+
+Required Properties:
+- compatible
+  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
+  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
+  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
+      the 7278).
+  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
+
+- reg -- the register start address and length for the PCIe reg block.
+- interrupts -- two interrupts are specified; the first interrupt is for
+     the PCI host controller and the second is for MSI if the built-in
+     MSI controller is to be used.
+- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
+- #address-cells -- set to <3>.
+- #size-cells -- set to <2>.
+- #interrupt-cells: set to <1>.
+- interrupt-map-mask and interrupt-map, standard PCI properties to define the
+     mapping of the PCIe interface to interrupt numbers.
+- ranges: ranges for the PCI memory and I/O regions.
+- linux,pci-domain -- should be unique per host controller.
+
+Optional Properties:
+- clocks -- phandle of pcie clock.
+- clock-names -- set to "sw_pcie" if clocks is used.
+- dma-ranges -- Specifies the inbound memory mapping regions when
+     an "identity map" is not possible.
+- msi-controller -- this property is typically specified to have the
+     PCIe controller use its internal MSI controller.
+- msi-parent -- set to use an external MSI interrupt controller.
+- brcm,enable-ssc -- (boolean) indicates usage of spread-spectrum clocking.
+- max-link-speed --  (integer) indicates desired generation of link:
+     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
+
+Example Node:
+
+pcie0: pcie@f0460000 {
+		reg = <0x0 0xf0460000 0x0 0x9310>;
+		interrupts = <0x0 0x0 0x4>;
+		compatible = "brcm,bcm7445-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
+			  0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &intc 0 47 3
+				 0 0 0 2 &intc 0 48 3
+				 0 0 0 3 &intc 0 49 3
+				 0 0 0 4 &intc 0 50 3>;
+		clocks = <&sw_pcie0>;
+		clock-names = "sw_pcie";
+		msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
+		msi-controller;         /* use PCIe's internal MSI controller */
+		brcm,ssc;
+		max-link-speed = <1>;
+		linux,pci-domain = <0>;
+	};
-- 
1.9.0.138.g2de3478

