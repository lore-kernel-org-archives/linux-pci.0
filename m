Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbeEKW1y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 May 2018 18:27:54 -0400
Date: Fri, 11 May 2018 17:27:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-pci@vger.kernel.org,
        kbuild-all@01.org
Subject: Re: [pci:pci/resource 8/10] drivers/pci/of.c:332:3-8: WARNING:
 invalid free of devm_ allocated data
Message-ID: <20180511222750.GA211882@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.DEB.2.20.1805110706001.3191@hadrien>
 <3b005d1f-ee86-722b-d5ba-d543c044a941@siemens.com>
 <4720dc4c-9055-2616-c58b-d40895b9477c@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4720dc4c-9055-2616-c58b-d40895b9477c@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 07:53:21AM +0200, Jan Kiszka wrote:
> On 2018-05-11 07:45, Jan Kiszka wrote:
> > On 2018-05-11 07:08, Julia Lawall wrote:
> >> The devm_kzalloc on line 324 makes the kfrees on lines 332 and 355
> >> incorrect.  They can just be removed.
> > 
> > True. In fact, 358 and 359 should go as well - making them obsolete is
> > the whole point of this conversion.
> 
> More precisely, 332 needs to become devm_kfree because we skip over one
> resource without failing.
> 
> > 
> > The issue comes already with patch "Add dev parameter to
> > __of_pci_get_host_bridge_resources()" when dev != NULL. Bjorn, should I
> > resend the series with that patch fixed and the rest rebased? Or do you
> > prefer when I update only this patch, fixing the issue here?
> 
> ...or is a fixup patch on top preferred?

Sorry, I missed this until now.  If you send me a fixup patch on top of my
pci/resource branch, I'll just fold it in.
