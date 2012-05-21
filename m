Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33886 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758184Ab2EUUVY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2012 16:21:24 -0400
Message-ID: <4FBAA3A5.4070200@ladisch.de>
Date: Mon, 21 May 2012 22:20:53 +0200
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
To: Rob Allen <ra-kernel@hotmail.co.uk>
CC: Yinghai Lu <yinghai@kernel.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Ram Pai <linuxram@us.ibm.com>,
	linux1394-devel@lists.sourceforge.net, linux-pci@vger.kernel.org
Subject: Re: [Bug 43244] New: firewire_ohci prevents boot
References: <bug-43244-4803@https.bugzilla.kernel.org/> <20120513221357.7574ae79@stein> <4FB0A6F6.9050504@ladisch.de> <CAE9FiQXA4C8hACXChokL4CZVBDhdh17Qs7tngn5q-pS0U5=bPQ@mail.gmail.com> <BLU0-SMTP12B809D527F768CCC42B18B7180@phx.gbl> <4FB3B159.2090401@ladisch.de> <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
In-Reply-To: <BLU0-SMTP47479D78AA811CB0B224ADFB71D0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rob Allen wrote:
> I've built the kernel and I can replicate the failure.
>
> However, I'm having trouble getting the log output. As soon as I see
> the "firewire_ohci: Failed to set Link Power Status" message, the
> machine locks up. After cycling the power, that log output isn't
> anywhere in /var/log anywhere (even if I booted with 'rw').

Blacklist the firewire-ohci module (man modprobe.d), then you should be
able to get the log output until before the driver loads.  To see the
remaining messages on the screen, load it with "modprobe firewire-ohci"
after raising the console log level with "dmesg -n 8".


Regards,
Clemens
