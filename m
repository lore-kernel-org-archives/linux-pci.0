Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35146 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbIUVWs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 17:22:48 -0400
MIME-Version: 1.0
In-Reply-To: <CAKsTQn=aigrfTz5hYmzvERK3w6Ax1yxEyZfzWt_NaT6d+-DYuA@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
	<CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
	<CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
	<CAKsTQn=skDo7mbTrvFfQHW+nD1Ggy-g+qT922WOrjiwqyK5BwQ@mail.gmail.com>
	<CAKsTQn=aigrfTz5hYmzvERK3w6Ax1yxEyZfzWt_NaT6d+-DYuA@mail.gmail.com>
Date: Mon, 21 Sep 2015 14:22:48 -0700
Message-ID: <CAE9FiQWxBWaJh0CbbEfeBUJK+54NDrTW6r0v-6itXEyTkmzkhQ@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Yinghai Lu <yinghai@kernel.org>
To: Ruud <netwerkforens@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 21, 2015 at 7:06 AM, Ruud <netwerkforens@gmail.com> wrote:
> 2015-09-21 9:49 GMT+02:00 Ruud <netwerkforens@gmail.com>:

> Test result based upon
>
> http://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> 7e3fad2 (for-pci-v4.3-rc1)
>
> Unfortunately your script hangs the system, I modified it for my
> situation (only one root complex, 1 PCI switch will be affected).
>  It seems to aggressive on the BAR's..tried to troubleshoot but don't
> understand the details on
>
>       /sbin/setpci -s $NAME 0x20.l=0
>       /sbin/setpci -s $NAME 0x24.l=0
>       /sbin/setpci -s $NAME 0x28.l=0
>       /sbin/setpci -s $NAME 0x2c.l=0
>
> why you zero these (besides the bus numbers).

so the realloc will start from clean.

>
> I got the full system working by just zeroing the busnumbers on the
> switch at root complex level, remove the switch and rescan it.

Good.

> In this
> procedure I need to take care of the some physical aspects: I can not
> turn on the chassis when the PCIe switch is removed, some interrupt
> comes through and will result in a kernel panic.

?

>
> Thus the procedure that works is:
> 1) Chassis off
> 2) Boot linux
> 3) Chassis on
> 4) setpci busnrs to 0
> 5) remove switch
> 6) rescan

4, 5 is reversed?

>
> Cards recognised and functional, memory regions look ok, running out
> of iospace but not much can be done about that.
>
> Same procedure on 3.2.0 kernel (debian stock)  results in all cards
> being recognized (enum ok) but fails to assign BAR's (tries to fit
> them below 4G)

Could be resource allocation problem.

Thanks

Yinghai
