Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD09C433DB
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7609B61A0E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Mar 2021 09:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCYJBH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Mar 2021 05:01:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38288 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCYJAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:00:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P90Wcp101275;
        Thu, 25 Mar 2021 04:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616662832;
        bh=5JJpg9j3RLrGgrdEl+YnV8LMQv7KjuW4Rj/Mh+ZOO5I=;
        h=From:To:CC:Subject:Date;
        b=CcaLQPF+uM7Sb8AiTSgn95YOey1r+MfuZCupzUJfyEUh8LhqTTepDGQrZ2ia6vKao
         hunPStMLCgFQLnOBGCOxPxmPi/lSXMKTgpeI2ymz7dYYmfLJHctmdjQzBlUXz3/tuT
         9yf0qpi2GY5qUiZNKk3sWF7iqm9FGTLWq6uG4Mjg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P90Wa5017892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:00:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:00:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:00:31 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P90Rk7115556;
        Thu, 25 Mar 2021 04:00:28 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/6] PCI: Add legacy interrupt support in Keystone
Date:   Thu, 25 Mar 2021 14:30:20 +0530
Message-ID: <20210325090026.8843-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Keystone driver is used by K2G and AM65 and the interrupt handling of
both of them is different. Add support to handle legacy interrupt for
both K2G and AM65 here.

Some discussions regarding this was already done here [1] and it was
around having pulse interrupt for legacy interrupt.

The HW interrupt line connected to GIC is a pulse interrupt whereas
the legacy interrupts by definition is level interrupt. In order to
provide level interrupt functionality to edge interrupt line, PCIe
in AM654 has provided IRQ_EOI register. When the SW writes to IRQ_EOI
register after handling the interrupt, the IP checks the state of
legacy interrupt and re-triggers pulse interrupt invoking the handler
again.

Patch series also includes converting AM65 binding to YAML and an
errata applicable for i2037.

[1] -> https://lore.kernel.org/linux-arm-kernel/20190221101518.22604-4-kishon@ti.com/

Kishon Vijay Abraham I (6):
  dt-bindings: PCI: ti,am65: Add PCIe host mode dt-bindings for TI's
    AM65 SoC
  dt-bindings: PCI: ti,am65: Add PCIe endpoint mode dt-bindings for TI's
    AM65 SoC
  irqdomain: Export of_phandle_args_to_fwspec()
  PCI: keystone: Convert to using hierarchy domain for legacy interrupts
  PCI: keystone: Add PCI legacy interrupt support for AM654
  PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)

 .../bindings/pci/ti,am65-pci-ep.yaml          |  80 ++++
 .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++
 drivers/pci/controller/dwc/pci-keystone.c     | 343 +++++++++++++-----
 include/linux/irqdomain.h                     |   2 +
 kernel/irq/irqdomain.c                        |   6 +-
 5 files changed, 440 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml

-- 
2.17.1

