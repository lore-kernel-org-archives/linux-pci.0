Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DEEC4332B
	for <linux-pci@archiver.kernel.org>; Tue,  9 Feb 2021 13:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5331B64EF4
	for <linux-pci@archiver.kernel.org>; Tue,  9 Feb 2021 13:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhBINTf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:19:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12886 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhBINTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 08:19:23 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZk2M0kmYz7bGP;
        Tue,  9 Feb 2021 21:17:15 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Feb 2021 21:18:35 +0800
Subject: Re: [RFC PATCH 0/3] PCI: Enable 10-bit tags support for PCIe devices
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <1610183483-2061-1-git-send-email-liudongdong3@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <f8f98eb8-d2d4-94d7-75c9-6e0520e60c2a@huawei.com>
Date:   Tue, 9 Feb 2021 21:18:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1610183483-2061-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

kindly ping :)

On 2021/1/9 17:11, Dongdong Liu wrote:
> 10-Bit Tag capability, introduced in PCIe-4.0 increases the total Tag
> field size from 8 bits to 10 bits.
>
> For platforms where the RC supports 10-Bit Tag Completer capability,
> it is highly recommended for platform firmware or operating software
> that configures PCIe hierarchies to Set the 10-Bit Tag Requester Enable
> bit automatically in Endpoints with 10-Bit Tag Requester capability. This
> enables the important class of 10-Bit Tag capable adapters that send
> Memory Read Requests only to host memory.
>
> This patchset is to enable 10-bits for PCIe EP devices.
>
> Dongdong Liu (3):
>   PCI: Add 10-Bit Tag register definitions
>   PCI: Enable 10-bit tags support for PCIe devices
>   PCI/IOV: Enable 10-bit tags support for PCIe VF devices
>
>  drivers/pci/iov.c             |  8 ++++++++
>  drivers/pci/probe.c           | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  5 +++++
>  4 files changed, 53 insertions(+)
>
> --
> 1.9.1
>
> .
>
