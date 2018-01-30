Return-Path: <SRS0=vRdu=EZ=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=vRdu=EZ=intel.com=keith.busch@kernel.org>
Date: Tue, 30 Jan 2018 12:43:50 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v2 11/14] PCI/DPC: Remove unnecessary RP PIO register
 structs
Message-ID: <20180130194349.GD27205@localhost.localdomain>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180130182648.106875.32803.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180130185758.GC27205@localhost.localdomain>
 <20180130191100.GH232763@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180130191100.GH232763@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 30, 2018 at 01:11:00PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2018 at 11:57:58AM -0700, Keith Busch wrote:
> > On Tue, Jan 30, 2018 at 12:26:48PM -0600, Bjorn Helgaas wrote:
> > > +	u16 cap = dpc->cap_pos;
> > > +	u32 status, mask;
> > > +	u32 sev, syserr, exc;
> > > +	u16 dpc_status, first_error;
> > > +	u32 dw0, dw1, dw2, dw3;
> > > +	u32 log;
> > > +	u32 prefix;
> > 
> > Minor nit, could you squash the declarations of the same type?
> 
> I did it that way so it matches the order of the chunks of code where
> they're used.  But I guess we don't really do that elsewhere in the
> file, so I did.  Here's the result:

Thanks! That's all I had on this series. Looks good to me!

Reviewed-by: Keith Busch <keith.busch@intel.com>
