Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Aug 2014 20:37:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Grant Likely <grant.likely@linaro.org>, x86@kernel.org,
	Len Brown <lenb@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix 1/2] x86, irq, PCI: Keep IRQ assignment for PCI devices
 during suspend/hibernation
Message-ID: <20140805183729.GA23068@pd.tnic>
References: <1407209178-18644-1-git-send-email-jiang.liu@linux.intel.com>
 <1407209178-18644-2-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1407209178-18644-2-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 05, 2014 at 11:26:17AM +0800, Jiang Liu wrote:
> Now IOAPIC driver dynamically allocates IRQ numbers for IOAPIC pins.
> We need to keep IRQ assignment for PCI devices during suspend/hibernation,
> otherwise it may cause failure of suspend/hibernation due to:
> 1) Device driver calls pci_enable_device() to allocate an IRQ number
>    and register interrupt handler on the returned IRQ.
> 2) Device driver's suspend callback calls pci_disable_device() and
>    release assigned IRQ in turn.
> 3) Device driver's resume callback calls pci_enable_device() to
>    allocate IRQ number again. A different IRQ number may be assigned
>    by IOAPIC driver this time.
> 4) Now the hardware delivers interrupt to the new IRQ but interrupt
>    handler is still registered against the old IRQ, so it breaks
>    suspend/hibernation.
> 
> To fix this issue, we keep IRQ assignment during suspend/hibernation.
> Flag pci_dev.dev.power.is_prepared is used to detect that
> pci_disable_device() is called during suspend/hibernation.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
> Hi Borislav,
> 	Could you please help to review the patch again since I have
> made changes against the previous version?

I think you're asking me to test that patch, correct?

If so, what is the exact tree I need to apply? tip/x86/apic + those two
patches here? What else? What about the USB chunk which removes the proc
splat, is that somewhere too? Maybe Linus did pull it already?

Please specify what exactly I should test.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
