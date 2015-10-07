Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:38621 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbbJGJXy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 05:23:54 -0400
Date: Wed, 7 Oct 2015 12:25:19 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: 4.3-rc3 BAR allocation problems on multiple machines
Message-ID: <alpine.LRH.2.20.1510071147520.8345@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First I noticed that on Sun Netra t1-150 (sparc64 CPU), PCI allocation 
was failing for qla1280 scsi driver. Reading dmesg uncovered "can't 
claim BAR" errors. Looking for this in my other test machines I see more 
of them - on many sparc64 machines and some on x86.

In another thread for "Resource allocation cleanup for v4.4", Yinghai Lu 
asked for full dmesg to solve another similar case. So to help 
understanding this one, here are the dmesgs of my machines:

sparc64 machines:

http://kodu.ut.ee/~mroos/dm/dm.t1-105
http://kodu.ut.ee/~mroos/dm/dm.t1-200
http://kodu.ut.ee/~mroos/dm/dm.v120
http://kodu.ut.ee/~mroos/dm/dm.v210
http://kodu.ut.ee/~mroos/dm/dm.v240
http://kodu.ut.ee/~mroos/dm/dm.sb100

amd64 machine:

http://kodu.ut.ee/~mroos/dm/dm.x2100

-- 
Meelis Roos (mroos@linux.ee)
