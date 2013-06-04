Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:57920 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3FDWAz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 18:00:55 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so1356044obb.8
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2013 15:00:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW=WM5v+VExCS0Od6gow7j4tTEOunECwqHP_hZduOETJw@mail.gmail.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
 <1369974092-11450-2-git-send-email-jiang.liu@huawei.com> <CAErSpo70u7oM07jcGA+E1MUHA4OWiJ1gQ8SuS7YCRuvGMxeaqA@mail.gmail.com>
 <CAErSpo5YbhPtB9OtjkUrMo8OKkjFXzOxeR3Jc4dQU8eC9D45XQ@mail.gmail.com> <CAE9FiQW=WM5v+VExCS0Od6gow7j4tTEOunECwqHP_hZduOETJw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Jun 2013 16:00:35 -0600
Message-ID: <CAErSpo6GBw4C3mXRrd_f=6GFnEwhH7tHcAkp+ib=HMwVPpc0=w@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 4, 2013 at 3:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jun 4, 2013 at 2:48 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, May 31, 2013 at 3:40 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> [+cc Rafael]
>>>
>>> On Thu, May 30, 2013 at 10:21 PM, Jiang Liu <liuj97@gmail.com> wrote:
>>>> From: Yinghai Lu <yinghai@kernel.org>
>>>>
>>>> When sriov is enabled, VF could just start after PF in pci tree.
>>>> like c1:00.0 will be PF, and c1:00.1 and after will be VF.
>>>>
>>>> acpi do have dev with same ADR. that will make them get glued
>>>> wrongly.
>>>>
>>>> Skip that if it is virtfn.
>>>>
>>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>>>> ---
>>>>  drivers/pci/pci-acpi.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>> index e4b1fb2..720f3a2 100644
>>>> --- a/drivers/pci/pci-acpi.c
>>>> +++ b/drivers/pci/pci-acpi.c
>>>> @@ -321,6 +321,10 @@ static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
>>>>         u64     addr;
>>>>
>>>>         pci_dev = to_pci_dev(dev);
>>>> +       /* don't mix vf with real pci device */
>>>> +       if (pci_dev->is_virtfn)
>>>> +               return -ENODEV;
>>>
>>> Rafael, can you review this?  I don't understand the implications of
>>> this change.
>>>
>>> And I don't know exactly what problem this would fix, so I don't know
>>> if it's stable material or not.  Yinghai did propose it as v3.10
>>> material in https://lkml.kernel.org/r/1368498506-25857-1-git-send-email-yinghai@kernel.org,
>>> but I don't know why.
>>
>> Ping?
>>
>> Jiang or Yinghai, what problem does this fix?
>
> fix the wrong binding between acpi dev and VFs.

Well, I read that in the changelog, but that doesn't tell me what bad
things happen as a result.  Can you elaborate a little bit?  Does it
mean PM doesn't work, hotplug doesn't work, drivers can't bind to the
VFs correctly, the magic smoke comes out of the PF, or what?

> Found that in my recent sriov test.
>
>>
>> I'm guessing maybe all three of these should be marked for stable, but
>> I'd like confirmation of that.
>
> Yes
>
> Yinghai
