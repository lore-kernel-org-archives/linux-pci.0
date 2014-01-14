Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:34433 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaANIuf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 03:50:35 -0500
Received: by mail-ee0-f50.google.com with SMTP id d17so51261eek.37
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 00:50:34 -0800 (PST)
Date: Tue, 14 Jan 2014 10:50:31 +0200
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org, bhelgaas@google.com,
	amirv@mellanox.com, ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114105031.71882944@jpm-OptiPlex-GX620>
In-Reply-To: <20140114062215.GA19345@richard>
References: <20140114062215.GA19345@richard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Jan 2014 14:22:15 +0800
Wei Yang <weiyang@linux.vnet.ibm.com> wrote:

> Error log:
>   mlx4_core 0003:05:00.0: Multiple PFs not yet supported.  Skipping
> PF. mlx4_core: probe of 0003:05:00.0 failed with error -22

1. Please include the full error log starting from host bootup and
driver start

2. What FW is loaded on the card?

3. Please provide output of "lspci -vv -nn" for the Mellanox device(s)
