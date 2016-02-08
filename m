Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	guohanjun@huawei.com, wangzhou1@hisilicon.com,
	liudongdong3@huawei.com, linuxarm@huawei.com, qiujiang@huawei.com,
	bhelgaas@google.com, Lorenzo.Pieralisi@arm.com, tn@semihalf.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuwei5@hisilicon.com, linux-acpi@vger.kernel.org, jcm@redhat.com,
	zhangjukuo@huawei.com, liguozhu@hisilicon.com
Subject: Re: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host controller ECAM compliant
Date: Mon, 08 Feb 2016 14:48:18 +0100
Message-ID: <3532826.pJr5R5Xa4c@wuerfel>
In-Reply-To: <1454935264-6076-3-git-send-email-gabriele.paoloni@huawei.com>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com> <1454935264-6076-3-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 February 2016 12:41:03 Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patch modifies the current Hip05/Hip06 PCIe host controller
> driver to make it ECAM compliant. This is needed in preparation
> for the ACPI based driver to allow both DT and ACPI drivers to
> use the same BIOS (that configure the Designware iATUs).
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> 

Doesn't this break backwards compatibility?

I think you need to use a new compatible string in the firmware
if you change the register layout, and then change the driver
to support both the old and the new layout.

	Arnd
