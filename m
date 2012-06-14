Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50880 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037Ab2FNNzc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jun 2012 09:55:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SfAWF-0005zi-B0
	for linux-pci@vger.kernel.org; Thu, 14 Jun 2012 15:55:27 +0200
Received: from dsl001-168-162.bos1.dsl.speakeasy.net ([72.1.168.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 14 Jun 2012 15:55:27 +0200
Received: from tkcarr03873 by dsl001-168-162.bos1.dsl.speakeasy.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 14 Jun 2012 15:55:27 +0200
To: linux-pci@vger.kernel.org
From: Tom Carr <tkcarr03873@gmail.com>
Subject: Re: PCIe rescan not working
Date: Thu, 14 Jun 2012 13:55:13 +0000 (UTC)
Message-ID: <loom.20120614T154236-959@post.gmane.org>
References: <loom.20120607T194858-986@post.gmane.org> <CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com> <loom.20120611T205954-871@post.gmane.org> <CAE9FiQWsv+VU_240BgzHhyR5=A+7DkceWR0oNuYgYxi5TwWvyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai Lu <yinghai <at> kernel.org> writes:

> 
> On Mon, Jun 11, 2012 at 12:32 PM, Tom Carr <tkcarr03873 <at> gmail.com> wrote:
> >
> > Yinghai, sorry about the direct email on Friday, I tried to reply back to
> > the
> > newsgroup but the send kept failing. Your suggestion worked but only if 
> > there
> > were no drivers attached to the endpoints. If I load the driver for the
> > endpoint
> > at bus 6.0 and 9.0, then load the empty FPGA at bus 8.0, which is off of 
> > 4.8,
> > and write 1 to /sys/bus/pci/remove the system crashes. Is there a
> > requirement that all down stream devices be removed? I could not find any
> > such
> > requirement in any documentation. Here is the most of the stack trace.
> 
> can you please try current linus kernel like
> 3.4 or 3.5-rc1 ?
> 
> looks like there is some stop/remove pci device code bug in old kernel.
> 
> Thanks
> 
> Yinghai
> 

Yinghai, thank you for the help. Moving to 3.4 fixed the problem. I am now able
to load the FPGA and bring the FPGA endpoint online using remove and rescan. I
was curious if it would be possible to instruct the root complex port to
allocate enough memory to deal with endpoints that come on line
after the system is booted. With the solution I have now, the drivers for all
the endpoints in the PCIe tree starting at the root port 1.2 have to be removed
which means if they have to stop processing while the rescan is done. Since
this is an embedded design, the endpoints and the memory they will use does
not change. If the root could be instructed to allocate enough memory to deal
with endpoints coming in later then only the switch port connected to the
endpoint would need to be removed and the other endpoints should be able to 
continue to function. If you think this is doable and of value to others, I 
would be willing to make the change and offer it up for consideration.



