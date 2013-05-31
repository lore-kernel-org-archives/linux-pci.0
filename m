Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 31 May 2013 09:41:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ortiz, Lance E" <lance.oritz@hp.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"mchehab@redhat.com" <mchehab@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] aerdrv: Move cper_print_aer() call out of interrupt
 context
Message-ID: <20130531074101.GA3379@nazgul.tnic>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
 <30463843.EmBn1xaq3I@vostro.rjw.lan>
 <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
 <A961433CDFF2F640A2866803152E61F95D13A6F2@G9W0715.americas.hpqcorp.net>
 <20130530072849.GA20793@pd.tnic>
 <1369921028.26799.4.camel@gandalf.local.home>
 <A961433CDFF2F640A2866803152E61F95D13A762@G9W0715.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A961433CDFF2F640A2866803152E61F95D13A762@G9W0715.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 30, 2013 at 02:04:42PM +0000, Ortiz, Lance E wrote:
> Steve, you do have a good point here. I am wondering if that is why
> we should consider changing the output to match aer_print_error().
> The code path to aer_print_error() is the more common path where not
> as many platforms support the cper_print_error() path (firmware first
> AER). So it is more likely that any tools written would know how to
> parse the output from aer_print_error(). It would be good for those
> tools to support firmware first AER when it becomes more common. Of
> course this is purely conjecture. I have no idea if there are any
> tools that parse this text output.

Whatever you end up doing, just make sure you've hammered out the
information going out to userspace to be clear, succinct and complete
(as far as possible, of course). Because once you cast it in stone and
tools start using it, changing its format is a huge PITA, if at all
possible.

And if the error formats are compatible, then sharing the format is
obviously advantageous.
