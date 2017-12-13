Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:43790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbdLMTwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Dec 2017 14:52:09 -0500
Date: Wed, 13 Dec 2017 14:52:07 -0500 (EST)
Message-Id: <20171213.145207.1867670053920464966.davem@davemloft.net>
To: hkallweit1@gmail.com
Cc: nic_swsd@realtek.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] r8169: extend PCI core and switch to
 device-managed functions in probe
From: David Miller <davem@davemloft.net>
In-Reply-To: <36fa928b-e974-c023-de3e-c2bd05f53df2@gmail.com>
References: <36fa928b-e974-c023-de3e-c2bd05f53df2@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 12 Dec 2017 07:34:26 +0100

> Probe error path and remove callback can be significantly simplified
> by using device-managed functions. To be able to do this in the r8169
> driver we need a device-managed version of pci_set_mwi first.
> 
> v2:
> Change patch 1 based on Björn's review comments and add his Acked-by.

Series applied, thanks.
