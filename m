Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 12 Aug 2013 09:13:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	rjw@sisk.pl, lance.ortiz@hp.com, m.chehab@samsung.com,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mce: acpi/apei: trace: Include PCIe AER trace event
 conditionally
Message-ID: <20130812091337.6f8c057d@gandalf.local.home>
In-Reply-To: <5208C8DD.3050204@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
	<1375986471-27113-2-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
	<20130808152329.1f98b5e0@gandalf.local.home>
	<5208C8DD.3050204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 12 Aug 2013 17:07:01 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> > TRACE_EVENT_PCIE_AER for the users as well. That is, the places that
> > include ras.h and use the trace_aer_*() tracepoints.
> 
> Do you mean the change I've done to aerdrv-errprint.c below? This trace 
> point is currently only used there, so I guess we are ok?
> 


Yeah, if it's only used on one place, then it's fine. But if it gets
used in other files, than those other files with have to define the
macro as well.

-- Steve
