Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Jun 2015 18:53:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Paul Mackerras <paulus@samba.org>,
	Chris Metcalf <cmetcalf@ezchip.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tejun Heo <tj@kernel.org>, Joe Perches <joe@perches.com>,
	linux-ia64@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,33/36] genirq: Use helper function to access
 irq_data->msi_desc
In-Reply-To: <20150602034507.1BBCB1412F1@ozlabs.org>
Message-ID: <alpine.DEB.2.11.1506031850340.31424@nanos>
References: <20150602034507.1BBCB1412F1@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2 Jun 2015, Michael Ellerman wrote:
> Though I would point out we already have 16 irq_foo_get_bar() accessors?!

Say thanks to the people who mindlessly fiddled in the core managed
fields of irqdesc and irqdata. The hard to track down wreckage they
caused me to enforce accessors.

The new accessors are to help migrating members of irq_data to a new
data structure without breaking the world and some more.

Thanks,

	tglx


