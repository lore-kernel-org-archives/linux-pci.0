Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A227BC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7629F2086D
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 11:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7629F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeLJL5N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:57:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeLJL5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 06:57:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C36F8208A4A9;
        Mon, 10 Dec 2018 19:57:10 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Dec 2018
 19:57:02 +0800
Date:   Mon, 10 Dec 2018 11:56:53 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     Logan Gunthorpe <logang@deltatee.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, Eric Wehage <Eric.Wehage@huawei.com>,
        <linuxarm@huawei.com>
Subject: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
Message-ID: <20181210115653.0000615a@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

This is perhaps a somewhat unusual RFC as it's to ask for feedback on an ECR
that is currently under discussion in the PCI SIG.  That ECR, at least partly,
came out of the issues highlighted during the discussion of P2PDMA.  In
that patch set, p2pdma is only allowed if there is a switch between the
devices involved ensuring the path does not pass through a root port.
Put simply there is no way to know if a root complex will allow p2p or not.

So we are asking for feedback at a stage where modifications to the
proposal can be made. Eric has agreed to this being shared with mailing list
to hopefully get such feedback.  Note this is under active discussion within
the SIG so inputs in that forum also welcome.

I would recommend reading the ECR and presentation for more details.
Anyone who can't get to Google Drive, email me and I'll send a copy directly.

ECR: https://drive.google.com/open?id=1X08pfyjkNwSfpTVBuiut90ajxBZd7BXg
Slides: https://drive.google.com/open?id=11d3egA8x91d99-QqfYGZ-MxLGrHpJHCK

My summary probably won't be great, but I'll give it a go to persuade people
to look at the real docs!

Problem Statement:

Linux does not generally enable Peer to Peer because (amongst other reasons)
it does not know which Root Complexes support Peer to Peer.

* Some Root Complexes do not support Peer to Peer
* Some Root Complexes only support Posted Peer to Peer
* Some Root Complexes only support Peer to Peer within one PCIe Segment
* Some Root Complexes only support Address Decode Peer to Peer (no ID routing)
* Some Root Complexes may not support Peer to Peer from Integrated End Points

Related other issue
* MPS must be programmed the same across all devices supporting P2P
* Hot plugged devices might require a smaller MPS than was programmed.

Solution:
* New extended capability and control (though only one bit in the control)
* Advertise what a Peer to Peer Root Port and Switch Down Stream ports can do.
* Define packet splitting scheme for MPS mismatches.
	- Rules on how this must be done if supported.

All feedback welcome.  Let's make sure we get this right.

Thanks,

Jonathan Cameron
Huawei

