Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39841 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab3EEARX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 May 2013 20:17:23 -0400
Message-ID: <1367712932.11982.20.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Sun, 05 May 2013 10:15:32 +1000
In-Reply-To: <1367712653.11982.19.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2013-05-05 at 10:10 +1000, Benjamin Herrenschmidt wrote:
> Once upon a time, our PCI resource assignment code use to be reasonably
> straightforward... right now I'm having a hard time making any sense
> of it.

Note that the devices so far seem to be working and here's the resulting
layout:

/ # cat /proc/iomem 
00000000-7ffffffff : System RAM
3d00080000000-3d000fffeffff : /pciex@3fffe40000000
  3d00080000000-3d000807fffff : PCI Bus 0000:01
    3d00080000000-3d0008003ffff : 0000:01:00.0
      3d00080000000-3d0008003ffff : ipr
  3d00080800000-3d00081ffffff : PCI Bus 0000:01
    3d00080800000-3d0008081ffff : 0000:01:00.0
    3d00081000000-3d00081ffffff : 0000:01:00.0
      3d00081000000-3d00081ffffff : ipr
3d01080000000-3d010fffeffff : /pciex@3fffe40100000
  3d01080000000-3d010817fffff : PCI Bus 0001:01
    3d01080000000-3d010817fffff : PCI Bus 0001:02
      3d01080000000-3d010807fffff : PCI Bus 0001:08
        3d01080000000-3d0108001ffff : 0001:08:00.0
      3d01080800000-3d01080ffffff : PCI Bus 0001:09
      3d01081000000-3d010817fffff : PCI Bus 0001:03
  3d01081800000-3d010837fffff : PCI Bus 0001:01
    3d01081800000-3d01081ffffff : PCI Bus 0001:02
      3d01081800000-3d01081ffffff : PCI Bus 0001:08
        3d01081800000-3d0108180ffff : 0001:08:00.0
          3d01081800000-3d0108180ffff : ipr
        3d01081810000-3d0108181ffff : 0001:08:00.0
          3d01081810000-3d0108181ffff : ipr
    3d01082000000-3d0108203ffff : 0001:01:00.0
3d04080000000-3d040fffeffff : /pciex@3fffe40400000
3d05080000000-3d050fffeffff : /pciex@3fffe40500000
  3d05081800000-3d050847fffff : PCI Bus 0003:01
    3d05081800000-3d05081ffffff : PCI Bus 0003:02
      3d05081800000-3d05081ffffff : PCI Bus 0003:03
        3d05081800000-3d0508180ffff : 0003:03:00.0
        3d05081810000-3d05081811fff : 0003:03:00.0
    3d05082000000-3d0508203ffff : 0003:01:00.0
  3d05084800000-3d050867fffff : PCI Bus 0003:01
    3d05084800000-3d050867fffff : PCI Bus 0003:02
      3d05084800000-3d05084ffffff : PCI Bus 0003:09
        3d05084800000-3d0508487ffff : 0003:09:00.0
        3d05084880000-3d050848fffff : 0003:09:00.1
        3d05084900000-3d0508497ffff : 0003:09:00.2
        3d05084980000-3d050849fffff : 0003:09:00.3
        3d05084a00000-3d05084a0ffff : 0003:09:00.0
          3d05084a00000-3d05084a0ffff : tg3
        3d05084a10000-3d05084a1ffff : 0003:09:00.0
          3d05084a10000-3d05084a1ffff : tg3
        3d05084a20000-3d05084a2ffff : 0003:09:00.0
          3d05084a20000-3d05084a2ffff : tg3
        3d05084a30000-3d05084a3ffff : 0003:09:00.1
          3d05084a30000-3d05084a3ffff : tg3
        3d05084a40000-3d05084a4ffff : 0003:09:00.1
          3d05084a40000-3d05084a4ffff : tg3
        3d05084a50000-3d05084a5ffff : 0003:09:00.1
          3d05084a50000-3d05084a5ffff : tg3
        3d05084a60000-3d05084a6ffff : 0003:09:00.2
          3d05084a60000-3d05084a6ffff : tg3
        3d05084a70000-3d05084a7ffff : 0003:09:00.2
          3d05084a70000-3d05084a7ffff : tg3
        3d05084a80000-3d05084a8ffff : 0003:09:00.2
          3d05084a80000-3d05084a8ffff : tg3
        3d05084a90000-3d05084a9ffff : 0003:09:00.3
          3d05084a90000-3d05084a9ffff : tg3
        3d05084aa0000-3d05084aaffff : 0003:09:00.3
          3d05084aa0000-3d05084aaffff : tg3
        3d05084ab0000-3d05084abffff : 0003:09:00.3
          3d05084ab0000-3d05084abffff : tg3
      3d05085000000-3d050857fffff : PCI Bus 0003:0f
      3d05085800000-3d05085ffffff : PCI Bus 0003:0a
      3d05086000000-3d050867fffff : PCI Bus 0003:04

Cheers,
Ben.


