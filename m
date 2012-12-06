Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1354758031.17101.7.camel@gandalf.local.home>
Subject: Re: [PATCH v5 2/3] aerdrv: Enhanced AER logging
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Lance Ortiz <lance.ortiz@hp.com>, bhelgaas@google.com,
	lance_ortiz@hotmail.com, jiang.liu@huawei.com, tony.luck@intel.com,
	mchehab@redhat.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Dec 2012 20:40:31 -0500
In-Reply-To: <20121204093007.GG4369@liondog.tnic>
References: <20121203212047.24373.8646.stgit@grignak.americas.hpqcorp.net>
	 <20121203212053.24373.10914.stgit@grignak.americas.hpqcorp.net>
	 <20121204093007.GG4369@liondog.tnic>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2012-12-04 at 10:30 +0100, Borislav Petkov wrote:

> Steve,
> 
> AFAIU, this will create all tracepoint code from the ras.h header
> in this compilation unit, i.e. aerdrv_errprint.c. It has only one
> tracepoint now but with time, as more RAS TPs are being added, it would
> make sense to have that CREATE_TRACE_POINTS code at a more central place
> in the kernel, right?

Yes.

> 
> And, on configs with PCIEAER disabled, we won't have the TPs available
> so the CREATE_TRACE_POINTS thing should be in a compilation unit which
> gets included unconditionally, correct?

You can have a config that enables these trace points, and when you
enable one of the systems that uses them, have that config select the
config that enables tracepoints. Have that config compile the file for
tracepoints. For example, in a Makefile:

obj-$(CONFIG_RAS_TRACE_POINTS) += ras-trace.o


Use #ifdef CONFIG_FOO_BAR around tracepoints that are required for
specific systems if the tracepoints in the header file are for different
subsystems that can be enabled or disabled separately by configs.

-- Steve



