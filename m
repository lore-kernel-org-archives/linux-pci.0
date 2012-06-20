Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47434 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab2FTSDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 14:03:07 -0400
Received: by dady13 with SMTP id y13so10145243dad.19
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 11:03:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FE18A9B.9040501@huawei.com>
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
	<1340111732-6276-7-git-send-email-jiang.liu@huawei.com>
	<CAE9FiQWAPb7S9kBrebnf6nn2KmCL2ohUbukycJPGQLB=11+_pA@mail.gmail.com>
	<4FE18A9B.9040501@huawei.com>
Date: Wed, 20 Jun 2012 11:03:05 -0700
Message-ID: <CAE9FiQXCzFZwbrNsAcUrAXpabdF37c+fkWxB4LYy302gMqhT-g@mail.gmail.com>
Subject: Re: [PATCH v8 06/12] PCI/ACPI: provide MCFG address for PCI host bridges
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 20, 2012 at 1:32 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Hi Yinghai,
>
>        Yes, I'm going to adopt solution two as you suggested.
> On the other hand, the MMCFG caching is kept due to following
> considerations:
> 1) To emit a warning message if MMCFG entries in MCFG table only
> partially covers buses under a PCI host bridge. Taku reported that
> he has a system which exhibits such a behavior.
Interesting.
that should have one overal checking after _CBA entry is added into
pci_mmcfg_list.
We limit root bus bus range after busn_alloc is there.
aka dump the bus range above mmcfg.
or user need to disable mmcfg.


> 2) To cross-check that MMCFG addresses returned by MCFG table and
> _CBA method are consistent if both are available (though that
> violates the PCI FW/ACPI specifications).

now we are adding support for pci hostbridge plug. so we should better to stick
with spec instead of trying to workaround possible FW problem.
Do spoil them too much.

my point is: MCFG is static. so the range from MCFG can not be changed after
they pass the sanity checking.
later if _CBA is trying come again with overlapping, just through that away.
then if _CBA is good, then just record the range, and later release the range
according the storage during hostbridge removal.

> 3) In future, we may try to remove MMCFG entry constructed from
> MCFG table when hot-removing a PCI host bridge. We have some systems
> which assign a distinguish segment ID for each host bridge. In such
> a case, it may be reasonable to remove the MMCFG entry when removing
> a host bridge.
No, MCFG is static one.

> 4) The MCFG cache should be small under normal cases.
>
>        If you feel it's unnecessary to keep the cache, I will remove
> it and send out a updated version soon.
for pci host bridge support, we would touch too much thing, I would
like to limit
first round change and keep it simple, and later could optimize it if possible.

Thanks

Yinghai
