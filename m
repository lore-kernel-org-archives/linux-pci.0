Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61242 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab2I1Fsc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2012 01:48:32 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVRtpYeCJTbDjsUq81qxcHTBr8GcR-AoaKC1SkTh1kY=A@mail.gmail.com>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
	<1348561590-28067-11-git-send-email-yinghai@kernel.org>
	<CAOLK0pzmP6bZqPJTi6h2XqbX72gb79VKMYObegP1X3xmEX3TJA@mail.gmail.com>
	<CAE9FiQVQOw0Dt5Vkz4+8DpoXY0a_xKW7Etk-uCzvJpiMhsL=PQ@mail.gmail.com>
	<CAE9FiQVRtpYeCJTbDjsUq81qxcHTBr8GcR-AoaKC1SkTh1kY=A@mail.gmail.com>
Date: Fri, 28 Sep 2012 13:48:31 +0800
Message-ID: <CAOLK0pyiuTuZG47p3USS3fVq1z9T5YJXCcgJ9q_Z=qc4jdh5LQ@mail.gmail.com>
Subject: Re: [PATCH 10/29] PCI, USB: remove find_bridge in acpi_bus_type
From: Lan Tianyu <lantianyu1986@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2012/9/28 Yinghai Lu <yinghai@kernel.org>:
> On Tue, Sep 25, 2012 at 9:57 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Tue, Sep 25, 2012 at 1:35 AM, Lan Tianyu <lantianyu1986@gmail.com> wrote:
>>> 2012/9/25 Yinghai Lu <yinghai@kernel.org>:
>>>> The struct member is not used anymore, remove it.
>>>>
>>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-usb@vger.kernel.org
>>>> ---
>>>>  drivers/usb/core/usb-acpi.c |    1 -
>>>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
>>>> index 8947b20..a6ea613 100644
>>>> --- a/drivers/usb/core/usb-acpi.c
>>>> +++ b/drivers/usb/core/usb-acpi.c
>>>> @@ -102,7 +102,6 @@ static int usb_acpi_find_device(struct device *dev, acpi_handle *handle)
>>>>
>>>>  static struct acpi_bus_type usb_acpi_bus = {
>>>>         .bus = &usb_bus_type,
>>>> -       .find_bridge = NULL,
>>>>         .find_device = usb_acpi_find_device,
>>>>  };
>>>>
>>> HI Yinghai:
>>>                  This member has been populated in the usb-next tree.
>>>
>>> http://git.kernel.org/?p=linux/kernel/git/gregkh/usb.git;a=commit;h=d557542421da643358201664903e67fd01dfca1a
>>
>> Thanks for pointing that out.
>>
>> Looks that following change is not needed in that commit.
>>
>> @@ -102,7 +139,7 @@ static int usb_acpi_find_device(struct device
>> *dev, acpi_handle *handle)
>>
>>  static struct acpi_bus_type usb_acpi_bus = {
>>         .bus = &usb_bus_type,
>> -       .find_bridge = NULL,
>> +       .find_bridge = usb_acpi_find_device,
>>         .find_device = usb_acpi_find_device,
>>  };
>>
>
> after looking your code closely, that find_bridge is still needed.
> that usb_port does not have usb_bus_type.
hi Yinghai:
                   Sorry for late reply. You are right.
>
> but mixing find bridge and find device cause confusing.
>
> Please check attached patch that will separate find_bridge out.
Ok. Find one indention error.

-		return 0;
-	} else if (is_usb_port(dev)) {
-		sscanf(dev_name(dev), "port%d", &port_num);
-		/* Get the struct usb_device point of port's hub */
-		udev = to_usb_device(dev->parent->parent);
+	}
+		usb_acpi_check_port_connect_type(udev, *handle, port_num); <== one more tab.
+
+	return 0;
+}
+
>
> -Yinghai



--
Best regards
Tianyu Lan
