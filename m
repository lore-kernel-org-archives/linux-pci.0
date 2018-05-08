Return-Path: <SRS0=UZgS=H3=goodmis.org=rostedt@kernel.org>
Return-Path: <SRS0=UZgS=H3=goodmis.org=rostedt@kernel.org>
Date: Tue, 8 May 2018 09:34:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Gagniuc
 <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI/AER: add pcie TLP header information in the
 tracepoint
Message-ID: <20180508093459.092988b6@gandalf.local.home>
In-Reply-To: <a5578a08-2434-af48-7910-6f858e5477d6@oracle.com>
References: <20180402154708.5032-1-thomas.tai@oracle.com>
	<20180507222136.GD161390@bhelgaas-glaptop.roam.corp.google.com>
	<20180508090756.57f38d17@gandalf.local.home>
	<a5578a08-2434-af48-7910-6f858e5477d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 8 May 2018 09:25:01 -0400
Thomas Tai <thomas.tai@oracle.com> wrote:

> >>>   	TP_STRUCT__entry(
> >>>   		__string(	dev_name,	dev_name	)
> >>>   		__field(	u32,		status		)
> >>>   		__field(	u8,		severity	)
> >>> +		__field(	u32, 		tlp_header_valid)  
> > 
> > I'm guessing tlp_header_valid is just a boolean. It's after severity
> > which is just one byte long. Why not make this one byte as well,
> > otherwise you are wasting 3 bytes.  
> 
> Thanks Steven. Yes boolean is fine.

But don't use "bool", use u8, as bool can be various sizes on different
archs.

-- Steve
