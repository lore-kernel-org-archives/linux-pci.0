Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:40419 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbaE2Dg1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 May 2014 23:36:27 -0400
Received: by mail-ie0-f178.google.com with SMTP id rl12so11292343iec.9
        for <linux-pci@vger.kernel.org>; Wed, 28 May 2014 20:36:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53868F40.8000909@huawei.com>
References: <1400729544-7940-1-git-send-email-wangyijing@huawei.com>
	<20140528032213.GP11907@google.com>
	<538558D2.3050706@huawei.com>
	<CAE9FiQWM15UHvX=7wv4aMXfTp5QLsB+J9c1qjOzpZ1vU0ePB4A@mail.gmail.com>
	<53868F40.8000909@huawei.com>
Date: Wed, 28 May 2014 20:36:26 -0700
Message-ID: <CAE9FiQX6-E7xq9Ew=KJQnMf9NkorSBtsAEWt_9+PW2R_T5ABrg@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix return in pci_bus_add_device
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 28, 2014 at 6:37 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> I found some kernel code still check this return value, and I also think return the
>>> real retval make sense.
>>
>> No, that is not right.
>>
>> If you look closely,
>>
>> device_attach() returns
>> 1: success
>> 0: not attached
>> <0: fail.
>
> Hi Yinghai,
>    Thanks for your explanation.
> I found all the kernel code to check its return value, only for print a warning for users.
>
>
> So I think we can drop all return checking from calling path

I prefer this one. as pci_bus_add_device already have

>         WARN_ON(retval < 0);

There is no need to print warning message later again.

Thanks

Yinghai
