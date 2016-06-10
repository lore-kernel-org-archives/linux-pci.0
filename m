Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56219 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbcFJFpx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 01:45:53 -0400
Message-ID: <1465537530.2948.51.camel@kernel.crashing.org>
Subject: Re: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	mpe@ellerman.id.au, alistair@popple.id.au
Date: Fri, 10 Jun 2016 15:45:30 +1000
In-Reply-To: <fb22a56a-92fe-b12b-2f79-dc77e26fcc09@ozlabs.ru>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
	 <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
	 <20160610043349.GA17817@gwshan>
	 <fb22a56a-92fe-b12b-2f79-dc77e26fcc09@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-06-10 at 15:28 +1000, Alexey Kardashevskiy wrote:
> > Actually, it's likely caused by hardware defect
> > - we can't set 2GB (0x80000000 - 0xffffffff) to RC's memory window.
> > Otherwise, it *seems* the window is disabled. I tried updating the
> > window with (0x80000000 - 0xffefffff) or (0x80000000 - 0xffdffff), no
> > EEH error was seen. I already got 0x00001000 on read despite whatever
> > I wrote to 0x20 reg.
> > 
> > The hardware is broken. In order to fix this, I intend to include a
> > bitmap for every PHB device node in skiboot. Kernel uses this to apply
> > fixup accordingly. One bit is reserved on Garrison platform to avoid
> > this issue. The fix can be a patch inserted before this patch in next
> > revision
> 
> This sounds better as preserves bisectability. Thanks.

Ah yes they made those registers read-only. Look at my PHB4 code, I
implement a cache for them in SW.

Cheers,
Ben.

