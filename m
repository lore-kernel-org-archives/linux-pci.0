Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34493 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbcGCP1e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jul 2016 11:27:34 -0400
MIME-Version: 1.0
In-Reply-To: <c72d2b44-a5d2-bd8f-16a7-2a80ae2b71eb@huawei.com>
References: <1467100302-221983-1-git-send-email-zhaonenglong@hisilicon.com> <c72d2b44-a5d2-bd8f-16a7-2a80ae2b71eb@huawei.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Sun, 3 Jul 2016 20:57:33 +0530
Message-ID: <CAHM4w1=y8hxdji7tGS1G6KhuTKVJr17iBT8Yytgyek2z1tuNJA@mail.gmail.com>
Subject: Re: [PATCH] Exchange the Assignments of `MEMORYs' and `CFGs/IOs' in
 Designware PCIe Driver
To: "dongbo (E)" <dongbo4@huawei.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Linuxarm <linuxarm@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhanweitao <zhanweitao@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 28, 2016 at 1:42 PM, dongbo (E) <dongbo4@huawei.com> wrote:
>
> From: Dong Bo <dongbo4@huawei.com>
>
> In designware PCIe driver, the iatu0 is used for both CFG and IO accesses.
> When sending CFGs to peripherals (e.g. lspci), iatu0 frequently switches
> between CFG and IO alternatively.
>
> A MEMORY probably be sent as an IOs by mistake. Considering the following
> configurations:
> MEMORY          ->      BASE_ADDR: 0xb4100000, LIMIT: 0xb4100FFF, TYPE=mem
> CFG             ->      BASE_ADDR: 0xb4000000, LIMIT: 0xb4000FFF, TYPE=cfg
> IO              ->      BASE_ADDR: 0xFFFFFFFF, LIMIT: 0xFFFFFFFE, TYPE=io
>
> Suppose PCIe has just completed a CFG access, to switch back to IO, it set
> the BASE_ADDR to 0xFFFFFFFF, LIMIT 0xFFFFFFFE and TYPE to io. When another
> CFG comes, the BASE_ADDR is set to 0xb4000000 to switch to CFG. At this
> moment, a MEMORY access shows up, since it matches with iatu0
> (due to 0xb4000000 <= MEMORY BASE_ADDR <= MEMORY LIMIE <= 0xFFFFFFF), it
> is treated as an IO access by mistake, then sent to perpheral.
>
> This patch fixes the problem by exchanging the assignments of `MEMORYs'
> and `CFGs/IOs', which assigning MEMEORYs to iatu0, CFGs and IOs to iatu1.


Had a re-thought on it. While it will fix wrong memory access in your
case, it can still cause issues with IO access for some other
platform.

Can you please test [1] and check it that works for you. You will need
to define num-viewport in your device tree file.

~Pratyush

[1] https://github.com/pratyushanand/linux/commit/131b83ea7db0834d77ee5df65c6696bccbf8a1ce
