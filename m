Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33347 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbbFCGzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Jun 2015 02:55:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1Z02Zq-0008HW-LW
	for linux-pci@vger.kernel.org; Wed, 03 Jun 2015 08:55:02 +0200
Received: from sjc12-dmz-wsa-2.cisco.com ([173.36.240.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2015 08:55:02 +0200
Received: from boheng528 by sjc12-dmz-wsa-2.cisco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2015 08:55:02 +0200
To: linux-pci@vger.kernel.org
From: bo <boheng528@gmail.com>
Subject: Re: Debugging "Completion Timeout" errors as reported by AER
Date: Wed, 3 Jun 2015 06:47:44 +0000 (UTC)
Message-ID: <loom.20150603T083209-872@post.gmane.org>
References: <CAA93t1rN_av-KBUxLtaYX00T1FyQhEaLGme_P7DaR=pd4eELPA@mail.gmail.com> <1397066100.3215.305.camel@ul30vt.home> <8866b20235964890a6aee25f21e43ca3@DM2PR05MB671.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rajat Jain <rajatjain <at> juniper.net> writes:

> 
> > >
> > >         cpld = (u8 *)sam->membase;
> > >         for (i = 0; i < 0x40; i++) {
> > >                         pr_emerg(" %02X", cpld[i]);
> > >         }
> > >
> > >
> > > My questions:
> > 
> > Maybe a silly question, but does the device support byte-width 
access to this
> > space?  Thanks,
> > 
> 
> Voila!!!!! That was the issue - the device only supports 4byte 
accesses.
> 
> Thanks a lot Alex!
> 
> I feel so stupid. Sometimes the most silly items get overlooked.
> 
> Thanks again,
> 
> Rajat
> 


Hi every one

I have completion time out issue with a different topology.

my topology is as below

CPU is x86-64bit

cpu === pcie switch === pcie end devices

completion time out is reported (rarely) on cpu root port connected to 
pcie switch. 

Since there are multiple devices (accessed by multiple drivers) under 
the pcie switch and the issue is rarely seen,I am not able to figure out 
which device is causing the issue.

could some one please throw some light on what other factors cause 
completion time out other than access width ? 




