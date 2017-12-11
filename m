Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:38318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdLKSt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Dec 2017 13:49:27 -0500
Date: Mon, 11 Dec 2017 13:49:26 -0500 (EST)
Message-Id: <20171211.134926.963420253377232764.davem@davemloft.net>
To: hkallweit1@gmail.com
Cc: nic_swsd@realtek.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: introduce a device-managed version of
 pci_set_mwi
From: David Miller <davem@davemloft.net>
In-Reply-To: <3e560e2b-7f11-74e2-6db5-60c8479dc59b@gmail.com>
References: <9eee5aba-a739-a609-fd65-76666f377ed1@gmail.com>
        <3e560e2b-7f11-74e2-6db5-60c8479dc59b@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Sun, 10 Dec 2017 00:43:48 +0100

> Introduce a device-managed version of pci_set_mwi. First user is the
> Realtek r8169 driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Bjorn, can I get an ACK on this?  And would you be OK with this going
through my tree as the patches later in this series give an example of
usage?

Thanks.
