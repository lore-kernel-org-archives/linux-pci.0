Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50679 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753790AbbDGLYe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Apr 2015 07:24:34 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 0/7] Consolidate common ACPI PCI host bridge code into ACPI core
Date: Tue, 07 Apr 2015 13:48:57 +0200
Message-ID: <1602543.J47QWOMlgo@vostro.rjw.lan>
In-Reply-To: <1428381072-27486-1-git-send-email-jiang.liu@linux.intel.com>
References: <1428381072-27486-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 07, 2015 12:31:05 PM Jiang Liu wrote:
> As suggested by Bjorn, this patch set consolidates common ACPI PCI host
> bridge code from x86 and IA64 into ACPI core. It may also help to
> support ACPI PCI host bridge on ARM64 platfrom too in future.
> 
> It introduces struct acpi_pci_root_ops and acpi_pci_root_create().
> Arch code only needs to implement struct acpi_pci_root_ops and then
> invoke acpi_pci_root_create() to parse ACPI resources and create
> PCI root bus.
> struct acpi_pci_root_info_common {
>         struct pci_controller           controller;
>         struct acpi_pci_root            *root;
>         struct acpi_device              *bridge;
>         struct acpi_pci_root_ops        *ops;
>         struct list_head                resources;
>         char                            name[16];
> };
> struct acpi_pci_root_ops {
> 	struct pci_ops *pci_ops;
> 	int (*init_info)(struct acpi_pci_root_info_common *info);
> 	void (*release_info)(struct acpi_pci_root_info_common *info);
> 	int (*prepare_resources)(struct acpi_pci_root_info_common *info,
> 				 int status);
> };
> extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> 					    struct acpi_pci_root_ops *ops,
> 					    size_t extra_size);
> It passes Fengguang's 0day test suite and has been tested on 
> 1) An Intel x86 4 socket platform
> 2) An Intel IA64 SDV
> 3) An HP IA64 platform
> 
> And you may access it at:
> https://github.com/jiangliu/linux.git acpi_pci_root_v1
> 
> Thanks!
> Gerry
> 
> Jiang Liu (7):
>   ACPI/PCI: Enhance ACPI core to support sparse IO space
>   ia64/PCI/ACPI: Use common ACPI resource parsing interface for host
>     bridge
>   ia64/PCI: Use common struct resource_entry to replace struct
>     iospace_resource
>   x86/PCI: Rename struct pci_sysdata as struct pci_controller
>   PCI/ACPI: Consolidate common PCI host bridge code into ACPI core
>   x86/PCI/ACPI: Use common interface to support PCI host bridge
>   ia64/PCI/ACPI: Use common interface to support PCI host bridge
> 
>  arch/ia64/include/asm/pci.h   |    5 -
>  arch/ia64/pci/pci.c           |  360 ++++++++++-------------------------------
>  arch/x86/include/asm/pci.h    |   12 +-
>  arch/x86/include/asm/pci_64.h |    4 +-
>  arch/x86/pci/acpi.c           |  283 +++++++++-----------------------
>  arch/x86/pci/common.c         |    2 +-
>  drivers/acpi/pci_root.c       |  215 ++++++++++++++++++++++++
>  drivers/acpi/resource.c       |    9 +-
>  include/linux/ioport.h        |    1 +
>  include/linux/pci-acpi.h      |   24 +++
>  10 files changed, 409 insertions(+), 506 deletions(-)

That's generally fine by me, but let's fix the resources issue first, shall we?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
