Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:60233 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3EVVBb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 17:01:31 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6436111iea.18
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2013 14:01:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369255489.3870.19.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
	<CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
	<CAErSpo45wXjnDiXiZ1qs+Z7fsEoVmAxbjhGVvtZGEUkbd4bNKg@mail.gmail.com>
	<1369255489.3870.19.camel@pasglop>
Date: Wed, 22 May 2013 14:01:30 -0700
Message-ID: <CAE9FiQX5oLcEoNVPrutdUy+-wT5Vks2VR5BHg_6mB81apfmq1g@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 22, 2013 at 1:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2013-05-22 at 11:21 -0600, Bjorn Helgaas wrote:
>> > looks like right fix for v3.9 should be as attached patch.
>> > it will keep must+optional for mmio, if only ioport fails....
>>
>> I read all that before, but it didn't answer my questions.  I assume
>> we're trying to fix a device that doesn't work.  Which device is it?
>
> We have MMIO assignment failures due to the "retry" but so far it hasn't
> prevented the devices I have tested from working. It does make me very
> nervous however.
>

yes, io port allocation failure trigger wrong retry with mmio.

Yinghai
