Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from server1.meinberg.de ([85.10.202.66]:61000 "EHLO
	server1.meinberg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088Ab2ASJn4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2012 04:43:56 -0500
Message-ID: <4F17E5D9.3030902@meinberg.de>
Date: Thu, 19 Jan 2012 10:43:53 +0100
From: Martin Burnicki <martin.burnicki@meinberg.de>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-pci@vger.kernel.org
Subject: Re: PCI card not accessible; I/O ports at <ignored>
References: <4F16EA07.4000607@meinberg.de> <20120118162858.GB22156@kroah.com> <4F170DDB.3010105@meinberg.de> <20120118203536.GB2671@kroah.com>
In-Reply-To: <20120118203536.GB2671@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg KH wrote:
> On Wed, Jan 18, 2012 at 07:22:19PM +0100, Martin Burnicki wrote:
>> Greg KH wrote:
>>> On Wed, Jan 18, 2012 at 04:49:27PM +0100, Martin Burnicki wrote:
>>>> Hi folks,
>>>>
>>>> I'm maintaining the driver software for the PCI cards manufactured
>>>> by our company, Meinberg Funkuhren in Germany. Basically our Linux
>>>> driver supports all our PCI cards on all Linux kernels 2.6.x and
>>>> 3.x. The PCI cards are e.g. GPS receivers, radio clocks, or IRIG
>>>> time code receivers.
>>>
>>> Nice, any reason why these drivers aren't in the main kernel.org tree?
>>
>> Yes, you wouldn't like the coding style of our driver ;-)
>>
>> Seriously, I have discussed this with some Linux guys before, and
>> also with some folks from *BSD who also wanted to pick up the driver
>> into their *BSD source trees.
>>
>>
>> The disadvantages of this approach were:
>
> <snip>
>
> That all makes sense, thanks.  It's your decision, but note, everyone
> who has ever taken the time to get their code into the main kernel tree,
> FreeBSD included, has had less time and energy maintaining it over the
> long-run.

This may be true e.g. for NIC drivers, etc, which need to talk to the 
NIC hardware at the downside and be compliant to the network stack API 
upwards.

However, for the kind of cards we are dealing with there is no 
standardized API (like the network stack) in the kernel which the kernel 
could use to access the hardware.

Based on a simple standard skeleton driver providing some methods for 
loading, unloading, ioctl, etc. the major changes required over the last 
years to support different kernel versions were to account for changes 
in the kernel API calls which need to be called by the driver, e.g. 
around 2.6.27 the function device_create() started to expect one more 
parameter than in earlier kernel versions.

We don't even use DMA or some other enhanced techniques since the amount 
of data to be transferred is usually marginal. The main

Appliances for our cards are usually to let applications read timestamps 
from the card as exactly as possible, and with as low latency and 
execution time as possible.

If new ways are found to improve this then the hardware/firmware needs 
to support this, the kernel driver needs to support this, etc.

As said earlier, with our approach we can make the required changes once 
in the source code and the new features are available under all 
supported operating systems and kernel versions.

If the code was in the kernel trees of several open source operating 
systems we either had to explain to every maintainer of every OS what 
they needed to change, or do it by ourselves individually for every OS 
and submit a number of patches.

> Plus, you get support for your customers from Red Hat and SUSE and
> others, and you don't void their warranty by loading unsupported kernels
> :)

In all the years we have supported Linux there have not been any 
stability problems due to our driver, even though it is not officially 
supported by distributions. ;-)

> But it's your business decision, if this is what you want to do, great,
> best of luck.

Thanks. Again I hope I could make the reasining for our approach clear 
enough, and I also hope that I'm anyway allowed to ask for some 
technical information here on this list, especially where my actual 
question is not even directly related to our driver, but just to changes 
in the kernel which cause existing PCI hardware to be treated 
differently as before.


Regards,

Martin
-- 
Martin Burnicki

Meinberg Funkuhren
Bad Pyrmont
Germany
