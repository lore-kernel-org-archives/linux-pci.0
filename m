Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1354283631.6276.143.camel@gandalf.local.home>
Subject: Re: [PATCH 1/3] aerdrv: Trace Event for AER
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com,
	lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com,
	mchehab@redhat.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Nov 2012 08:53:51 -0500
In-Reply-To: <20121130134232.GD6869@liondog.tnic>
References: <20121129215443.5483.43364.stgit@grignak.americas.hpqcorp.net>
	 <1354240279.6276.131.camel@gandalf.local.home>
	 <20121130105311.GA6869@liondog.tnic>
	 <1354275551.6276.140.camel@gandalf.local.home>
	 <20121130134232.GD6869@liondog.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2012-11-30 at 14:42 +0100, Borislav Petkov wrote:

> So, it sounds to me like we should we move all RAS-specific tracepoints
> to <trace/events/ras.h> and then in each usage site do:

Note, the CREATE_TRACE_POINTS must only be done in one location. Not
every place. It creates the code that does the work to make the
tracepoints show up in /debug/tracing/events/* as well as the callback
code and other such things. If you define it in more than one .c file,
then you will have linker issues due to the functions being created more
than once.

> 
> #define CREATE_TRACE_POINTS
> #include <trace/events/ras.h>
> 
> Correct?

That's the default way to do things.

> 
> FWIW, it looks neat and clean to me that way.

Yep, that's why it's default ;-)

-- Steve


