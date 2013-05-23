Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43791 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758563Ab3EWVXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 May 2013 17:23:32 -0400
Message-ID: <1369344196.3870.35.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Fri, 24 May 2013 07:23:16 +1000
In-Reply-To: <CAE9FiQWyEhdQGjC+hiGxOHdHwZoajfwfcgp26wivqL0s62NPkA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-05-23 at 14:00 -0700, Yinghai Lu wrote:
> Yes, that is what patch try to do. Keep the mmio allocation from first
> try, and only retry with io port.

Can you describe more precisely what happens with the *current* code ?

Ie. The first pass allocates my device MMIO regions fine. The second
pass them spew some error messages about some mem allocation. I can
still observe *something* being assigned to devices and in the (limited)
setup I've been able to test with, so far, the devices seemed to still
work, so I don't have a good grasp of the extent of the risk here.

Is there a chance that this failed "second pass" actually prevents
proper allocation of resources ?

Cheers,
Ben.


