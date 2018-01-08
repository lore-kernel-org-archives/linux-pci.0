Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51900 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756068AbeAHMzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jan 2018 07:55:17 -0500
Date: Mon, 8 Jan 2018 13:55:15 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Mason <slash.tmp@free.fr>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/8] arch/sh: add sh7786_mm_sel() function
Message-ID: <20180108135515.166da07c@windsurf>
In-Reply-To: <a306b914-e95a-4199-60de-39e88782ac05@free.fr>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
        <20171204150907.24345-2-thomas.petazzoni@free-electrons.com>
        <a306b914-e95a-4199-60de-39e88782ac05@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Mon, 8 Jan 2018 13:28:42 +0100, Mason wrote:

> > +static inline u32 sh7786_mm_sel(void)
> > +{
> > +	return __raw_readl(0xFC400020) & 0x7;  
> 
> I thought we were never supposed to use __raw_readl(), rather use readl_relaxed() instead?
> 
> The difference is that readl_relaxed() takes care of endianness, which would seem relevant
> since you have both endianness. Am I missing something?

Yes. That I/O accessors in Linux are a mess.

On ARM for example, when the CPU runs big-endian, the devices are still
little-endian, so we use readl/writel (or their relaxed variants) to do
the endianness conversion.

However, on SH, platform devices have an endianness that follow the
CPU one. So if you run little-endian, your devices are little endian,
if you run big-endian, your devices are big endian. Hence the use of
__raw_readl().

So you could ask me: but if SH behaves like this, why is readl/writel
doing an endianness conversion on this architecture? Well because
readl/writel were originally introduced for PCI devices, and PCI
devices are always little-endian, even when your SH core runs
big-endian.

Basically, I think the I/O accessors are just a mess, and the only way
to solve this mess properly would be to have a "struct device *" as
argument to those accessors, that tells the accessor how the device
behaves in terms of endianness.

Best regards, 

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
