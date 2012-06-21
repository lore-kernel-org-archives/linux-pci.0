Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49775 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab2FUWW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 18:22:26 -0400
Received: by pbbrp8 with SMTP id rp8so2705259pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 15:22:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5ABBo787gr+FqfvAhU=qQ9a5zgQyg=+HTr5dkigB3-XA@mail.gmail.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
	<CAErSpo5ABBo787gr+FqfvAhU=qQ9a5zgQyg=+HTr5dkigB3-XA@mail.gmail.com>
Date: Thu, 21 Jun 2012 15:22:25 -0700
Message-ID: <CAE9FiQUcnW9W5q7rqyX+0TmLW=32CrULW7C+bdbzouNPWV3PuA@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 1:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Jun 21, 2012 at 3:36 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
>> This patchset enhance pci_root driver to update MMCFG information when
>> hot-plugging PCI root bridges. It applies to
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next
>
> Yinghai, I'm hoping you will review these.  I'd like to get them into
> -next soon and you're the main person paying attention to them :)  If
> you can't, let me know and I'll give it a go myself.

Hi, Bjorn,

Only

[PATCH v9 07/11] x86/PCI: update MMCFG information when hot-plugging
PCI host bridges

still have problem with non-0 segment handling on failing path.

So assume us time tonight, and china time friday daytime, Jiang could fix it.

otherwise I will fix it tomorrow morning, then you could merge tomorrow noon.

Thanks

Yinghai
