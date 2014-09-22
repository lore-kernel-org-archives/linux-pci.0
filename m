Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:40489 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbaIVN1z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 09:27:55 -0400
Received: by mail-la0-f51.google.com with SMTP id gi9so6615124lab.38
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 06:27:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140904202436.GA17125@google.com>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	<1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	<20140814202248.GA2071@google.com>
	<1409743007.1535.1.camel@pengutronix.de>
	<20140904202436.GA17125@google.com>
Date: Mon, 22 Sep 2014 10:27:54 -0300
Message-ID: <CAOMZO5AAZXVRu3WkKkU=5SM+t8CYBww+Jmqyz5UFYsdog479wA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Thu, Sep 4, 2014 at 5:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> Bjorn,
>>
>> I would have expected for this to show up in 3.17 as it fixes a real bug
>> and has been posted some time ago. While you have picked it up into your
>> pci/host-imx6 branch it doesn't show up in Linus tree nor in any pull
>> requests AFAICS.
>> Was it intentional from you to hold this patch or is this just an
>> oversight?
>
> Nope, I just missed it, thanks for the reminder.  I put in my
> for-linus branch and will ask Linus to pull it after it's been
> in -next for a few days.

We still don't see this patch applied in linux-next.
