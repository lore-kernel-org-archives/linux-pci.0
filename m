Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:55209 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423015AbcIZQvQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Sep 2016 12:51:16 -0400
Date: Mon, 26 Sep 2016 10:51:04 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Adit Ranadive <aditr@vmware.com>
Cc: Leon Romanovsky <leon@kernel.org>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, pv-drivers@vmware.com,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        jhansen@vmware.com, asarwade@vmware.com, georgezhang@vmware.com,
        bryantan@vmware.com
Subject: Re: [PATCH v5 00/16] Add Paravirtual RDMA Driver
Message-ID: <20160926165104.GA12011@obsidianresearch.com>
References: <cover.1474759181.git.aditr@vmware.com>
 <20160925070352.GU4088@leon.nu>
 <9f65ab5c-d8c2-e8e3-9334-5d1865a20dc9@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f65ab5c-d8c2-e8e3-9334-5d1865a20dc9@vmware.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 25, 2016 at 10:25:12PM -0700, Adit Ranadive wrote:
> > As Jason said, you need a very good reason to split and create number of
> > files per-driver in UAPI folder.
> 
> I can move the pvrdma-uapi.h back to the pvrdma driver folder.

Just don't copy any of the content into your user space provider.

Thanks
Jason
