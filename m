Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:60308 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeBSPa1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Feb 2018 10:30:27 -0500
Date: Mon, 19 Feb 2018 10:30:25 -0500 (EST)
Message-Id: <20180219.103025.1676484157305869188.davem@davemloft.net>
To: dwmw2@infradead.org
Cc: sparclinux@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] sparc: Use generic pci_mmap_resource_range()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519053858.7876.84.camel@infradead.org>
References: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
        <20180219.094951.2098243214524004486.davem@davemloft.net>
        <1519053858.7876.84.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 19 Feb 2018 15:24:18 +0000

>> For one, the sparc specific code allows mmap'ing any address range
>> within a PCI bus device.  The generic code does not allow that.
> 
> 
> You mean any address range in a given PCI bus even if there is no
> actual device with a BAR at the corresponding address?
> 
> Would I be right to assume this was only available through the legacy
> procfs API? I think it should be possible to accommodate it, and it
> does look like I'd missed this requirement the first time round; thanks
> for pointing it out.

It was probably the case that only procfs could do it.

It is the mechanism by which we were able to let the X server poke
around in VGA ISA space.  It does a bus I/O space map for the bus
device above the VGA card.
