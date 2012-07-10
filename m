Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61497 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab2GJWJC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 18:09:02 -0400
Received: by vbbff1 with SMTP id ff1so356872vbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 15:09:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>
	<CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
	<OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>
Date: Tue, 10 Jul 2012 15:09:00 -0700
Message-ID: <CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
Subject: Re: PICe hotplug problems
From: Yinghai Lu <yinghai@kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 2:42 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> yhlu.kernel@gmail.com wrote on 2012/07/10 20:22:09:
>
>>
>> On Tue, Jul 10, 2012 at 10:29 AM, Joakim Tjernlund
>> <joakim.tjernlund@transmode.se> wrote:
>> >
>> > I got an PCIe device that is woken up by user space, clocks needs to configured in various ways before the
>> > device enables its PCIe interface.
>> >
>> > The device is connected to a built in root bridge on a P2010(mpc85xx) CPU.
>> > To enable HP in Linux we need to apply some minor hacks.
>>
>> can you post lspci -vvxxx -s BB:DD:F of the two devices?
>
> Not really, this is an embedded device with limited SW. I got
> busybox and its lspci but that is very limited:
> # > ./busybox lspci -mk
> 00:00.0 "Class 0604" "1957" "0079" "0000" "0000" "pcieport"
> 01:00.0 "Class 0200" "14e4" "b540" "14e4" "b540"
>
> Does that tell you anything?

No. Can you compile lspci util as static and run it ?

Thanks

Yinghai
