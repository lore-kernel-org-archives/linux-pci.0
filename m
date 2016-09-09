Return-Path: <bp@alien8.de>
Return-Path: <bp@alien8.de>
Date: Sat, 10 Sep 2016 00:07:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Rui Wang <rui.y.wang@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, helgaas@kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	rjw@rjwysocki.net, tony.luck@intel.com,
	Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: 584c5c422f6c ("x86/ioapic: Support hot-removal of IOAPICs present
 during boot")
Message-ID: <20160909220710.etdw5zzubb72xv53@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi,

commit in $Subject from tip breaks booting on my SNB test box,
it freezes somewhere very early during boot. When I revert the
aforementioned commit ontop of Linus' master + tip/master from today, it
boots fine.

Additional info is available upon request.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
