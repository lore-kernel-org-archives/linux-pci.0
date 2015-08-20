Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56113 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbbHTRvV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 13:51:21 -0400
Date: Thu, 20 Aug 2015 10:51:20 -0700 (PDT)
Message-Id: <20150820.105120.2282063631702003363.davem@davemloft.net>
To: oftedal@gmail.com
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee,
	sparclinux@vger.kernel.org, eric.snowberg@oracle.com
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <CALMQjD_d+S4e1OLhMDdt6PTn8Bfm3o9ZqXJxitcVtzE+hSrs+A@mail.gmail.com>
References: <1440023349.2737.21.camel@kernel.crashing.org>
	<CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
	<CALMQjD_d+S4e1OLhMDdt6PTn8Bfm3o9ZqXJxitcVtzE+hSrs+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Thu, 20 Aug 2015 08:44:45 +0200

> Less assumptions made on the basis of the PCIe spec might prevent
> some of this breakage?

+1
