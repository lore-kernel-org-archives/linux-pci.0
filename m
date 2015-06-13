Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <557C5F29.7010301@linux.intel.com>
Date: Sun, 14 Jun 2015 00:49:45 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>
CC: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [RFC v1 14/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-15-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201724260.4225@nanos> <555CA834.7080807@linux.intel.com> <alpine.DEB.2.11.1505201750280.4225@nanos> <alpine.DEB.2.10.1506131059180.2486@hadrien> <alpine.DEB.2.11.1506131130490.3786@nanos> <alpine.DEB.2.10.1506131603151.2314@hadrien> <alpine.DEB.2.10.1506131652380.2314@hadrien>
In-Reply-To: <alpine.DEB.2.10.1506131652380.2314@hadrien>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/13 22:53, Julia Lawall wrote:
> Better formatted diff.
Great thanks to you, Julia!
It seems really attractively, I will try to figure out
whether I have caught all the cases.

BTW, a new version of these patch set has been posted at:
http://comments.gmane.org/gmane.linux.kernel.pci/42320

I have also push the new version to github in case you need
to access it:
 https://github.com/jiangliu/linux.git irq:irqdesc_v2

Thanks!
Gerry
