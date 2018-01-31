Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:48466 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeAaMl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jan 2018 07:41:26 -0500
Date: Wed, 31 Jan 2018 13:41:24 +0100
From: Martin Mares <mj@ucw.cz>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] Fix Vector table and PBA addresses print output
Message-ID: <mj+md-20180131.124058.57203.nikam@ucw.cz>
References: <998ca55d1a2b9a7f6912dcff69bc57d31b690fb0.1517308416.git.gustavo.pimentel@synopsys.com>
 <20180130070718.335deb52@w520.home>
 <80372960-864f-0f7d-db04-c2cb49631f63@synopsys.com>
 <20180130094542.1457e2fd@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180130094542.1457e2fd@w520.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> Which is a meaningless and misleading value.  The PBA lives at offset
> 0x1800 into BAR0 MMIO space, why is anything other than that relevant
> to present to the user?  By your logic we should also present
> count as 32 and let the user figure out that it's encoded as N-1.

I completely agree that we should display the real offset (as we do now).

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The better the better, the better the bet.
