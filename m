Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38621 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbFXXFn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 19:05:43 -0400
Received: by igin14 with SMTP id n14so44271503igi.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2015 16:05:42 -0700 (PDT)
Date: Wed, 24 Jun 2015 18:05:34 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Rajat Jain <rajatxjain@gmail.com>, PCI <linux-pci@vger.kernel.org>
Subject: Re: pciehp command complete timeout issue
Message-ID: <20150624230534.GQ7710@google.com>
References: <5582B43F.4090303@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5582B43F.4090303@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 08:06:23PM +0800, Yijing Wang wrote:
> When I tried to unbind pciehp driver on a pcie root port(bound pciehp driver),
> a lot timeout warning appeared.
> 
> The first timeout value is 102387672 msec :(
> I debug and found that when pciehp complete pcie_enable_notification(), there was no command complete interrupt
> be triggered, so cmd_busy always be set, and once another command post, a very long timeout warning noised.
> 
> 
>  +-[0000:40]-+-00.0-[41]--
>  |           +-01.0-[42-43]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>  |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>  |           +-03.0-[44-45]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>  |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
> 
> [root@hulk slots]# ls
> 0  0-1  0-2  0-3  0-4  0-5  1  10  11  12  13  14  15  16  2  3  4  5  6  7  8  9
> [root@hulk slots]# cat 6/address
> 0000:44:00
> [root@hulk slots]#
> 
> [root@hulk pciehp]# echo 0000:40:03.0:pcie04 > unbind
> [root@hulk pciehp]#
> 
> ...
> [102413.749632] pciehp 0000:40:03.0:pcie04: unloading service driver pciehp
> [102413.749638] pciehp_remove dev 0000:40:03.0, cmd_busy 1
> [102413.754929] pcie_disable_notification: ctrl cmd busy 1
> [102413.765903] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x11f1 (issued 102387672 msec ago)

The fact that you got this timeout message means the controller did
not set the "No Command Completed Support" bit, right?  If we had
NO_CMD_CMPL(ctrl), pcie_wait_cmd() becomes a no-op, and we would
never print any timeout message.

Since the "No Command Completed Support" bit is NOT set, we expect
to get an interrupt after every command completes.

This sounds like the Intel CF118 erratum mentioned just above that timeout
message:

         * Controllers with errata like Intel CF118 don't generate
         * completion notifications unless the power/indicator/interlock
         * control bits are changed.  On such controllers, we'll emit this
         * timeout message when we wait for completion of commands that
         * don't change those bits, e.g., commands that merely enable
         * interrupts.

So to me, this sounds like pciehp is working correctly.  What did you
expect to happen instead?

> [102413.775171] pcie_do_write_cmd: dev 0000:40:03.0, cmd_busy set to 1
> [102415.377950] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x01c0 (issued 1600 msec ago)
> ...
> 
> -- 
> Thanks!
> Yijing
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
