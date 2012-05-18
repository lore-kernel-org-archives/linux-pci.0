Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43732 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932365Ab2ERQgb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 12:36:31 -0400
Received: by lahd3 with SMTP id d3so2210527lah.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 09:36:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FAA4754.1010803@gmail.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
 <20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com> <4FA950A5.6040106@gmail.com>
 <20120509162117.63d8c155.izumi.taku@jp.fujitsu.com> <4FAA4754.1010803@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 18 May 2012 10:36:09 -0600
Message-ID: <CAErSpo6SFyRCGoTP5TsEK8Zr8ZZ9ZUwjGucXQ2F6yYQq+WvaJg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Jiang Liu <liuj97@gmail.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 9, 2012 at 4:30 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Thanks, Taku!
>
> On 05/09/2012 03:21 PM, Taku Izumi wrote:
>> On Wed, 09 May 2012 00:58:13 +0800
>> Jiang Liu <liuj97@gmail.com> wrote:
>>
>>> Hi Taku,
>>>      Thanks for testing. Could you please help to try the patch below?
>>
>>   Hi Jian,
>>   I confirmed this patch solves my problem.

Can you fold this patch in, Jian?

Taku, I'm curious about your machine.  Are there devices on [bus
14-ff]?  I assume that with Jian's patch, we only map MMCONFIG space
for [bus 00-13], but I'd like to confirm that.  A complete dmesg log
would answer both questions.

I think the right thing is to map MMCONFIG space for [bus 00-13].  If
there are devices on [bus 14-ff], they should still work; it's just
that we wouldn't be able to access their extended config space.

Bjorn
