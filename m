Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tor-sh10.fullhost.com ([162.219.163.6]:35543 "EHLO
	tor-sh10.fullhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbaFMRqE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jun 2014 13:46:04 -0400
Received: from cpe0013f7f0fb44-cm0013f7f0fb40.cpe.net.cable.rogers.com ([174.112.49.58]:52908 helo=[192.168.0.185])
	by tor-sh10.fullhost.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <patrick@spellingbeewinnars.org>)
	id 1WvVYA-0014fJ-DA
	for linux-pci@vger.kernel.org; Fri, 13 Jun 2014 13:46:02 -0400
Message-ID: <539B3878.2070202@spellingbeewinnars.org>
Date: Fri, 13 Jun 2014 13:44:24 -0400
From: Patrick <patrick@spellingbeewinnars.org>
MIME-Version: 1.0
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: help with setpci "no devices at"
References: <539B2609.3090106@spellingbeewinnars.org>
In-Reply-To: <539B2609.3090106@spellingbeewinnars.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/06/14 12:25 PM, Patrick wrote:
> Hi Everyone
>
> Thanks again to Bjorn for helping me in the thread "updating firmware 
> with setpci"
>
> I have started a new thread as it's more specific than the previous 
> one and might be more valuable this way in the archives.
>
> I replaced a PCI chip on one card I am trying to copy the good PCI 
> configuration space settings from another card, as-is they are very 
> different and the repaired card is failing.
>
> I found a perfect little awk script here to generate setpci commands 
> from lspci -xxx  :
>
> https://gist.github.com/jlopez-git/4594728
>
> I ended up with setpci complaining about missing a width. I found this 
> thread:
> https://access.redhat.com/site/solutions/45240
>
> It looks like older versions of the tool did not require widths to be 
> specified. The awk script may be a bit dated.
>
> I changed XX= to XX.b=
> setpci -sD 04:01.0 00.b=813010e8
>
> based on:
> http://www.tutorialspoint.com/unix_commands/setpci.htm
> which gave this example:
> setpci -s 13:8.4 40.b=50:d0,04:0c,ff
>
>
> but now I have another error:
> setpci: Warning: No devices selected for "04:01.0".
> setpci: Invalid width "0".
>
>
> lspci shows the device at:
> 04:01.0 Unassigned class [ff00]: Device a101:81ff
>
> The example showed the b near the register address but the "invalid 
> width 0" error has me wondering if it's supposed to go somewhere else 
> or I should be using a different width flag.
>
> Could someone point me in the right direction ?
>
> Thanks for reading-Patrick
>
>

I am not sure if it is good etiquette to answer your own post but I 
wanted to mention that I found two of my mistakes.

I specified B but I was writing 4 bytes. I thought I better use the -D 
flag to test-run things but that doesn't look right in this situation.

setpci -s  04:01.0 0x00.L=813010e8

Ran without errors but the changes were not reflected in the card's 
configuration space. lspci -xxx gave the same results before and after. 
I have run all commands as root.

If anyone can point out another mistake I have made that would be so great.












