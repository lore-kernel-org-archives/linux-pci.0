Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 9 Feb 2016 14:57:04 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Hanjun Guo <hanjun.guo@linaro.org>, Tony Luck <tony.luck@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Mark Salter <msalter@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: ACPI: IA64: fix IO port generic range check
Message-ID: <20160209145704.GA22868@red-moon>
References: <1454322357-10912-1-git-send-email-lorenzo.pieralisi@arm.com>
 <56AF4359.1020709@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AF4359.1020709@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Mon, Feb 01, 2016 at 07:36:57PM +0800, Hanjun Guo wrote:
> On 2016/2/1 18:25, Lorenzo Pieralisi wrote:
> >The [0 - 64k] ACPI PCI IO port resource boundary check in:
> >
> >acpi_dev_ioresource_flags()
> >
> >is currently applied blindly in the ACPI resource parsing to all
> >architectures, but only x86 suffers from that IO space limitation.
> >The check in generic ACPI code leaves other arches (ie IA64) IO space
> >broken (ie kernel can't claim IO resources since the host bridge
> >IO resource is disabled and discarded by ACPI core code, eg log on
> >IA64):
> >
> >pci 0000:00:03.0: [1002:515e] type 00 class 0x030000
> >
> >pci 0000:00:03.0: reg 0x10: [mem 0x80000000-0x87ffffff pref]
> >
> >pci 0000:00:03.0: reg 0x14: [io  0x1000-0x10ff]
> >
> >pci 0000:00:03.0: reg 0x18: [mem 0x88020000-0x8802ffff]
> >
> >pci 0000:00:03.0: reg 0x30: [mem 0x88000000-0x8801ffff pref]
> >
> >pci 0000:00:03.0: supports D1 D2
> >
> >pci 0000:00:03.0: can't claim BAR 1 [io  0x1000-0x10ff]: no compatible
> >bridge window
> >
> >For this reason, the IO port resources boundaries check in generic ACPI
> >parsing code should be moved to x86 arch code so that more arches (ie
> >ARM64) can benefit from the generic ACPI resources parsing interface
> >without incurring in unexpected resource filtering, fixing at the same
> >time current breakage on IA64.
> >
> >This patch moves the IO ports boundary [0 - 64k] check to x86 arch code
> >code that validates the PCI host bridge resources.
> >
> >Fixes: 3772aea7d6f3 ("ia64/PCI/ACPI: Use common ACPI resource parsing
> >interface for host bridge")
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Bjorn Helgaas <bhelgaas@google.com>
> >Cc: Hanjun Guo <hanjun.guo@linaro.org>
> >Cc: Jiang Liu <jiang.liu@linux.intel.com>
> >Cc: Tony Luck <tony.luck@intel.com>
> >Cc: Tomasz Nowicki <tn@semihalf.com>
> >Cc: Mark Salter <msalter@redhat.com>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >---
> >  arch/x86/pci/acpi.c     | 18 +++++++++++++-----
> >  drivers/acpi/resource.c |  3 ---
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> >index 3cd6983..e20dbe5 100644
> >--- a/arch/x86/pci/acpi.c
> >+++ b/arch/x86/pci/acpi.c
> >@@ -275,11 +275,14 @@ static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
> >   *     to access PCI configuration space.
> >   *
> >   * So explicitly filter out PCI CFG IO ports[0xCF8-0xCFF].
> >+ *
> >+ * Furthermore, IO ports address space is limited to 16k on x86,
> 
> Minor typo for '16k', should be '64k'? or we can just specify
> the magic number 0x10003?
> 
> By the way, I tested this patch both on x86 and ia64 box,
> and PCI for both box is working properly after boot,
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Any comment on this patch ? It actually fixes IO space on IA64
as described in the commit log, it would be good if IA64 folks
can confirm.

I need to update a comment but would like to check first if the fix
itself is ok.

Thanks a lot,
Lorenzo
