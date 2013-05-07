Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:47492 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3EGWoT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2013 18:44:19 -0400
MIME-Version: 1.0
In-Reply-To: <1367965682.25488.26.camel@pasglop>
References: <1367965054-9013-1-git-send-email-yinghai@kernel.org>
	<1367965054-9013-4-git-send-email-yinghai@kernel.org>
	<1367965682.25488.26.camel@pasglop>
Date: Tue, 7 May 2013 15:44:18 -0700
Message-ID: <CAE9FiQUC74+jp0JcfpqZu=BZc+rWnnuFS5UZGKL=w_GOXeLavw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] PCI: Skip IORESOURCE_MMIO allocation for root bus
 without MMIO range
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 7, 2013 at 3:28 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2013-05-07 at 15:17 -0700, Yinghai Lu wrote:
>> For x86 8 sockets or 32 sockets system that will have one root bus per socket,
>> They may have some root buses do not have mmio non-pref range.
>
> That seems very odd. Most device registers are non-prefetchable. I know
> of no adapter today that would work in a prefetchable-only environment.

FC/10G/FCoE from Qlogic and Emulex can be used with 64bit mmio-pref only.

pci bridge will only support 32bit non-pref mmio, so we have them under 4G,
and it could be only 2G at most.

x86 32 socket system, we may need to leave more mmiol for only several
sockets to make them work with cards that does not support mmio 64 bit pref.

we can always have enough 64bit mmio pref above 4G....

>
> Are you sure that isn't the other way around ?
>
> Regarding your 3.10 patches, me and Gavin will test your v3 later today
> (ASAP) and will give you an Ack if they work, in which case they should
> hit Linus as soon as Bjorn is comfortable with :-)

Thanks

Yinghai
