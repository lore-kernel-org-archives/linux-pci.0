Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37798 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2FOQfU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 12:35:20 -0400
Received: by dady13 with SMTP id y13so4251538dad.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 09:35:19 -0700 (PDT)
Message-ID: <4FDB642F.3010900@gmail.com>
Date: Sat, 16 Jun 2012 00:34:55 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com> <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com> <CAErSpo5BtQ3dmn4t==ByG+Y=Q7w+wwZ7sw+LJwkSxQG8bKuUzg@mail.gmail.com>
In-Reply-To: <CAErSpo5BtQ3dmn4t==ByG+Y=Q7w+wwZ7sw+LJwkSxQG8bKuUzg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/15/2012 11:46 PM, Bjorn Helgaas wrote:
> I wrote:
> 
>> But the code in the init path is ridiculously, embarrassingly complicated ...
> 
> On Fri, Jun 15, 2012 at 1:15 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> here cache cfg too early.  should do that after
>>
>> pci_mmcfg_reject_broken().
>>
>> otherwise will use mcfg even try to reject that before.
> ...
This is an issue and I have worked out a patch for this, actually the patch
produces better readable code.

>> that really change the logic.
>>
>> looks like it will break mrst/sfi path.
>>
>> the scan from pci_legacy_init() for mrst/sfi will not have ext_pci_ops
>> set for bus 0.
> 
> I rest my case.  The current init path is unmaintainable.
I think it doesn't change the logic here. I have paid special attention
to the SFI staff when preparing the patch. On systems with SFI instead of
ACPI, such as Moorsetown, there's no ACPI root pointer table available,
so acpi_initialize() will fail and set acpi_disabled to true. We have
checked "!acpi_disabled" before calling free_all_mmcfg(), that means
we won't call free_all_mmcfg() on SFI platforms. 

> 
> I'll wait for a v8 (or later) with fixes for the build issues
> Fengguang found and Yinghai's ack.  It will make things somewhat
> easier for me if you start with my topic/jiang-mmconfig-v7 branch.
Sure, will rebase my v8 patches onto this branch tomorrow.

> 
> Bjorn

