Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52707 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab3EFKsp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 May 2013 06:48:45 -0400
Message-ID: <1367837311.15842.31.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 06 May 2013 20:48:31 +1000
In-Reply-To: <20130506103159.GA16927@shangw.(null)>
References: <1367712653.11982.19.camel@pasglop>
	 <1367712932.11982.20.camel@pasglop>
	 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	 <1367732090.11982.38.camel@pasglop>
	 <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	 <1367740336.11982.41.camel@pasglop>
	 <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	 <20130506103159.GA16927@shangw.(null)>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-05-06 at 18:31 +0800, Gavin Shan wrote:
> The possible (temporary) fix would be checking "local_fail_head" in function
> __assign_resources_sorted() and don't do reassignment if all the element in
> the list is IO related. In the future, we might introduce specific flag to
> indicate the PCI host can't support IO and skip all IO assignment accordingly.

Yinghai, what's the best we can do for 3.10 ? This kernel will go to enterprise
distros I'm told and that's a pretty nasty problem for some of our machines
that don't do IO.

Cheers,
Ben.


