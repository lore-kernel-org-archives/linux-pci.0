Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C7C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 13:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D484720657
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 13:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfAQNCz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:02:55 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:2125 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfAQNCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 08:02:55 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2019 08:02:54 EST
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 17 Jan 2019 04:47:39 -0800
Received: from akaher-lnx-dev.eng.vmware.com (unknown [10.110.19.203])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id AEBC4B1341;
        Thu, 17 Jan 2019 07:47:47 -0500 (EST)
From:   Ajay Kaher <akaher@vmware.com>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>
CC:     <devel@linuxdriverproject.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 0/3] PCI: hv: Use vPCI protocol version 1.2 for v4.9 
Date:   Fri, 18 Jan 2019 02:17:15 +0530
Message-ID: <1547758038-5255-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For now, please consider these patches for review and suggest if these can be merged to mainline kernel v4.9.

These patches add support for vPCI protocol version 1.2, by baqkpotring from v4.14 to v4.9. Individual patches are summarised below: 

Patch 1: PCI: hv: Allocate physically contiguous hypercall params buffer
Backported as is.

Patch 2: PCI: hv: Add vPCI version protocol negotiation
Backported as is.

Patch 3: PCI: hv: Use vPCI protocol version 1.2 for v4.9
Change: Replaced hv_tmp_cpu_nr_to_vp_nr() with vmbus_cpu_number_to_vp_number()
to make this patch compatible for linux v4.9.

 drivers/pci/host/pci-hyperv.c | 387 +++++++++++++++++++++++++++++++++---------
 1 file changed, 311 insertions(+), 76 deletions(-)

-- 
2.7.4

