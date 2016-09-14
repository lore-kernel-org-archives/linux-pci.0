Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:47264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761961AbcINPcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 11:32:53 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
        "yinghai@kernel.org" <yinghai@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/6] PCI: xilinx: Keep both legacy and MSI interrupt
 references.
Date: Wed, 14 Sep 2016 15:32:44 +0000
Message-ID: <8520D5D51A55D047800579B094147198258D6418@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
 <20160913155641.GB4138@localhost>
In-Reply-To: <20160913155641.GB4138@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 03:44:41PM +0530, Bharat Kumar Gogada wrote:
> When built with MSI support the legacy domain reference is being=20
> overwritten with MSI.
> Instead creating two separate domains for MSI and legacy interrupts.
>=20
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>

Applied all these (except [5/6]) with Michal's ack to pci/host-xilinx for v=
4.9, thanks!

I already applied Po Liu's patch ("PCI: xilinx: Relax device number checkin=
g to allow SR-IOV") to pci/virtualization.  This is identical to [5/6], so =
I dropped [5/6] to avoid a conflict.

Thanks Bjorn.=20
Some how I couldn't find Po Liu's patch, can you provide git link of patch =
that was applied.=20
Hope it wouldn't take much time of you.=20

Thanks & Regards,
Bharat

