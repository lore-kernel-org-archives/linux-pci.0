Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31466 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754132AbcILWNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2016 18:13:55 -0400
From: Adit Ranadive <aditr@vmware.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Jorgen S. Hansen" <jhansen@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        George Zhang <georgezhang@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH v4 16/16] MAINTAINERS: Update for PVRDMA driver
Date: Mon, 12 Sep 2016 22:13:47 +0000
Message-ID: <BLUPR0501MB8369F3976825A9764DD864CC5FF0@BLUPR0501MB836.namprd05.prod.outlook.com>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <1473655766-31628-17-git-send-email-aditr@vmware.com>
 <20160912175222.GG5843@obsidianresearch.com>
In-Reply-To: <20160912175222.GG5843@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 12, 2016 at 10:52:26 -0700, Jason Gunthorpe wrote:=20
> On Sun, Sep 11, 2016 at 09:49:26PM -0700, Adit Ranadive wrote:
> > Add maintainer info for the PVRDMA driver.
>=20
> You can probably squash the last three patches.

Thanks for taking a look.
Since Doug mentioned that he would squash my commits anyways while applying=
 I
decided to keep them separate. Let me know if you still want me to squash t=
hem.

> .. and fix the __u32 stuff throughout the entire driver please.

Will do.

Thanks,
Adit
