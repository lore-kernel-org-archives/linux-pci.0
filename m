Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32979 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbaKSSca (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 13:32:30 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so1489097igi.6
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 10:32:30 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 19 Nov 2014 11:32:29 -0700
Message-ID: <CA+r1ZhgMQF4pxwFTRyLQxQJVVzXp17AO0p7FQrfZwoFPWA+FNg@mail.gmail.com>
Subject: randconfig warnings with next-20141119, in drivers/pci/probe.c
From: Jim Davis <jim.epost@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hej! Builds with CONFIG_X86_32=y are getting these warning messages

drivers/pci/probe.c:430:5: warning: left shift count >= width of type
[enabled by default]
drivers/pci/probe.c:431:5: warning: left shift count >= width of type
[enabled by default]

which would seem to refer to

                               base |= ((dma_addr_t) mem_base_hi) << 32;
                                limit |= ((dma_addr_t) mem_limit_hi) << 32;
