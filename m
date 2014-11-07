Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, rjw@rjwysocki.net, linux-pci@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [Linaro-acpi] [RFC PATCH 3/4] arm64, acpi, pci: Add arch specific functions for mmconfig driver.
Date: Fri, 07 Nov 2014 15:12:45 +0100
Message-ID: <16660879.6KxQndPqBW@wuerfel>
In-Reply-To: <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org> <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 07 November 2014 14:27:55 Tomasz Nowicki wrote:
> These calls allow to map/unmap PCI config space ranges (which are specified in
> MMCFG ACPI table).
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 

Nothing in this patch looks arm64 specific, and most of it looks like a
copy of the x86 code.

	Arnd
