Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	Linuxarm <linuxarm@huawei.com>, qiujiang <qiujiang@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"jcm@redhat.com" <jcm@redhat.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: RE: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
 controller ECAM compliant
Date: Mon, 8 Feb 2016 15:55:35 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECACF44@lhreml503-mbs>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <1454935264-6076-3-git-send-email-gabriele.paoloni@huawei.com>
 <3532826.pJr5R5Xa4c@wuerfel>
In-Reply-To: <3532826.pJr5R5Xa4c@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 08 February 2016 13:48
> To: linux-arm-kernel@lists.infradead.org
> Cc: Gabriele Paoloni; Guohanjun (Hanjun Guo); Wangzhou (B); liudongdong
> (C); Linuxarm; qiujiang; bhelgaas@google.com;
> Lorenzo.Pieralisi@arm.com; tn@semihalf.com; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; xuwei (O); linux-acpi@vger.kernel.org;
> jcm@redhat.com; zhangjukuo; Liguozhu (Kenneth)
> Subject: Re: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
> controller ECAM compliant
> 
> On Monday 08 February 2016 12:41:03 Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> >
> > This patch modifies the current Hip05/Hip06 PCIe host controller
> > driver to make it ECAM compliant. This is needed in preparation
> > for the ACPI based driver to allow both DT and ACPI drivers to
> > use the same BIOS (that configure the Designware iATUs).
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >
> 
> Doesn't this break backwards compatibility?

Well Hip05/Hip06 SoCs are used into evaluation boards
For the Estuary project.

https://github.com/hisilicon/estuary

As this new driver gets upstream we'll merge this new driver into estuary
and release a new version of the firmware to support it.

> 
> I think you need to use a new compatible string in the firmware
> if you change the register layout, and then change the driver
> to support both the old and the new layout.

You are right, for some reason in this patchset I missed the Documentation
update that I posted in the previous one, i.e.:

--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -23,8 +23,8 @@ Optional properties:
 Hip05 Example (note that Hip06 is the same except compatible):
 	pcie@0xb0080000 {
 		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
-		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
-		reg-names = "rc_dbi", "config";
+		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00100000 0 0x0f00000>;
+		reg-names = "rc_dbi", "ecam-cfg";

I will fix this in v3

Thanks

Gab 


> 
> 	Arnd
