Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] x86, acpi, pci: Isolate new PCI mmconfig entry insertion.
Date: Fri, 07 Nov 2014 15:09:10 +0100
Message-ID: <1927317.6tJuq4S5Om@wuerfel>
In-Reply-To: <1415366876-30811-3-git-send-email-tomasz.nowicki@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org> <1415366876-30811-3-git-send-email-tomasz.nowicki@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 07 November 2014 14:27:54 Tomasz Nowicki wrote:
> Add special pci_mmcfg_insert_lock mutex since pci_mmcfg_lock was moved
> to common file. No functional changes.
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 

What is the new lock protecting against? You no longer have a mutual
exclusion with the other code, which looks like it is a functional
change, and also incorrect.

It also sounds like the code was broken after the first patch and
you need this one to make it compile again. You can't do that, and
instead need to change the locking rules first.

	Arnd
