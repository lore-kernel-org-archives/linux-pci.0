Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48491 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab2FEGfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jun 2012 02:35:47 -0400
Received: from /spool/local
	by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Tue, 5 Jun 2012 02:35:46 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A788238C8054
	for <linux-pci@vger.kernel.org>; Tue,  5 Jun 2012 02:35:43 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q556ZhqG122210
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 02:35:43 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q556ZgvF028943
	for <linux-pci@vger.kernel.org>; Tue, 5 Jun 2012 03:35:43 -0300
Date: Tue, 5 Jun 2012 14:35:38 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: One chart on pci bridge and its bus and their children
Message-ID: <20120605063538.GE6637@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20120605032627.GA23271@richard>
 <20120605041146.GD6637@ram-ThinkPad-T61>
 <CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
 <CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
 <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQUCV1+ePfyX7bqOyZ+Wcsj1neCO91MvuM5vNh3+UPERDQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 04, 2012 at 10:20:51PM -0700, Yinghai Lu wrote:
> On Mon, Jun 4, 2012 at 10:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Mon, Jun 4, 2012 at 9:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> That's true, but I don't think it answers the question.  If we have:
> >>
> >>    pci_bus->bridge == pci_bus->self->dev
> >>
> >> why would we need both "self" and "bridge"?  It would be interesting
> >> to try to remove "bridge" and replace uses of it with "self->dev".
> >
> > then how about root bus?
> >
> > root bus ->self should be NULL.
> >
> > root bus ->bridge is to the hostbridge->dev.

Yinghai,

is there a reason why this can't be fixed in
pci_create_root_bus() by having
   bus->self = bridge; /* 'bridge' is the pci_device of the corresponding host bridge */
   get_device(&bridge->dev);


RP

