Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:3685 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab3H0W2V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 18:28:21 -0400
From: "Yuval Mintz" <yuvalmin@broadcom.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
cc: "Jiang Liu" <liuj97@gmail.com>, "Zhao, Yu" <yu.zhao@intel.com>,
	"Jiang Liu" <jiang.liu@huawei.com>,
	"linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: correctly check availability of PCIe Link
 Cap/Status/Control registers
Date: Tue, 27 Aug 2013 22:28:13 +0000
Message-ID: <979A8436335E3744ADCD3A9F2A2B68A52AD155DE@SJEXCHMB10.corp.ad.broadcom.com>
References: <CAErSpo6pCzw6Gjn+SCFhu7PnBpHkUz0oqO+tGmmOH8NxoMiH6g@mail.gmail.com>
 <1377621883-6707-1-git-send-email-liuj97@gmail.com>
 <CAErSpo4B8XTfgq+eQsPZwrEkJ0cG81CskPrtFZWTwuoRBkp8ww@mail.gmail.com>
 <1377626563.5825.8.camel@jekeller-desk1.amr.corp.intel.com>
 <CAErSpo6m96iE4rShiXqHpU_N0qQXKTfSi3qTR+TV=PU3erQ0Jg@mail.gmail.com>
In-Reply-To: <CAErSpo6m96iE4rShiXqHpU_N0qQXKTfSi3qTR+TV=PU3erQ0Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Tue, Aug 27, 2013 at 12:02 PM, Keller, Jacob E
> >> > From: Jiang Liu <jiang.liu@huawei.com>
> >> > ---
> >> > Hi Bjorn,
> >> >         Yuval has a PCIe 1.0 swither, so triggers the bug.  I'm not sure
> >> > why Yu Zhao has implemented pcie_cap_has_linctl() in that way, any
> special
> >> > consideration here?
> >> >
> >> > Hi Yuval,
> >> >         Could you please help to test this patch? Due to hardware resource
> >> > constraints, I have just compiled the patch on my laptop without testing.
> >> >

Hi,

Don't know whether your fix is correct or not (I'm leaving that to you PCI guys),
but it solved my issue - width now returns as x4. Thanks.

Tested-by: Yuval Mintz <yuvalmin@broadcom.com>

> >> > Thanks!
> >> >
> >> > ---
> >> >  drivers/pci/access.c | 12 ++++++++----
> >> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> >> > index 1cc2366..23ff366 100644
> >> > --- a/drivers/pci/access.c
> >> > +++ b/drivers/pci/access.c
> >> > @@ -484,10 +484,14 @@ static inline bool pcie_cap_has_lnkctl(const
> struct pci_dev *dev)
> >> >  {
> >> >         int type = pci_pcie_type(dev);
> >> >
> >> > -       return pcie_cap_version(dev) > 1 ||
> >> > -              type == PCI_EXP_TYPE_ROOT_PORT ||
> >> > -              type == PCI_EXP_TYPE_ENDPOINT ||
> >> > -              type == PCI_EXP_TYPE_LEG_END;
> >> > +       return  pcie_cap_version(dev) == 1 ||
> >> > +               type == PCI_EXP_TYPE_ENDPOINT ||
> >> > +               type == PCI_EXP_TYPE_LEG_END ||
> >> > +               type == PCI_EXP_TYPE_ROOT_PORT ||
> >> > +               type == PCI_EXP_TYPE_UPSTREAM ||
> >> > +               type == PCI_EXP_TYPE_DOWNSTREAM ||
> >> > +               type == PCI_EXP_TYPE_PCI_BRIDGE ||
> >> > +               type == PCI_EXP_TYPE_PCIE_BRIDGE;
> >> >  }
> >> >
> >> >  static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
> >> > --
> >> > 1.8.1.2
> >> >
> >
> >


