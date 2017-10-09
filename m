Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:46738 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753968AbdJIH5N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Oct 2017 03:57:13 -0400
Subject: Re: [BUG] vt6655: A possible sleep-in-atomic bug in vt6655_suspend
To: Greg KH <gregkh@linuxfoundation.org>
Cc: forest@alittletooquiet.net, simon@nikanor.nu, tvboxspy@gmail.com,
        scott@matheina.com, dan.a.cashman@gmail.com,
        golubev.mikhail@gmail.com, bhelgaas@google.com,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <f3f4b129-471e-6ccd-a2fa-6ffd915bcb7f@163.com>
 <20171009054327.GA12559@kroah.com>
From: Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <b96d4517-8484-892b-43b8-107067c7f78c@163.com>
Date: Mon, 9 Oct 2017 15:56:49 +0800
MIME-Version: 1.0
In-Reply-To: <20171009054327.GA12559@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Okay, I will send a patch :)


Thanks,
Jia-Ju Bai

On 2017/10/9 13:43, Greg KH wrote:
> On Mon, Oct 09, 2017 at 09:10:28AM +0800, Jia-Ju Bai wrote:
>> According to device_main.c, the driver may sleep under a spinlock,
>> and the function call path is:
>> vt6655_suspend (acquire the spinlock)
>>    pci_set_power_state
>>      __pci_start_power_transition (drivers/pci/pci.c)
>>        msleep --> may sleep
>>
>> A possible fix is to replace msleep with mdelay in
>> __pci_start_power_transition in drivers/pci/pci.c.
> Patches are usually best to send in for things that you find like this.
>
> thanks,
>
> greg k-h
