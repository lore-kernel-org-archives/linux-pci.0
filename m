Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:31210 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdJJH7X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2017 03:59:23 -0400
Subject: Re: [PATCH 1/2] PCI: dwc: dra7xx: Create functional dependency
 between PCIe and PHY
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
References: <20171009090338.26033-1-kishon@ti.com>
 <20171009090338.26033-2-kishon@ti.com>
 <f258c2f0-11a2-60ac-3919-dcc0badfa870@ti.com>
 <ac5b3f42-19a1-3f8d-3bb6-37d63c3574de@ti.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <9dce2e30-a245-460d-a808-a733eaf7ffec@ti.com>
Date: Tue, 10 Oct 2017 10:59:18 +0300
MIME-Version: 1.0
In-Reply-To: <ac5b3f42-19a1-3f8d-3bb6-37d63c3574de@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 10/10/17 10:42, Kishon Vijay Abraham I wrote:
> Roger,
>=20
> On Tuesday 10 October 2017 12:49 PM, Roger Quadros wrote:
>> On 09/10/17 12:03, Kishon Vijay Abraham I wrote:
>>> PCI core access configuration space registers in resume_noirq callbacks=
.
>>> In the case of dra7xx, PIPE3 PHY connected to PCIe controller has to be
>>> enabled before accessing configuration space registers. Since
>>> PIPE3 PHY is enabled by only configuring control module registers, no
>>> aborts has been observed so far (though during noirq stage, interface
>>> clock of PIPE3 PHY is not enabled).
>>>
>>> With new TRM updates, PIPE3 PHY has to be initialized (PIPE3 PHY
>>> registers has to be accessed) as well which requires the interface
>>> clock of PIPE3 PHY to be enabled. The interface clock of PIPE3 PHY is
>>> derived from OCP2SCP and hence PCIe PHY is modeled as a child of
>>> OCP2SCP. Since pm_runtime is not enabled during noirq stage,
>>> pm_runtime_get_sync done in phy_init doesn't enable
>>> OCP2SCP clocks resulting in abort when PIPE3 PHY registers are
>>> accessed.
>>
>> This could be the case not only with PCIe but even with USB and SATA?
>=20
> right, if USB/SATA driver has no_irq callbacks then the same issue might =
occur.

OK. Is this something that we should document in Documentation/phy.txt?

> But looks like none of them uses no_irq callbacks.

>> Maybe today it doesn't complain because USB/SATA is being resumed (by ch=
ance) after PHY?
>=20
> But once pm_runtime is enabled, USB/SATA can enable PHY which in turn wil=
l
> enable OCP2SCP and PHY can be accessed without any issues.
>=20
> Thanks
> Kishon
>=20

--=20
cheers,
-roger
