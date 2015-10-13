Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 13 Oct 2015 10:32:04 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
In-Reply-To: <CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1510131020140.9747@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee> <CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com> <alpine.LRH.2.20.1510120808240.3251@math.ut.ee> <CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
 <alpine.LRH.2.20.1510130800380.3972@math.ut.ee> <CAE9FiQVAtPGgzwwMaHjGjyzOD8wKb0TqCd1wynF6-ZmFqZzEaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Updated on V210 - the others were more recent. Now I get more BAR
> > warning there too:
> >
> > http://kodu.ut.ee/~mroos/dm/dm.v210+patches
> >
> 
> interesting, mem and mem64 is overlapping.
> 
> [   38.824625] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
> [   38.824654] /pci@1f,700000: PCI IO [io
> 0x7f601000000-0x7f601ffffff] offset 7f601000000
> [   38.824680] /pci@1f,700000: PCI MEM [mem
> 0x7f700000000-0x7f7ffffffff] offset 7f700000000
> [   38.824704] /pci@1f,700000: PCI MEM64 [mem
> 0x7f700000000-0x7f7ffffffff] offset 7f700000000
> [   38.826310] PCI: Scanning PBM /pci@1f,700000
> [   38.826479] schizo f0069c00: PCI host bridge to bus 0000:00
> [   38.826506] pci_bus 0000:00: root bus resource [io
> 0x7f601000000-0x7f601ffffff] (bus address [0x0000-0xffffff])
> [   38.826536] pci_bus 0000:00: root bus resource [mem
> 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
> [   38.826565] pci_bus 0000:00: root bus resource [mem
> 0x7f700000000-0x7f7ffffffff] (bus address [0x00000000-0xffffffff])
> 
> We need to add more sanitary checking.
> 
> Can you send boot log after booting with "debug ignore_loglevel ofpci_debug=1" ?

http://kodu.ut.ee/~mroos/dm/dm.v210+patch+debug

Applied the fix_mem_mem64_overlapping.patch and retested. The BAR 
allocation problems are still there:

http://kodu.ut.ee/~mroos/dm/dm.v210+patch+mem64patch+debug

-- 
Meelis Roos (mroos@linux.ee)
