Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:63143
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752398AbcI1FpL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Sep 2016 01:45:11 -0400
From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "holler@ahsoftware.de" <holler@ahsoftware.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: ATA failure regression
Date: Wed, 28 Sep 2016 05:45:08 +0000
Message-ID: <MWHPR12MB177486F96C515BCAEADC7D70A0CF0@MWHPR12MB1774.namprd12.prod.outlook.com>
References: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
 <8520D5D51A55D047800579B094147198258E4869@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi=20

Can someone please help me to debug this issue?

Regards
Nehal

-----Original Message-----
From: Shah, Nehal-bakulchandra=20
Sent: Monday, September 26, 2016 3:45 PM
To: 'Bharat Kumar Gogada' <bharat.kumar.gogada@xilinx.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-pci@vger.kernel.o=
rg; holler@ahsoftware.de; tj@kernel.org; linux-ide@vger.kernel.org; linux-k=
ernel@vger.kernel.org
Subject: RE: ATA failure regression

Hi Bharat

Thanks for the reply. I have observed following thing

If IOMMU is enabled in BIOS and I use following option FCH SATA Debug Optio=
ns --> Unused SATA Port Auto Shut Down Disabled. Issue is not happening. I =
have attached dmesg and lspci output with this option

Also I have attached lspci log with IOMMU disabled.

When issue is happening I am not able to take lspci logs as it stops in ini=
tramfs itself. I will try to get.


Thanks

Nehal
-----Original Message-----
From: Bharat Kumar Gogada [mailto:bharat.kumar.gogada@xilinx.com]
Sent: Friday, September 23, 2016 3:40 PM
To: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>; linux-kerne=
l@vger.kernel.org; linux-pci@vger.kernel.org; holler@ahsoftware.de; tj@kern=
el.org; linux-ide@vger.kernel.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: ATA failure regression

> Hi All,
>=20
> Resending this wider audience
>=20
> Currently I am working on AMD future platform.  I am hitting the same=20
> bug of ATA Failure Regression reported in past.
> (https://patchwork.kernel.org/patch/6875661/) or=20
> http://lkml.iu.edu/hypermail/linux/kernel/1507.3/01961.html
>=20
> I am newbie to this and because of this Ubuntu  16.04 is not booting.=20
> If disable IOMMU and MSI obviously it works but that is not solution.=20
> Even when I bisected it boiled to same place which was mentioned in past =
discussion.
>=20
So here when you are disabling MSI, it is working with legacy interrupts or=
 MSI-X.
Can you post the end sata device lscpi -xxx -vvv content.=20

Bharat
