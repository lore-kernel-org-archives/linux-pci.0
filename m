Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
References: <20150724224258.GA23990@google.com> <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
From: Duc Dang <dhdang@apm.com>
Date: Tue, 28 Jul 2015 10:45:26 -0700
Message-ID: <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in pci_generic_config_read32
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 9:43 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jul 24, 2015 at 7:05 PM, Duc Dang <dhdang@apm.com> wrote:
>> Hi Bjorn,
>>
>> On Fri, Jul 24, 2015 at 3:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> I regularly see faults like this on an APM X-Gene:
>>>
>>>   U-Boot 2013.04-mustang_sw_1.14.14 (Dec 16 2014 - 15:59:33)
>>>   CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
>>>        32 KB ICACHE, 32 KB DCACHE
>>>        SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
>>>   ...
>>>   Unhandled fault: synchronous external abort (0x96000010) at 0xffffff8000110034
>>>   Internal error: : 96000010 [#1] SMP
>>>   Modules linked in:
>>>   CPU: 0 PID: 3723 Comm: ... 4.1.0-smp-DEV #3
>>>   Hardware name: APM X-Gene Mustang board (DT)
>>>   task: ffffffc7dc1a4140 ti: ffffffc7dc118000 task.ti: ffffffc7dc118000
>>>   PC is at pci_generic_config_read32+0x4c/0xb8
>>>   LR is at pci_generic_config_read32+0x40/0xb8
>>>   pc : [<ffffffc00033b90c>] lr : [<ffffffc00033b900>] pstate: 600001c5
>>>   ...
>>>   Call trace:
>>>   [<ffffffc00033b90c>] pci_generic_config_read32+0x4c/0xb8
>>>   [<ffffffc00033bf58>] pci_user_read_config_byte+0x60/0xc4
>>>   [<ffffffc0003496a8>] pci_read_config+0x15c/0x238
>>>   [<ffffffc0002393b4>] sysfs_kf_bin_read+0x68/0xa0
>>>   [<ffffffc00023896c>] kernfs_fop_read+0x9c/0x1ac
>>>   [<ffffffc0001c361c>] __vfs_read+0x44/0x128
>>>   [<ffffffc0001c3e28>] vfs_read+0x84/0x144
>>>   [<ffffffc0001c4764>] SyS_read+0x50/0xb0
>>
>> The log shows kernel gets an exception when trying to access Mellanox
>> card configuration space. This is usually due to suboptimal PCIe
>> SerDes parameters are using in your board, which will cause bad link
>> quality.
>> The PCIe SerDes programming is done in U-Boot, so I suggest you do a
>> U-Boot upgrade to our latest X-Gene U-Boot release.
>
> I installed U-Boot 1.15.12, which I thought was the latest.  I'm still
> seeing this issue regularly, approx once/hour.

Our latest U-Boot is 1.15.15, but U-Boot 1.15.12 is already a good
version to use. Are you running any PCIe traffic test when the error
happens? I will try to reproduce the issue with my Mustang board as
well.

And it will be useful if you can share your "lspci -vvv" output when
the board is running, we can check to see if there is any error status
reported.

-- 
Regards,
Duc Dang.
