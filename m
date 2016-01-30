Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36850 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcA3GPf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jan 2016 01:15:35 -0500
MIME-Version: 1.0
In-Reply-To: <20160129163159.GC12965@localhost>
References: <20160128192951.CC6AF820DC@mx.svc.vniiem.ru>
	<20160129163159.GC12965@localhost>
Date: Fri, 29 Jan 2016 22:15:34 -0800
Message-ID: <CAE9FiQXq5-h56P-94+_LVXRhVipJsfVFYx1HcwqewEfZp1PGkw@mail.gmail.com>
Subject: Re: PCI device driver broken between 4.2 and 4.3
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?B?0JzQvtGA0L7QtyDQntC70LXQsw==?= <oleg.moroz@mcc.vniiem.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 29, 2016 at 8:31 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> 991de2e59090 is related to IRQs, so I'd start by printing dev->irq in your
> driver before and after you call pci_enable_device().  Add some printks in
> pcibios_alloc_irq() and pcibios_enable_device() just to confirm that we got
> there and when, e.g., add lines like this:

looks like that commit removed pcibios_enable_irq for parent bridge.

pci_enable_device==>pci_enable_bridge==>pci_enable_device==>pcibios_enable_device
==>pcibios_enable_irq without msi enabled.

so pci=routeirq may workaround the problem.

Thanks

Yinghai
