Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34745 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbcKJNOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 08:14:37 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so3100850wme.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2016 05:14:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161110071327.GA30661@kroah.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
 <20161109165607.26322-1-emil.l.velikov@gmail.com> <20161110071327.GA30661@kroah.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Thu, 10 Nov 2016 13:14:35 +0000
Message-ID: <CACvgo50m+nNhfUOmB_vw1ScMXDteG+fXU6D5G6D+suiH85Digw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: create revision file in sysfs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 November 2016 at 07:13, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 09, 2016 at 04:56:07PM +0000, Emil Velikov wrote:
>> From: Emil Velikov <emil.velikov@collabora.com>
>>
>> Currently the revision isn't available via sysfs/libudev thus if one
>> wants to know the value they need to read through the config file.
>>
>> This in itself wakes/powers up the device, causing unwanted delays.
>>
>> There are at least two userspace components which could make use the new
>> file - libpciaccess and libdrm. At the moment the former will wake up
>> _every_ PCI device for simple invocation of glxinfo [when using Mesa
>> 10.0+ drivers]. While the latter [in association with Mesa 13.0] can
>> lead to 2-3 second delays while starting firefox, thunderbird or
>> chromium.
>>
>> Expose the revision as a separate file, just like we do for the device,
>> vendor, their subsystem version and class.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
>> Tested-by: Mauro Santos <registo.mailling@gmail.com>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>> ---
>> v2:
>>  - Add r-b/t-b tags
>>  - Slim down CC list
>>  - Add note about userspace.
>>
>> As before, please keep me in the CC list. Additionally if there's
>> anything else I can do to get things going please let me know.
>>
>> Thanks
>> Emil
>> ---
>>  drivers/pci/pci-sysfs.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index bcd10c7..0666287 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -50,6 +50,7 @@ pci_config_attr(vendor, "0x%04x\n");
>>  pci_config_attr(device, "0x%04x\n");
>>  pci_config_attr(subsystem_vendor, "0x%04x\n");
>>  pci_config_attr(subsystem_device, "0x%04x\n");
>> +pci_config_attr(revision, "0x%02x\n");
>>  pci_config_attr(class, "0x%06x\n");
>>  pci_config_attr(irq, "%u\n");
>
> Shouldn't we get a Documentation/ABI/ update for this as well?
>
Definitely, we should.

I've updated Documentation/filesystems/sysfs-pci.txt [locally] yet
looking through ABI/ there is only a 'testing' one -
Documentation/ABI/testing/sysfs-bus-pci.

Feels a bit strange there is no stable one, guess I should/could start one ?

Thanks
Emil
