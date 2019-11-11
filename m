Return-Path: <SRS0=GTBH=ZD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE27C43331
	for <linux-pci@archiver.kernel.org>; Mon, 11 Nov 2019 03:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08CE206DF
	for <linux-pci@archiver.kernel.org>; Mon, 11 Nov 2019 03:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKKDbn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:31:43 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfKKDbm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 10 Nov 2019 22:31:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 77AE02E6E022136FE73F;
        Mon, 11 Nov 2019 11:31:41 +0800 (CST)
Received: from [127.0.0.1] (10.65.58.147) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 11:31:37 +0800
To:     <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <keith.busch@intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Subject: [Query]: PCIe Root Port Error Recovery
Message-ID: <255b77ba-13bd-c7f1-c7ab-d0e6bd398f2c@hisilicon.com>
Date:   Mon, 11 Nov 2019 11:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

hello,

I found that the root port itself is not handled in pcie_do_recovery() function
and I noticed the commit(bfcb79f) in reset_link(), err.c writes:
"If a Downstream Port (including a Root Port) reports an error, we assume the Port itself is reliable and we need to
reset its downstream link"

Is it real that the root port is always reliable and
How to recover the root ports if it do meet some errors?

Many thanks,
Yang


