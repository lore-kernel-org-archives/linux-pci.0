Return-Path: <bharat.kumar.gogada@xilinx.com>
Return-Path: <bharat.kumar.gogada@xilinx.com>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, Soren Brinkmann
	<sorenb@xilinx.com>, "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>, "grygorii.strashko@ti.com"
	<grygorii.strashko@ti.com>, "yinghai@kernel.org" <yinghai@kernel.org>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"fengguang.wu@intel.com" <fengguang.wu@intel.com>, Michal Simek
	<michals@xilinx.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Ravikiran Gummaluri
	<rgummal@xilinx.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/6] PCI: xilinx: Keep both legacy and MSI interrupt
 references.
Date: Thu, 15 Sep 2016 05:09:37 +0000
Message-ID: <8520D5D51A55D047800579B094147198258D6806@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
 <20160913155641.GB4138@localhost>
 <8520D5D51A55D047800579B094147198258D6418@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160914191704.GA9208@localhost>
In-Reply-To: <20160914191704.GA9208@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 03:32:44PM +0000, Bharat Kumar Gogada wrote:
> On Thu, Sep 01, 2016 at 03:44:41PM +0530, Bharat Kumar Gogada wrote:
> > When built with MSI support the legacy domain reference is being=20
> > overwritten with MSI.
> > Instead creating two separate domains for MSI and legacy interrupts.
> >=20
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>=20
> Applied all these (except [5/6]) with Michal's ack to pci/host-xilinx for=
 v4.9, thanks!
>=20
> I already applied Po Liu's patch ("PCI: xilinx: Relax device number check=
ing to allow SR-IOV") to pci/virtualization.  This is identical to [5/6], s=
o I dropped [5/6] to avoid a conflict.
>=20
> Thanks Bjorn.=20
> Some how I couldn't find Po Liu's patch, can you provide git link of patc=
h that was applied.=20

Sure, here it is: https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.=
git/commit/?h=3Dpci/virtualization&id=3D8e7ca8ca5fd8a3242289105723c429733be=
8b73b

Thanks Bjorn, this patch is similar to [5/6] patch.=20
