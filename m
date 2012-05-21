Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s9.blu0.hotmail.com ([65.55.111.148]:12357 "EHLO
	blu0-omc4-s9.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752749Ab2EUTdx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2012 15:33:53 -0400
Message-ID: <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
Date: Mon, 21 May 2012 20:33:49 +0100
From: Rob Allen <ra-kernel@hotmail.co.uk>
MIME-Version: 1.0
To: Clemens Ladisch <clemens@ladisch.de>
CC: Yinghai Lu <yinghai@kernel.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl> <4FB3B159.2090401@ladisch.de>
In-Reply-To: <4FB3B159.2090401@ladisch.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/05/12 14:53, Clemens Ladisch wrote:
> Rob Allen wrote:
>> On 14/05/12 07:39, Yinghai Lu wrote:
>>> can you post full log with pci debug enabled with lastest upsteam kernel?
>>
>> I'm happy to do that, although I need with some guidance on what I need to
>> enable to get the required output.
>
> For Ubuntu, see<https://wiki.ubuntu.com/KernelTeam/GitKernelBuild>.
>
> To enable PCI debugging, enable the configuration options
> CONFIG_DEBUG_KERNEL and CONFIG_PCI_DEBUG.

Thanks. I've built the kernel and I can replicate the failure.

However, I'm having trouble getting the log output. As soon as I see the 
"firewire_ohci: Failed to set Link Power Status" message, the machine 
locks up. After cycling the power, that log output isn't anywhere in 
/var/log anywhere (even if I booted with 'rw').

After some searching, I guess a decent route is to output to a serial 
console. The machine in question doesn't have a serial port, although I 
have a PCI-e serial card somewhere. (Is that likely to work so early in 
the boot process?)

Can you suggest the best way to get the log output?

Thanks,
Rob
