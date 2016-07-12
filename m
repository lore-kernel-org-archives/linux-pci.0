Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Tue, 12 Jul 2016 10:35:15 +0200
Message-ID: <3580311.QdyhSxNzVU@wuerfel>
In-Reply-To: <1468291344-122909-4-git-send-email-liudongdong3@huawei.com>
References: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com> <1468291344-122909-4-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 12, 2016 10:42:24 AM CEST Dongdong Liu wrote:
>  MAINTAINERS                       |   1 +
>  drivers/pci/host/Kconfig          |   7 ++
>  drivers/pci/host/Makefile         |   1 +
>  drivers/pci/host/mcfg-quirks.c    |   8 ++
>  drivers/pci/host/mcfg-quirks.h    |   8 ++
>  drivers/pci/host/pcie-hisi-acpi.c | 151 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pcie-hisi.c      |   2 -
>  drivers/pci/host/pcie-hisi.h      |   2 +
>  8 files changed, 178 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
> 
> 

Please keep the quirks separate from the PCI host drivers.

The ACPI code includes its own host driver and the only thing
you need to override here is the config space access, so just put that
into drivers/acpi/

	Arnd
