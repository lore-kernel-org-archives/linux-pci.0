Return-Path: <andreas.noever@gmail.com>
Return-Path: <andreas.noever@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160502173026.GF24851@localhost>
References: <1460285307-3557-1-git-send-email-andreas.noever@gmail.com> <20160502173026.GF24851@localhost>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Tue, 3 May 2016 01:18:11 +0200
Message-ID: <CAMxnaaUQUrVYfMaZ0Z7-Cq3sGG5dom5Edz1kUwmXV-8yC6fHeg@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Fix double free of drom buffer
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 2, 2016 at 7:30 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Apr 10, 2016 at 12:48:27PM +0200, Andreas Noever wrote:
>> If tb_drom_read fails sw->drom is freed but not set to NULL. sw->drom
>> is then freed again in the error path of sw_switch_alloc.
>
> s/sw_switch_alloc/tb_switch_alloc/ ?
>
>> The bug can be triggered by unplugging a thunderbolt device shortly
>> after it is detected by the thunderbolt driver.
>>
>> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Cc: stable@vger.kernel.org
>
> How far back would this need to be applied?  What is the commit where
> the but was introduced?
>
> I applied this to pci/thunderbolt for v4.7 with the following
> changelog.  If I did it wrong, I'll gladly update it, especially if
> you have specific symptoms of a bug or oops that would help people
> find this fix.
>
>     thunderbolt: Fix double free of drom buffer
>
>     If tb_drom_read() fails, sw->drom is freed but not set to NULL.  sw->drom
>     is then freed again in the error path of tb_switch_alloc().
>
>     The bug can be triggered by unplugging a thunderbolt device shortly after
>     it is detected by the thunderbolt driver.
>
>     Clear sw->drom if tb_drom_read() fails.
The changelog is correct. The bug can be triggered starting from
343fcb8c ("thunderbolt: Fix nontrivial endpoint devices.") which is in
3.17-rc1. I observed crashes during subsequent hotplug operations (pci
core, sometimes in pciehp). But by nature of a double free bug these
were not very reliable (used kasan to track it down).

Thanks
Andreas


>     [bhelgaas: add Fixes:, stable versions of interest]
>     Fixes: 343fcb8c70d7 ("thunderbolt: Fix nontrivial endpoint devices.")
>     Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org  # v3.17+
>     CC: Lukas Wunner <lukas@wunner.de>
>
>> ---
>>  drivers/thunderbolt/eeprom.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
>> index 0dde34e..545c60c 100644
>> --- a/drivers/thunderbolt/eeprom.c
>> +++ b/drivers/thunderbolt/eeprom.c
>> @@ -444,6 +444,7 @@ int tb_drom_read(struct tb_switch *sw)
>>       return tb_drom_parse_entries(sw);
>>  err:
>>       kfree(sw->drom);
>> +     sw->drom = NULL;
>>       return -EIO;
>>
>>  }
>> --
>> 2.8.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
