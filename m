Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Mon, 12 Sep 2016 15:46:15 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Wang, Rui Y" <rui.y.wang@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/ioapic: Ignore root bridges without a companion ACPI
 device
Message-ID: <20160912214614.GA1891@localhost.localdomain>
References: <1473522046-31329-1-git-send-email-rui.y.wang@intel.com>
 <20160912212537.GA1740@localhost.localdomain>
 <3908561D78D1C84285E8C5FCA982C28F3A1C7E09@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F3A1C7E09@ORSMSX114.amr.corp.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 12, 2016 at 03:43:23PM -0600, Luck, Tony wrote:
> > What branch is this based on? I can't find the relevant code/commits
> 
> tip tree. branch x86/apic
> 
> -Tony

Cheers!
