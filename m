Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E0BC282E1
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CD520811
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 06:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDVGoB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:44:01 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:37736 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfDVGoB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2019 02:44:01 -0400
X-IronPort-AV: E=Sophos;i="5.60,380,1549954800"; 
   d="scan'208";a="31972696"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.99.222])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2019 23:43:59 -0700
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX2.microsemi.net
 (10.201.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 22 Apr
 2019 01:43:59 -0500
Received: from AUSMBX3.microsemi.net (10.201.34.33) by AUSMBX3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 22 Apr
 2019 01:43:58 -0500
Received: from server1.microsemi.net (10.188.116.203) by ausmbx3.microsemi.net
 (10.201.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 22 Apr 2019 01:43:55 -0500
From:   Wesley Sheng <wesley.sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@microchip.com>,
        <kelvin.cao@microchip.com>
Subject: [PATCH 0/3] Redundant steps removal and bug fix of ntb_hw_switchtec
Date:   Mon, 22 Apr 2019 22:42:55 +0800
Message-ID: <1555944178-1957-1-git-send-email-wesley.sheng@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Everyone,

This patch series remove redundant steps and fix one bug of the 
ntb_hw_switchtec module.

When a re-initialization is caused by a link event, the driver will
re-setup the shared memory windows. But at that time, the shared memory
is still valid, and it's unnecessary to free, reallocate and then
initialize it again. Remove these redundant steps.

In case of NTB crosslink topology, the setting of shared memory window
in the virtual partition doesn't reset on peer's reboot. So skip the
re-setup of shared memory window for that case.

Switchtec does not support setting multiple MWs simultaneously. However,
there's a race condition when a re-initialization is caused by a link 
event, the driver will re-setup the shared memory window asynchronously
and this races with the client setting up its memory windows on the 
link up event. Fix this by ensure do the entire initialization in a work
queue and signal the client once it's done. 

Regard,
Wesley

--

Changed since v1:
  - It's a resend of v1

--


Joey Zhang (2):
  ntb_hw_switchtec: Remove redundant steps of
    switchtec_ntb_reinit_peer() function
  ntb_hw_switchtec: Fix setup MW with failure bug

Wesley Sheng (1):
  ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
    for crosslink case

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 80 +++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 31 deletions(-)

-- 
2.7.4

