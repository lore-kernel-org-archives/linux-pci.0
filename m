Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s13.blu0.hotmail.com ([65.55.111.152]:3070 "EHLO
	blu0-omc4-s13.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964796Ab2EPNM7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 May 2012 09:12:59 -0400
Message-ID: <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
Date: Wed, 16 May 2012 14:12:55 +0100
From: Rob Allen <ra-kernel@hotmail.co.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Clemens Ladisch <clemens@ladisch.de>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net,
	bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/05/12 07:39, Yinghai Lu wrote:
> On Sun, May 13, 2012 at 11:32 PM, Clemens Ladisch<clemens@ladisch.de>  wrote:
>> I'm not sure how resource-related changes can result in something that looks
>> like a power management issue, but maybe the chip doesn't allow register
>> accesses after its resources are moved, or something like that.  Any ideas?
>>
>
> can you post full log with pci debug enabled with lastest upsteam kernel?

Yinghai,

Sorry for the delay.

I'm happy to do that, although I need with some guidance on what I need 
to enable to get the required output.

(I've been using pre-built kernels so far, and I've never built and 
installed from source. I'm not averse to doing so, but please just bear 
it in mind that I'm a newbie!)

Thanks,
Rob
