Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755573AbcJZVux (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 17:50:53 -0400
Date: Wed, 26 Oct 2016 16:50:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: 4.3-rc3 BAR allocation problems on multiple machines
Message-ID: <20161026215047.GA28097@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Meelis,

On Wed, Oct 07, 2015 at 12:25:19PM +0300, Meelis Roos wrote:
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
> 
> amd64 machine:
> 
> http://kodu.ut.ee/~mroos/dm/dm.x2100

I'm looking through the PCI bugs in bugzilla.kernel.org and came
across one that I opened for this issue
(https://bugzilla.kernel.org/show_bug.cgi?id=117191)

Is this still an issue?  I've applied some patches from Yinghai, but I
know there are a bunch more in the queue, so I'm trying to figure out
what's fixed and what's still broken.

Bjorn
