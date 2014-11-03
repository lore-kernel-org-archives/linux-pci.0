Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33862 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaKCT3e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 14:29:34 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn18so5235962igb.9
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2014 11:29:33 -0800 (PST)
Date: Mon, 3 Nov 2014 12:29:30 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Elmar Stellnberger <estellnb@elstel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: [Bug 43192] ExpressCards are not recognized
Message-ID: <20141103192930.GA26548@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=43192

Elmar reported this bug over two years ago.  Anybody who's interested is
more than welcome to take a look at it.

> Whether I try to use ExpressCards on a system with native ExpressCard
> interface (Amilo Xi2550, AdapterNo: 07473DD) or with a PCMCIA to
> ExpressCard adapter (DeLock Card Adapter CardBus for E-Card) lspci does not
> recognize my ExpressCards (tried with DeLock and Transcend USB 3.0
> adapter). The only thing which is recognized is the PCMCIA to ExpressCard
> adapter, not the ExpressCards themselves.
> 
> # lspci | grep -i cardbus
> 00:0b.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
> 
> # diff lspci-n_adapter-only/transcend/delock.msg lspci-n_none.msg
> 17,18d16
> < 03:00.0 0c03: 1033:0035 (rev 44)
> < 03:00.1 0c03: 1033:00e0 (rev 05)

There are also other bugs languishing in the PCI bugzilla:

https://bugzilla.kernel.org/buglist.cgi?bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&bug_status=NEEDINFO&columnlist=assigned_to%2Cbug_status%2Ccf_kernel_version%2Cshort_short_desc&component=PCI&order=bug_id%20DESC

I try to mention new incoming bugs on linux-pci in the hope that somebody
will adopt them, but sometimes I forget.  Sometimes I can look at things
myself, but I don't have time to work on them all.

Bjorn
