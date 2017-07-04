Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49657 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdGDR73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2017 13:59:29 -0400
Date: Tue, 4 Jul 2017 19:59:16 +0200
From: Wim ten Have <wim.ten.have@oracle.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Wim ten Have <wim.ten.have@oracle.com>
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
Message-ID: <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
In-Reply-To: <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
        <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
        <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Jul 2017 11:57:37 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> Hi,
> 
> On 7/4/2017 11:32 AM, Bjorn Helgaas wrote:
> > [+cc linux-pci]
> > 
> > Thanks very much for the detailed problem report, Wim!  I'm taking the
> > liberty to forward to the linux-pci list in case others trip over the
> > same thing.
> >   
> 
> So, the spec is lying :) and reality doesn't match theory.
> 
> "Per the ECN mentioned below, all PCIe Receivers are expected to support
>  Extended Tags"
> 
> > The problem is not specific to this piece of h/w.  I did pin-point the
> > issue to specific kernel code commit  
> <snip>
> 
> > 60db3a4d8cc9073cf56264785197ba75ee1caca4
> >   * <wtenhave@hagen:55> git bisect good
> >     60db3a4d8cc9073cf56264785197ba75ee1caca4 is the first bad commit
> >     commit 60db3a4d8cc9073cf56264785197ba75ee1caca4
> >     Author: Sinan Kaya <okaya@codeaurora.org>
> >     Date:   Fri Jan 20 09:16:51 2017 -0500
> > 
> >       PCI: Enable PCIe Extended Tags if supported
> >   
> <snip>
> 
> > 3. Boot and see it crash as soon it starts to operate on specific PCI
> > Express Ethernet controller.
> >   
> 
> I guess we have an endpoint/system with errata that needs to be blacklisted.
> Can you please try another endpoint with the same system?
> 
> You have conflicting information above. I want to understand whether it
> is the endpoint or the system that needs to be blacklisted.

  Specific PCI Express ethernet are embedded on the systems mainboard.
  There's only one PCI Express that requires a riser card.  It is empty.

> Please also provide sudo lspci -vvv output from the system with the patch.
> Sinan

  Detail (lspci -vvv) is added to RedHat filed bugzilla entry; BugID 1467674
  since the info is rather large.

	https://bugzilla.redhat.com/show_bug.cgi?id=1467674

Enjoy,
- Wim.
