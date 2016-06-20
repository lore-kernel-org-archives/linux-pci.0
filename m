Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Jun 2016 09:56:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	karol herbst <karolherbst@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>, koriakin@0x04.net
Subject: Re: [PATCH] tracing: Expose CPU physical addresses (resource
 values) for PCI devices
Message-ID: <20160620095621.6f188668@gandalf.local.home>
In-Reply-To: <1466202203.24271.76.camel@au1.ibm.com>
References: <20160511190657.5898.4248.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160617175901.7bd90d14@gandalf.local.home>
	<1466202203.24271.76.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 18 Jun 2016 08:23:23 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Fri, 2016-06-17 at 17:59 -0400, Steven Rostedt wrote:
> > Sorry for the late reply, this patch got pushed down in my INBOX.
> > 
> > Could I get someone from PPC to review this patch, just to be safe?  
> 
> The patch makes sense, I can try getting somebody onto porting
> mmiotrace one of these days.
> 

OK, thanks!

I'll pull this into my for-next repo then.

-- Steve
