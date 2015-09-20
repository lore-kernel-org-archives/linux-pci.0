Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35593 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbbITRDq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 13:03:46 -0400
MIME-Version: 1.0
In-Reply-To: <CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
	<CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
Date: Sun, 20 Sep 2015 10:03:45 -0700
Message-ID: <CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Yinghai Lu <yinghai@kernel.org>
To: Ruud <netwerkforens@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 20, 2015 at 2:17 AM, Ruud <netwerkforens@gmail.com> wrote:
>
> The current procedure I follow is to boot with two PCIe switches in the host.
> (one at the root complex level, intel based, one level above PLX
> based, and the whole tree in the chassis).
>
> - I turn off the chassis (as it conflicts with the BIOS :( )
> - Reboot into linux.
> - remove the intel based switch (has no relevant childs) (echo 1
>>.../remove  sorry for the missing numbers its weekend)
> - turn on chassis
> - rescan starting at the root complex  (echo 1 > .../rescan )
>
> During the rescan, it will map in the original busnumber-range which
> is too small. I understand from your email that by clearing the
> busnumber range in the switch (perhaps both host switces), the kernel
> will pick a different range which is not clamped in by the other
> busnumbers of surrounding other switches?

Yes.

Only need to clear root port.

here the scripts that I used to test busn_alloc and other mmio
resource allocation.
The system could have 8 peer pci root buses.

#
# for x4-4, x4-8, x5-4, x5-8

BUSES='00 20 40 60 80 a0 c0 e0'
DEV_FUNCS='02.0 03.2'

echo "Remove all child devices at first"
for BUS in $BUSES; do
    for DEV_FUNC in $DEV_FUNCS; do
      NAME=0000:"$BUS":"$DEV_FUNC"
      LINE=`/sbin/lspci -nn -s $NAME | wc -l`
      if [ $LINE -eq 0 ]; then
        continue
      fi
      echo $NAME
      NA=`find /sys/devices/pci0000:"$BUS"/"$NAME"/*/remove -name "remove"`
      for N in $NA; do
        echo $N
        echo -n 1 > "$N"
        sleep 1s
      done
    done
done

sleep 5s

echo "Clear bridge mmio BARs and busn"
for BUS in $BUSES; do
    for DEV_FUNC in $DEV_FUNCS; do
      NAME=0000:"$BUS":"$DEV_FUNC"
      LINE=`/sbin/lspci -nn -s $NAME | wc -l`
      if [ $LINE -eq 0 ]; then
        continue
      fi
      echo $NAME
      /sbin/setpci -s $NAME 0x20.l=0
      /sbin/setpci -s $NAME 0x24.l=0
      /sbin/setpci -s $NAME 0x28.l=0
      /sbin/setpci -s $NAME 0x2c.l=0
      /sbin/setpci -s $NAME 0x18.w=0
      /sbin/setpci -s $NAME 0x1a.b=0
      N=`find /sys/devices/pci0000:"$BUS"/"$NAME"/remove -name "remove"`
      echo $N
      echo -n 1 > "$N"
      sleep 1s
    done
done


>
> I will test next monday.

Good. Please check current upstream and my tree for-pci-v4.3-rc1 branch.

>
> What I did get to work is the following procedure:
>> - I turn off the chassis (as it conflicts with the BIOS :(  )
> - Boot linux with parameter pci=assign-busses (BIOS will have
> configured the switches in the host without a serious busnumber range)
> - remove the intel based switch (has no relevant childs) (echo 1
>>.../remove  sorry for the missing numbers its weekend)
> - turn on chassis
> - rescan starting at the root complex  (echo 1 > .../rescan )
> During rescan the numbering is messed up, and dmesg fills up with
> ethernet renaming "errors", didn;t dare to look at other side-effects.

assign-busses may be too destructive.  May make some card firmware
not happy.

>
>>
>>>
>>
>> Do you mean changing bus number without unloading driver ?
>>
>> No, you can not do that.
>>
>> some device firmware like lsi cards, if you change it's primary bus number,
>> the device will stop working, but that is another problem.
>>
>
> Are these settings in the binary driver? I do not see that much need
> for a driver to use the geographical addressing after the BAR's have
> been set. I thus wondered if it is feasable to hide the geographical
> addressing from the driver and offer an API for it from the PCIe layer
> to the drivers...

Card firmware.  Assume those card firmware would trap pci conf read cycle
and compare something inside.
The only workaround that I found is reset the link to make firmware rebooting.
but that will have problem if you are use the disk as root etc.

Thanks

Yinghai
