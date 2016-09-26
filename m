Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:39120 "EHLO quartz.orcorp.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933166AbcIZVHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Sep 2016 17:07:31 -0400
Date: Mon, 26 Sep 2016 15:07:24 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Adit Ranadive <aditr@vmware.com>
Cc: Leon Romanovsky <leon@kernel.org>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, pv-drivers@vmware.com,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        jhansen@vmware.com, asarwade@vmware.com, georgezhang@vmware.com,
        bryantan@vmware.com
Subject: Re: [PATCH v5 00/16] Add Paravirtual RDMA Driver
Message-ID: <20160926210724.GA16413@obsidianresearch.com>
References: <cover.1474759181.git.aditr@vmware.com>
 <20160925070352.GU4088@leon.nu>
 <9f65ab5c-d8c2-e8e3-9334-5d1865a20dc9@vmware.com>
 <20160926165104.GA12011@obsidianresearch.com>
 <b4e0acd9-e1a2-f6ac-0afa-c0fd62dd62f0@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b4e0acd9-e1a2-f6ac-0afa-c0fd62dd62f0@vmware.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 26, 2016 at 01:40:10PM -0700, Adit Ranadive wrote:

> Wouldnt they be some overlap between the user-space and kernel driver? Or is
> it expected that the common structures (even device specific ones) be moved to
> the ABI file?

Yes, even device specific structures must be in the abi file. Anything
that is used with copy_to_user/copy_from_user/etc.

> For the mlx4 driver I see that the structures in include/linux/mlx4/qp.h
> and in libmlx4/src/wqe.h are similar.

We are trying to clean exactly that sort of stuff up, please try not
to add more.

Jason
