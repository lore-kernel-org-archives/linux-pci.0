Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
	"jcm@redhat.com" <jcm@redhat.com>,
	"tn@semihalf.com" <tn@semihalf.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	"Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	qiujiang <qiujiang@huawei.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host Controllers
Date: Mon, 08 Feb 2016 14:55:11 +0100
Message-ID: <7297343.ktGck3KQJN@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAC944@lhreml503-mbs>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com> <1930535.mkCdtpUWq7@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1ECAC944@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 08 February 2016 13:17:58 Gabriele Paoloni wrote:
> 
> Now I have removed the dependency from designware but I still think
> the best location for the code is in "drivers/pci/host/":
> the ACPI quirks share the config read/write functions with the DT
> driver, moreover for other hosts in future I think it makes sense
> to stay in "drivers/pci/host/" as they could even share more init
> code with their respective DT versions...

I haven't really followed what is going on with ACPI. Do you expect
to see future machines come out that are not just implementing SBSA
but that still need to run ACPI? I thought this was just a hack
for some early machines that only run with ACPI but are not actually
compliant.

	Arnd
