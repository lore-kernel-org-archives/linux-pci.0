Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40033 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbaDOTPX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Apr 2014 15:15:23 -0400
Date: Tue, 15 Apr 2014 15:15:20 -0400 (EDT)
Message-Id: <20140415.151520.1523135090870130956.davem@davemloft.net>
To: agordeev@redhat.com
Cc: linux-kernel@vger.kernel.org, shahed.shaikh@qlogic.com,
	Dept-HSGLinuxNICDev@qlogic.com, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] qlcnic: Fix MSI-X initialization code
From: David Miller <davem@davemloft.net>
In-Reply-To: <1397554634-26795-1-git-send-email-agordeev@redhat.com>
References: <1397554634-26795-1-git-send-email-agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Gordeev <agordeev@redhat.com>
Date: Tue, 15 Apr 2014 11:37:14 +0200

> Function qlcnic_setup_tss_rss_intr() might enter endless
> loop in case pci_enable_msix() contiguously returns a
> positive number of MSI-Xs that could have been allocated.
> Besides, the function contains 'err = -EIO;' assignment
> that never could be reached. This update fixes the
> aforementioned issues.
> 
> Cc: Shahed Shaikh <shahed.shaikh@qlogic.com>
> Cc: Dept-HSGLinuxNICDev@qlogic.com
> Cc: netdev@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Applied, thanks.
