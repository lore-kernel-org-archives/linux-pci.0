Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 Jun 2015 17:48:22 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86 @ kernel . org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v5 4/6] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
Message-ID: <20150610164821.GA18832@red-moon>
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
 <1433780448-18636-5-git-send-email-jiang.liu@linux.intel.com>
 <20150609161230.GC8591@red-moon>
 <55771B27.1060509@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55771B27.1060509@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 05:58:15PM +0100, Jiang Liu wrote:
> On 2015/6/10 0:12, Lorenzo Pieralisi wrote:

[...]

> >> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >> +				     struct acpi_pci_root_ops *ops,
> >> +				     struct acpi_pci_root_info *info,
> >> +				     void *sysdata, int segment, int node)
> > 
> > I do not think you need to pass segment and node, they clutter the
> > function signature when you can retrieve them from root, I would
> > make them local variables and use root->segment and acpi_get_node
> > in the function body to retrieve them.
> On x86, node and segment may be overridden under certain conditions.
> For example, segment will always be 0 if 'pci_ignore_seg' is set.

Ok, so the question would be then why do you not override the value
in root->segment then (actually, is it *correct* to leave the segment
value in root-> unchanged even if it is overriden) ?

Anyway, node is just used for a printk, why do not you add segment and
node to acpi_pci_root_info ? Just cosmetic stuff, trying to help you
simplify the code, it is not easy to parse.

Thanks,
Lorenzo
