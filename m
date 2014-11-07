Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: linaro-acpi@lists.linaro.org, catalin.marinas@arm.com,
	will.deacon@arm.com, bhelgaas@google.com, Liviu.Dudau@arm.com,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	rjw@rjwysocki.net, linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Linaro-acpi] [RFC PATCH 3/4] arm64, acpi, pci: Add arch specific functions for mmconfig driver.
Date: Fri, 07 Nov 2014 15:54:09 +0100
Message-ID: <2483899.fnsktEmYFO@wuerfel>
In-Reply-To: <545CD9A4.3080900@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org> <16660879.6KxQndPqBW@wuerfel> <545CD9A4.3080900@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 07 November 2014 15:39:32 Tomasz Nowicki wrote:
> On 07.11.2014 15:12, Arnd Bergmann wrote:
> > On Friday 07 November 2014 14:27:55 Tomasz Nowicki wrote:
> >> These calls allow to map/unmap PCI config space ranges (which are specified in
> >> MMCFG ACPI table).
> >>
> >> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >>
> >
> > Nothing in this patch looks arm64 specific, and most of it looks like a
> > copy of the x86 code.
> 
> Yes, most of the logic was borrowed from mmconfig_64.c file, 
> mmconfig_32.c looks differently, though. It is not simple to merge them 
> both. IMO, we have two choices:
> 1. Refactor and move mmconfig_64.c out of x86 to e.g. drivers/acpi/ and 
> let it be default.
> 2. Stay with solution presented in this patch.
> 3. Thoughts ?

If the code is generic, it should be shared with as many architectures as
possible. Moving the x86-64 implementation to drivers/acpi/ would immediately
let you share it with two out of the four architectures (x86-64 and arm64,
but not x86-32 and ia64) as well as any potential other architectures that
might implement ACPI in the future.

	Arnd
