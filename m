Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:49720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIDG15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2018 02:27:57 -0400
Date: Mon, 03 Sep 2018 19:05:08 -0700 (PDT)
Message-Id: <20180903.190508.740770038342700188.davem@davemloft.net>
To: anthony.wong@ubuntu.com
Cc: nic_swsd@realtek.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for NCube 8168 network card
From: David Miller <davem@davemloft.net>
In-Reply-To: <1535717202-26397-1-git-send-email-anthony.wong@ubuntu.com>
References: <1535717202-26397-1-git-send-email-anthony.wong@ubuntu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Anthony Wong <anthony.wong@ubuntu.com>
Date: Fri, 31 Aug 2018 20:06:42 +0800

> This card identifies itself as:
>   Ethernet controller [0200]: NCube Device [10ff:8168] (rev 06)
>   Subsystem: TP-LINK Technologies Co., Ltd. Device [7470:3468]
> 
> Adding a new entry to rtl8169_pci_tbl makes the card work.
> 
> Link: http://launchpad.net/bugs/1788730
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Anthony Wong <anthony.wong@ubuntu.com>

Applied.
