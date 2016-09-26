Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:39020 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750798AbcIZFZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2016 01:25:22 -0400
Subject: Re: [PATCH v5 00/16] Add Paravirtual RDMA Driver
To: Leon Romanovsky <leon@kernel.org>
References: <cover.1474759181.git.aditr@vmware.com>
 <20160925070352.GU4088@leon.nu>
CC: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>, <netdev@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <jhansen@vmware.com>,
        <asarwade@vmware.com>, <georgezhang@vmware.com>,
        <bryantan@vmware.com>
From: Adit Ranadive <aditr@vmware.com>
Message-ID: <9f65ab5c-d8c2-e8e3-9334-5d1865a20dc9@vmware.com>
Date: Sun, 25 Sep 2016 22:25:12 -0700
MIME-Version: 1.0
In-Reply-To: <20160925070352.GU4088@leon.nu>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 25 2016 at 10:03:52AM +0300, Leon Romanovsky wrote:
> On Sat, Sep 24, 2016 at 04:21:24PM -0700, Adit Ranadive wrote:
> 
> <...>
> 
> >  include/uapi/rdma/pvrdma-abi.h                 |   99 ++
> >  include/uapi/rdma/pvrdma-uapi.h                |  255 +++++
> 
> As Jason said, you need a very good reason to split and create number of
> files per-driver in UAPI folder.

I can move the pvrdma-uapi.h back to the pvrdma driver folder.
