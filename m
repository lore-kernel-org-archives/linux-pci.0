Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:56919 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446Ab3EXQds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 May 2013 12:33:48 -0400
Message-ID: <1369413197.30145.27.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Sat, 25 May 2013 02:33:17 +1000
In-Reply-To: <CAErSpo40LBfJGHfGiveE-czMgbF=qqziySCPgPAAJT3BYBS__A@mail.gmail.com>
References: <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	 <1367732090.11982.38.camel@pasglop>
	 <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	 <1367740336.11982.41.camel@pasglop>
	 <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	 <518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
	 <CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
	 <CAE9FiQXw=Q9hDWMS3kx8=G0eSqo2keKh-VP3=LWZ31PfXmrAmg@mail.gmail.com>
	 <519dcfbe.89e9420a.4934.488bSMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAE9FiQW==Zvwv976-xjtRFj70JWoZW94yQyM0NMTvMpR-yDG9Q@mail.gmail.com>
	 <CAErSpo5ASyYvRJgA3TDt7A5xtxL0sqopfAxbnJwDL=z_2hDJag@mail.gmail.com>
	 <CAE9FiQX8o97RY-Bd9t1vj+gm_Uri0v_hAUwecaNoF2GwGGTNyA@mail.gmail.com>
	 <CAErSpo5vY-DY9_bLWbM5UNrSZdO5dyASx1hLGMQg-ypgZHXLLg@mail.gmail.com>
	 <CAE9FiQWyEhdQGjC+hiGxOHdHwZoajfwfcgp26wivqL0s62NPkA@mail.gmail.com>
	 <1369344196.3870.35.camel@pasglop>
	 <CAE9FiQUS9rUfhH=J5pgynO6Xhrnn8Rx4pHeZ=p0dHm0fUoHd3A@mail.gmail.com>
	 <CAErSpo40LBfJGHfGiveE-czMgbF=qqziySCPgPAAJT3BYBS__A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-05-24 at 09:59 -0600, Bjorn Helgaas wrote:
> I do not agree that your current patches are the right way to fix
> this.  You are trying to make a relatively small patch that we can
> wedge into v3.10 in a hurry.  I would prefer that we work out a
> cleaner solution that simplifies reassignment, *then* figure out the
> best way to backport it as needed.

I agree. The current stuff seems to be working enough for basic
functionality (read: getting the distro installer to work). If the only
problem we have is with SR-IOV or hotplug I can deal with that.

The right solution is to once and for all consider IO and MEM as two
completely separate address spaces that require completely different
passes IMHO.

Cheers,
Ben.


