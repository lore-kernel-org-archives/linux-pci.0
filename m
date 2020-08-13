Return-Path: <SRS0=UuFS=BX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA3C433E1
	for <linux-pci@archiver.kernel.org>; Thu, 13 Aug 2020 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE25E20774
	for <linux-pci@archiver.kernel.org>; Thu, 13 Aug 2020 13:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iQEqT2XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMNwE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:52:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:45754 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726100AbgHMNwE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 09:52:04 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 76C01407BF;
        Thu, 13 Aug 2020 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597326723; bh=vf8EyPinLUc3ZVANlQbLC0ipRATPUu1KLgKmKnH59Dc=;
        h=From:To:Cc:Subject:Date:From;
        b=iQEqT2XIVTm02PL9lTSiB0ajDABr+j2WODc7OXIgA0BynrRVWlH90XZdDVGVTPKVO
         ulVQzBa+rHBBecBr3LEsDoTM8o1nGMJvwGufKSgDLVfs6EAV5Knc2rSbAMkS3+Rj9y
         NDfkezZ53pEw7DPpX05Id9U28pMLaNSgsA6i+6KwxbnzjSCVefT6BnDUcXXPNUFwJx
         X+nzy15KxqzjWDjDfSuALmjZRLWKeNmHksTflAmz0iOYr1O9BYbs8QtdtSSW4Bu51L
         Awax16eQbPaRtJyvV2Tl8Z4KEcLvHUJwMmhPqKqf0mK/CveNYcFcFLUvNEBt2dNjVr
         0fL7hv9QXXCSA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 888F6A005A;
        Thu, 13 Aug 2020 13:52:01 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH 0/3] PCI: Remove unnecessary headers include
Date:   Thu, 13 Aug 2020 15:51:50 +0200
Message-Id: <cover.1597325845.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Coverity Scan has detected 3 headers include that don't provide
any symbol required by the current code implemented on
drivers/pci/pci.c, therefore this patchset aims to remove those
entries.

Gustavo Pimentel (3):
  PCI: Remove unnecessary header include (linux/of_pci.h)
  PCI: Remove unnecessary header include (linux/pci-ats.h)
  PCI: Remove unnecessary header include (asm/setup.h)

 drivers/pci/pci.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.7.4

