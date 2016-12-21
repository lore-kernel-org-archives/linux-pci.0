Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37035 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbcLUQxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2016 11:53:33 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so164054489wmt.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Dec 2016 08:53:32 -0800 (PST)
Received: from [10.82.95.35] (soho87-122.sohonet.co.uk. [193.203.87.122])
        by smtp.gmail.com with ESMTPSA id j6sm31455171wjk.25.2016.12.21.08.53.30
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:53:30 -0800 (PST)
From: Harry Mallon <hjmallon@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: lspci memory behind bridge reporting
Message-Id: <CDB45911-510C-459D-BCDC-17955FCC400D@gmail.com>
Date: Wed, 21 Dec 2016 16:53:30 +0000
To: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

I am currently debugging a PCIE BAR assignment issue and am working on a =
patch to save me some time in future with lspci. Would patches like this =
be considered? Does anyone have any input on the proposed formats of the =
readouts?

1. Currently if a bridge has no memory behind bridge it displays =
messages like the following, for reasons of PCI implementation detail.

I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff

I would prefer:
I/O behind bridge: None
Memory behind bridge: None
Prefetchable memory behind bridge: None

2. It would be useful for me to have access to the amount of memory in =
these chunks (my mental hex subtraction is pretty terrible). Maybe this =
would be displayed something like

I/O behind bridge: 0000c000-0000dfff [8.00K]
Memory behind bridge: f4000000-f65fffff [38.00M]
Prefetchable memory behind bridge: 00000000e0000000-00000000f3ffffff =
[320.00M]


Thanks for your feedback,
Harry Mallon


