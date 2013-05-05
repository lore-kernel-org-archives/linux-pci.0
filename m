Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53999 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab3EEFfC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 5 May 2013 01:35:02 -0400
Message-ID: <1367732090.11982.38.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 05 May 2013 15:34:50 +1000
In-Reply-To: <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
References: <1367712653.11982.19.camel@pasglop>
	 <1367712932.11982.20.camel@pasglop>
	 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2013-05-04 at 22:18 -0700, Yinghai Lu wrote:
> we intend to assign unassigned resources in two try,
> first one will try to allocate must_have and optional ones the same
> time.
> 
> if it fails to do that, will only allocate must_have again.
> 
> now optional one only include SRIOV related.

Hrm... ok. We'll eventually need some kind of hook here for power as
the way we deal with SR-IOV will have to be somewhat "special", but
I'll explain that some other time.

Anything shows up from my log about what you think might be the cause
of those assignment failures ?

Thanks !

Cheers,
Ben.


