Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41838 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756282Ab3FRVZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 18 Jun 2013 17:25:40 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, alexdeucher@gmail.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-acpi@vger.kernel.org, Jiang Liu <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUGFIX v2 0/4] fix bug 56531, 59501 and 59581
Date: Tue, 18 Jun 2013 23:35:01 +0200
Message-ID: <1880810.6jIKdDRiJm@vostro.rjw.lan>
In-Reply-To: <CAN_LGv2Y6jebtNUQ1gJYfy8uG2pxtUjT1gqMPmL+6E7myELd3A@mail.gmail.com>
References: <1371238081-32260-1-git-send-email-jiang.liu@huawei.com> <CAN_LGv1itN=ADE-3LNCoBJFXmpWZffhQb6NQuoBzvONkX3brug@mail.gmail.com> <CAN_LGv2Y6jebtNUQ1gJYfy8uG2pxtUjT1gqMPmL+6E7myELd3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, June 15, 2013 01:25:48 PM Alexander E. Patrakov wrote:
> 2013/6/15 Alexander E. Patrakov <patrakov@gmail.com>:
> > Note that the snd_hda_intel bug somehow didn't manifest itself today,
> > probably because the TV that is connected to the HDMI output of the
> > radeon card was off and because Xorg never really tried to use the
> > card.
> 
> Well, it did. The sympthoms are the same as before: incomplete
> undocking. The 16:00.1 device (HD audio controller on the radeon card)
> has disappeared from lspci output, while 16:00.0 (the radeon card
> itself) didn't, and the "Docked" LED didn't turn off. Fixed up by this
> command:
> 
> fuser -k /dev/snd/* ; rmmod snd-hda-intel
> 
> thus confirming again that the extra references that acpiphp waits to
> go away are from open fds.

OK, let's try to untangle this a bit.

If you applyt patches [1/4] and [4/4] from the $subject series only, what
does remain unfixed?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
