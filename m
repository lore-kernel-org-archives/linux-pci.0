Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52454 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964824Ab2HVR0k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Aug 2012 13:26:40 -0400
Received: by lagy9 with SMTP id y9so709328lag.19
        for <linux-pci@vger.kernel.org>; Wed, 22 Aug 2012 10:26:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50330473.6030902@huawei.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
 <5031C3E4.9050407@huawei.com> <CAErSpo6sV1pi5mCQ-G6stz4hYam30-Vs7A_4YMxwRyUMUiH74Q@mail.gmail.com>
 <50330473.6030902@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 Aug 2012 10:26:18 -0700
Message-ID: <CAErSpo4D=p=ZZFnqmqYqmOyZOp21X-gwSsYOz+ah54SCf1C4Ng@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Clean up drivers/pci/remove.c
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2012 at 8:45 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2012/8/20 23:40, Bjorn Helgaas wrote:
>> On Sun, Aug 19, 2012 at 10:58 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> tested-by Yijing Wang <wangyijing@huawei.com>
>>
>> Great, thanks for trying this out!  Can you give me any details on
>> what you tested (what sort of machine, which hotplug driver, PCIe
>> button/LED style hotplug or ExpressCard style, etc?)
>>
>
> Hi Bjorn,
>    I tested these patches in IA_64, and use acpiphp driver to do the hot-plug test.
> The hotplug action was triggered via sysfs interface(/sys/bus/pci/slots/xxx/).
> The target pcie devices were fibre channel card and Intel 82576 card.As bellow:

Thanks, that's perfect!  It's especially good to test acpiphp because
that was one of the "not completely obvious" changes.

I added your Tested-by: to the acpiphp and the PCI core patches; let
me know if that's not what you intended.

> 0000:40:07.0 root port supports hotplug by acpiphp.
> hot plug 0000:46:00.0 and its child devices and buses.
>
> -+-[0000:40]-+-00.0-[0000:41]--
>  |           +-01.0-[0000:42]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>  |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
>  |           +-03.0-[0000:43]----00.0  LSI Logic / Symbios Logic SAS1064ET PCI-Express Fusion-MPT SAS
>  |           +-04.0-[0000:44]--
>  |           +-05.0-[0000:45]--
>  |           +-07.0-[0000:46-49]----00.0-[0000:47-49]--+-02.0-[0000:48]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>  |           |                                         |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
>  |           |                                         \-04.0-[0000:49]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>  |           |                                                           \-00.1  Intel Corporation 82576 Gigabit Network Connection
>
> after hot remove
> -+-[0000:40]-+-00.0-[0000:41]--
>  |           +-01.0-[0000:42]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>  |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
>  |           +-03.0-[0000:43]----00.0  LSI Logic / Symbios Logic SAS1064ET PCI-Express Fusion-MPT SAS
>  |           +-04.0-[0000:44]--
>  |           +-05.0-[0000:45]--
>  |           +-07.0-[0000:46-49]--
>
>
>>>> This started as a simple conversion of list_for_each() to
>>>> list_for_each_entry(), so I could remove the pci_dev_b() helper.
>>>>
>>>> In the process, I noticed that drivers/pci/remove.c is getting a little
>>>> crufty, so I reworked it to make it more understandable.  This is a long
>>>> series of small patches, so it might be easiest to start by looking at the
>>>> end product, so you have some idea where I'm heading.
>
>
>
> --
> Thanks!
> Yijing
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
