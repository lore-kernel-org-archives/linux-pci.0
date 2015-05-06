Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <5549A402.2010007@linux.intel.com>
Date: Wed, 06 May 2015 13:17:54 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>,
	Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Daniel J Blueman <daniel@numascale.com>,
	linux-doc@vger.kernel.org
Subject: Re: [Patch 2/2] x86, irq: Support CPU vector allocation policies
References: <1430707662-28598-1-git-send-email-jiang.liu@linux.intel.com> <1430707662-28598-3-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505052116210.4225@nanos>
In-Reply-To: <alpine.DEB.2.11.1505052116210.4225@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/6 3:25, Thomas Gleixner wrote:
> On Mon, 4 May 2015, Jiang Liu wrote:
>> +enum {
>> +	/* Allocate CPU vectors from CPUs on device local node */
>> +	X86_VECTOR_POL_NODE = 0x1,
>> +	/* Allocate CPU vectors from all online CPUs */
>> +	X86_VECTOR_POL_GLOBAL = 0x2,
>> +	/* Allocate CPU vectors from caller specified CPUs */
>> +	X86_VECTOR_POL_CALLER = 0x4,
>> +	X86_VECTOR_POL_MIN = X86_VECTOR_POL_NODE,
>> +	X86_VECTOR_POL_MAX = X86_VECTOR_POL_CALLER,
>> +}
> 
>> +static unsigned int vector_alloc_policy = X86_VECTOR_POL_NODE |
>> +					  X86_VECTOR_POL_GLOBAL |
>> +					  X86_VECTOR_POL_CALLER;
>   
>> +static int __init apic_parse_vector_policy(char *str)
>> +{
>> +	if (!strncmp(str, "node", 4))
>> +		vector_alloc_policy |= X86_VECTOR_POL_NODE;
> 
> This does not make sense. X86_VECTOR_POL_NODE is already set.
> 
>> +	else if (!strncmp(str, "global", 6))
>> +		vector_alloc_policy &= ~X86_VECTOR_POL_NODE;
> 
> Why would one disable node aware allocation? We fall back to the
> global allocation anyway, if the node aware allocation fails.
> 
> I'm completely missing the value of this command line option.
Hi Thomas,
	You are right. Originally I want a method to disable the
per-node allocation policy. Think it twice, it seems unnecessary
at all. Enabling per-node allocation policy by default shouldn't
cause serious issues, and user may change irq affinity setting
if the default affinity isn't desired.
	So we don't need the kernel parameter at all. Will update
the patch.

Thanks!
Gerry

> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
