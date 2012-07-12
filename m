Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:51225 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030684Ab2GLQLz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jul 2012 12:11:55 -0400
Message-ID: <4FFEF71E.7080706@xenotime.net>
Date: Thu, 12 Jul 2012 09:11:10 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: linux-next: Tree for July 12 (pci)
References: <20120712160335.9cbff13c2f18eadc7d3cb0cf@canb.auug.org.au>
In-Reply-To: <20120712160335.9cbff13c2f18eadc7d3cb0cf@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/11/2012 11:03 PM, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20120710:
> 
> 
> The pci tree lost its conflicts.


on x86_64:

drivers/built-in.o: In function `pci_bus_add_device':
(.text+0x4f62): undefined reference to `pci_fixup_final_inited'


when CONFIG_PCI_QUIRKS is not enabled.


-- 
~Randy
