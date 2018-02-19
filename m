Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37565 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932067AbeBSVKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Feb 2018 16:10:44 -0500
Received: by mail-yb0-f195.google.com with SMTP id g26-v6so3270864ybj.4
        for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2018 13:10:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87eflghf60.fsf@devnulllabs.io>
References: <20180212230457.23181-1-kballou@devnulllabs.io> <87eflghf60.fsf@devnulllabs.io>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 19 Feb 2018 15:10:23 -0600
Message-ID: <CAErSpo6otjOp99+jH0dNF+V-TFj2rQRd1MOwvYz5GKxzhJW-1w@mail.gmail.com>
Subject: Re: [PATCH] pci: use kstrtobool over ad hoc string parsing
To: Kenny Ballou <kballou@devnulllabs.io>
Cc: linux-pci@vger.kernel.org, googlegot@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 2:56 PM, Kenny Ballou <kballou@devnulllabs.io> wrot=
e:
>
> On 2018=E5=B9=B402=E6=9C=8812=E6=97=A5 23:04 GMT, Kenny Ballou wrote:
>> Convert ROM read access enable/disable string parsing to use the
>> `kstrtobool` function.
>>
>> This fixes Bugzilla Bug 111301 -- Sysfs PCI rom file functionality does
>> not match documentation.
>>
>> bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D111301
>>
>> Reported-by: googlegot@yahoo.com
>> Signed-off-by: Kenny Ballou <kballou@devnulllabs.io>
>> ---
>>  drivers/pci/pci-sysfs.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index eb6bee8724cc..3cde1f25e786 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1424,10 +1424,12 @@ static ssize_t pci_write_rom(struct file *filp, =
struct kobject *kobj,
>>  {
>>       struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
>>
>> -     if ((off =3D=3D  0) && (*buf =3D=3D '0') && (count =3D=3D 2))
>> -             pdev->rom_attr_enabled =3D 0;
>> -     else
>> +     bool res =3D false;
>> +
>> +     if (kstrtobool(buf, &res) =3D=3D 0 && res)
>>               pdev->rom_attr_enabled =3D 1;
>> +     else
>> +             pdev->rom_attr_enabled =3D 0;
>>
>>       return count;
>>  }
>
> Bjorn,
>
> How does one know if a patch was accepted?  Should I be monitoring
> patchwork?  What's the status of the quoted patch?  Patchwork doesn't
> seem to show any changes for this patch.

When I apply or review a patch, I always respond to the original email
posting of it.  So you don't need to do anything more; I just haven't
gotten to this one.  I don't see any real issues with this, although
I'll probably expand the changelog to contain a little more detail
about exactly what the problem is and how this fixes it.  The bugzilla
link is great but the changelog itself should have enough information
to justify the change.

Bjorn
