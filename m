Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Mon, 12 Sep 2016 15:25:38 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Rui Wang <rui.y.wang@intel.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, rjw@rjwysocki.net,
	mingo@kernel.org, bp@alien8.de, torvalds@linux-foundation.org,
	peterz@infradead.org, helgaas@kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioapic: Ignore root bridges without a companion ACPI
 device
Message-ID: <20160912212537.GA1740@localhost.localdomain>
References: <1473522046-31329-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473522046-31329-1-git-send-email-rui.y.wang@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 10, 2016 at 11:40:45PM +0800, Rui Wang wrote:
> Some PCI root bridges don't have a corresponding ACPI device.
> This can be the case on some old platforms. Don't call acpi_ioapic_add()
> on these bridges because they can't support ioapic hotplug.
Not just old platforms. VMD is a new device which initializes a root port in software without an acpi handle.

What branch is this based on? I can't find the relevant code/commits
