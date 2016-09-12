Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:54040 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbcILXQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 19:16:19 -0400
Date: Mon, 12 Sep 2016 17:16:15 -0600
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
Message-ID: <20160912231615.GA31855@obsidianresearch.com>
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

> Sorry I haven't paying attention to that discussion. Do you know how soon 
> distros will pick up the rdma-plumbing stuff?

Hopefully things will be clearer after the call on Tuesday.

I'm hoping we can begin the process sooner than later.

There are 4 new drivers being submitted and at least 2-3 more kernel
drivers that are not yet in Debian/SuSE/etc.

By far the simplest way to push those 6 new user space drivers into
the distros will be via rdma-plumbing, I'm optimistic that the vendors
will work together on this.

> It seems like it should be fairly straightforward to include the libpvrdma git
> within the rdma-plumbing git as well. Let me know what the process is since
> I may have to discuss it internally.

For now, you can prepare your own clone and create a providers/pvrdma
directory similar to the others. It should be very
straightforward. Let me know if you have any problems.

You should ensure clean compilation on FC24 (for instance using the
provided docker tooling), and review the commit stream in
rdma-plumbing to make sure you pick up all the systemic fixes that
have already been done to the other providers.

If Doug accepts your provider upstream before we finalize
rdma-plumbing then I will add your git to the giant merge, however
please make my life easier and ensure the code does not have any of
the systemic problems I alreadly fixed in other providers :(

After finalization you'll have to post your user space provider to the
mailing list and Doug will pick it up.

Jason
