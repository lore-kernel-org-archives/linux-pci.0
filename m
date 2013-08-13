Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40952 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757659Ab3HML5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Aug 2013 07:57:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-pci@vger.kernel.org, Greg KH <gregkh@linux.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: Re: acpiphp and pciehp not working together on Thinkpad X200s
Date: Tue, 13 Aug 2013 14:08:09 +0200
Message-ID: <2083548.ARi4u8nkYX@vostro.rjw.lan>
In-Reply-To: <520A0153.4020406@message-id.googlemail.com>
References: <520747B6.8010309@message-id.googlemail.com> <11028683.ZZQRkho7yW@vostro.rjw.lan> <520A0153.4020406@message-id.googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 13, 2013 11:50:11 AM Stefan Seyfried wrote:
> Hi Rafael,

Hi,

> Am 11.08.2013 23:36, schrieb Rafael J. Wysocki:
> 
> > There's some ACPIPHP rework material queued up for 3.12 in linux-next, but
> > I doubt it'll make a difference on your machine.  Anyway, if you want to
> > try it, you can just pull the linux-next branch of my linux-pm.git tree
> > (to avoid pulling all of the other linux-next material in addition to it).
> 
> Just for the record: I tried that, and it did not change anything
> (acpiphp claims the slot and pciehp then does not work).

The idea was that acpiphp might work instead, but then it would work previously
too most likely.

Thanks,
Rafael

