Return-Path: <SRS0=cGNF=ED=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224DC55178
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 02:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE30A2242E
	for <linux-pci@archiver.kernel.org>; Wed, 28 Oct 2020 02:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJ1CGB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Oct 2020 22:06:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:3619 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgJ1CGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 22:06:01 -0400
X-IronPort-AV: E=Sophos;i="5.77,425,1596466800"; 
   d="scan'208";a="60779609"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2020 11:06:00 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4F954417A2E8;
        Wed, 28 Oct 2020 11:06:00 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     bhelgaas@google.com, marek.vasut+renesas@gmail.com,
        robh+dt@kernel.org
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/3] dt-bindings: pci: rcar-pci-host: convert bindings to json-schema
Date:   Wed, 28 Oct 2020 11:05:48 +0900
Message-Id: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert bindings of rcar-pci.txt to json-schema. And, I realized
r8a77965 [1] and r8a774e1 [2] are not documented on rcar-pci.txt.
So, I made incremental patches to document them.

[1]
https://patchwork.kernel.org/project/linux-renesas-soc/patch/1528373494-18503-2-git-send-email-ykaneko0929@gmail.com/

This patch was old, so I didn't reuse this patch.

[2]
https://patchwork.kernel.org/project/linux-renesas-soc/patch/20200927124257.29612-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

I reused this patch.


Lad Prabhakar (1):
  dt-bindings: pci: rcar-pci: Add device tree support for r8a774e1

Yoshihiro Shimoda (2):
  dt-bindings: pci: rcar-pci-host: convert bindings to json-schema
  dt-bindings: pci: rcar-pci-host: document r8a77965 bindings

 .../devicetree/bindings/pci/rcar-pci-host.yaml     | 148 +++++++++++++++++++++
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 ----------
 2 files changed, 148 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

-- 
2.7.4

