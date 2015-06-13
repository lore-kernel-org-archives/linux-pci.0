Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 13 Jun 2015 11:00:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Thomas Gleixner <tglx@linutronix.de>
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
	linux-acpi@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <alpine.DEB.2.11.1505201750280.4225@nanos>
Message-ID: <alpine.DEB.2.10.1506131059180.2486@hadrien>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com>
 <alpine.DEB.2.11.1505201750280.4225@nanos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>     unsigned irq = irq_desc_get_irq(desc);

Actually, it seems that this function doesn't exist in linux-next either.
What is the correct name of the function, or is there some other tree that
I should be working on?

thanks,
julia
