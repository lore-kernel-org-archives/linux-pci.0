Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta4.ai270.net ([94.126.40.171]:33158 "EHLO
	out-mta1.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933704AbcA1KXI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2016 05:23:08 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost> <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost> <56A8DA21.7060607@keynet-technology.com>
 <20160127215522.GA4875@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <56A9EC07.8080509@keynet-technology.com>
Date: Thu, 28 Jan 2016 10:23:03 +0000
MIME-Version: 1.0
In-Reply-To: <20160127215522.GA4875@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

Thanks for looking at it. Actually I've tried 3 different PCI cards in
both slots and they all work fine.  I have 2 different single channel
BT878 based PCI cards in there now capturing CCTV 24 x 7, the machine
stays up for months. That's why it's so odd.  Any other pointers?  Does
the kernel need the BIOS to detect the card right?

Thanks again
Richard

On 27/01/2016 21:55, Bjorn Helgaas wrote:
> Hi Richard,
> 
> On Wed, Jan 27, 2016 at 02:54:25PM +0000, Richard F wrote:
>> Would someone be able take a quick look at my logs and give me any kind
>> of steer as to where to look?  I'm happy to do some more debugging with
>> a bit of guidance.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=110851
> 
> The kernel doesn't see the bt878 devices at all on your new machine,
> with the exception of the boot in comment #6, where you added another
> card in an adjacent slot.  That makes me think there might be a
> hardware problem with the slot.  Can you try a completely different
> kind of card in that slot?  Do devices in that slot work with any
> other OS?

