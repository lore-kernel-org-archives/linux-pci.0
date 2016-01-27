Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta4.ai270.net ([94.126.40.171]:33685 "EHLO
	out-mta1.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932957AbcA0Oyb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jan 2016 09:54:31 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost> <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <56A8DA21.7060607@keynet-technology.com>
Date: Wed, 27 Jan 2016 14:54:25 +0000
MIME-Version: 1.0
In-Reply-To: <20160119033839.GA3339@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

Would someone be able take a quick look at my logs and give me any kind
of steer as to where to look?  I'm happy to do some more debugging with
a bit of guidance.

https://bugzilla.kernel.org/show_bug.cgi?id=110851

Thanks
Richard


On 19/01/2016 03:38, Bjorn Helgaas wrote:
> On Mon, Jan 18, 2016 at 02:48:59PM +0000, Richard F wrote:
>> I posted a DMESG with 4.3.3 to Bugzilla now.
>> 4.4.0 crashed on boot, not sure why yet.
> 
> Thanks for all the data you collected!  I haven't had a chance to look
> at them yet, but maybe others will take a look also.
> 
> Crashing on boot is a much more serious problem than failure to find a
> card.  Any information you can collect about the v4.4.0 problem would
> be extremely useful.  A serial console log would be ideal, but even a
> photo or video of the boot might be helpful.  Boot with
> "ignore_loglevel" to make sure we see all the messages.
> 
> Bjorn
> 

