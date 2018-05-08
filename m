Return-Path: <SRS0=UZgS=H3=goodmis.org=rostedt@kernel.org>
Return-Path: <SRS0=UZgS=H3=goodmis.org=rostedt@kernel.org>
Date: Tue, 8 May 2018 09:07:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Gagniuc
 <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/AER: add pcie TLP header information in the
 tracepoint
Message-ID: <20180508090756.57f38d17@gandalf.local.home>
In-Reply-To: <20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402154708.5032-1-thomas.tai@oracle.com>
	<20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 7 May 2018 17:21:37 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Steve, Alex]
> 
> On Mon, Apr 02, 2018 at 11:47:08AM -0400, Thomas Tai wrote:
> > When a PCIe AER occurs, the TLP header information is
> > printed in the kernel message but it is missing from
> > the tracepoint. A userspace program can use this information
> > in the tracepoint to better analyze problems.
> > 
> > Example tracepoint output:
> > aer_event: 0000:01:00.0
> > PCIe Bus Error: severity=Uncorrected, non-fatal, Completer Abort
> > TLP Header={0x0,0x1,0x2,0x3}
> > 
> > Signed-off-by: Thomas Tai <thomas.tai@oracle.com>  
> 
> I tentatively applied this to pci/aer for v4.18, thanks!
> 
> Steve, let me know if you have any comments.
> 
> Alex, I just copied you because you've been unifying the AER native and
> CPER paths, and this is another case of code that appears in both paths.
> FYI only, no action required :)
> 
> > ---
> >  drivers/pci/pcie/aer/aerdrv_errprint.c |  4 ++--
> >  include/ras/ras_event.h                | 20 ++++++++++++++++----
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> > index 6a352e638699..0a78a773bd25 100644
> > --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> > +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> > @@ -192,7 +192,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> >  		pci_err(dev, "  Error of this Agent(%04x) is reported first\n", id);
> >  
> >  	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> > -			info->severity);
> > +			info->severity, info->tlp_header_valid, &info->tlp);
> >  }
> >  
> >  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> > @@ -252,6 +252,6 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
> >  		__print_tlp_header(dev, &aer->header_log);
> >  
> >  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> > -			aer_severity);
> > +			aer_severity, tlp_header_valid, &aer->header_log);
> >  }
> >  #endif
> > diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> > index 9c689868eb4d..90f59556f595 100644
> > --- a/include/ras/ras_event.h
> > +++ b/include/ras/ras_event.h
> > @@ -298,30 +298,42 @@ TRACE_EVENT(non_standard_event,
> >  TRACE_EVENT(aer_event,
> >  	TP_PROTO(const char *dev_name,
> >  		 const u32 status,
> > -		 const u8 severity),
> > +		 const u8 severity,
> > +		 const u32 tlp_header_valid,
> > +		 struct aer_header_log_regs *tlp),
> >  
> > -	TP_ARGS(dev_name, status, severity),
> > +	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
> >  
> >  	TP_STRUCT__entry(
> >  		__string(	dev_name,	dev_name	)
> >  		__field(	u32,		status		)
> >  		__field(	u8,		severity	)
> > +		__field(	u32, 		tlp_header_valid)

I'm guessing tlp_header_valid is just a boolean. It's after severity
which is just one byte long. Why not make this one byte as well,
otherwise you are wasting 3 bytes.


> > +		__array(	u32, 		buf, 4		)
> >  	),
> >  
> >  	TP_fast_assign(
> >  		__assign_str(dev_name, dev_name);
> >  		__entry->status		= status;
> >  		__entry->severity	= severity;
> > +		__entry->tlp_header_valid = tlp_header_valid;

> > +		__entry->buf[0] = tlp->dw0;
> > +		__entry->buf[1] = tlp->dw1;
> > +		__entry->buf[2] = tlp->dw2;
> > +		__entry->buf[3] = tlp->dw3;

Should this assignment be dependent on whether or not tlp_header_valid
is true? Could tlp be pointing to some random memory if it isn't? What
about:

	if ((__entry->tlp_header_valid = tlp_header_valid)) {
		__entry->buf[0] = tlp->dw0;
		__entry->buf[1] = tlp->dw1;
		__entry->buf[2] = tlp->dw2;
		__entry->buf[3] = tlp->dw3;
	}


> >  	),
> >  
> > -	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
> > +	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
> >  		__get_str(dev_name),
> >  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
> >  			__entry->severity == AER_FATAL ?
> >  			"Fatal" : "Uncorrected, non-fatal",
> >  		__entry->severity == AER_CORRECTABLE ?
> >  		__print_flags(__entry->status, "|", aer_correctable_errors) :
> > -		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
> > +		__print_flags(__entry->status, "|", aer_uncorrectable_errors),
> > +		__entry->tlp_header_valid ?
> > +			__print_array(__entry->buf, 4, sizeof(unsigned int)) :

Note, "sizeof" will be shown in the format file that perf and trace-cmd
read to parse this event. They currently do not know how to parse that
(although I could add that in the future).

Since sizeof(unsigned int) is always 4 in Linux, just use 4.

			__print_array(__entry->buf, 4, 4)

-- Steve


> > +			"Not available")
> >  );
> >  
> >  /*
> > -- 
> > 2.14.1
> >   
