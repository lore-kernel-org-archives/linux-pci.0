Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53742 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbaIJEAs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Sep 2014 00:00:48 -0400
Message-ID: <540FCCEA.2080003@linux.intel.com>
Date: Wed, 10 Sep 2014 12:00:42 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: i386 minimal config w/ PCI is broken
References: <CALCETrUyaSSLCpi3e2tF9-NSgFx54du1D0UH0ofE9E+HX=VqfA@mail.gmail.com>
In-Reply-To: <CALCETrUyaSSLCpi3e2tF9-NSgFx54du1D0UH0ofE9E+HX=VqfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,
	Sorry for this. It should be fixed by:
http://marc.info/?l=linux-kernel&m=140938277815528&w=2
Regards!
Gerry
On 2014/9/10 8:08, Andy Lutomirski wrote:
> The attached config doesn't compile for me w/ Linus' tree from today.
> It complains about undeclared mp_should_keep_irq in
> arch/x86/pci/irq.c.
> 
> I haven't tested for real, but I think that the offending commit is:
> 
> commit c03b3b0738a56cf283b0d05256988d5e3c8bd719
> Author: Jiang Liu <jiang.liu@linux.intel.com>
> Date:   Mon Jun 9 16:20:08 2014 +0800
> 
>     x86, irq, mpparse: Release IOAPIC pin when PCI device is disabled
> 
> 
