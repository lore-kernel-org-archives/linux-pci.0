Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:41510 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389344AbeHAQDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2018 12:03:25 -0400
Subject: Re: Possible race condition in the kernel between PCI driver and AER
 handling
To: gokul cg <gokuljnpr@gmail.com>
Cc: linux-pci@vger.kernel.org
References: <CAFP4jM9xmXHVnBPObNxTtr1kDo2kbW9G4N5q=BLU5gf5=+M0xg@mail.gmail.com>
 <c5fb4a6a-136f-99f1-104e-32c923f00a22@oracle.com>
 <CAFP4jM84BuVZ+yKvcVvbu_6LFoO+2iVivWWZTZgbEEy3=oMftg@mail.gmail.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <9c3bd9bf-d170-2661-2f53-e8ede9d19927@oracle.com>
Date: Wed, 1 Aug 2018 10:17:23 -0400
MIME-Version: 1.0
In-Reply-To: <CAFP4jM84BuVZ+yKvcVvbu_6LFoO+2iVivWWZTZgbEEy3=oMftg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/01/2018 01:42 AM, gokul cg wrote:
> Hi Thomas,
> 
> In my hardware, there is i2c power control chip for PCI card, I just 
> powered down using i2c command .

Hi Gokul,
I see. That is why we normally didn't see this issue. Let me dig around 
to see if we have any machine that we can do similar thing.

Thomas

> 
> Regards,
> Gokul
> 
> On Tue, Jul 31, 2018 at 6:45 PM, Thomas Tai <thomas.tai@oracle.com 
> <mailto:thomas.tai@oracle.com>> wrote:
> 
> 
> 
>     On 07/31/2018 08:42 AM, gokul cg wrote:
> 
>         Hi All,
> 
> 
>         I am suspecting a possible race condition in the kernel between
>         PCI driver and AER handling.
> 
>         Because of the same kernel panic happens from worker thread
>         which handles bottom half of aer irq.
> 
> 
>         I am seeing this issue when I suddenly power off PCI card which
>         supports/enabled PCIE AER error reporting.
> 
>         While powering off PCI device, AER driver will get AER IRQ for
>         the device, from AER IRQ handler, it will cache AER error code
>         and schedule worker thread to handle error.
> 
> 
>     Hi Gokul,
> 
>     It may be an issue in the AER driver. How do you power off your
>     device? I've never seen this issue with normal shutdown nor "echo 0
>      > /sys/bus/pci/slots/xx/power"
> 
>     Cheers,
>     Thomas
> 
> 
> 
>         The PCIe device will get removed from PCI tree before worker
>         thread completes its task and kernel panic is  happening when
>         worker thread tries to access PCI device's config space.
> 
> 
> 
>         Issue:
> 
> 
>         crash>
> 
>         crash> bt
> 
>         PID: 2727   TASK: ffff880272adc530  CPU: 0   COMMAND: "kworker/0:2"
> 
>         #0 [ffff88027469fac8] machine_kexec at ffffffff8102cf18
> 
>         #1 [ffff88027469fb28] crash_kexec at ffffffff810a6b05
> 
>         #2 [ffff88027469fbf0] oops_end at ffffffff8176d960
> 
>         #3 [ffff88027469fc18] die at ffffffff810060db
> 
>         #4 [ffff88027469fc48] do_general_protection at ffffffff8176d452
> 
>         #5 [ffff88027469fc70] general_protection at ffffffff8176cdf2
> 
>               [exception RIP: pci_bus_read_config_dword+100]
> 
>               RIP: ffffffff813405f4  RSP: ffff88027469fd20  RFLAGS: 00010046
> 
>               RAX: 435f494350006963  RBX: ffff880274892000  RCX:
>         0000000000000004
> 
>               RDX: 0000000000000100  RSI: 0000000000000060  RDI:
>         ffff880274892000
> 
>               RBP: ffff88027469fd48   R8: ffff88027469fd2c   R9:
>         00000000000012c0
> 
>               R10: 0000000000000006  R11: 00000000000012bf  R12:
>         ffff88027469fd5c
> 
>               R13: 0000000000000246  R14: 0000000000000000  R15:
>         ffff8802741a4000
> 
>               ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
> 
>         #6 [ffff88027469fd50] pci_find_next_ext_capability at
>         ffffffff81345d7b
> 
>         #7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225
> 
>         #8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d
> 
>         #9 [ffff88027469fdd0] aer_isr at ffffffff81357a38
> 
>         #10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0
> 
>         #11 [ffff88027469fe70] worker_thread at ffffffff8105e251
> 
>         #12 [ffff88027469fed0] kthread at ffffffff81064260
> 
>         #13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38
> 
> 
>         crash>
> 
> 
>         I have tested it on kernel 3.10 . But from source i could see
>         that this case is still relevant for latest Linux source .
> 
> 
>         Can anybody tell me if this is an issue with AER driver in linux ?
> 
> 
> 
> 
>         Regards
> 
>         Gokul CG
> 
> 
