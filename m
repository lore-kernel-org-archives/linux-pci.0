Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5548C45A.7040709@ti.com>
Date: Tue, 5 May 2015 18:53:38 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit ST <mohit.kumar.dhaka@gmail.com>
Subject: Re: [Query] PCIe power management with designware
References: <55479D35.3060603@ti.com> <CAHM4w1mXddxXbbJo8FR=PvzVJ66iJLDyHFvmHoLxABjfO21m3Q@mail.gmail.com>
In-Reply-To: <CAHM4w1mXddxXbbJo8FR=PvzVJ66iJLDyHFvmHoLxABjfO21m3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pratyush,

On Tuesday 05 May 2015 06:33 PM, Pratyush Anand wrote:

Thank you for responding.
> Hi Kishon,
>
> Correcting Mohit's ID
>
> On Mon, May 4, 2015 at 9:54 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi,
>>
>> I'm planning to add power management (suspend/resume) support for DRA7xx and have a query.
>>
>> The pci_pm_suspend_noirq callback being a bus pm_ops gets invoked late i.e after the suspend hooks of the pci devices (including the RC driver). The problem is after the 'suspend' of the RC driver, the clocks are disabled. Now
>
> I think, clocks should not be disabled at this point.
>
> pci_pm_suspend_noirq has a call to pci_save_state() which tries to access the
>> configuration space registers. Since the clocks are disabled by now, this results in an abort. Shouldn't we do save_state() earlier?
>
> So, RC driver should need to implement a pm->suspend_noirq() where it
> can handle all these.

okay.. let me try that.
>
>>
>> After working around the above problem, I face one more issue with broadcom BCM95721 A211 card. After resuming, I'm unable to access the memory space. I'm not sure if that is specific to that particular card, since I have no problems with USB cards.
>
> If you are able to access configuration space and  not able to access
> memory space then that seems strange.
> If cfg is also not accessible then can you check if link training with
> BCM95721 A211 card was successful?

I'm able to access the configuration space. The pci core writes D0 to the pmcsr 
register of the card and I get

"tg3 0000:01:00.0: Refused to change power state, currently in D3".

After that in the resume callback of the card, when it tries to access the 
ethernet registers it hangs.

Thanks
Kishon
