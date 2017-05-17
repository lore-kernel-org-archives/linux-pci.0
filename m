Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0073.outbound.protection.outlook.com ([104.47.0.73]:16096
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753719AbdEQQBx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 May 2017 12:01:53 -0400
From: "M.H. Lian" <minghuan.lian@nxp.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Mingkai Hu <mingkai.hu@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Subject: PCIe RC AER/PME/HotPlug interrupt design
Date: Wed, 17 May 2017 16:01:49 +0000
Message-ID: <VI1PR04MB1615B66B5099194B38EF8FD8E8E70@VI1PR04MB1615.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

We are using a PCIe controller which integrate Root complex  and one Root p=
ort.
But I am not clear about the interrupt routing.

1. AER interrupt
PCIe base specification rev3.0  6.2.6 Error message controls has a Figure 6=
-3 which provides a conceptual summary in the form of a pseudo logic diagra=
m for how  error Message are generated, logged, forwarded and ultimately no=
tified to the system.  But I have a question, does it mean only INTx or MSI=
 can be used for AER?  Can a platform specific interrupt be used for AER?

2. PME interrupt
 PCIe base specification rev3.0  6.1.6 describes Native PME software Model.=
 It is clear that INTx or MSI can be used to trigger PME interrupt. but for=
 Legacy PME Software Model, 6.1.7 said " informs system software through an=
 implementation specific mechanism". Does it mean we can use a platform spe=
cific interrupt for PME?

Let me sum up, I want to know if a platform specific interrupt can be used =
for AER, PME, hot plug or only INTx/MSI can be used.

Any comments would be highly appreciated.

Thanks,
Minghuan    =20
