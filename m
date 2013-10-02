Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab3JBTZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Oct 2013 15:25:07 -0400
Message-ID: <1380741905.2673.3.camel@ul30vt.home>
Subject: Re: override B:D:F assignments for SRIOV VFs
From: Alex Williamson <alex.williamson@redhat.com>
To: Andre Richter <andre.o.richter@gmail.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 02 Oct 2013 13:25:05 -0600
In-Reply-To: <CAKqeN2-uu9sV5g7LpTn-E8osOf1L3mi97FnA1Oi6YJAs8POBCw@mail.gmail.com>
References: <CAKqeN2-uu9sV5g7LpTn-E8osOf1L3mi97FnA1Oi6YJAs8POBCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-10-02 at 21:10 +0200, Andre Richter wrote:
> Hello all,
> 
> i have an SRIOV capable device which has its PF behind 01:00.0.
> After enabling SRIOV, the VFs show up as 01:08.0, 01:08.1 and so on.
> 
> Due to several stupid reasons, I'd like to do a quick and dirty hack
> that makes my VFs show up as 01:00.1, 01:00.2 and so on.
> 
> I'd be so happy for any hints where to start with this.
> 
> What I found already is virtfn_devfn() in iov.c, where the devfns for
> the VFs are computed, but changing it here doesn't work. I guess this
> has to be done way before?
> However, I wonder where the rule for computing the devfn comes from?

Can't be done, the VF address is determined by the stride and offset in
the SR-IOV capability on the PF which are read-only per the SR-IOV spec.
The kernel doesn't get to decide where they appear.  Thanks,

Alex

