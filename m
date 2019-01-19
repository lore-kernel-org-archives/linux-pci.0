Return-Path: <SRS0=pnr2=P3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0EC61CE4
	for <linux-pci@archiver.kernel.org>; Sat, 19 Jan 2019 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574F220883
	for <linux-pci@archiver.kernel.org>; Sat, 19 Jan 2019 09:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfASJxw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:53:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727718AbfASJxw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Jan 2019 04:53:52 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 466CBF0FE0A8B2DF0A52;
        Sat, 19 Jan 2019 17:53:50 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Sat, 19 Jan 2019
 17:53:39 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
Subject: [Bug report] PCI/ERR: handle non-fatal error for all subordinates
 seems incorrect
To:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Message-ID: <beab3124-1dfc-9991-449f-feec499df51a@huawei.com>
Date:   Sat, 19 Jan 2019 17:53:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith, Bjorn

The patch [1] PCI/ERR: Run error recovery callbacks for all affected devices
have broken the non-fatal error handling logic in patch [2].
For non-fatal error, link is reliable, so no need to reset link,
handle non-fatal error for all subordinates seems incorrect.

[1] PCI/ERR: Run error recovery callbacks for all affected devices   #4.20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfcb79fca19d267712e425af1dd48812c40dec0c

[2] PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=86acc790717fb60fb51ea3095084e331d8711c74

Thanks,
Dongdong

