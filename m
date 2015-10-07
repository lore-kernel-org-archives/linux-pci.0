Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33139 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbbJGWtn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 18:49:43 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
Date: Wed, 7 Oct 2015 15:49:42 -0700
Message-ID: <CAE9FiQXM9YxRwcbG577Pcqmj7YbOa0yk6hYELb2FpTtct5u2jg@mail.gmail.com>
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 7, 2015 at 2:25 AM, Meelis Roos <mroos@linux.ee> wrote:
> First I noticed that on Sun Netra t1-150 (sparc64 CPU), PCI allocation
> was failing for qla1280 scsi driver. Reading dmesg uncovered "can't
> claim BAR" errors. Looking for this in my other test machines I see more
> of them - on many sparc64 machines and some on x86.
>
> In another thread for "Resource allocation cleanup for v4.4", Yinghai Lu
> asked for full dmesg to solve another similar case. So to help
> understanding this one, here are the dmesgs of my machines:
>
> sparc64 machines:
>
> http://kodu.ut.ee/~mroos/dm/dm.t1-105
> http://kodu.ut.ee/~mroos/dm/dm.t1-200
> http://kodu.ut.ee/~mroos/dm/dm.v120
> http://kodu.ut.ee/~mroos/dm/dm.v210
> http://kodu.ut.ee/~mroos/dm/dm.v240
> http://kodu.ut.ee/~mroos/dm/dm.sb100

Please try

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-v4.4-next

It should fix some "no compatible bridge window"

Thanks

Yinghai
