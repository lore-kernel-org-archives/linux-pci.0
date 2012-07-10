Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:51880 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307Ab2GJVmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Jul 2012 17:42:35 -0400
In-Reply-To: <CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se> <CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
Subject: Re: PICe hotplug problems
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, yhlu.kernel@gmail.com
Message-ID: <OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 10 Jul 2012 23:42:32 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

yhlu.kernel@gmail.com wrote on 2012/07/10 20:22:09:

>
> On Tue, Jul 10, 2012 at 10:29 AM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> >
> > I got an PCIe device that is woken up by user space, clocks needs to configured in various ways before the
> > device enables its PCIe interface.
> >
> > The device is connected to a built in root bridge on a P2010(mpc85xx) CPU.
> > To enable HP in Linux we need to apply some minor hacks.
>
> can you post lspci -vvxxx -s BB:DD:F of the two devices?

Not really, this is an embedded device with limited SW. I got
busybox and its lspci but that is very limited:
# > ./busybox lspci -mk
00:00.0 "Class 0604" "1957" "0079" "0000" "0000" "pcieport"
01:00.0 "Class 0200" "14e4" "b540" "14e4" "b540"

Does that tell you anything?

 Jocke

