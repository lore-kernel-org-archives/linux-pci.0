Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:54930 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184AbbJMFEi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 01:04:38 -0400
Date: Tue, 13 Oct 2015 08:06:10 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
In-Reply-To: <CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1510130800380.3972@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee> <CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com> <alpine.LRH.2.20.1510120808240.3251@math.ut.ee> <CAE9FiQXHsgYaTgF2rsWFJXSYJ=kH3j63ageJ2H8F5wnzbFgxRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >> > sparc64 machines:
> >>
> >> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> >> for-pci-v4.4-next
> >>
> >> It should fix some "no compatible bridge window"
> >
> > Blade 100: still has 2 address conflicts:
> > http://kodu.ut.ee/~mroos/dm/dm.sb100+patch
> >
> > V240: still has a lot of address conflicts:
> > http://kodu.ut.ee/~mroos/dm/dm.v240+patch
> >
> > V210: fixes the line
> > pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> >
> > These lines are still present:
> >
> > pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
> > pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
> >
> you should not have those.
> 
> Looks like you are using old branch before 2015-10-05.
> 
> If you use the git directly, please update the branch to local again.

Updated on V210 - the others were more recent. Now I get more BAR 
warning there too:

http://kodu.ut.ee/~mroos/dm/dm.v210+patches

-- 
Meelis Roos (mroos@linux.ee)
