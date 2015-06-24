Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36067 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbFXUqW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 16:46:22 -0400
Received: by wicnd19 with SMTP id nd19so146067718wic.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2015 13:46:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6JtrMS9wvF8KHfVank+iLzP9BqvE9xZo_he_3w-+zA3Q@mail.gmail.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150619224243.14626.59367.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CAErSpo6JtrMS9wvF8KHfVank+iLzP9BqvE9xZo_he_3w-+zA3Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Jun 2015 15:46:02 -0500
Message-ID: <CAErSpo5uq2Tq7=smQFabW8SjogO7S1-3vK9-1q0xxJ34j8qC7w@mail.gmail.com>
Subject: Re: [PATCH 4/6] PCI: Fix Intel generic reset quirk class code check
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>,
	Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 6:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [-cc Dexuan, Matthew (bounced)]
> [+cc Mathias, since MAINTAINERS mentions USB, Intel, and you in one entry :)]
>
> On Fri, Jun 19, 2015 at 5:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> We checked for "dev->class == PCI_CLASS_SERIAL_USB", but dev->class
>> contains the entire three-byte base class/sub-class/interface, while
>> PCI_CLASS_SERIAL_USB is only the two-byte base class/sub-class.
>>
>> This error meant that we used the Intel device-specific reset on devices
>> with class code 0x000c03 instead of those with class code 0x0c03xx.
>> 0x000c03 is a reserved value in the 0x00 backwards compatibility base class
>> and shouldn't match any devices, so I think reset_intel_generic_dev()
>> always failed.
>>
>> Shift dev->class to discard the interface byte before comparing with
>> PCI_CLASS_SERIAL_USB.
>>
>> Fixes: aeb30016fec3 ("PCI: add Intel USB specific reset method")
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Dexuan Cui <dexuan.cui@intel.com>
>> CC: Yu Zhao <yu.zhao@intel.com>
>> ---
>>  drivers/pci/quirks.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 8bc60c2..356a401 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3358,7 +3358,7 @@ static int reset_intel_generic_dev(struct pci_dev *dev, int probe)
>>         int pos;
>>
>>         /* only implement PCI_CLASS_SERIAL_USB at present */
>> -       if (dev->class == PCI_CLASS_SERIAL_USB) {
>> +       if ((dev->class >> 8) == PCI_CLASS_SERIAL_USB) {
>
> I'm a little bit concerned about this change because it *looks* like
> this has always been broken, but I assume it was tested and somebody
> would have noticed.

Unless we get confirmation that somebody cares about
reset_intel_generic_dev() and it has been tested, I'm inclined to
revert aeb30016fec3 ("PCI: add Intel USB specific reset method")
instead of applying this fix.

I think reset_intel_generic_dev() always returns -ENOTTY except for
devices with "class == 0x000c03", which is an invalid class code.  If
I "fix" it by putting in the shift, it will start poking at config
space on Intel USB devices.  I have no way of testing that, and I
haven't seen a problem report related to this, so a change is just as
likely to break something as to fix something.

So the safest thing looks like just dropping the quirk altogether,
which shouldn't change behavior at all.

>>                 pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
>>                 if (!pos)
>>                         return -ENOTTY;
>>
