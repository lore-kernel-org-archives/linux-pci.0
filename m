Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46397 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbcBXTkK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:40:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1aYfI4-0007sU-Kl
	for linux-pci@vger.kernel.org; Wed, 24 Feb 2016 20:40:05 +0100
Received: from 96-94-100-129-static.hfc.comcastbusiness.net ([96-94-100-129-static.hfc.comcastbusiness.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2016 20:40:04 +0100
Received: from akshay.bhat by 96-94-100-129-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 24 Feb 2016 20:40:04 +0100
To: linux-pci@vger.kernel.org
From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: Re: [PATCH v2] PCI: imx6: add dt prop for link gen, default to gen1
Date: Wed, 24 Feb 2016 19:35:55 +0000 (UTC)
Message-ID: <loom.20160224T202751-432@post.gmane.org>
References: <1446735481-27326-1-git-send-email-tharvey@gateworks.com> <1447942365-11662-1-git-send-email-tharvey@gateworks.com> <20151125231435.GI8869@localhost> <CAJ+vNU0ar_d=2n4Yz3QX4qidSkH6PBLyfB8-w-ErLOYzwqj7rw@mail.gmail.com> <CAJ+vNU399O0uskuAQGaqPQUhFdNYktZY4bm-=JCmdEgQF-HgYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tim Harvey <tharvey <at> gateworks.com> writes:

> >>
> >> Is there some sort of DT or OF spec that lists "max-link-speed" as a
> >> generic property?  I see Lucas' desire to have this be common across
> >> DesignWare PCIe cores.  Should it be moved up a level even from there,
> >> i.e., to bindings/pci/pci.txt?
> >
> > Bjorn,
> >
> > I don't know what the general consensus is here. As your the PCI
> > maintainer I would leave that up to you. Are there other platforms
> > that need to link at a lesser capability than the host controller is
> > capable of? I am only aware of the IMX6 and SPEAr13XX [1]
> >
> > I can make that change and re-submit if you feel that is necessary.
> >
> 
> Bjorn,
> 
> Any thoughts here? I would really like to see this get picked up
> sooner rather than later.
> 
> Regards,
> 
> Tim
> 

Bjorn,

It looks like there was no further follow-up on this patch. Could you 
kindly provide feedback to Tim's question? We have multiple i.MX boards 
that could use this patch to resolve PCIe issues.

Thanks,
Akshay



