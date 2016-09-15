Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759534AbcIOGPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2016 02:15:39 -0400
Date: Wed, 14 Sep 2016 23:15:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Adit Ranadive <aditr@vmware.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Jorgen S. Hansen" <jhansen@vmware.com>,
        Aditya Sarwade <asarwade@vmware.com>,
        George Zhang <georgezhang@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH v4 05/16] IB/pvrdma: Add functions for Verbs support
Message-ID: <20160915061537.GC4869@infradead.org>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
 <1473655766-31628-6-git-send-email-aditr@vmware.com>
 <20160914124947.GA14616@infradead.org>
 <BLUPR0501MB836AB8BF5108322033C5DD6C5F00@BLUPR0501MB836.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLUPR0501MB836AB8BF5108322033C5DD6C5F00@BLUPR0501MB836.namprd05.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 15, 2016 at 12:10:10AM +0000, Adit Ranadive wrote:
> On Wed, Sep 14, 2016 at 05:49:50 -0700 Christoph Hellwig wrote:
> > > +	props->max_fmr = dev->dsr->caps.max_fmr;
> > > +	props->max_map_per_fmr = dev->dsr->caps.max_map_per_fmr;
> > 
> > Please don't add FMR support to any new drivers.
> 
> We don't and our device reports these as 0. If you want me to more explicit I
> can remove the zero'd out properties.

Oh, ok.  I'll withdraw my comment then.
