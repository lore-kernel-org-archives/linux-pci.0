Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39862 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbcAOUPX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 15:15:23 -0500
Date: Fri, 15 Jan 2016 21:14:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
In-Reply-To: <CAErSpo7yGGr8iRuTJvKqwjJqVELTq35mNyxs9qg-1yhJODvGFQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1601152113350.3575@nanos>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com> <20160115181938.GA5296@localhost> <alpine.DEB.2.11.1601152042090.3575@nanos> <CAErSpo7yGGr8iRuTJvKqwjJqVELTq35mNyxs9qg-1yhJODvGFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 15 Jan 2016, Bjorn Helgaas wrote:

> On Fri, Jan 15, 2016 at 11:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 15 Jan 2016, Bjorn Helgaas wrote:
> >> +    [bhelgaas: add VMD BAR #defines, factor out vmd_cfg_addr(), whitespace]
> >>      Signed-off-by: Keith Busch <keith.busch@intel.com>
> >>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Just for the record. You forgot my Acked-bys
> 
> Sorry, I added them to the first two patches:
> 
>   irqdomain: Export irq_domain_set_info() for module use
>   genirq/MSI: Relax msi_domain_alloc() to support parentless MSI irqdomains
> 
> Let me know if you intended to ack any of the others, too.

The vmd driver itself (at least for the irq related parts). But you don't have
to redo it.

Thanks,

	tglx
