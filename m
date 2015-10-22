Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49549 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbJVBKt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2015 21:10:49 -0400
Date: Wed, 21 Oct 2015 18:27:14 -0700 (PDT)
Message-Id: <20151021.182714.551622926534141857.davem@davemloft.net>
To: yinghai@kernel.org
Cc: helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linux@iam.tj, wangyijing@huawei.com,
	khalid.aziz@oracle.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
References: <CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
	<20151021023522.GJ8224@localhost>
	<CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 21 Oct 2015 11:16:53 -0700

> otherwise we need to compare res with pbm->mem_space or pbm->mem64_space
> to get direct parent for request_resource_conflict() calling in
> pci_register_legacy_regions().

Right, this is the issue.

On sparc64, the cpu physical base address used for accessing 64-bit
and non-64-bit memory spaces is different.

And that's why the resource values will be different.

