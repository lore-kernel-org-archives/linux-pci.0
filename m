Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:44782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFVFIk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2018 01:08:40 -0400
Date: Fri, 22 Jun 2018 14:08:31 +0900 (KST)
Message-Id: <20180622.140831.1245451103607060086.davem@davemloft.net>
To: kai.heng.feng@canonical.com
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] r8169: Don't disable ASPM in the driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180621083039.22545-1-kai.heng.feng@canonical.com>
References: <20180621083039.22545-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 21 Jun 2018 16:30:38 +0800

> Enable or disable ASPM should be done in PCI core instead of in the
> device driver.
> 
> Commit ba04c7c93bbc ("r8169: disable ASPM") uses
> pci_disable_link_state() to disable ASPM, but it's not the best way to
> do it. If the device really wants to disable ASPM, we can use a quirk in
> PCI core to prevent the PCI core from setting ASPM before probe.
> 
> Let's remove pci_disable_link_state() for now. Use PCI core quirks if
> any regression happens.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
