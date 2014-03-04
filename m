Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbaCDSK6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Mar 2014 13:10:58 -0500
Message-ID: <1393956649.2895.128.camel@ul30vt.home>
Subject: Re: PCIE: Program pcie device private registers
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	shiv prakash Agarwal <chhotu.shiv@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Date: Tue, 04 Mar 2014 11:10:49 -0700
In-Reply-To: <CAErSpo7s7fdUZH6zXr3ZWHq8s+zQ_5_sszzBZWrqFOh+jXHUgA@mail.gmail.com>
References: <CAHH3p5JzL-9T-Hn=fp1S9=URzycpKTy6toaA0AjQfJYt7mQXsA@mail.gmail.com>
	 <20140304035917.GA3032@pratyush-vbox>
	 <CAErSpo7s7fdUZH6zXr3ZWHq8s+zQ_5_sszzBZWrqFOh+jXHUgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-03-04 at 10:45 -0700, Bjorn Helgaas wrote:
> On Mon, Mar 3, 2014 at 8:59 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
> > On Thu, Feb 27, 2014 at 05:12:38PM +0800, shiv prakash Agarwal wrote:
> >>    Hi All,
> >>
> >>
> >>
> >>    One query:
> >>
> >>
> >>
> >>    We can program config space registers of a pcie device using setpci but
> >>    how can we program private registers of a pcie device?
> >
> > You mean application specific registers?
> > These registers will not be accessible through any generic user space program.
> >
> > If you want to access them for debug purposes then you can provide
> > support in your driver.
> 
> If the registers are in config space, you can use setpci, even if they
> are non-architected registers specific to the device.
> 
> If they are in MMIO space, you can use lspci to learn where the BARs
> are mapped, and then use something like rdwrmem
> (http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c) to access the
> registers.
> 
> If they are in I/O port space, you can again use lspci to learn where
> they are mapped, and then use ioperm()/iopl()/inb()/outb()/etc.

The pci-sysfs resource# files are probably an easier alternative.  MMIO
regions can be mmap'd and I/O port regions support direct read/write.
Thanks,

Alex

