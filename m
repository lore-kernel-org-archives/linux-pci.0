Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:46609 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab2FEQnw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 12:43:52 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Tue, 5 Jun 2012 10:43:51 -0600
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9CA1EC9012C
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 12:40:44 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q55Geh1J134602
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 12:40:44 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q55GeRrG005900
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 10:40:28 -0600
Date: Wed, 6 Jun 2012 00:40:19 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Ram Pai <linuxram@us.ibm.com>, Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605164019.GF6637@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120605032627.GA23271@richard>
 <20120605041146.GD6637@ram-ThinkPad-T61>
 <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
 <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
 <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
 <20120605063538.GE6637@ram-ThinkPad-T61>
 <4FCE1AA3.5070601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FCE1AA3.5070601@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2012 at 10:41:39PM +0800, Jiang Liu wrote:
> On 06/05/2012 02:35 PM, Ram Pai wrote:
> > On Mon, Jun 04, 2012 at 10:20:51PM -0700, Yinghai Lu wrote:
> >> On Mon, Jun 4, 2012 at 10:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> >>> On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >>>> That's true, but I don't think it answers the question.  If we have:
> >>>>
> >>>>    pci_bus->bridge == pci_bus->self->dev
> >>>>
> >>>> why would we need both "self" and "bridge"?  It would be interesting
> >>>> to try to remove "bridge" and replace uses of it with "self->dev".
> >>>
> >>> then how about root bus?
> >>>
> >>> root bus ->self should be NULL.
> >>>
> >>> root bus ->bridge is to the hostbridge->dev.
> > 
> > Yinghai,
> > 
> > is there a reason why this can't be fixed in
> > pci_create_root_bus() by having
> >    bus->self = bridge; /* 'bridge' is the pci_device of the corresponding host bridge */
> Hi Ram,
> 	A host bridge has no associated pci_device because it's out of the
> PCI domain. PCI domain only covers the hierarchy starting from the host bridge,
> but doesn't include the host bridge itself.

That makes it even easier to kill pci_bus->bridge.

for non-root buses, we can access the bridge's device using
bus->self->dev and for root bridges we can silently ignore
the bridge's dev since we know that it does not exist; because
pci_bus->self is null.

No?
RP

