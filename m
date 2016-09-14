Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:13308
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751091AbcINF2e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 01:28:34 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 1/3] PCI: Xilinx NWL PCIe: Expanding PCIe core errors
 and printing event occurred.
Date: Wed, 14 Sep 2016 05:28:27 +0000
Message-ID: <8520D5D51A55D047800579B094147198258D616B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1472553558-27215-1-git-send-email-bharatku@xilinx.com>
 <20160913151805.GD27748@localhost>
In-Reply-To: <20160913151805.GD27748@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Tue, Aug 30, 2016 at 04:09:16PM +0530, Bharat Kumar Gogada wrote:
> > The current driver prints pcie core error, for all core events.
> > Instead of just printing PCIe core error, now adding prints to show
> > individual core events occurred.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>=20
> I applied the first two patches to pci/host-xilinx for v4.9, thanks!
>=20
> I'd like to work on the third one a little more, as I mentioned in my res=
ponse to
> it.
>=20
Thanks Bjorn, yes I agree that third one needs better way of handling.
