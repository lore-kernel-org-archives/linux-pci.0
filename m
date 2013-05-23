Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45592 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758017Ab3EWRIh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 13:08:37 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so9584866ieb.10
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2013 10:08:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <519dcfbe.89e9420a.4934.488bSMTPIN_ADDED_BROKEN@mx.google.com>
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
Date: Thu, 23 May 2013 10:08:37 -0700
Message-ID: <CAE9FiQW==Zvwv976-xjtRFj70JWoZW94yQyM0NMTvMpR-yDG9Q@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 1:13 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> On Wed, May 22, 2013 at 01:50:35PM -0700, Yinghai Lu wrote:
>>On Wed, May 22, 2013 at 9:59 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> We try must+optional as first, then if there is any ioport or mmio fail
>>> we will stick to must only then extend must to meet optional.
>>> but mmio range and mmio-pref could be connected each other,
>>> so extend will fail...
>>>
>>> problem here, some root bus will not have ioport range, so it will always have
>>> ioport allocation fail.
>>>
>>> looks like right fix for v3.9 should be as attached patch.
>>> it will keep must+optional for mmio, if only ioport fails....
>>
>>looks like i missed change to realloc_head list.
>>
>>Ben/Shan, can you check attached v2?
>>
>
> Sorry for late response. I spend lots of time to get the simulator working
> with PCI stuff. I had a try with your patch on top of mainline (3.10.RC2).
> Things look good except that we still see the intended the failure message
> of failure to assign I/O ports as the attached kernel log indicates :-)
>

Good, will resend this as complete form to Bjorn for v3.10.

Thanks

Yinghai
