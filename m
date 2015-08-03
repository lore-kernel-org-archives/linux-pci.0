Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Aug 2015 21:43:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jake Oshins <jakeo@microsoft.com>
cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: RE: [PATCH 4/4] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
In-Reply-To: <DM2PR0301MB1232A1E50FA39BEAB5707FEDAB770@DM2PR0301MB1232.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508032142500.3825@nanos>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com> <1438476889-19220-5-git-send-email-jakeo@microsoft.com> <alpine.DEB.2.11.1508020948470.3825@nanos> <DM2PR0301MB1232A1E50FA39BEAB5707FEDAB770@DM2PR0301MB1232.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 3 Aug 2015, Jake Oshins wrote:

> I do have a question about your last point, though.  If I build this
> into the kernel, it will need to depend on sending and receiving
> messages through the hv_vmbus driver, which isn't built in.  It

Fair enough. I missed that detail.

> seemed like the indirection and glue code necessary to make that
> work would be almost as big as this entire implementation (which
> admittedly isn't very big.)  If you prefer that, I'll do it.  But it
> would make more sense to me to refactor this a bit more so that
> functions like the one above are exported rather than putting
> hv_pcie_init_irq_domain and hv_pcie_free_irq_domain into the kernel
> itself.  Would that work?

Yes.

Thanks,

	tglx
