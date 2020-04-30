Return-Path: <SRS0=q/mj=6O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3BCC83006
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCBA2073E
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588234031;
	bh=EVFjn07kmFor7UKViXp0cTbAK/KeKBmBXH77UZhMUfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SfPEX6HH1ZbyV7bOB5EcbZEEu0NYNHo41CW20DI4FK6SjBTijtzgi17y+U964nAnj
	 PhxwgtWdb62+PBDdhlobdgqa7fVUbEt7YpGDwa2u4eOm6Dxu97kg23qTADLRY/tB05
	 sVjmZ2L5rgn8vpLntfA7lHxdJKXXLXemQwNe0Sco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD3IHD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgD3IGv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:51 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4F121BE5;
        Thu, 30 Apr 2020 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234010;
        bh=EVFjn07kmFor7UKViXp0cTbAK/KeKBmBXH77UZhMUfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v67OJ1Rp1oOFl7Vj1Smbs4oVAWXOK0Qh3/349/FZd5r6Dka/ntS9BkYRLT4ulnV9O
         nnWrETfrA+f8o3tGADIFy6rIMjzfTmJ4MRb733n8ixye+2rS2dMrelkF6Bq4NiyMS9
         O594pO37ZBxr6RYdubkx22V5/XXInqarw7uG5ZPc=
Received: by pali.im (Postfix)
        id ED84B7AD; Thu, 30 Apr 2020 10:06:48 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 09/12] dt-bindings: PCI: aardvark: Describe new properties
Date:   Thu, 30 Apr 2020 10:06:22 +0200
Message-Id: <20200430080625.26070-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
References: <20200430080625.26070-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

Document the possibility to reference a PHY and reset-gpios and to set
max-link-speed property.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/aardvark-pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
index 310ef7145c47..2b8ca920a7fa 100644
--- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
+++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
@@ -19,6 +19,9 @@ contain the following properties:
  - interrupt-map-mask and interrupt-map: standard PCI properties to
    define the mapping of the PCIe interface to interrupt numbers.
  - bus-range: PCI bus numbers covered
+ - phys: the PCIe PHY handle
+ - max-link-speed: see pci.txt
+ - reset-gpios: see pci.txt
 
 In addition, the Device Tree describing an Aardvark PCIe controller
 must include a sub-node that describes the legacy interrupt controller
@@ -48,6 +51,7 @@ Example:
 				<0 0 0 2 &pcie_intc 1>,
 				<0 0 0 3 &pcie_intc 2>,
 				<0 0 0 4 &pcie_intc 3>;
+		phys = <&comphy1 0>;
 		pcie_intc: interrupt-controller {
 			interrupt-controller;
 			#interrupt-cells = <1>;
-- 
2.20.1

