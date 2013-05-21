Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38613 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223Ab3EUWEL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 May 2013 18:04:11 -0400
Message-ID: <1369173711.6387.67.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 22 May 2013 08:01:51 +1000
In-Reply-To: <CAErSpo4jW3v5CTDAoqNqr-q9BNFPPFjHuy3BcrgjQumQ8HGVNg@mail.gmail.com>
References: <1367712653.11982.19.camel@pasglop>
	 <1367712932.11982.20.camel@pasglop>
	 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	 <1367732090.11982.38.camel@pasglop>
	 <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	 <1367740336.11982.41.camel@pasglop>
	 <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	 <1367837311.15842.31.camel@pasglop>
	 <CAE9FiQU=ZEfvVKeQgVOa0jeG5smJrKRaeLTOckR=v2vzTyTvLw@mail.gmail.com>
	 <5188b791.a110420a.0bea.077eSMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAE9FiQUc2q0GfVumVrp3_ba0q6N_a_WxjKhMWbyqbLfO=WGaFQ@mail.gmail.com>
	 <1368768974.20726.1.camel@pasglop>
	 <CAErSpo4jW3v5CTDAoqNqr-q9BNFPPFjHuy3BcrgjQumQ8HGVNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-05-21 at 11:28 -0600, Bjorn Helgaas wrote:
> On Thu, May 16, 2013 at 11:36 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2013-05-07 at 15:21 -0700, Yinghai Lu wrote:
> >> I just sent v3, please test that.
> >>
> >> That should be less invasive for v3.10. As it will skip adding faile
> >> resource to failed list when the resource is IORESOURCE_IO, and bus
> >> does not have IORESOURCE_IO.
> >
> > Any news about merging this ?
> 
> I'm starting to look at this.  Do you think this is v3.10 material?
> My first impression is that it seems pretty large for that.

Well, it's problematic for us, the assignment fails here or there on
some of our new systems with the new code multi-pass code for memory due
to the lack of IO which is nasty at best.

We were hoping we could get 3.10 to support those machines since that's
apparently what a well known enterprise distro will pickup (and trying
to get them to pickup backport can be complete hell).

Cheers,
Ben.




