Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1309BC4338F
	for <linux-pci@archiver.kernel.org>; Thu,  5 Aug 2021 08:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84BE610FB
	for <linux-pci@archiver.kernel.org>; Thu,  5 Aug 2021 08:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbhHEIjK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Aug 2021 04:39:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7793 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbhHEIjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Aug 2021 04:39:10 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgMTM21P5zYlPd;
        Thu,  5 Aug 2021 16:38:47 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 5 Aug 2021 16:38:54 +0800
Subject: Re: [PATCH V7 7/9] PCI/sysfs: Add a 10-Bit Tag sysfs file
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20210804235211.GA1693993@bjorn-Precision-5520>
CC:     <hch@infradead.org>, <kw@linux.com>, <logang@deltatee.com>,
        <leon@kernel.org>, <linux-pci@vger.kernel.org>,
        <rajur@chelsio.com>, <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <netdev@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <1b6fdf2d-cab3-3f02-5ed6-3752f8adbc0f@huawei.com>
Date:   Thu, 5 Aug 2021 16:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210804235211.GA1693993@bjorn-Precision-5520>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2021/8/5 7:52, Bjorn Helgaas wrote:
> On Wed, Aug 04, 2021 at 09:47:06PM +0800, Dongdong Liu wrote:
>> PCIe spec 5.0 r1.0 section 2.2.6.2 says that if an Endpoint supports
>> sending Requests to other Endpoints (as opposed to host memory), the
>> Endpoint must not send 10-Bit Tag Requests to another given Endpoint
>> unless an implementation-specific mechanism determines that the Endpoint
>> supports 10-Bit Tag Completer capability. Add a 10bit_tag sysfs file,
>> write 0 to disable 10-Bit Tag Requester when the driver does not bind
>> the device if the peer device does not support the 10-Bit Tag Completer.
>> This will make P2P traffic safe. the 10bit_tag file content indicate
>> current 10-Bit Tag Requester Enable status.
>>
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>
>> +		The file is also writeable, the value only accept by write 0
>> +		to disable 10-Bit Tag Requester when the driver does not bind
>> +		the deivce. The typical use case is for p2pdma when the peer
>> +		device does not support 10-BIT Tag Completer.
>
> s/10-BIT/10-Bit/
Will fix and will check other place.

Thank,
Dongdong
> .
>
