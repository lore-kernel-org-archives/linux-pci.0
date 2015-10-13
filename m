Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510131020140.9747@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
	<CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
	<alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
	<CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
	<alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
	<CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
	<alpine.LRH.2.20.1510131020140.9747@math.ut.ee>
Date: Tue, 13 Oct 2015 12:30:09 -0700
Message-ID: <CAE9FiQV3OuPn=Z2LKHgndeeUQUwjM+9O4f8AAAgZ3QGvxJydOA@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 13, 2015 at 12:32 AM, Meelis Roos <mroos@linux.ee> wrote:

> Applied the fix_mem_mem64_overlapping.patch and retested. The BAR
> allocation problems are still there:
>
> http://kodu.ut.ee/~mroos/dm/dm.v210+patch+mem64patch+debug

Good, now MEM64 is gone.

[   34.145275] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   34.145304] /pci@1f,700000: PCI IO [io
0x7f601000000-0x7f601ffffff] offset 7f601000000
[   34.145330] /pci@1f,700000: PCI MEM [mem
0x7f700000000-0x7f7ffffffff] offset 7f700000000
[   34.146938] PCI: Scanning PBM /pci@1f,700000
[   34.147104] schizo f0069c00: PCI host bridge to bus 0000:00
[   34.147132] pci_bus 0000:00: root bus resource [io
0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
[   34.147162] pci_bus 0000:00: root bus resource [mem
0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
