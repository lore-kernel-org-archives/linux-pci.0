Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:54752 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423279Ab3FUQNY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 12:13:24 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so7383968lab.8
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 09:13:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
Date: Fri, 21 Jun 2013 17:13:22 +0100
Message-ID: <CAH9N0t_NUOq_XNb1mQKqPFG=bRDLTP_DqRgUL2G6XJ2bTd2ssA@mail.gmail.com>
Subject: PCIe Hotplug Script Automatization
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I'm trying to automatize the hotplug procedure.
As far as i have seen it is possible using the udev deamon.

1. I have a script to remove a pcie card when it is unpluged from
system but i am doing it manually.
2. Also I have a pcie board script that actually re-enumerates the pci
bus and inserts the device drivers when the card is plugged into the
system.

My question: is it possible to trigger these scripts automatically? If
so, how can that be done exactly?

Regards,
Paulo.
