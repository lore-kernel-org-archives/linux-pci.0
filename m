Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63955 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab3HMJuQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2013 05:50:16 -0400
Received: by mail-wi0-f177.google.com with SMTP id hq12so389532wib.10
        for <linux-pci@vger.kernel.org>; Tue, 13 Aug 2013 02:50:15 -0700 (PDT)
Message-ID: <520A0153.4020406@message-id.googlemail.com>
Date: Tue, 13 Aug 2013 11:50:11 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-pci@vger.kernel.org, Greg KH <gregkh@linux.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: Re: acpiphp and pciehp not working together on Thinkpad X200s
References: <520747B6.8010309@message-id.googlemail.com> <1880950.SYaKzZm9j7@vostro.rjw.lan> <5207FFB8.3080202@message-id.googlemail.com> <11028683.ZZQRkho7yW@vostro.rjw.lan>
In-Reply-To: <11028683.ZZQRkho7yW@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

Am 11.08.2013 23:36, schrieb Rafael J. Wysocki:

> There's some ACPIPHP rework material queued up for 3.12 in linux-next, but
> I doubt it'll make a difference on your machine.  Anyway, if you want to
> try it, you can just pull the linux-next branch of my linux-pm.git tree
> (to avoid pulling all of the other linux-next material in addition to it).

Just for the record: I tried that, and it did not change anything
(acpiphp claims the slot and pciehp then does not work).

Best regards,

	Stefan
-- 
Stefan Seyfried
Linux Consultant & Developer -- GPG Key: 0x731B665B

B1 Systems GmbH
Osterfeldstraße 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
