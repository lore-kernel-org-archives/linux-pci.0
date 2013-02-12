Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5119DCCD.70709@zytor.com>
Date: Mon, 11 Feb 2013 22:10:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
CC: Yinghai Lu <yinghai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/26] x86, irq: support ioapic device hotplug
References: <1360351703-20571-1-git-send-email-yinghai@kernel.org> <20130211093417.GC23932@gmail.com>
In-Reply-To: <20130211093417.GC23932@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/11/2013 01:34 AM, Ingo Molnar wrote:
> 
> * Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> Hi,
>>
>> Current x86 code does not support iapic hotplug yet.
> 
> Please give a better high-level description: outline how an 
> IO-APIC will be hotplugged physically and what changes the 
> user will experience.
> 
> That needs at least 2 paragraphs, not one cursory sentence. Then 
> should come technical descriptions - but even those need 
> improvements, please first explain the current status quo, then 
> explain how that is inadequate for IO-APIC hot-plugging, *then* 
> only explain what you are doing in the patch ...
> 

A few more notes:

Please explain what you mean with pre-reserve IRQ blocks, and in
particular, how do you know what to reserve and for what?

Second, some of the things in this patchset seems to overlap with what
we would need to support MSI (as opposed to MSI-X), and you have several
patches related to MSI vs MSI-X.  Are you also supporting multivector
MSI (I believe the answer is no) or could some of this work make
multivector MSI practical (possible)?

	-hpa


