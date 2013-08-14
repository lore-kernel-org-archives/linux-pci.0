Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <520B603E.3040002@linux.vnet.ibm.com>
Date: Wed, 14 Aug 2013 16:17:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Borislav Petkov <bp@alien8.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com> <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic> <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com> <20130812114404.3bd64fa0@samsung.com> <520A1B5E.8040105@linux.vnet.ibm.com> <20130813094147.062317f8@concha.lan> <520A6A30.1030406@linux.vnet.ibm.com> <3908561D78D1C84285E8C5FCA982C28F31CB8DB5@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CB8DB5@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/13/2013 11:09 PM, Luck, Tony wrote:
>> In the meantime, like Boris suggests, I think we can have a different
>> trace event for raw APEI reports - userspace can use it as it pleases.
>>
>> Once ghes_edac gets better, users can decide whether they want raw APEI
>> reports or the EDAC-processed version and choose one or the other trace
>> event.
>
> It's cheap to add as many tracepoints as we like - but may be costly to maintain.
> Especially if we have to tinker with them later to adjust which things are logged,
> that puts a burden on user-space tools to be updated to adapt to the changing
> API.

Agree. And this is the reason I have been considering mc_event. But, the 
below issues with ghes_edac made me unsure:
- One, the logging format for APEI data is a bit verbose and hard to 
parse. But, I suppose we could work with this if we make a few changes. 
Is it ok to change how the APEI data is made available through 
mc_event->driver_detail?
- Two, if ghes_edac is enabled, it prevents other edac drivers from 
being loaded. It looks like the assumption here is that if ghes/firmware 
first is enabled, then *all* memory errors are reported through ghes 
which is not true. We could have (a subset of) corrected errors reported 
through ghes, some through CMCI and uncorrected errors through MCE. So, 
if I'm not mistaken, if ghes_edac is enabled, we will only receive ghes 
error events through mc_event and not the others. Mauro, is this accurate?

>
> Mauro has written his user-space tool to process the ghes-edac events:
>    git://git.fedorahosted.org/rasdaemon.git
>
> Who is writing the user space tools to process the new apei tracepoints
> you want to add?

Enabling rasdaemon itself for the new tracepoint is an option, as long 
as Mauro doesn't object to it ;)

>
> I'm not opposed to these patches - just wondering who is taking the next step
> to make them useful.

Sure.


Regards,
Naveen

