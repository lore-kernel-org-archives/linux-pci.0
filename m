Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host Controllers
Date: Thu, 04 Feb 2016 18:01:51 +0100
Message-ID: <1930535.mkCdtpUWq7@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EF4B@lhreml503-mbs>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com> <76564455.dlc1WHiVY2@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1EC9EF4B@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 February 2016 16:44:12 Gabriele Paoloni wrote:
> Effectively the ACPI version of the HiSilicon driver does not rely on
> Designware as much as the DT version (that calls dw_pcie_host_init());
> however in order to do what you suggest I'd need to copy and paste and
> modify dw_pcie_rd_conf and dw_pcie_wr_conf.
> Also I'd need to declare duplicate version of the functions in
> pcie-hisi-common.c (if I do not want to split the object across
> different paths "drivers/pci/host" and "drivers/acpi/")
> 
> Now I can do it but I thought it was more correct to pass &dw_pcie_ops
> as input pointer in DECLARE_ACPI_MCFG_FIXUP(); this is also because maybe in
> future other Designware based controllers may need to support ACPI and it
> would be easier for them to reuse their DT based driver functions
> 
> Honestly I am a bit confused...
> 

I don't think you can use the dw_pcie_ops as-is anyway, as they in
turn rely on the device driver structure, and you also don't need
those as they seem to be written for the generic case of a 32-bit
architecture that does not have enough space to map the entire
config space into MMIO. Just set up all those mapping registers from
the firmware and pass the config space base address as you'd normally
do on ACPI.

	Arnd
