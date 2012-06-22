Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51818 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab2FVQyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 12:54:47 -0400
Received: by lbbgm6 with SMTP id gm6so3827663lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 09:54:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FE44BEA.5030101@gmail.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
 <CAE9FiQUn-NhgJkhHXFu4gMi=xzWz06hSVxUJunj25e8gH_xqBw@mail.gmail.com>
 <20120622192128.60b57d14.izumi.taku@jp.fujitsu.com> <4FE44BEA.5030101@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 22 Jun 2012 10:54:25 -0600
Message-ID: <CAErSpo6-nKFDTT_J=Ae61aVvxTkyn+FoQ_XGVEH=gyjS4_JAWQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] acpi, pci: hostbridge hotplug support
To: Jiang Liu <liuj97@gmail.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 22, 2012 at 4:41 AM, Jiang Liu <liuj97@gmail.com> wrote:
> On 06/22/2012 06:21 PM, Taku Izumi wrote:
>> On Thu, 21 Jun 2012 11:18:07 -0700
>> Yinghai Lu <yinghai@kernel.org> wrote:
>>
>>> On Thu, Jun 21, 2012 at 2:34 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>>>>
>>>>  This patchset adds basic code for host bridge hotplug.
>>>>
>>>>  I assume ACPI container device (ACPI0004) which carries
>>>>  hostbridges will be hot-added or hot-removed. In that case
>>>>  some codes are now missing for hostbridge hotplug.
>>>>  This patchset mainly adds the following:
>>>>   - remove hostbridge and devices under it
>>>>   - resoruce-assign code for devices under hot-added hostbridge
>>>>
>>>>  The behavior when you don't try hostbridge hotplug should not change.
>>>>
>>>>  *[PATCH 1/4] acpi, pci: introduce list for acpi_pci_root drivers
>>>>  *[PATCH 2/4] acpi, pci: introduce acpi_root_sem for list manipulation
>>>>  *[PATCH 3/4] acpi, pci: add hostbridge removal function
>>>>  *[PATCH 4/4] acpi, pci: add resoruce-assign code for devices under
>>>>      hot-added hostbridge
>>>
>>> Hi, did you check our pci root bus hot plug branch ?
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>>> for-pci-root-bus-hotplug
>>>
>>> It contain some similar patches from jiang and me.
>>
>>   Hi Yinghai,
>>   Thank you for your comment.
>>
>>   I checked your branch out. It seems to include many work.
>>   Is it already scheduled to be merged to Bjorn's tree?
>>   If not, should I develop based on your tree?
> Hi Taku,
> I think the target is to merge those changes into Bjorn gate in near future,
> so it would be better to base on Yinghai's gate.

As you can probably tell, I'm falling behind in getting things merged.
 If you can agree among yourselves on which series is preferable *and*
spend some time reviewing each other's patches and adding
"Reviewed-by", that would help me out be resolving some of the issues.

Bjorn
