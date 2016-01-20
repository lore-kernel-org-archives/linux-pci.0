Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45111 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933215AbcATMhL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Jan 2016 07:37:11 -0500
Date: Wed, 20 Jan 2016 12:38:49 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V3 11/21] pci, acpi: Move ACPI host bridge device
 companion assignment to core code.
Message-ID: <20160120123849.GA13437@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-12-git-send-email-tn@semihalf.com>
 <20160119160224.GD5276@red-moon>
 <569F6D67.5000000@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <569F6D67.5000000@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 20, 2016 at 12:20:07PM +0100, Tomasz Nowicki wrote:
> On 19.01.2016 17:02, Lorenzo Pieralisi wrote:
> >On Wed, Jan 13, 2016 at 02:20:57PM +0100, Tomasz Nowicki wrote:
> [...]
> >>device via pci_create_root_bus parameter (as the ACPI device type)
> >
> >I do not understand what you mean by "as the ACPI device type".
> 
> See below.
> 
> >
> >>and using ACPI_COMPANION_SET in core code for ACPI boot method.
> >>ACPI_COMPANION_SET is safe to run for all cases DT, ACPI and DT&ACPI.
> >>
> >>Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >>---
> >>  drivers/acpi/pci_root.c | 5 ++++-
> >>  drivers/pci/probe.c     | 2 ++
> >>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >>index ae3fe4e..a65c8c2 100644
> >>--- a/drivers/acpi/pci_root.c
> >>+++ b/drivers/acpi/pci_root.c
> >>@@ -846,7 +846,10 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >>
> >>  	pci_acpi_root_add_resources(info);
> >>  	pci_add_resource(&info->resources, &root->secondary);
> >>-	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
> >>+
> >>+	/* Root bridge device needs to be sure of parent ACPI type */
> >>+	ACPI_COMPANION_SET(&device->dev, device);
> >
> >I do not understand why the code above is needed, can you elaborate
> >please ?
> >
> 
> This makes sure that device->dev can be identified as ACPI device,
> so we can use to_acpi_device_node() and assign companion safely
> below.

I do not follow. If you refer to the fwnode handle type, that is
already set by ACPI core code (before acpi_pci_root_add() is called,
in acpi_init_device_object()).

Did you add the code above to solve a real issue you encountered ?

Thanks,
Lorenzo
