Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:55540 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761275AbcINRgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 13:36:38 -0400
Date: Wed, 14 Sep 2016 11:36:36 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Adit Ranadive <aditr@vmware.com>
Cc: "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Jorgen S. Hansen" <jhansen@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        George Zhang <georgezhang@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH v4 00/16] Add Paravirtual RDMA Driver
Message-ID: <20160914173636.GA10309@obsidianresearch.com>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <20160912180251.GH5843@obsidianresearch.com>
 <BLUPR0501MB836ED564F2AE7AB9221AC25C5FF0@BLUPR0501MB836.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLUPR0501MB836ED564F2AE7AB9221AC25C5FF0@BLUPR0501MB836.namprd05.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 12, 2016 at 10:43:00PM +0000, Adit Ranadive wrote:
> On Mon, Sep 12, 2016 at 11:03:39 -0700, Jason Gunthorpe wrote:
> > On Sun, Sep 11, 2016 at 09:49:10PM -0700, Adit Ranadive wrote:
> > > [2] Libpvrdma User-level library - 
> > > http://git.openfabrics.org/?p=~aditr/libpvrdma.git;a=summary
> > 
> > You will probably find that rdma-plumbing will be the best way to get
> > your userspace component into the distributors.
> 
> Hi Jason,
> 
> Sorry I haven't paying attention to that discussion. Do you know how soon 
> distros will pick up the rdma-plumbing stuff?

We desire to use this as the vehical for the userspace included with
the 4.9 kernel.

I anticipate the tree will be running by Oct 1.

Jason
