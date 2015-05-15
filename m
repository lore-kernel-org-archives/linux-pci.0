Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 15 May 2015 22:44:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Grant Likely <grant.likely@linaro.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC v1 03/11] genirq: Use CONFIG_NUMA instead of CONFIG_SMP to
 guard irq_common_data.node
In-Reply-To: <1430709339-29083-4-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505152243310.4225@nanos>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com> <1430709339-29083-4-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 4 May 2015, Jiang Liu wrote:

> NUMA is enabled by CONFIG_NUMA instead of CONFIG_SMP, so use CONFIG_NUMA
> to guard irq_common_data.node.

Please move this change to the front and do it on irq_data. That would
have avoided confusing Abel :)

Thanks,

	tglx
