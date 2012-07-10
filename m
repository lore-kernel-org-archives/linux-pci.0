Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50514 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab2GJWU6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 18:20:58 -0400
Received: by lbbgm6 with SMTP id gm6so1200561lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 15:20:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>
 <CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
 <OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se> <CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Jul 2012 16:20:36 -0600
Message-ID: <CAErSpo7UmgG636R7Nz142g4WfFMw9Gi-kEWYfNmbbyWNfx55=A@mail.gmail.com>
Subject: Re: PICe hotplug problems
To: Yinghai Lu <yinghai@kernel.org>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 4:09 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jul 10, 2012 at 2:42 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
>> yhlu.kernel@gmail.com wrote on 2012/07/10 20:22:09:
>>
>>>
>>> On Tue, Jul 10, 2012 at 10:29 AM, Joakim Tjernlund
>>> <joakim.tjernlund@transmode.se> wrote:
>>> >
>>> > I got an PCIe device that is woken up by user space, clocks needs to configured in various ways before the
>>> > device enables its PCIe interface.
>>> >
>>> > The device is connected to a built in root bridge on a P2010(mpc85xx) CPU.
>>> > To enable HP in Linux we need to apply some minor hacks.
>>>
>>> can you post lspci -vvxxx -s BB:DD:F of the two devices?
>>
>> Not really, this is an embedded device with limited SW. I got
>> busybox and its lspci but that is very limited:
>> # > ./busybox lspci -mk
>> 00:00.0 "Class 0604" "1957" "0079" "0000" "0000" "pcieport"
>> 01:00.0 "Class 0200" "14e4" "b540" "14e4" "b540"
>>
>> Does that tell you anything?
>
> No. Can you compile lspci util as static and run it ?

You might also be able to get this info as console output by booting
with "pci=earlydump".
