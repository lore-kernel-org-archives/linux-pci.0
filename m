Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB32C43461
	for <linux-pci@archiver.kernel.org>; Thu,  8 Apr 2021 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E06610E6
	for <linux-pci@archiver.kernel.org>; Thu,  8 Apr 2021 13:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhDHN0Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:26:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16051 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhDHN0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 09:26:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGMQb4JKmzPnmc;
        Thu,  8 Apr 2021 21:23:19 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 21:25:56 +0800
Subject: Re: [PATCH 0/4] Add support for HiSilicon PCIe Tune and Trace device
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <jonathan.cameron@huawei.com>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@huawei.com>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
 <YGxm49c9cT69NV5Q@kroah.com>
 <01b6e8f7-3282-514e-818d-0e768dcc5ba3@hisilicon.com>
 <YG2Imet/tbyzYcOo@kroah.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <7bebe992-ebdf-cf9f-22b5-6ba55892b318@hisilicon.com>
Date:   Thu, 8 Apr 2021 21:25:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YG2Imet/tbyzYcOo@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/7 18:25, Greg KH wrote:
> On Wed, Apr 07, 2021 at 06:03:11PM +0800, Yicong Yang wrote:
>> On 2021/4/6 21:49, Greg KH wrote:
>>> On Tue, Apr 06, 2021 at 08:45:50PM +0800, Yicong Yang wrote:
>>>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>>>> integrated Endpoint(RCiEP) device, providing the capability
>>>> to dynamically monitor and tune the PCIe traffic(tune),
>>>> and trace the TLP headers(trace). The driver exposes the user
>>>> interface through debugfs, so no need for extra user space tools.
>>>> The usage is described in the document.
>>>
>>> Why use debugfs and not the existing perf tools for debugging?
>>>
>>
>> The perf doesn't match our device as we've analyzed.
>>
>> For the tune function it doesn't do the sampling at all.
>> User specifys one link parameter and reads its current value or set
>> the desired one. The process is static. We didn't find a
>> way to adapt to perf.
>>
>> For the trace function, we may barely adapt to the perf framework
>> but it doesn't seems like a better choice. We have our own format
>> of data and don't need perf doing the parsing, and we'll get extra
>> information added by perf as well. The settings through perf tools
>> won't satisfy our needs, we cannot present available settings
>> (filter BDF number, TLP types, buffer controls) to
>> the user and user cannot set in a friendly way. For example,
>> we cannot count on perf to decode the usual format BDF number like
>> <domain>:<bus>:<dev>.<fn>, which user can use filter the TLP
>> headers.
> 
> Please work with the perf developers to come up with a solution.  I find
> it hard to believe that your hardware is so different than all the other
> hardware that perf currently supports.  I would need their agreement
> that you can not use perf before accepting this patchset.
> 

Sure. I'll resend this series with more detailed information and with perf list
and developers cc'ed to collect more suggestions on this device and driver.

Thanks,
Yicong




