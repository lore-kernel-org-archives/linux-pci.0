Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:39309
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752747AbcIWKKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Sep 2016 06:10:24 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "holler@ahsoftware.de" <holler@ahsoftware.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: ATA failure regression
Date: Fri, 23 Sep 2016 10:10:17 +0000
Message-ID: <8520D5D51A55D047800579B094147198258E4869@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Hi All,
>=20
> Resending this wider audience
>=20
> Currently I am working on AMD future platform.  I am hitting the same bug=
 of
> ATA Failure Regression reported in past.
> (https://patchwork.kernel.org/patch/6875661/) or
> http://lkml.iu.edu/hypermail/linux/kernel/1507.3/01961.html
>=20
> I am newbie to this and because of this Ubuntu  16.04 is not booting. If =
disable
> IOMMU and MSI obviously it works but that is not solution. Even when I bi=
sected
> it boiled to same place which was mentioned in past discussion.
>=20
So here when you are disabling MSI, it is working with legacy interrupts or=
 MSI-X.
Can you post the end sata device lscpi -xxx -vvv content.=20

Bharat
