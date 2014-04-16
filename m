Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:32817 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbaDPGdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Apr 2014 02:33:45 -0400
Message-ID: <1397629987.32730.9.camel@pasglop>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>, Yinghai Lu <yinghai@kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 16 Apr 2014 16:33:07 +1000
In-Reply-To: <1397629816.32730.8.camel@pasglop>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
	 <1394222924-28886-1-git-send-email-yinghai@kernel.org>
	 <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
	 <20140408025738.GA3198@yanx>
	 <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
	 <20140409075215.GA3173@yanx>
	 <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
	 <20140415115450.GA7792@yanx>
	 <CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
	 <1397629816.32730.8.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-04-16 at 16:30 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2014-04-15 at 18:09 -0600, Bjorn Helgaas wrote:
> > 
> > Thanks for the example.  Please open a bug report at
> > http://bugzilla.kernel.org and attach the complete dmesg logs before
> > and after Yinghai's patch.
> > 
> > Having the complete logs helps me answer questions myself without
> > having to bother you, and it also helps me figure out whether we can
> > improve our logging to make it easier to diagnose problems like this.
> 
> Unfortunately, for a *little while* longer (hint !) we can't publish
> a complete log from a Power8 machine, but we should be able to include
> everything remotely related to PCI.

Hrm, actually, I'm not sure we can disclose the device details just yet,
so let's just hide the vendor/device ID to make the lawyers happy and
you can print all the rest.

Cheers,
Ben.


