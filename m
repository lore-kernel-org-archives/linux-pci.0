Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:55795 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688Ab3EFT4L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 May 2013 15:56:11 -0400
Received: by mail-ia0-f174.google.com with SMTP id e36so3525256iag.19
        for <linux-pci@vger.kernel.org>; Mon, 06 May 2013 12:56:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367837311.15842.31.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<1367837311.15842.31.camel@pasglop>
Date: Mon, 6 May 2013 12:56:11 -0700
Message-ID: <CAE9FiQU=ZEfvVKeQgVOa0jeG5smJrKRaeLTOckR=v2vzTyTvLw@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 6, 2013 at 3:48 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2013-05-06 at 18:31 +0800, Gavin Shan wrote:
>> The possible (temporary) fix would be checking "local_fail_head" in function
>> __assign_resources_sorted() and don't do reassignment if all the element in
>> the list is IO related. In the future, we might introduce specific flag to
>> indicate the PCI host can't support IO and skip all IO assignment accordingly.
>
> Yinghai, what's the best we can do for 3.10 ? This kernel will go to enterprise
> distros I'm told and that's a pretty nasty problem for some of our machines
> that don't do IO.

ok, will look at that today.

will fix that from pci core side.

as later on x86 8 sockets and even 32 sockets system, will have more chance
that some root bus will not get io port allocation ...

Thanks

Yinghai
