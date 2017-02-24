Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33027 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXSja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2017 13:39:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170224171743.GA4964@otc-nc-03>
References: <20170224065435.14954-1-yinghai@kernel.org> <20170224171743.GA4964@otc-nc-03>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 24 Feb 2017 10:39:28 -0800
Message-ID: <CAE9FiQVE=OmKMJR0getueC7QYWP2=JAUQo4MfdCUB=zmFLdFTA@mail.gmail.com>
Subject: Re: [PATCH] PCI, pciehp: Reuse set_slot_off()
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2017 at 9:17 AM, Raj, Ashok <ashok.raj@intel.com> wrote:
> On Thu, Feb 23, 2017 at 10:54:35PM -0800, Yinghai Lu wrote:
>> +++ linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -71,9 +71,6 @@ static void set_slot_off(struct controll
>>                */
>>               msleep(1000);
>>       }
>> -
>> -     pciehp_green_led_off(pslot);
>> -     pciehp_set_attention_status(pslot, 1);
>
> Re using set_slot_off() in remove_board() make sense.. but i'm not sure
> why these are pulled out? It seems to be functionally complete
> when these are done in set_slot_off().

Just don't want to the led operation is wrapped too deep inside.

In board_added(), has led operation code directly for success path.

so put led operation code directly for error path make them more symmetrically.

>
>>  }
>>
>>  /**
>> @@ -126,6 +123,8 @@ static int board_added(struct slot *p_sl
>>
>>  err_exit:
>>       set_slot_off(ctrl, p_slot);
>> +     pciehp_green_led_off(p_slot);
>> +     pciehp_set_attention_status(p_slot, 1);
>>       return retval;
>>  }
>>
>> @@ -142,16 +141,7 @@ static int remove_board(struct slot *p_s
>>       if (retval)
>>               return retval;
>>
>> -     if (POWER_CTRL(ctrl)) {
>> -             pciehp_power_off_slot(p_slot);
>> -
>> -             /*
>> -              * After turning power off, we must wait for at least 1 second
>> -              * before taking any action that relies on power having been
>> -              * removed from the slot/adapter.
>> -              */
>> -             msleep(1000);
>> -     }
>> +     set_slot_off(ctrl, p_slot);
>>
>>       /* turn off Green LED */
>>       pciehp_green_led_off(p_slot);
> Don't we need the pciehp_set_attention_status() here?

that attention led could be on if previous power on is not done successfully

Thanks

Yinghai.
