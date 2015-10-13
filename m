Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33597 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbJMTny (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 15:43:54 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510131020140.9747@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
	<CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
	<alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
	<CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
	<alpine.LRH.2.20.1510131020140.9747@math.ut.ee>
Date: Tue, 13 Oct 2015 12:43:53 -0700
Message-ID: <CAE9FiQWhE=-FtZjuC5-fTzuTq0tm9Zt1MiD8J0a_Q_jiB5RLNg@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 13, 2015 at 12:32 AM, Meelis Roos <mroos@linux.ee> wrote:
>>
>> Can you send boot log after booting with "debug ignore_loglevel ofpci_debug=1" ?
>
> http://kodu.ut.ee/~mroos/dm/dm.v210+patch+debug

Firmware does reported overlapped resources.

[   34.150035] PCI: scan_bus[/pci@1e,600000] bus no 0
[   34.150050]   * /pci@1e,600000/isa@7
[   34.150085]     create device, devfn: 38, type:
[   34.150114]     class: 0x60100 device name: 0001:00:07.0
[   34.150129]     parse addresses (60 bytes) @ fff000123fe92b40
[   34.150144]   start: 7fe01000000, end: 7fe0100ffff, i: 10 ==========
[   34.150159]   start: 7ff00000000, end: 7ff000fffff, i: 14
[   34.150174]   start: 7ff00000000, end: 7ff000fffff, i: 18
[   34.150188]     adding to system ...
[   34.150333] PCI: dev header type: 0
[   34.150348]   * /pci@1e,600000/pmu@6
[   34.150386]     create device, devfn: 30, type:
[   34.150409]     class: 0x0 device name: 0001:00:06.0
[   34.150424]     parse addresses (20 bytes) @ fff000123fe7d080
[   34.150439]   start: 7fe01000000, end: 7fe0100000f, i: 10 =============
[   34.150453]     adding to system ...
[   34.150582] PCI: dev header type: 0
[   34.150596]   * /pci@1e,600000/usb@a
[   34.150630]     create device, devfn: 50, type:
[   34.150655]     class: 0xc0310 device name: 0001:00:0a.0
[   34.150670]     parse addresses (20 bytes) @ fff000123fe7aec0
[   34.150686]   start: 7ff01000000, end: 7ff01ffffff, i: 10
[   34.150699]     adding to system ...
[   34.150727] pci 0001:00:0a.0: PME# supported from D3cold
[   34.150888] PCI: dev header type: 0
[   34.150902]   * /pci@1e,600000/ide@d
[   34.150932]     create device, devfn: 68, type: ide
[   34.150959]     class: 0x101ff device name: 0001:00:0d.0
[   34.150976]     parse addresses (100 bytes) @ fff000123fe79900
[   34.150991]   start: 7fe01000900, end: 7fe01000907, i: 10 =============
[   34.151006]   start: 7fe01000918, end: 7fe0100091f, i: 14 =============
[   34.151021]   start: 7fe01000910, end: 7fe01000917, i: 18 ==============
[   34.151035]   start: 7fe01000908, end: 7fe0100090f, i: 1c ============
[   34.151050]   start: 7fe01000920, end: 7fe0100092f, i: 20 =============


can you send out output for
lspci -vvxxx
lspci -tv

Thanks

Yinghai
