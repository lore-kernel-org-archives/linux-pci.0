Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48883 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab2GAU4D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Jul 2012 16:56:03 -0400
Received: by vbbff1 with SMTP id ff1so3199781vbb.19
        for <linux-pci@vger.kernel.org>; Sun, 01 Jul 2012 13:56:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BAY153-W382DF41517C8EA770817E4B7EB0@phx.gbl>
References: <20120513221357.7574ae79@stein>
	<4FB0A6F6.9050504@ladisch.de>
	<CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com>
	<BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl>
	<4FB3B159.2090401@ladisch.de>
	<BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
	<4FBAA3A5.4070200@ladisch.de>
	<20120524202610.5c561d99@stein>
	<4FBE8146.1030803@hotmail.co.uk>
	<BLU0-SMTP435F81F04D60963F0755BA9B70F0@phx.gbl>
	<20120605025422.GB6637@ram-ThinkPad-T61>
	<BLU0-SMTP4409FB70A51AD516797B0B1B7FF0@phx.gbl>
	<BAY153-W382DF41517C8EA770817E4B7EB0@phx.gbl>
Date: Sun, 1 Jul 2012 13:56:02 -0700
Message-ID: <CAE9FiQXbo984cn-oXOZHZ6pbH4TsxZyKCwT3Fu5g_OJxGw4UZg@mail.gmail.com>
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
From: Yinghai Lu <yinghai@kernel.org>
To: Rob Allen <ra-kernel@hotmail.co.uk>
Cc: linuxram@us.ibm.com, stefanr@s5r6.in-berlin.de, clemens@ladisch.de,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 1, 2012 at 4:55 AM, Rob Allen <ra-kernel@hotmail.co.uk> wrote:
> Ram Pai,
>
> I've attached the logs you requested to the bugzilla entry, but I'm happy to
> help in any other ways I can. Please let me know if I can help any further.
>
> For now, I'm awaiting your response on the next step.

working one:
	Region 0: Memory at d0402000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at d0403000 (32-bit, non-prefetchable) [size=2K]
not working one:
	Region 0: Memory at d0401000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Region 1: Memory at d0403000 (32-bit, non-prefetchable) [disabled] [size=2K]

can not understand why could make a difference.

please try boot with pci=resource_alignment=13@a0:09.4

Thanks

Yinghai
