Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51172 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab2BXFEZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 00:04:25 -0500
Received: by wics10 with SMTP id s10so1197284wic.19
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2012 21:04:24 -0800 (PST)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 21:04:04 -0800
Message-ID: <CAErSpo67Y4xtctJ=a8LQLqopRyM9_3gYKwFSUw8kT6XEVsPZzA@mail.gmail.com>
Subject: pci_probe_only and bus_to_resources patches rebased to pci linux-next branch
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jesse,

I rebased these series:

    v2 generic pci_probe_only flag
    (http://marc.info/?l=linux-pci&m=133002621016744&w=2)

    v2 add PCI bus-to-resource offset support in core
    (http://marc.info/?l=linux-pci&m=132884138928641&w=2)

onto your current linux-next tree (based on commit 823806ff).  Minor
conflict resolutions in include/linux/pci.h, and that's about it.

You can examine the result here:

    https://github.com/bjorn-helgaas/linux/tree/pci-next+probe_only+bus2res-fb127cb

or pull both series with:

    git pull git://github.com/bjorn-helgaas/linux.git
pci-next+probe_only+bus2res-fb127cb

Bjorn
