Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:20806 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750798AbcIZFWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 01:22:11 -0400
Subject: Re: [PATCH v5 16/16] MAINTAINERS: Update for PVRDMA driver
To: Leon Romanovsky <leon@kernel.org>
References: <cover.1474759181.git.aditr@vmware.com>
 <fe5e7704757254073963cd40bff5240421b1fce0.1474759181.git.aditr@vmware.com>
 <20160925073010.GW4088@leon.nu>
CC: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>, <netdev@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <jhansen@vmware.com>,
        <asarwade@vmware.com>, <georgezhang@vmware.com>,
        <bryantan@vmware.com>
From: Adit Ranadive <aditr@vmware.com>
Message-ID: <7ddc5906-6ba8-335e-c0b8-eb60427a1be8@vmware.com>
Date: Sun, 25 Sep 2016 22:22:02 -0700
MIME-Version: 1.0
In-Reply-To: <20160925073010.GW4088@leon.nu>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 25 2016 at 10:30:10AM +0300, Leon Romanovsky wrote:
> On Sat, Sep 24, 2016 at 04:21:40PM -0700, Adit Ranadive wrote:
> > Add maintainer info for the PVRDMA driver.
> >
> > Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> > Reviewed-by: George Zhang <georgezhang@vmware.com>
> > Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
> > Reviewed-by: Bryan Tan <bryantan@vmware.com>
> > Signed-off-by: Adit Ranadive <aditr@vmware.com>
> > ---
> > Changes v4->v5:
> >  - Added pvrdma files to common UAPI folder.
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 87e23cd..5023dc0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12615,6 +12615,15 @@ S:	Maintained
> >  F:	drivers/scsi/vmw_pvscsi.c
> >  F:	drivers/scsi/vmw_pvscsi.h
> >
> > +VMWARE PVRDMA DRIVER
> > +M:	Adit Ranadive <aditr@vmware.com>
> > +M:	VMware PV-Drivers <pv-drivers@vmware.com>
> > +L:	linux-rdma@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/infiniband/hw/pvrdma/
> > +F:	include/uapi/rdma/pvrdma-abi.h
> > +F:	include/uapi/rdma/pvrdma-uapi.h
> 
> Please remove the last two lines, these files will be maintained by
> Doug.
> 
> Thanks
>

Ok. Based on your recent patch series on export vendor specific ABIs,
the ABI files were added to be maintained [1] by individual driver owners. 
Is that not the case now?

[1] http://marc.info/?l=linux-rdma&m=147455473718235&w=2
