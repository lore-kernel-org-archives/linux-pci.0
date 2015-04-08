Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:38962 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbbDHQIT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 12:08:19 -0400
Date: Wed, 08 Apr 2015 12:08:13 -0400 (EDT)
Message-Id: <20150408.120813.640877580019025571.davem@davemloft.net>
To: bhelgaas@google.com
Cc: yinghai@kernel.org, david.ahern@oracle.com,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	benh@kernel.crashing.org
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150408154759.GN10892@google.com>
References: <20150406.203533.1356187749826485194.davem@davemloft.net>
	<CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
	<20150408154759.GN10892@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 8 Apr 2015 10:47:59 -0500

> Dave, I know you weren't happy with this proposal the first time around,
> but I'm not sure why.  If you have a better idea, let me know.

At this point getting things working again is more important I guess,
so I'm fine with this for now.
