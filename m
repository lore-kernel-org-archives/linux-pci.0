Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59113 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab3CXOjn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 24 Mar 2013 10:39:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1UJm5d-0003xR-0h
	for linux-pci@vger.kernel.org; Sun, 24 Mar 2013 15:40:05 +0100
Received: from 78-134-117-101.v4.ngi.it ([78.134.117.101])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 24 Mar 2013 15:40:05 +0100
Received: from ordex by 78-134-117-101.v4.ngi.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 24 Mar 2013 15:40:05 +0100
To: linux-pci@vger.kernel.org
From: Antonio Quartulli <ordex@autistici.org>
Subject: Re: =?utf-8?b?d2Fybl9zbG93cGF0aF9jb21tb24=?= in drivers/pci/search.c:44 on linux-3.4.0
Date: Sun, 24 Mar 2013 14:34:37 +0000 (UTC)
Message-ID: <loom.20130324T153215-633@post.gmane.org>
References: <20120526082551.GA2723@ritirata.org> <CAErSpo553_-AivRa7VbjHrFraHaO4NYoYR7A9Am5fkDP-CMvSA@mail.gmail.com> <20120529083552.GN2604@amd.com> <20120529085648.GA13941@ritirata.org> <20120529101657.GO2604@amd.com> <4FC4F5BC.5000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello people,

Jiang Liu <liuj97 <at> gmail.com> writes:

> 
> On 05/29/2012 06:16 PM, Joerg Roedel wrote:
> > On Tue, May 29, 2012 at 10:56:50AM +0200, Antonio Quartulli wrote:
> >> attached!
> >> Some days ago I tried to put some printk in the code and, as far as I can
> >> understand, you are right.
> > 
> > Hmm, looks like device 03:00.0 is a 32bit PCI device attached to device
> > 00:1c.2 which calls itself a Root Port instead of a PCI Bridge. I am
> > not sure if the check in search.c is really necessary. As I see it there
> > are also other possible pcie_types like PCI_EXP_TYPE_PCIE_BRIDGE.
> > Putting Anil Keshavamurthy on Cc.
> > 
> > Anil, is this check in pci_find_upstream_pcie_bridge() really
> > necessary:
> > 
> >         /* PCI device should connect to a PCIe bridge */
> >         if (pdev->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE) {
> >                 /* Busted hardware? */
> >                 WARN_ON_ONCE(1);
> >                 return NULL;
> >         }
> > 
> > ? In the warning that triggers for Antonio the value of pcie_type seems
> > to be PCI_EXP_TYPE_ROOT_PORT and from the available types I think that
> > PCI_EXP_TYPE_PCIE_BRIDGE is also possible.
> It seems that device 00:1c.2 is a real PCIe root port, and device 03:00.0
> is a CardBus bridge. Should we call device 03:00.0 as Legacy Endpoint here?
> Could a PCIe legacy endpoint be directly connected to root port and downstream
> port? If the answer is yes, the assumption in pci_find_upstream_pcie_bridge()
> 
> BTW, does PCI_EXP_TYPE_PCIE_BRIDGE mean PCI/PCI-X to PCIe bridge? Do we
> really have such chipsets?
> 

It has been a while that we did not discuss the issue :)
Today, while checking my dmesg, I've seen the same warning.
Now I am running linux-3.8.4.

Did we/you find any possible answer to how to proceed given the existante of the 
configuration that is triggering the warning?

Let me know if you want me to test any code.

Thanks a lot.
Cheers,



