Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58924 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756892Ab2FPVs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 16 Jun 2012 17:48:56 -0400
Received: by lahd3 with SMTP id d3so2787625lah.19
        for <linux-pci@vger.kernel.org>; Sat, 16 Jun 2012 14:48:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVp9gyzRppPDu=bbRbOqY=mu1478YUSAJs=t3Cyvpmh+Q@mail.gmail.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
 <1338026043-3968-9-git-send-email-jiang.liu@huawei.com> <CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
 <4FDB2192.5070709@huawei.com> <CAE9FiQVWhSZBcZM1DXJaN7rsj64YO=OjzOm6XkUqio5fZ5di+w@mail.gmail.com>
 <4FDC5084.6090504@huawei.com> <CAE9FiQVp9gyzRppPDu=bbRbOqY=mu1478YUSAJs=t3Cyvpmh+Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 16 Jun 2012 15:48:33 -0600
Message-ID: <CAErSpo5q=UJyT=bughbgfGpG19MfnYn6h=X=YFzfUdgLy9KcPg@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2012 at 2:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Jun 16, 2012 at 2:23 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
>> On 2012-6-16 0:51, Yinghai Lu wrote:
>>>
>>> still have some problem:
>>> pci_mmcfg_check_reserved==>is_mmconf_reserved
>>>
>>> will update cfg->end_bus.
>> Hi Yinghai,
>>        How about following patch for this issue? I guess we need to
>> keep current behavior at boot time for backward compatibility, right?
>
> We'd better to make all path share as most code as possible.
> 1. hostbridge scanning during boot -- early, it will check chipset and e820
> 2. MCFG checking during boot -- early, it will check e820
> 3. MCFG checking during boot -- late, it will check acpi pnp
> 4. _CBA checking for hotplug-able pci root bus but it is installed during boot.
> 5. _CBA checking for hotplug-able pci root bus during run time.
>
> please keep mapping for all entries in MCFG table. aka 1, 2, 3.
> I have some local patches that will read ext pci conf space before scan pci bus.
> please check attached one for nehalem-ioh.

I don't think it's a requirement that Gerry keep your Nehalem patch
working.  Your intel_bus.c is not in the tree and you haven't provided
an explanation for why it should be.

The only requirement I'm aware of for PCI config access before we
discover the host bridges via ACPI is for segment group 0, bus 0, as
mentioned in ACPI spec 5.0, sec 5.2.3.1, PDF page 143, and I think
that applies only to the first 0x100 bytes of config space.  I don't
think there's a requirement for access to the extended configuration
space (bytes 0x100-0xFFF).  I do not see a requirement that this
pre-host bridge access happen via MMCONFIG; as far as I can tell, we
can use the legacy 0xCF8/0xCFC mechanism.

> for case 4, 5: only need to add one bool in acpi_pci_root to record if
> mmconf list and mapping is touched.
>
> Thanks
>
> Yinghai
