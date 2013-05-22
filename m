Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39579 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab3EVOzU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 10:55:20 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so2750518oag.19
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2013 07:55:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1367712653.11982.19.camel@pasglop> <1367712932.11982.20.camel@pasglop>
 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
 <1367732090.11982.38.camel@pasglop> <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
 <1367740336.11982.41.camel@pasglop> <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com> <518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 May 2013 08:54:59 -0600
Message-ID: <CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
Subject: Re: Resource assignment oddities
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 6, 2013 at 4:31 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> On Sun, May 05, 2013 at 08:04:48PM -0700, Yinghai Lu wrote:
>>On Sun, May 5, 2013 at 7:08 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
>>> On Sun, May 05, 2013 at 05:52:16PM +1000, Benjamin Herrenschmidt wrote:
>>>>On Sun, 2013-05-05 at 00:09 -0700, Yinghai Lu wrote:
>
> Hi Ben/Yinghai,
>
> Here's what happened for the failure to allocate memory window of P2P
> bridge 0001:01:00.0.
>
> 1. Sizing P2P bridge window.
> 2. Allocated resources in sorted order for specific PCI bus. Unfortunately,
>    it should fail since the PCI bus doesn't IO (not MMIO) resource. So in
>    function __assign_resources_sorted(), those resources that have been allocated
>    would be released, then allocate the so-called "must-have" resources and
>    eventually allocate the additional size for the corresponding resource. However,
>    we have some conflict in the last step (the additional size). Let have one
>    example here.
>
>    [0 24MB] Memory window of bus 0001:01     "ROOT"
>    [0 8MB]  Meory window#0 of 0001:01:00.0   "WIN#0"   with additional size 8MB
>    [0 8MB]  Memory window#1 of 0001:01:00.0  "WIN#1"   with additional size 0
>
>    If the last step (mentioned as above) fails, the resource would be allocated
>    in following sequence:
>
>    WIN#0  ->  WIN#1       -> WIN#0 with additional size 8MB
>    [0 8MB]    [8MB 16MB]     No available space for this one (16MB)
>
> The possible (temporary) fix would be checking "local_fail_head" in function
> __assign_resources_sorted() and don't do reassignment if all the element in
> the list is IO related. In the future, we might introduce specific flag to
> indicate the PCI host can't support IO and skip all IO assignment accordingly.

What exactly is the problem here?  Is it just that you don't want to
see the "can't assign" messages?  Or is there a device with a BAR that
*should* be assigned, but isn't?  If so, which device is it?

Bjorn
