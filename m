Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
 Controllers
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
 <1930535.mkCdtpUWq7@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECAC944@lhreml503-mbs>
 <7297343.ktGck3KQJN@wuerfel>
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56B8A214.8040203@codeaurora.org>
Date: Mon, 8 Feb 2016 09:11:32 -0500
MIME-Version: 1.0
In-Reply-To: <7297343.ktGck3KQJN@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/8/2016 8:55 AM, Arnd Bergmann wrote:
> I haven't really followed what is going on with ACPI. Do you expect
> to see future machines come out that are not just implementing SBSA
> but that still need to run ACPI? I thought this was just a hack
> for some early machines that only run with ACPI but are not actually
> compliant.
> 
> 	Arnd

I agree. We shouldn't be playing with half-baked ACPI solutions. We have seen
two variants already that claim to be ACPI compliant yet they do not tie into
anything inside ACPICA. 

The correct route is to use Tomasz's ACPI PCI root bridge driver and use the ACPI
framework.

If a platform has quirks, Tomasz's patches allow vendors add quirks too.

The combination of PCI host bridge driver + ACPI hack is not right.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
