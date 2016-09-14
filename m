Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4372 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764135AbcINQAd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 12:00:33 -0400
From: Adit Ranadive <aditr@vmware.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
CC: "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Jorgen S. Hansen" <jhansen@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        George Zhang <georgezhang@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: RE: [PATCH v4 01/16] vmxnet3: Move PCI Id to pci_ids.h
Date: Wed, 14 Sep 2016 16:00:25 +0000
Message-ID: <DM2PR0501MB844852987661859C6654E40C5F10@DM2PR0501MB844.namprd05.prod.outlook.com>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <1473655766-31628-2-git-send-email-aditr@vmware.com>
 <20160914110854.GA15800@yuval-lap.uk.oracle.com>
In-Reply-To: <20160914110854.GA15800@yuval-lap.uk.oracle.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 14, 2016 at 04:09:12 -0700, Yuval Shaia wrote:
> Please update vmxnet3_drv.c accordingly.

Any reason why? I don't think we need to. Vmxnet3 should just pick up the m=
oved
PCI device id from pci_ids.h file.

- Adit
