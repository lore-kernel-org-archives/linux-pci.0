Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:27193 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbcIZVTb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 17:19:31 -0400
Subject: Re: [PATCH v5 00/16] Add Paravirtual RDMA Driver
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <cover.1474759181.git.aditr@vmware.com>
 <20160925070352.GU4088@leon.nu>
 <9f65ab5c-d8c2-e8e3-9334-5d1865a20dc9@vmware.com>
 <20160926165104.GA12011@obsidianresearch.com>
 <b4e0acd9-e1a2-f6ac-0afa-c0fd62dd62f0@vmware.com>
 <20160926210724.GA16413@obsidianresearch.com>
CC: Leon Romanovsky <leon@kernel.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <pv-drivers@vmware.com>,
        <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <jhansen@vmware.com>, <asarwade@vmware.com>,
        <georgezhang@vmware.com>, <bryantan@vmware.com>
From: Adit Ranadive <aditr@vmware.com>
Message-ID: <b1b78471-c136-fd24-6d4c-96e855e03b3b@vmware.com>
Date: Mon, 26 Sep 2016 14:16:20 -0700
MIME-Version: 1.0
In-Reply-To: <20160926210724.GA16413@obsidianresearch.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 26, 2016 at 14:07:24PM -0700, Jason Gunthorpe wrote:
> On Mon, Sep 26, 2016 at 01:40:10PM -0700, Adit Ranadive wrote:
> 
> > Wouldnt they be some overlap between the user-space and kernel driver? Or is
> > it expected that the common structures (even device specific ones) be moved to
> > the ABI file?
> 
> Yes, even device specific structures must be in the abi file. Anything
> that is used with copy_to_user/copy_from_user/etc.
> 

Ok. Will make sure we consolidate the common stuff in the ABI file in the 
next version.

Thanks,
Adit
