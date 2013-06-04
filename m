Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58739 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754508Ab3FDWrR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 18:47:17 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
Date: Wed, 05 Jun 2013 00:49:38 +0200
Message-ID: <2947055.dGtK2eC6Fm@vostro.rjw.lan>
In-Reply-To: <2049081.aBp0De0oje@vostro.rjw.lan>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com> <1369974092-11450-2-git-send-email-jiang.liu@huawei.com> <2049081.aBp0De0oje@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 05, 2013 12:44:27 AM Rafael J. Wysocki wrote:
> On Friday, May 31, 2013 12:21:30 PM Jiang Liu wrote:
> > From: Yinghai Lu <yinghai@kernel.org>
> > 
> > When sriov is enabled, VF could just start after PF in pci tree.
> > like c1:00.0 will be PF, and c1:00.1 and after will be VF.
> > 
> > acpi do have dev with same ADR. that will make them get glued
> > wrongly.
> 
> How exactly are they glued in that case?
> 
> > Skip that if it is virtfn.
> 
> That should be a bit more specific as far as I can say.  I don't see why a VF
> would not have a valid ACPI device object corresponding to it.  Is there any
> particular reason?

To be precise, I don't quite see why it is impossible or invalid for a VF to
have a corresponding ACPI device object.  It may not be the case on this
particular system, but why not in general?

Rafael


> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> > ---
> >  drivers/pci/pci-acpi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index e4b1fb2..720f3a2 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -321,6 +321,10 @@ static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
> >  	u64	addr;
> >  
> >  	pci_dev = to_pci_dev(dev);
> > +	/* don't mix vf with real pci device */
> > +	if (pci_dev->is_virtfn)
> > +		return -ENODEV;
> > +
> >  	/* Please ref to ACPI spec for the syntax of _ADR */
> >  	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> >  	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
> > 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
