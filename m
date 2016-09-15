Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:5805 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760345AbcIOAKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 20:10:19 -0400
From: Adit Ranadive <aditr@vmware.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Jorgen S. Hansen" <jhansen@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        George Zhang <georgezhang@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: RE: [PATCH v4 05/16] IB/pvrdma: Add functions for Verbs support
Date: Thu, 15 Sep 2016 00:10:10 +0000
Message-ID: <BLUPR0501MB836AB8BF5108322033C5DD6C5F00@BLUPR0501MB836.namprd05.prod.outlook.com>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <1473655766-31628-6-git-send-email-aditr@vmware.com>
 <20160914124947.GA14616@infradead.org>
In-Reply-To: <20160914124947.GA14616@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 05:49:50 -0700 Christoph Hellwig wrote:
> > +	props->max_fmr =3D dev->dsr->caps.max_fmr;
> > +	props->max_map_per_fmr =3D dev->dsr->caps.max_map_per_fmr;
>=20
> Please don't add FMR support to any new drivers.

We don't and our device reports these as 0. If you want me to more explicit=
 I
can remove the zero'd out properties.
