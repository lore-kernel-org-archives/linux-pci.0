Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48326 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932228AbcBANcn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Feb 2016 08:32:43 -0500
Date: Mon, 1 Feb 2016 13:34:37 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Mark Salter <msalter@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: ACPI: IA64: fix IO port generic range check
Message-ID: <20160201133437.GD10764@red-moon>
References: <1454322357-10912-1-git-send-email-lorenzo.pieralisi@arm.com>
 <56AF4359.1020709@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AF4359.1020709@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 01, 2016 at 07:36:57PM +0800, Hanjun Guo wrote:

[...]

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

Thanks, I will fix it, it is a leftover.

> By the way, I tested this patch both on x86 and ia64 box,
> and PCI for both box is working properly after boot,
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thank you very much !

Lorenzo
