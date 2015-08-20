Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56074 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbHTRrb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 13:47:31 -0400
Date: Thu, 20 Aug 2015 10:47:28 -0700 (PDT)
Message-Id: <20150820.104728.699050706854625548.davem@davemloft.net>
To: bhelgaas@google.com
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee,
	sparclinux@vger.kernel.org, eric.snowberg@oracle.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150820054800.GB10267@google.com>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
	<20150820054800.GB10267@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 00:48:00 -0500

> [+cc Dave, Eric, Ben, sparclinux]

I think the comment is terrible.

It is not limited to those two systems, it is a general problem with
how the code assumes the root PCI-E port is instantiated in the PCI
bus hierarchy which will not be true on any system which has a PCI
controller that doesn't actually provide a bonafide config space to
access.

