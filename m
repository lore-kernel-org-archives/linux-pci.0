Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 15 May 2015 22:42:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Grant Likely <grant.likely@linaro.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [RFC v1 02/11] genirq: Move field 'node' from struct irq_data
 into struct irq_common_data
In-Reply-To: <1430709339-29083-3-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505152240280.4225@nanos>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com> <1430709339-29083-3-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 4 May 2015, Jiang Liu wrote:

> NUMA node information is per-irq instead of per-irqchip, so move it into
> struct irq_common_data.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/sh/kernel/irq.c          |    2 +-
>  arch/x86/kernel/apic/vector.c |    8 ++++----
>  arch/x86/platform/uv/uv_irq.c |    2 +-
>  include/linux/irq.h           |   20 ++++++++++++++++++--
>  kernel/irq/internals.h        |    5 +++++
>  kernel/irq/irqdesc.c          |   10 ++--------
>  kernel/irq/irqdomain.c        |    4 ++--
>  kernel/irq/manage.c           |    2 +-
>  kernel/irq/proc.c             |    2 +-

Can you please split this into several patches for review and
bisection sake?

    1) Do the cleanup of s/data->node/irq_data_get_node(data)/

       1 a) core code
       1 b) arch/sh
       1 c) arch/x86

    2) Do the actual move of node to common_data

Thanks,

	tglx
