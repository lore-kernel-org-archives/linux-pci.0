Return-Path: <SRS0=TBtX=6P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8176BC47253
	for <linux-pci@archiver.kernel.org>; Fri,  1 May 2020 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B3424957
	for <linux-pci@archiver.kernel.org>; Fri,  1 May 2020 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N8cR5SfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgEAO2v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 May 2020 10:28:51 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46894 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729050AbgEAO2v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 10:28:51 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 5514530C046;
        Fri,  1 May 2020 07:28:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 5514530C046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1588343318;
        bh=B0RTfqVPs2WXX8d2voJyNu01vjv3akzX5dBoypICIos=;
        h=From:To:Cc:Subject:Date:From;
        b=N8cR5SfTMqR8j82pUoWuhkg2ZN4o2y9y8vimR1bn92JHHpKGzrisNleWBdqJ08Gyv
         euE49TzHw1kv8ZpQgKsiZxPsDkqZvGWfb0VWHkj1/GJLgzJGGNr0DiTr18zNRsZdpz
         xJI1+XVDEShNT2Etlx1s+ONRYmdFI4UhMZtHf/B4=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 22338140069;
        Fri,  1 May 2020 07:28:48 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND
        ENDPOINT DRIVERS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/4] PCI: brcmstb: Some minor fixes/features
Date:   Fri,  1 May 2020 10:28:26 -0400
Message-Id: <20200501142831.35174-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2 -- Dropped commit concerning CRS.
   -- Chanded new prop 'brcm,aspm-en-l0s' to 'aspm-no-l0s'.
   -- Capitalize first letter in commit subject line; spelling.

v1 -- original

Jim Quinlan (4):
  PCI: brcmstb: Don't clk_put() a managed clock
  PCI: brcmstb: Fix window register offset from 4 to 8
  dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
  PCI: brcmstb: Disable L0s component of ASPM if requested

 .../bindings/pci/brcm,stb-pcie.yaml           |  4 ++++
 drivers/pci/controller/pcie-brcmstb.c         | 19 +++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.17.1

