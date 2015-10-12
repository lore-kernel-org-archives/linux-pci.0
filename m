Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:36174 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbbJLNDP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 09:03:15 -0400
Date: Mon, 12 Oct 2015 16:04:47 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
In-Reply-To: <CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1510120808240.3251@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee> <CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > sparc64 machines:
> >
> > http://kodu.ut.ee/~mroos/dm/dm.t1-105
> > http://kodu.ut.ee/~mroos/dm/dm.t1-200
> > http://kodu.ut.ee/~mroos/dm/dm.v120
> > http://kodu.ut.ee/~mroos/dm/dm.v210
> > http://kodu.ut.ee/~mroos/dm/dm.v240
> > http://kodu.ut.ee/~mroos/dm/dm.sb100
> 
> Please try
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-v4.4-next
> 
> It should fix some "no compatible bridge window"

Blade 100: still has 2 address conflicts:
http://kodu.ut.ee/~mroos/dm/dm.sb100+patch

V240: still has a lot of address conflicts:
http://kodu.ut.ee/~mroos/dm/dm.v240+patch

V210: fixes the line
pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]

These lines are still present:

pci 0001:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
pci 0001:00:07.0: can't claim BAR 2 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]

V120: all messages gone, used to have
[   46.962673] pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
[   46.962794] pci 0000:02:08.0: can't claim BAR 1 [mem 0x1ff00002000-0x1ff00003fff]: no compatible bridge window
[   46.962856] pci 0000:02:08.0: can't claim BAR 3 [mem 0x1ff00004000-0x1ff00005fff]: no compatible bridge window
[   46.962917] pci 0000:02:08.1: can't claim BAR 1 [mem 0x1ff00006000-0x1ff00007fff]: no compatible bridge window
[   46.962976] pci 0000:02:08.1: can't claim BAR 3 [mem 0x1ff00008000-0x1ff00009fff]: no compatible bridge window

T1-200: all messages gone, used to have
[   41.606858] pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
[   41.606981] pci 0000:02:08.0: can't claim BAR 1 [mem 0x1ff00002000-0x1ff00003fff]: no compatible bridge window
[   41.607043] pci 0000:02:08.0: can't claim BAR 3 [mem 0x1ff00004000-0x1ff00005fff]: no compatible bridge window
[   41.607174] pci 0000:02:08.1: can't claim BAR 1 [mem 0x1ff00006000-0x1ff00007fff]: no compatible bridge window
[   41.607236] pci 0000:02:08.1: can't claim BAR 3 [mem 0x1ff00008000-0x1ff00009fff]: no compatible bridge window
[   41.607298] pci 0000:02:05.0: can't claim BAR 1 [mem 0x1ff0000a000-0x1ff0000bfff]: no compatible bridge window
[   41.607358] pci 0000:02:05.0: can't claim BAR 6 [mem 0x1ff00020000-0x1ff0003ffff]: no compatible bridge window

T1-105: all messages are gone, qla1280 works. used to have 
[   21.107754] pci 0000:00:01.0: can't claim BAR 8 [mem 0x1ff00000000-0x1ffbfffffff]: address conflict with Video RAM area [??? 0x1ff000a0000-0x1ff000bffff flags 0x80000000]
[   21.107856] pci 0000:02:01.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
[   21.107926] pci 0000:03:0f.0: can't claim BAR 8 [mem 0x1ff00100000-0x1ff028fffff]: no compatible bridge window
[   21.107993] pci 0000:04:00.0: can't claim BAR 0 [mem 0x1ff01000000-0x1ff01ffffff]: no compatible bridge window
[   21.108058] pci 0000:04:00.0: can't claim BAR 1 [mem 0x1ff02000000-0x1ff027fffff]: no compatible bridge window
[   21.108124] pci 0000:04:00.1: can't claim BAR 0 [mem 0x1ff02800000-0x1ff0280702f]: no compatible bridge window
[   21.108190] pci 0000:04:04.0: can't claim BAR 1 [mem 0x1ff02808000-0x1ff02808fff]: no compatible bridge window
[   21.108256] pci 0000:04:04.0: can't claim BAR 6 [mem 0x1ff02810000-0x1ff0281ffff]: no compatible bridge window
...
[   53.649523] qla1280 0000:04:04.0: can't ioremap BAR 1: [mem size 0x00001000]
[   53.742379] qla1280: Unable to map I/O memory


-- 
Meelis Roos (mroos@linux.ee)
