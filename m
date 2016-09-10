Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: bp@alien8.de
Cc: bhelgaas@google.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	helgaas@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rjw@rjwysocki.net,
	tony.luck@intel.com,
	mingo@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Rui Wang <rui.y.wang@intel.com>
Subject: 584c5c422f6c ("x86/ioapic: Support hot-removal of IOAPICs present during boot")
Date: Sat, 10 Sep 2016 08:14:04 +0800
Message-Id: <1473466444-25519-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160909220710.etdw5zzubb72xv53@pd.tnic>
References: <20160909220710.etdw5zzubb72xv53@pd.tnic>
List-ID: <linux-pci.vger.kernel.org>

On Saturday, September 10, 2016 6:07 AM, Borislav Petkov wrote:
> 
> Hi,
> 
> commit in $Subject from tip breaks booting on my SNB test box, it freezes
> somewhere very early during boot. When I revert the aforementioned
> commit ontop of Linus' master + tip/master from today, it boots fine.
> 
> Additional info is available upon request.
> 

Hi Boris,

Is it a Romley-EP ? What kind of SNB box is it? I'll try to find one
to reproduce the problem.

Thanks
Rui
