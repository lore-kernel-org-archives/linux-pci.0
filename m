Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33274C282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BEB2171F
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1Oyy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:54:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2788 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1Oyy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 09:54:54 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 537FE81AB7E4AC55786D;
        Mon, 28 Jan 2019 22:54:50 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 28 Jan 2019
 22:54:41 +0800
Subject: Re: [PATCH] PCI/ERR: Fix run error recovery callbacks for all
 affected devices
To:     Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
References: <1548337810-69892-1-git-send-email-liudongdong3@huawei.com>
 <ea302148-7778-d295-4fca-cec436b64e28@kernel.org>
 <20190124213701.GA9882@localhost.localdomain>
 <5d58ea17-115f-139d-93db-fe6e9ce573cb@huawei.com>
 <20190125171713.GB11210@localhost.localdomain>
 <bbe67d36-103c-1cda-4186-128a155e8c0e@kernel.org>
 <f1d8845c-68fc-e0bf-67ed-7348b933eda1@kernel.org>
CC:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <2623f4f8-a832-c517-e5a5-7df2af57bc07@huawei.com>
Date:   Mon, 28 Jan 2019 22:54:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f1d8845c-68fc-e0bf-67ed-7348b933eda1@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2019/1/26 1:46, Sinan Kaya 写道:
> On 1/25/2019 12:37 PM, Sinan Kaya wrote:
>> On 1/25/2019 12:17 PM, Keith Busch wrote:
>>> On Fri, Jan 25, 2019 at 06:28:03AM -0800, Dongdong Liu wrote:
>>>> I want to fix 2 points by the patch.
>>>>
>>>> 1. For EP devices (such as multi-function EP device) under the same bus,
>>>> when one of the EP devices met non-fatal error, should report non-fatal
>>>> error only to the error endpoint device, no need to broadcast all of them.
>>>> That is the patch (PCI/AER: Report non-fatal errors only to the affected endpoint  #4.15)
>>>> have done, but current code PATCH [1] broken this.
>>>
>>> How do you know a non-fatal affects only the reporting end point? These can
>>> certainly be bus errors, and it's not the first to detect may be affected.
>>>
>>> In any case, what harm does the broadcast cause?
>>>
>>
>> What is the PCIe spec rule about AER errors for multi-function devices?
>>
>> Does it say it needs to be propagated to all functions or each function has
>> its own unique AER error handler?
>>
>
> Thinking more...
>
> I think there is value in probing all devices for errors like today because
> multiple errors bit can be set. Since root port's AER register only captures the
> first error, the rest of the errors requires OS to poll each device to see what
> is going on.
>
> In this case the AER error status of other functions should not report any
> outstanding event. Please verify this. Otherwise, you are looking at a device quirk.

Agree, multiple errors bit can be set, AER driver or firmware will collect the error
devices and call pcie_do_recovery() for every error devices.

also have different PFs (device numbers are different) under the same bus.
This case do not need to brodcast all the devices under the same bus.

Thanks
Dongdong
>
>
> .
>

