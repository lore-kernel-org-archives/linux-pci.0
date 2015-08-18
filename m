Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34449 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbbHRELT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 00:11:19 -0400
Received: by paccq16 with SMTP id cq16so79349974pac.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 21:11:19 -0700 (PDT)
Date: Mon, 17 Aug 2015 23:11:13 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 27/51] PCI: Move ISA ioport align out of
 calculate_iosize
Message-ID: <20150818041113.GW26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-28-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-28-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:45PM -0700, Yinghai Lu wrote:
> So we could unify calculate_iosize and calculate_memsize later.

Please make this a complete sentence, not just a continuation of the
summary line.

> when one bridge have several children devices, and every devices
> have several io port resources and resource size < 0x400.

This isn't a sentence either, so I'm not sure what this is supposed to
mean.

> We need to check size, and add extra size to make sure bit8/9
> to be zero.
