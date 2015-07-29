Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Jul 2015 15:54:17 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
Message-ID: <20150729205417.GD9640@google.com>
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
 <1433780448-18636-5-git-send-email-jiang.liu@linux.intel.com>
 <20150609161230.GC8591@red-moon>
 <55771B27.1060509@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55771B27.1060509@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 10, 2015 at 12:58:15AM +0800, Jiang Liu wrote:
> On 2015/6/10 0:12, Lorenzo Pieralisi wrote:
> > On Mon, Jun 08, 2015 at 05:20:46PM +0100, Jiang Liu wrote:

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

I agree we should drop the segment and node parameters.  Having the
information in two places means we can make a mistake, and we can easily
avoid that possibility by only keeping it in one place.

I think it is a bug that we don't set root->segment to zero when we have
pci_ignore_seg.  Sorry, that's my fault from 1f09b09b4de0 ("x86/PCI: Ignore
_SEG on HP xw9300").

I don't understand the issue about overriding the node number.  Can you
explain it?
