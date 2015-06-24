Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Jun 2015 10:30:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boszormenyi Zoltan <zboszor@pr.hu>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Bugfix v2] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32bit kernel
Message-ID: <20150624083019.GA26672@gmail.com>
References: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Jiang Liu <jiang.liu@linux.intel.com> wrote:

> Since commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces to 
> simplify implementation"), x86 PCI ACPI host bridge driver validates ACPI 
> resources by first converting an ACPI resource to a 'struct resource' structure 
> and then applying checks against the converted resource structure. The 'start' 
> and 'end' fields in 'struct resource' are defined to be type of resource_size_t, 
> which may be 32 bits or 64 bits depending on CONFIG_PHYS_ADDR_T_64BIT.
> 
> This may cause incorrect resource validation results with 32 bit kernels because 
> 64bit ACPI resource descriptors may get truncated when converting to 32bit 
> 'start' and 'end' fields in 'struct resource'. And eventually affects PCI 
> resource allocation subsystem and causes some PCI devices unusable.

s/causes some PCI devices unusuable.
  makes some PCI devices unusuable.

Also, this description is still pretty vague. What exactly happened? Did some PCI 
devices not show up during bootup? Or did they hang? Or did something else happen?

This is _by far_ the most important part of the changelog and determines whether a 
patch gets backported or not. Why does a usable regression description have to be 
coaxed out of you like pulling teeth??

> So enhance the ACPI resource parsing interfaces to ignore ACPI resource 
> descriptors with address/offset observe 4G when running in 32bit mode. This 
> reverts to the behavior before commit 593669c2ac0f.
> 
> This issue was triggered on a platform running 32bit kernel with an ACPI 
> resource descriptor with address range [0x400000000-0xfffffffff]. Please refer 
> to https://lkml.org/lkml/2015/6/19/277 for more information.

s/32bit/32-bit
s/64bit/64-bit
s/32 bit/32-bit
s/64 bit/64-bit

Thanks,

    Ingo

