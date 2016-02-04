Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: guohanjun@huawei.com, wangzhou1@hisilicon.com,
	liudongdong3@huawei.com, linuxarm@huawei.com, qiujiang@huawei.com,
	bhelgaas@google.com, Lorenzo.Pieralisi@arm.com, tn@semihalf.com,
	zhangjukuo@huawei.com, xuwei5@hisilicon.com,
	liguozhu@hisilicon.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jcm@redhat.com
Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host Controllers
Date: Thu, 04 Feb 2016 14:11:32 +0100
Message-ID: <2387127.DMZaDnZvEW@wuerfel>
In-Reply-To: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 February 2016 19:37:36 Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patchset adds ACPI support for the HiSilicon Hip05/Hip06 SoC PCIe controllers
> The four patches respectively:
>         - rework PCie Designware to be used for ACPI PCI Host controllers
>         - re-architect the current HiSilicon driver to make it scalable to the
>           new ACPI quirks
>         - rework the current HiSilicon driver to make it ECAM compliant
>         - adds the HiSilicon ACPI specific quirks.
> 
>    This patchset  is based on 
>    https://github.com/semihalf-nowicki-tomasz/linux.git
>    branch pci-acpi-v3 + Hip06 support applied on top:
>    https://patchwork.ozlabs.org/patch/549198/
> 

ACPI has its own PCI support, and should not need drivers for host
bridges. I don't think we can really mix the two things, as ACPI
needs to have access to things like PCI config space way before
we are probing normal device drivers.

Please put this in drivers/acpi/pci*.c.

	Arnd
