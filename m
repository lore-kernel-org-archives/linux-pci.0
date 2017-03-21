Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbdCUGLT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Mar 2017 02:11:19 -0400
Date: Tue, 21 Mar 2017 00:01:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Bodong Wang <bodong@mellanox.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        saeedm@mellanox.com, Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
Message-ID: <20170321000158.444991a3@t450s.home>
In-Reply-To: <20170321054305.GA12230@gwshan>
References: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
        <20170320230706.GA12252@gwshan>
        <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
        <20170320225708.6868676a@t450s.home>
        <20170321054305.GA12230@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 21 Mar 2017 16:43:05 +1100
Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:

> On Mon, Mar 20, 2017 at 10:57:08PM -0600, Alex Williamson wrote:
> >On Mon, 20 Mar 2017 18:34:23 -0500
> >Bodong Wang <bodong@mellanox.com> wrote:  
> 
> .../...
> 
> >> > Bodong, I'm not sure if there is a requirement to load driver for the
> >> > specified number of VFs? That indicates no driver will be loaded for
> >> > other VFs. If so, this interface might serve the purpose as well.    
> >> Gavin, thanks for the review. That is indeed an interesting suggestion. 
> >> Theoretically,  we can change that probe_vfs from boolean to integer. 
> >> And use it as a counter to probe the first N VFs(if N < total_vfs).  
> >> Let's see if there are any objections.  
> >
> >Is it just me or does this seem like a confusing user interface, ie. to
> >get binary on/off behavior a user now needs to 'cat total_vfs >
> >sriov_probe_vfs'.  It's not very intuitive, what's the use case for it?
> >  
> 
> After it's changed to integer, it accepts number. If users want to load
> driver for all VFs and don't want to check the maximal number of VFs,
> they can simply write 0xffffffff. So "on" and "off" are replaced with 0xffffffff
> and 0, but users has to press the keyboard more times though.
> 
> drivers/net/ethernet/mellanox/mlx4/main.c::probe_vfs_argc allows to specify
> the number of VFs with which we're going to bind drivers. Less time is needed
> to enable SRIOV capability. As I had in some development environment: assume
> PF supports 256 VFs and I'm going to enable all of them, but I only want to
> load driver for two of them, then test the data path on those two VFs. Besides,
> I can image the VF needn't a driver in host if it's going to be passed to guest. 
> Not sure how much sense it makes.

Yes, I understand what you're trying to do, but I still think it's
confusing for a user interface.  This also doesn't answer what's the
practical, typical user case you see where it's useful to probe some
VFs but not others.  The case listed is a development case where you
could just as easily disable all probing, then manually bind the first
two VFs to the host driver.  Which is the better design, impose a
confusing interface on all users to simplify an obscure development
environment or simplify the user interface and assume developers know
how to bind devices otherwise?  Thanks,

Alex
