Return-Path: <SRS0=uj/S=4O=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=uj/S=4O=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 11/13] PCI: Add has_mem64 for struct host_bridge
To: Bjorn Helgaas <helgaas@kernel.org>, Yinghai Lu <yinghai@kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-12-yinghai@kernel.org>
 <20170504230425.GC9648@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <734dd5df-1be5-9f97-b373-358b70d0b107@vodafone.de>
Date: Mon, 8 May 2017 10:54:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170504230425.GC9648@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 05.05.2017 um 01:04 schrieb Bjorn Helgaas:
> [+cc Christian]
Thanks for that.

> [SNIP]
> I *think* this will be broken by the current implementation of
> Christian's patch to enable a 64-bit host bridge window:
>
>    https://lkml.kernel.org/r/1493890270-1188-5-git-send-email-deathsimple@vodafone.de
>
> because pci_register_host_bridge() runs before we scan the bus, and
> Christian's patch adds a quirk that runs when we enumerate the AMD
> host bridge device.
>
> If we apply this and Christian's patch, I think we could end up with
> a host bridge window above 4G, but with bridge->has_mem64 not set.
Yes, indeed. I can adjust my patch, but I would prefer not to do so.

I don't completely understand the background of this change, but from 
what I know how the BIOS (at least on X86) allocates resources it 
doesn't sounds correct to me.

Maybe we just need a Sparc specific quirk here instead of changing the 
common logic?

Regards,
Christian.
