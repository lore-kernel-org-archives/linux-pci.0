Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com ([104.47.38.68]:11824
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750884AbeDPJ4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Apr 2018 05:56:45 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH] MAINTAINERS: Add missing /drivers/pci/cadence directory
 entry
Date: Mon, 16 Apr 2018 09:56:43 +0000
Message-ID: <SN6PR07MB4512D266F5C6F6B69E35A0A3D8B00@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <20180403165605.26035-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20180403165605.26035-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/03/2018 17:56 Lorenzo Pieralisi wrote:
> Commit 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for
> Cadence PCIe controller") created the /drivers/pci/cadence directory to k=
eep
> in a single place Cadence host and endpoint controller drivers.
>=20
> Since code in /drivers/pci/cadence falls within the PCI native host bridg=
e and
> endpoint controllers mainteinance remit, that maintainer entry should hav=
e
> been updated too by adding the /drivers/pci/cadence directory to it but i=
t
> actually was not.
>=20
> Update the MAINTAINERS entry accordingly, fixing the omission.
>=20
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Alan Douglas <adouglas@cadence.com>
