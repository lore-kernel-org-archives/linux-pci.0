Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B2C282DD
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0F220833
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 06:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDHGgH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:36:07 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:38309 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHGgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2019 02:36:07 -0400
X-IronPort-AV: E=Sophos;i="5.60,324,1549954800"; 
   d="scan'208";a="29431215"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2019 23:35:54 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Apr 2019
 23:35:53 -0700
Received: from server1.microsemi.net (10.188.116.154) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Apr 2019 23:35:51 -0700
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <kelvin.cao@microchip.com>
Subject: [PATCH 0/2] Fix two bugs of switchtec module
Date:   Mon, 8 Apr 2019 22:34:46 +0800
Message-ID: <1554734088-5755-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Everyone,

This patch series fix two bugs of switchtec module.

The first is introduced by device spec definition issue: the maximum
supported PCIe function number by hardware should be 255 instead of 
the false number of 48. Rectify it in driver and for backward 
compatible, a new ioctl and corresponding data structure are created,
while keep the deprecated one.

The second is MRPC event unintentionally masked at corner case.
Fix this bug by skipping the mask operation for MRPC event in event ISR
like what we already do for LINK event.

Regard,
Wesley


Wesley Sheng (2):
  switchtec: Fix false maximum supported PCIe function number issue
  switchtec: Fix unintended mask of MRPC event

 drivers/pci/switch/switchtec.c       | 42 +++++++++++++++++++++++++-----------
 include/linux/switchtec.h            |  2 +-
 include/uapi/linux/switchtec_ioctl.h | 13 ++++++++++-
 3 files changed, 42 insertions(+), 15 deletions(-)

-- 
2.7.4

