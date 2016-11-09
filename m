Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933949AbcKIPHr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 10:07:47 -0500
Date: Wed, 9 Nov 2016 08:07:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Adi Menachem <adim@mellanox.com>
Subject: Re: Shouldn't VFIO virtualize the ATS capability?
Message-ID: <20161109080746.24dd79dd@t450s.home>
In-Reply-To: <VI1PR0502MB29579BD9AA9A2E85288798E4D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
References: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161106100832.41e173d5@t450s.home>
        <VI1PR0502MB29579BD9AA9A2E85288798E4D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 9 Nov 2016 14:49:02 +0000
Ilya Lesokhin <ilyal@mellanox.com> wrote:

> I would virtualize the "ATS Control Register".

And do what?

> Regarding poor behavior, I couldn't really find what happens when ATS is misconfigured, but I would assume it can cause problems.
> The scenarios I'm concerned about are:
> 	1. The guest enables translation caching, while the hypervisor thinks there are disabled -> Hypervisor won't issue invalidations.

Aren't invalidations issued by the iommu, why does the hypervisor need
to participate?  How would a software entity induce an invalidation?

> 	2. Smallest Translation Unit misconfiguration. Not sure if it will cause invalid access or only poor caching behavior.
> 
> Thanks,
> Ilya
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Sunday, November 06, 2016 7:09 PM
> > To: Ilya Lesokhin <ilyal@mellanox.com>
> > Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org; bhelgaas@google.com
> > Subject: Re: Shouldn't VFIO virtualize the ATS capability?
> > 
> > On Sun, 6 Nov 2016 11:13:09 +0000
> > Ilya Lesokhin <ilyal@mellanox.com> wrote:
> >   
> > > Hi
> > > I've noticed that VFIO doesn't virtualize the ATS capability.
> > > It seems to me that translation caching and Smallest Translation Unit is  
> > something you would want to control on the host. Am I wrong?
> > 
> > What about those fields would we virtualize?  Why does the host need to be
> > an intermediary?  Can the user induce poor behavior with direct access to
> > them?  Thanks,
> > 
> > Alex  

