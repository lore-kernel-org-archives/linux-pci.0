Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 12 Jun 2015 22:35:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Julia Lawall <julia.lawall@lip6.fr>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.02.1506122224230.2010@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.11.1506122232510.3786@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos>
 <alpine.DEB.2.10.1505202155420.2642@hadrien> <alpine.DEB.2.11.1505202209470.4225@nanos> <alpine.DEB.2.10.1505202215230.2642@hadrien> <alpine.DEB.2.11.1505202219290.4225@nanos> <alpine.DEB.2.02.1506122224230.2010@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 12 Jun 2015, Julia Lawall wrote:
> What is the status of this?  I am close to having a semantic patch that 
> works.  The current version touches 133 files, but I haven't checked all 
> of them.  This includes both the local functions and the generic ones, but 
> not the cases where the name of the handler function is a local variable 
> or arbitrary expression.  This occurs in around 30 files.

Jiang sent out a new patch series, but I'm really interested in doing
a fully automated check. If conversion is possible for some of them,
fine, but the checking part to find all the places where this needs to
be applied is the most important to me.

If you want, just send me that script and I'll give it a test ride.

Thanks,

	tglx
