Return-Path: <SRS0=JmXD=D5=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=JmXD=D5=intel.com=keith.busch@kernel.org>
Date: Tue, 2 Jan 2018 12:12:18 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 0/4] Address error and recovery for AER and DPC
Message-ID: <20180102191218.GD24386@localhost.localdomain>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <20180102190215.GC6211@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102190215.GC6211@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 02, 2018 at 01:02:15PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 29, 2017 at 12:54:15PM +0530, Oza Pawandeep wrote:
> > This patch set brings in support for DPC and AER to co-exist and not to
> > race for recovery.
> > 
> > The current implementation of AER and error message broadcasting to the
> > EP driver is tightly coupled and limited to AER service driver.
> > It is important to factor out broadcasting and other link handling
> > callbacks. So that not only when AER gets triggered, but also when DPC get
> > triggered, or both get triggered simultaneously (for e.g. ERR_FATAL),
> > callbacks are handled appropriately.
> > having modularized the code, the race between AER and DPC is handled
> > gracefully.
> > for e.g. when DPC is active and kicked in, AER should not attempt to do
> > recovery, because DPC takes care of it.
> 
> High-level question:
> 
> We have some convoluted code in negotiate_os_control() and
> aer_service_init() that (I think) essentially disables AER unless the
> platform firmware grants us permission to use it.
> 
> The last implementation note in PCIe r3.1, sec 6.2.10 says
> 
>   DPC may be controlled in some configurations by platform firmware
>   and in other configurations by the operating system. DPC
>   functionality is strongly linked with the functionality in Advanced
>   Error Reporting. To avoid conflicts over whether platform firmware
>   or the operating system have control of DPC, it is recommended that
>   platform firmware and operating systems always link the control of
>   DPC to the control of Advanced Error Reporting.
> 
> I read that as suggesting that we should enable DPC support in Linux
> if and only if we also enable AER.  But I don't see anything in DPC
> that looks like that.  Should there be something there?  Should DPC be
> restructured so it's enabled and handled inside the AER driver instead
> of being a separate driver?

Yes, I agree the two should be linked. I submitted a patch for that here,
though driver responsibilities are still separate in this series:

  https://marc.info/?l=linux-pci&m=151371742225111&w=2
