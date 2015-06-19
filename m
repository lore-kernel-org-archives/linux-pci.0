Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35824 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbbFSROU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 13:14:20 -0400
Received: by iefd2 with SMTP id d2so22479830ief.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 10:14:20 -0700 (PDT)
Date: Fri, 19 Jun 2015 12:14:17 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] Trivial pci hotplug changes
Message-ID: <20150619171417.GL7710@google.com>
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 03:57:43PM +0800, Yijing Wang wrote:
> 
> Yijing Wang (3):
>   PCI: Use "slot" and "pci_slot" for struct hotplug_slot and struct
>     pci_slot
>   PCI: Simplify pcie_poll_cmd()
>   PCI: Use usleep_range() instead of msleep() for better accuracy

I applied the first two to pci/hotplug for v4.2, thanks!

I dropped the third, as explained in my response to it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
