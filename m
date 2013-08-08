Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51693 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933566Ab3HHADW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 20:03:22 -0400
Date: Wed, 07 Aug 2013 17:08:36 -0700 (PDT)
Message-Id: <20130807.170836.1214269360365516393.davem@davemloft.net>
To: vipul@chelsio.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, leedom@chelsio.com,
	tomreu@chelsio.com, divy@chelsio.com, dm@chelsio.com,
	nirranjan@chelsio.com, eilong@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH V2 0/4] Enable bus master till the FLR completes for
 Chelsio T4
From: David Miller <davem@davemloft.net>
In-Reply-To: <1375784319-25760-1-git-send-email-vipul@chelsio.com>
References: <1375784319-25760-1-git-send-email-vipul@chelsio.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vipul Pandya <vipul@chelsio.com>
Date: Tue,  6 Aug 2013 15:48:35 +0530

> This patch series adds device specific reset method for Chelsio T4 adapters.
> 
> The series also adds new routine, pci_wait_for_pending_transaction, to wait for
> pending pci transaction. There are few places where waiting for pending pci
> transaction code was duplicated. This patch series also replaces occurances of
> duplicate code.
> 
> This patch series is built against Bjorn Helgaas pci tree next branch. We would
> like to merge this series via the same.
> 
> I have Cced respective maintainers of the modified drivers. Kindly review and
> let us know in case of any review comments.

Please push this via the PCI tree, and for the networking bits you can add:

Acked-by: David S. Miller <davem@davemloft.net>

Thanks.
