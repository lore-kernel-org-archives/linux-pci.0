Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46603 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932701AbcKYQh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Nov 2016 11:37:27 -0500
Date: Fri, 25 Nov 2016 17:37:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?Q?Rog=C3=A9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, clemens@ladisch.de,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: Multiple problems with the Linux kernel on an AMD desktop
Message-ID: <20161125163721.y2hlhcxtlqfnpije@pd.tnic>
References: <20161124233957.k2twr352kna6ukd2@ime.usp.br>
 <20161125070159.ner7xvizvo2upb6h@pd.tnic>
 <20161125160548.b4wxokxffhk5zt6r@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161125160548.b4wxokxffhk5zt6r@ime.usp.br>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 25, 2016 at 02:05:48PM -0200, Rogério Brito wrote:
> In fact, I have quite a few computers that are not running Linux that well
> at this moment and I guess that lack of report from final users (or,
> perhaps, reports being lost in the way) prevents those problems from getting
> fixed.

CC me on those, I'd take a look.

> Ihope that my efforts will help other users to have fewer problems with
> Linux on older machines, at least.

> To speed things up a bit, I grabbed Ubuntu's precompiled 4.8 and 4.9-rc6
> (without any patches on top of Linus's tree) and booted on this machine.
> 
> The scanner problem is still there with vanilla 4.8 (with the irqpoll
> option), but is gone with vanilla 4.9-rc6 (with the irqpoll option).

Does -rc6 work *without* irqpoll?

Also, you can diff dmesg from both kernels and see whether you can spot
something relevant.

> I guess that backports of fixes to this (once detected) are needed for
> -stable kernels that distributions are shipping with?

Yes, once we know what fixes the issues.

> The other problems ("nobody cared" and the flood of evbug/lost xx rtc
> interrupts messages) remain with 4.9-rc6.
> 
> Interestingly, for a layman like me:
> 
> * if I remove the irqpoll option, the "hpet1: lost xx rtc interrupts" messages

Aha, so irqpoll is crap. Just remove it.

>   are gone, but I still get messages like
> 
>     [  130.007219] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
>     [  130.167191] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458767
>     [  130.167195] evbug: Event. Dev: input6, Type: 1, Code: 38, Value: 1
>     [  130.167197] evbug: Event. Dev: input6, Type: 0, Code: 0, Value: 0
>     [  130.247174] evbug: Event. Dev: input6, Type: 4, Code: 4, Value: 458767
> 
> * if I keep the irqpoll option, I get both "hpet1: lost xx rtc interrupts"
>   AND the evbug messages remain.

Just blacklist that module, it is for debugging input events.

> I'm attaching the dmesg of 4.9-rc6 both with and without irqpoll to this
> message.

Thanks.

[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 0500 05/11/2010

Has your BIOS *ever* been updated? If not, why not?

Yap, that BIOS is "fun":

[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM

Do you have an IOMMU option in your BIOS?

[   30.434052] usblp 5-2:1.1: usblp1: USB Bidirectional printer dev 2 if 1 alt 0 proto 2 vid 0x03F0 pid 0x4811
[   34.157510] irq 18: nobody cared (try booting with the "irqpoll" option)
[   34.157516] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.9.0-040900rc6-generic #201611201731
[   34.157518] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 0500 05/11/2010
[   34.157520]  ffff8a4cdfd83eb8 ffffffff8f217542 ffff8a4cd6fbb200 ffff8a4cd6fbb2b4
[   34.157524]  ffff8a4cdfd83ee8 ffffffff8eee5005 ffff8a4cd6fbb200 0000000000000000
[   34.157527]  ffffffff8fd5d560 0000000000000022 ffff8a4cdfd83f20 ffffffff8eee5393
[   34.157529] Call Trace:
[   34.157531]  <IRQ> 
[   34.157537]  [<ffffffff8f217542>] dump_stack+0x63/0x81
[   34.157540]  [<ffffffff8eee5005>] __report_bad_irq+0x35/0xc0
[   34.157542]  [<ffffffff8eee5393>] note_interrupt+0x243/0x290
[   34.157544]  [<ffffffff8eee24c4>] handle_irq_event_percpu+0x54/0x80
[   34.157546]  [<ffffffff8eee252e>] handle_irq_event+0x3e/0x60
[   34.157548]  [<ffffffff8eee5a8f>] handle_fasteoi_irq+0x9f/0x150
[   34.157551]  [<ffffffff8ee3030a>] handle_irq+0x1a/0x30
[   34.157554]  [<ffffffff8f68ec5b>] do_IRQ+0x4b/0xd0
[   34.157556]  [<ffffffff8f68cd42>] common_interrupt+0x82/0x82
[   34.157557]  <EOI> 
[   34.157560]  [<ffffffff8f68bc06>] ? native_safe_halt+0x6/0x10
[   34.157562]  [<ffffffff8f68b940>] default_idle+0x20/0xd0
[   34.157565]  [<ffffffff8ee3830f>] arch_cpu_idle+0xf/0x20
[   34.157568]  [<ffffffff8f68bd53>] default_idle_call+0x23/0x30
[   34.157570]  [<ffffffff8eec96b0>] cpu_startup_entry+0x1d0/0x240
[   34.157573]  [<ffffffff8ee51a81>] start_secondary+0x151/0x190
[   34.157575] handlers:
[   34.157577] [<ffffffff8f45ca30>] usb_hcd_irq
[   34.157578] [<ffffffff8f45ca30>] usb_hcd_irq
[   34.157580] [<ffffffff8f45ca30>] usb_hcd_irq
[   34.157581] Disabling IRQ #18

Looks to me like that USB host controller driver doesn't want to handle
its interrupt.

Lemme add USB people as I have no clue here why...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
