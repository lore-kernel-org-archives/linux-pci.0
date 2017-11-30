Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Nov 2017 23:08:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-pci@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] PCI: Tone down resource mmap warning
Message-ID: <20171130050822.GA32384@bhelgaas-glaptop.roam.corp.google.com>
References: <20171129225708.32271.35467.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171130013801.m4tiq5m47ogw3huk@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171130013801.m4tiq5m47ogw3huk@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 30, 2017 at 09:38:01AM +0800, Fengguang Wu wrote:
> This is perhaps the most clean solution. Thank you for the patch!  -fengguang

After thinking about it some more, I think we should just remove the
printk altogether.  I suspect it was added with the thought that it
would help debug the e1000e NVRAM corruption problem.  But in general,
we don't log messages when system calls fail, and I don't know why
this one should be special.

> On Wed, Nov 29, 2017 at 04:57:08PM -0600, Bjorn Helgaas wrote:
> >From: Bjorn Helgaas <bhelgaas@google.com>
> >
> >When a process tries to mmap more space than is available in a PCI BAR, we
> >emit a warning and a backtrace.  The mmap fails anyway, so the backtrace is
> >mainly for debugging.  It seems like overkill now, so reduce this to a
> >dev_info() and remove the backtrace.
> >
> >This was added by b5ff7df3df9e ("Check mapped ranges on sysfs resource
> >files").
> >
> >Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> >Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >---
> >drivers/pci/pci-sysfs.c |    6 ++----
> >1 file changed, 2 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> >index 06c7f0b85cd2..97f071674605 100644
> >--- a/drivers/pci/pci-sysfs.c
> >+++ b/drivers/pci/pci-sysfs.c
> >@@ -1217,11 +1217,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
> >		return -EINVAL;
> >
> >	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS)) {
> >-		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
> >+		dev_info(&pdev->dev, "process \"%s\" tried to map 0x%lx bytes at page 0x%lx of BAR %d %pR\n",
> >			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
> >-			pci_name(pdev), bar,
> >-			(u64)pci_resource_start(pdev, bar),
> >-			(u64)pci_resource_len(pdev, bar));
> >+			bar, res);
> >		return -EINVAL;
> >	}
> >	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
> >
