Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:1327 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbcBHQVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2016 11:21:12 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>,
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
Subject: RE: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
 Controllers
Date: Mon, 8 Feb 2016 16:20:55 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD0C2@lhreml503-mbs>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
 <1930535.mkCdtpUWq7@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECAC944@lhreml503-mbs>
 <7297343.ktGck3KQJN@wuerfel> <56B8A214.8040203@codeaurora.org>
In-Reply-To: <56B8A214.8040203@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd, Sinan

> -----Original Message-----
> From: Sinan Kaya [mailto:okaya@codeaurora.org]
> Sent: 08 February 2016 14:12
> To: Arnd Bergmann; linux-arm-kernel@lists.infradead.org
> Cc: Gabriele Paoloni; Lorenzo.Pieralisi@arm.com; jcm@redhat.com;
> tn@semihalf.com; linux-pci@vger.kernel.org; Linuxarm; xuwei (O); linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Wangzhou (B);
> liudongdong (C); Guohanjun (Hanjun Guo); bhelgaas@google.com;
> zhangjukuo; Liguozhu (Kenneth); qiujiang
> Subject: Re: [RFC PATCH 0/4] Add ACPI support for HiSilicon PCIe Host
> Controllers
> 
> On 2/8/2016 8:55 AM, Arnd Bergmann wrote:
> > I haven't really followed what is going on with ACPI. Do you expect
> > to see future machines come out that are not just implementing SBSA
> > but that still need to run ACPI? I thought this was just a hack
> > for some early machines that only run with ACPI but are not actually
> > compliant.

Well from our side (HiSilicon) we're trying to move away from non fully 
ECAM platforms, so from us in the long term I don't expect too many quirks,
but I don't know about the other vendors.

Obviously the reason why Tomasz implemented the quirks is to fit non 
fully ECAM HW and to allow custom HW init; this is why I thought better
to have the ACPI version in the same dir as the DT (maybe we can create 
an ACPI sub-dir in drivers/pci/host ?)


> >
> > 	Arnd
> 
> I agree. We shouldn't be playing with half-baked ACPI solutions. We
> have seen
> two variants already that claim to be ACPI compliant yet they do not
> tie into
> anything inside ACPICA.
> 
> The correct route is to use Tomasz's ACPI PCI root bridge driver and
> use the ACPI
> framework.
> 
> If a platform has quirks, Tomasz's patches allow vendors add quirks
> too.
> 
> The combination of PCI host bridge driver + ACPI hack is not right.

If you look at my patchset  you can see that I didn't do any hack,

I just used the framework provided by Tomasz patchset.

The discussion here is more about the code location for the quirks.
Since the configuration read/write and the HW init sequences can be
similar between the ACPI variant and DT variant I thought it make 
sense to have them in "drivers/pci/host"

Thanks

Gab

> 
> --
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center,
> Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
