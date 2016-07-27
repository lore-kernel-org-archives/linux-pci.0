Return-Path: <andreas.noever@gmail.com>
Return-Path: <andreas.noever@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ed33043d-fe00-9478-80fa-bdca311a52f1@gmail.com>
References: <20160726164038.1481-1-andreas.noever@gmail.com>
 <20160726164038.1481-2-andreas.noever@gmail.com> <ed33043d-fe00-9478-80fa-bdca311a52f1@gmail.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Thu, 28 Jul 2016 00:08:42 +0200
Message-ID: <CAMxnaaULYgu00dNzbu3LLNkdnAFz0bkke3vVt19yfHT=Y0_dkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C controller.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Xavier Gnata <xavier.gnata@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Andreas Noever <andreas.noever@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 10:11 AM, Xavier Gnata <xavier.gnata@gmail.com> wrote:
>
>
> On 26/07/2016 18:40, Andreas Noever wrote:
>>
>> From: Xavier Gnata <xavier.gnata@gmail.com>
>>
>> From: Xavier Gnata <xavier.gnata@gmail.com>
>>
>> Add support to INTEL_FALCON_RIDGE_2C controller and corresponding quirk
>> to support suspend/resume.
>> Tested against 4.7 master on a MacBook Air 11" 2015.
>>
>> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
>> ---
>>  drivers/pci/quirks.c      | 4 ++++
>>  drivers/thunderbolt/nhi.c | 6 ++++++
>>  2 files changed, 10 insertions(+)
>>
>> Rebased version of Xavier's patch.
>>
>> Xavier, could you verify that this still works on your system?
>>
> It does work on my system.
>
> Thanks,
> Xavier

Cool.

Greg, can we still get these into the current merge window?

Andreas

>
>> Thanks,
>> Andreas
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 75b2105..981f17d 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3325,6 +3325,7 @@ static void quirk_apple_wait_for_thunderbolt(struct
>> pci_dev *dev)
>>         if (nhi->vendor != PCI_VENDOR_ID_INTEL
>>                     || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
>>                         nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
>> &&
>> +                       nhi->device !=
>> PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI &&
>>                         nhi->device !=
>> PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
>>                     || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
>>                 goto out;
>> @@ -3341,6 +3342,9 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
>>                                PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>                                quirk_apple_wait_for_thunderbolt);
>>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
>> +                              PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
>> +                              quirk_apple_wait_for_thunderbolt);
>> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
>>                                PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
>>                                quirk_apple_wait_for_thunderbolt);
>>  #endif
>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>> index 9c15344..a8c2041 100644
>> --- a/drivers/thunderbolt/nhi.c
>> +++ b/drivers/thunderbolt/nhi.c
>> @@ -651,6 +651,12 @@ static struct pci_device_id nhi_ids[] = {
>>         {
>>                 .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
>>                 .vendor = PCI_VENDOR_ID_INTEL,
>> +               .device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI,
>> +               .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
>> +       },
>> +       {
>> +               .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
>> +               .vendor = PCI_VENDOR_ID_INTEL,
>>                 .device = PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI,
>>                 .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,
>>         },
>>
>
