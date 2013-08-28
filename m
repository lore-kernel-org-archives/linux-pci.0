Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-o-1.desy.de ([131.169.56.154]:52276 "EHLO smtp-o-1.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab3H1IJi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Aug 2013 04:09:38 -0400
Received: from smtp-map-1.desy.de (smtp-map-1.desy.de [131.169.56.66])
	by smtp-o-1.desy.de (DESY-O-1) with ESMTP id EFF90280835
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 10:09:36 +0200 (CEST)
Received: from ZITSWEEP1.win.desy.de (zitsweep1.win.desy.de [131.169.97.95])
	by smtp-map-1.desy.de (DESY_MAP_1) with ESMTP id E01C513EA2
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 10:09:34 +0200 (MEST)
Message-ID: <521DB03E.9000706@desy.de>
Date: Wed, 28 Aug 2013 10:09:34 +0200
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org
Subject: Re: PCIe endpoint crosstalk
References: <521C5AFF.90209@desy.de> <20130827162702.GB21180@google.com>
In-Reply-To: <20130827162702.GB21180@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/27/2013 06:27 PM, Bjorn Helgaas wrote:
> On Tue, Aug 27, 2013 at 09:53:35AM +0200, Ludwig Petrosyan wrote:
>> So: I use microTCA system with PCIe bus, there are two AMC cards (PCIe
>> endpoints), lets call card A and card B.
>> as well there are two device drivers for A and B. Card B has bug, after
>> PCIe memory write  operation (MWr) the card sends back Completion
>> packet without data (Cpl) (I now it is wrong, but card designed in this
>> way and has to be changed).
>> User process Ua reads data from Card A in loop, everything is OK , but
>> then I start second user process Ub which writes in loop data to card B
>> (bugged card) the Ua gets wrong data. After improving card B the problem
>> was solved, but could be it has to be checked on the PCIe driver level
>> as well.
> PCIe transactions (MWr, MRd, Cpl, etc.) are not directly visible
> to the OS or the driver.
>
> The only thing I can think of that we could do is add a quirk to
> blacklist the broken version of card B.  You can look at existing
> quirks in drivers/pci/quirks.c.  Most of them workaround issues
> that aren't quite as severe as this one, but we could probably
> figure out a way to make the device completely unusable.
>
> Or do you have something else in mind?
>
> Bjorn
We have fixed the bug in card B and now it is OK, but question is open,
what will happen if we got some PCIe endpoint card with the same bug:
read operations from other PCIe devices could be broken. Just I think
this problem should be solved on the OS level (I am not sure)

I will try to explain how things are going on how I think:

User process Ub sends Memory-Write request to card B, this is Posted
request, so just  after sending the request Ub forgets about it,
TLP of this packet contain Requester ID for RootComplex, at the same
time user process Ua (the RootComplex is free now) sends non-Posted
memory read request to card A and waits for Completion packet, but at
the same time the card B (bugged card, it should not send Completion to
Posted memory write request) send to RootComplex Completion Packet
without data and some how Ua get this data as result of his Memory Read
request. Seems the Completer ID (or Tag field) in Completion packet not
checked and completion from one PCIe endpoint returned as completion of
read request from other PCIe endpoint.

I want to say this is only an assumption, just I wont to be sure the
bugged PCIe device won't influence operation of other devices
But could be this problem has to be solved on PCIe Switch or RootComplex
side not in OS side...

with best regards

Ludwig
