Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from blu0-omc4-s1.blu0.hotmail.com ([65.55.111.140]:61150 "EHLO
	blu0-omc4-s1.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933458Ab2EXSnX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 14:43:23 -0400
Message-ID: <BLU0-SMTP129FFE755310932B1C36438B7000@phx.gbl>
Date: Thu, 24 May 2012 19:43:18 +0100
From: Rob Allen <ra-kernel@hotmail.co.uk>
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Clemens Ladisch <clemens@ladisch.de>,
	Yinghai Lu <yinghai@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl> <4FB3B159.2090401@ladisch.de> <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl> <4FBAA3A5.4070200@ladisch.de> <20120524202610.5c561d99@stein>
In-Reply-To: <20120524202610.5c561d99@stein>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24/05/12 19:26, Stefan Richter wrote:
> On May 24 bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=43244
>>
>> --- Comment #3 from Rob Allen<ra-kernel@hotmail.co.uk>   2012-05-24 17:30:12 ---
>> Created an attachment (id=73381)
>>   -->  (https://bugzilla.kernel.org/attachment.cgi?id=73381)
>> dmesg from v3.4 with CONFIG_PCI_DEBUG

This dmesg is the result of following Clemens's advice: boot with 
firewire_ohci blacklisted, increase the log level and then manually load it.

I was unable to boot with 'debug', because each time I did so, I got a 
backtrace (*).

Please let me know if there's anything else I can provide to help.

--

(*) When booting with 'debug', I experienced repeatable crashes: 1 oops 
and several bugs at kernel/timer.c:1085. Crashes also occurred without 
'debug', but not 100% of the time. The stack trace varied, so I'm 
suspicious (I intend to check the machine's memory). I also reproduced 
the crash on a stock Ubuntu 3.4 kernel, but failed to do so on a stock 
Ubuntu 3.2.16 kernel.

Assuming this isn't my machine being unreliable, what's my next step for 
this issue?

Thanks,
Rob
