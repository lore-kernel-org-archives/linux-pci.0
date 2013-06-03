Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:61972 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213Ab3FCTCW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2013 15:02:22 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so7930300obc.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Jun 2013 12:02:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51AC6A14.2040908@cogentembedded.com>
References: <1370255050-2358-1-git-send-email-shane.huang@amd.com> <51AC6A14.2040908@cogentembedded.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 3 Jun 2013 13:02:01 -0600
Message-ID: <CAErSpo5Jh_znOjr0CRBN=Kay+Y2ZJ2dDfVJdVW7MW9TjFzB6Yg@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/3] ahci: add AMD CZ SATA device ID
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Shane Huang <shane.huang@amd.com>, Tejun Heo <tj@kernel.org>,
	Jean Delvare <khali@linux-fr.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-ide@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 3, 2013 at 4:04 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 03-06-2013 14:24, Shane Huang wrote:
>
>> To add AMD CZ SATA controller device ID of IDE mode.
>
>
>> Signed-off-by: Shane Huang <shane.huang@amd.com>
>> Reviewed-by: Tejun Heo <tj@kernel.org>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/ata/ahci.c      | 1 +
>>   drivers/pci/quirks.c    | 2 ++
>>   include/linux/pci_ids.h | 1 +
>>   3 files changed, 4 insertions(+)
>
>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 751f1ea..548f1c3 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -310,6 +310,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>>
>>         /* AMD */
>>         { PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>> +       { PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
>>         /* AMD is using RAID class only for ahci controllers */
>>         { PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>           PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
>
> [...]
>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index e0b5623..22449c1 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -570,6 +570,7 @@
>>   #define PCI_DEVICE_ID_AMD_HUDSON2_IDE         0x780c
>>   #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE    0x7800
>>   #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS               0x780b
>> +#define PCI_DEVICE_ID_AMD_CZ_SATA_IDE  0x7900
>
>
>    We don't add the device IDs to this file anymore. And if you added it,
> why didn't you use it in ahci.c?

Sergei has a good point.  I first thought it was used in both ahci.c
and quirks.c, but since it's not, it seems easier to forget about the
pci_ids.h update.

I dropped the pci_ids.h updates from patches 2 and 3 and pushed the
result to http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/shane-amd-ahci-i2c

Let me know if anybody objects.  Otherwise, I'll merge it into my
-next branch tomorrow.

Bjorn
