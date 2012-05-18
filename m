Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52298 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618Ab2ERQ7g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 12:59:36 -0400
Received: by dady13 with SMTP id y13so4071943dad.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 09:59:36 -0700 (PDT)
Message-ID: <4FB67FEE.1020100@gmail.com>
Date: Sat, 19 May 2012 00:59:26 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/6] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com> <20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com> <4FA950A5.6040106@gmail.com> <20120509162117.63d8c155.izumi.taku@jp.fujitsu.com> <4FAA4754.1010803@gmail.com> <CAErSpo6SFyRCGoTP5TsEK8Zr8ZZ9ZUwjGucXQ2F6yYQq+WvaJg@mail.gmail.com>
In-Reply-To: <CAErSpo6SFyRCGoTP5TsEK8Zr8ZZ9ZUwjGucXQ2F6yYQq+WvaJg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/19/2012 12:36 AM, Bjorn Helgaas wrote:
> On Wed, May 9, 2012 at 4:30 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> Thanks, Taku!
>>
>> On 05/09/2012 03:21 PM, Taku Izumi wrote:
>>> On Wed, 09 May 2012 00:58:13 +0800
>>> Jiang Liu <liuj97@gmail.com> wrote:
>>>
>>>> Hi Taku,
>>>>      Thanks for testing. Could you please help to try the patch below?
>>>
>>>   Hi Jian,
>>>   I confirmed this patch solves my problem.
> 
> Can you fold this patch in, Jian?
Sure, I have already folded it into v6. Will send out v6 after addressing
your review comments.

Gerry
