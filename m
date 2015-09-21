Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKsTQn=skDo7mbTrvFfQHW+nD1Ggy-g+qT922WOrjiwqyK5BwQ@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
	<CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
	<CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
	<CAKsTQn=skDo7mbTrvFfQHW+nD1Ggy-g+qT922WOrjiwqyK5BwQ@mail.gmail.com>
Date: Mon, 21 Sep 2015 16:06:26 +0200
Message-ID: <CAKsTQn=aigrfTz5hYmzvERK3w6Ax1yxEyZfzWt_NaT6d+-DYuA@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Ruud <netwerkforens@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2015-09-21 9:49 GMT+02:00 Ruud <netwerkforens@gmail.com>:
>>       /sbin/setpci -s $NAME 0x1a.b=0
>>       N=`find /sys/devices/pci0000:"$BUS"/"$NAME"/remove -name "remove"`
>>       echo $N
>>       echo -n 1 > "$N"
>>       sleep 1s
>>     done
>> done
>>
>
> Thanks for the script!
>
>>
>>>
>>> I will test next monday.
>>


Test result based upon

http://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
7e3fad2 (for-pci-v4.3-rc1)

Unfortunately your script hangs the system, I modified it for my
situation (only one root complex, 1 PCI switch will be affected).
 It seems to aggressive on the BAR's..tried to troubleshoot but don't
understand the details on

      /sbin/setpci -s $NAME 0x20.l=0
      /sbin/setpci -s $NAME 0x24.l=0
      /sbin/setpci -s $NAME 0x28.l=0
      /sbin/setpci -s $NAME 0x2c.l=0

why you zero these (besides the bus numbers).

I got the full system working by just zeroing the busnumbers on the
switch at root complex level, remove the switch and rescan it. In this
procedure I need to take care of the some physical aspects: I can not
turn on the chassis when the PCIe switch is removed, some interrupt
comes through and will result in a kernel panic.

Thus the procedure that works is:
1) Chassis off
2) Boot linux
3) Chassis on
4) setpci busnrs to 0
5) remove switch
6) rescan

Cards recognised and functional, memory regions look ok, running out
of iospace but not much can be done about that.

Same procedure on 3.2.0 kernel (debian stock)  results in all cards
being recognized (enum ok) but fails to assign BAR's (tries to fit
them below 4G)


Best regards,

Ruud
