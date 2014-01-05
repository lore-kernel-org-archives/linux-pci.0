Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44928 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaAECFe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jan 2014 21:05:34 -0500
Date: Sat, 04 Jan 2014 21:05:33 -0500 (EST)
Message-Id: <20140104.210533.653844636617320862.davem@davemloft.net>
To: wangyijing@huawei.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH v3] sparc/PCI: Use dev_is_pci() to identify PCI devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <1386741626-35744-1-git-send-email-wangyijing@huawei.com>
References: <1386741626-35744-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 11 Dec 2013 14:00:26 +0800

> Use dev_is_pci() instead of checking bus type directly.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied.
