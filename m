Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 16 Dec 2015 14:05:56 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Jayachandran C." <jchandra@broadcom.com>, tn@semihalf.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
	arnd@arndb.de, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
Message-ID: <20151216140556.GC22916@red-moon>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <20151207203117.GB14429@localhost>
 <20151209100125.GA12632@jayachandranc.netlogicmicro.com>
 <20151209155511.GB21048@red-moon>
 <20151216125136.GE5890@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151216125136.GE5890@jayachandranc.netlogicmicro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 16, 2015 at 06:21:37PM +0530, Jayachandran C. wrote:

[...]

> > That list is there to manage hotplug bridges, what makes you think
> > it is not necessary ? Jiang (in CC) can certainly comment on that and
> > how that list handling can be updated/simplified, if possible.
> 
> Looking thru the code, I think moving the MCFG code to common can be
> done in a simpler way. I have posted a new patchset for this.
> (And I don't see how the hotplug case needs the list, but that is not
>  relevant now)

You must work with Tomasz and come up with a unified patchset that
implements ACPI PCIe support for ARM64. We do not need more churn, we
need a working set, period. Posting separate RFCs just adds to the
confusion and to maintainers' review backlog, with the end result of
confusing everyone and achieving nothing.

Lorenzo
