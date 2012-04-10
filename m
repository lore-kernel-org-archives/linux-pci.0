Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59721 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab2DJTQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 15:16:58 -0400
Received: by dake40 with SMTP id e40so148055dak.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 12:16:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F848357.3060007@snewbury.org.uk>
References: <1333968563.5678.19.camel@infinity>
	<CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	<4F84110E.3000400@snewbury.org.uk>
	<CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	<4F8467AA.90305@snewbury.org.uk>
	<CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	<4F848357.3060007@snewbury.org.uk>
Date: Tue, 10 Apr 2012 12:16:58 -0700
Message-ID: <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2012 at 12:00 PM, Steven Newbury <steve@snewbury.org.uk> wrote:

> Seems to be exactly the same.  When started docked (so I think both
> 'cards' try to claim the same preferred addresses) the integrated i965
> GFX gets reassigned high:
> 120000000-12fffffff : 0000:00:02.0
>
> But it's quite possible the i915 module doesn't currently handle this
> case and so fails to initialise.
>
> I'm not sure why the Radeon doesn't get assigned a high address when
> hot-plugged..?

bus layout with randon:
00:1e.0
          03:01.0
          03:01.4
          03:08.0
                    05:00.0

the bridge 03:08.0 from PLX does not support 64bit pref mem
So even 05.00.0 Radeon support that 64 pref mem, have to allocate
32bit mem range to it.

the suitable range for that is 0xe0000000-0xefffffff.
that is not bigger enough, because need to preallocate 64M optional
for 03:01.0 the cardbus.
but that is optional.

We should get 05:00.0 get assigned to 0xe00000000
and 03:01.0 without assignment.


>
> These are the only entries in /proc/iomem above 4GB:
>
>
> Booted UNDOCKED, then hot-docked
>
> 100000000-11fffffff : System RAM
> 120000000-1201fffff : PCI Bus 0000:0b
> 120200000-1203fffff : PCI Bus 0000:0c
> 120400000-1205fffff : PCI Bus 0000:09
>
>
> Booted DOCKED
>
> 100000000-11fffffff : System RAM
> 120000000-12fffffff : 0000:00:02.0
> 130000000-1301fffff : PCI Bus 0000:0b
> 130200000-1303fffff : PCI Bus 0000:0c
> 130400000-1305fffff : PCI Bus 0000:0d
> 130600000-1307fffff : PCI Bus 0000:09

whole dmesg wht pci debug enabled please.

Thanks

Yinghai
