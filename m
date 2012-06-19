Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [65.55.111.163] ([65.55.111.163]:62555 "EHLO
	blu0-omc4-s24.blu0.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752195Ab2FSVMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 17:12:10 -0400
Message-ID: <BLU0-SMTP4409FB70A51AD516797B0B1B7FF0@phx.gbl>
Date: Tue, 19 Jun 2012 22:11:40 +0100
From: Rob Allen <ra-kernel@hotmail.co.uk>
MIME-Version: 1.0
To: Ram Pai <linuxram@us.ibm.com>
CC: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Clemens Ladisch <clemens@ladisch.de>,
	Yinghai Lu <yinghai@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl> <4FB3B159.2090401@ladisch.de> <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl> <4FBAA3A5.4070200@ladisch.de> <20120524202610.5c561d99@stein> <4FBE8146.1030803@hotmail.co.uk> <BLU0-SMTP435F81F04D60963F0755BA9B70F0@phx.gbl> <20120605025422.GB6637@ram-ThinkPad-T61>
In-Reply-To: <20120605025422.GB6637@ram-ThinkPad-T61>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/06/12 03:54, Ram Pai wrote:
> We need to determine whether the ohci device behaves abnormally if it gets
> assigned a address other than what is assigned by the BIOS.
>
> To do that; as Yinghai suggested, lets see the contents of the
> register with and without the patch.
>
> output of the following command on a working kernel and a non-working
> kernel will shed some light.
>
> lspci -vvxxx -s 0a:09.4

Working kernel:
https://bugzilla.kernel.org/attachment.cgi?id=73871

Non-working kernel:
https://bugzilla.kernel.org/attachment.cgi?id=73881

> also boot messages on a working kernel will also be helpful.

https://bugzilla.kernel.org/attachment.cgi?id=73861

(Sorry for the delay in getting these.)

Thanks,
Rob
