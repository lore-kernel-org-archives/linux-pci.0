Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39313 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbbJaUs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 31 Oct 2015 16:48:27 -0400
Message-ID: <1446324424.4060.1.camel@kernel.crashing.org>
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>, yinghai@kernel.org
Cc: khalid.aziz@oracle.com, bhelgaas@google.com,
	weiyang@linux.vnet.ibm.com, linux@iam.tj, wangyijing@huawei.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 01 Nov 2015 07:47:04 +1100
In-Reply-To: <20151031.145142.372881581221024297.davem@davemloft.net>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
	 <5633E570.6040906@oracle.com>
	 <CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
	 <20151031.145142.372881581221024297.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2015-10-31 at 14:51 -0400, David Miller wrote:
> This is the way OF seems to work.
> 
> It maps all of the ROMs essentially to the same address range, but
> only enables one at a time as it inspects the ROMs and builds the
> device tree during power-on.
> 
> Then it makes sure all of them are disabled, and can therefore use
> some of that address range for mapping other BARs.
> 
> So if ROMs are disabled, you cannot put the address of such ROMs BAR
> in the kernel's assigned PCI address resource list.
> 
> I hope that is what you are doing?

I've seen that sort of stuff on x86 as well. Possibly on POWER, I don't
remember for sure.

I've also seen the VBIOS  of some cards manually remap the ROM BAR to
cover BAR 0, extract stuff from it, then disable it.

I think the ROM BAR must be treated as "special". It should probably
done in a separate pass from all the other BARs of all the other
adapters to be honest, and remapped if there's any conflict.

Cheers,
Ben

