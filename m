Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from resqmta-po-10v.sys.comcast.net ([96.114.154.169]:39749 "EHLO
	resqmta-po-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751047AbbJIQYI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:24:08 -0400
Message-ID: <1444407355.17726.1.camel@oracle.com>
Subject: Re: [PATCH v7 01/60] sparc/PCI: Add mem64 resource parsing for root
 bus
From: Khalid Aziz <khalid.aziz@oracle.com>
Reply-To: khalid.aziz@oracle.com
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:15:55 -0600
In-Reply-To: <1444340359-8011-2-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-2-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> Found "no compatible bridge window" warning in boot log from T5-8.
> 
> pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
> 
> That resource is above 4G, but does not get offset correctly as
> root bus only report io and mem32.
> 
> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [bus 00-77]
> 
> Add mem64 handling in pci_common for sparc, so we can have 64bit resource
> registered for root bus at first.
> 
> After patch, will have:
> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x800100000000-0x8007ffffffff] (bus address [0x100000000-0x7ffffffff])
> pci_bus 0000:00: root bus resource [bus 00-77]
> 
> -v2: mem64_space should use mem_space.start as offset.
> -v3: add IORESOURCE_MEM_64 flag
> -v4: set name for mem64_space, otherwise /proc/iomem will have <bad> for name
> 
> Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
> Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
> Reported-by: David Ahern <david.ahern@oracle.com>
> Tested-by: David Ahern <david.ahern@oracle.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>


Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 




