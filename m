Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33112 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbISVf4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Sep 2015 17:35:56 -0400
MIME-Version: 1.0
In-Reply-To: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
Date: Sat, 19 Sep 2015 14:35:55 -0700
Message-ID: <CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Yinghai Lu <yinghai@kernel.org>
To: Ruud <netwerkforens@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 19, 2015 at 1:20 AM, Ruud <netwerkforens@gmail.com> wrote:
> Hello all,
>
> Not a patch, not a complaint: a start of a discussion on PCIe bus
> renumbering and bus numbering in general..
>
>
> The current algorithm seems to allocate 8 extra busnumbers at the
> hotplug switch, but clearly 8 is not sufficient for the whole tree
> when it is discovered after initial numbering has been assigned. As
> the PCIe routing requires the bus numbers to be consecutive as it
> describes ranges there are not that many allocation strategies for bus
> numbers. It is impossible to predict at boot-time which switch will
> require lots of busses and which do not.

Well, if you need more than 8 bus number then practical way is
booting with pcie switch and late only hot-remove and host-add
instead of code hot-add.

>
> A solution is static assignment (e.g. as described by
> http://article.gmane.org/gmane.linux.kernel.pci/45212), but it seems
> not convenient to me.

Interesting, one patch in that thread looks like try to use bus range blindly.
so it is no go.

>
> I got the impression the most elegant way is to renumber, but at the
> same time I doubt. Would the BIOS become confused? Currently the
> kernel becomes confused as it renumbers the ethernet interfaces when
> the bus-numbers change. Several drivers seem to be locked to the
> device by its geographical routing (aka bus << 16 | device << 11 |
> function << 8 ). I got the impression that this is the root of the
> evil as the bus need not be as constant as expected.

Do you mean changing bus number without unloading driver ?

No, you can not do that.

some device firmware like lsi cards, if you change it's primary bus number,
the device will stop working, but that is another problem.

For cold hot add several pcie switches, right way would be have a script:
1. remove related children devices.
2. use setpci to clear bus number register
3. remove bridge devices
4. do pci rescan.

Yinghai
