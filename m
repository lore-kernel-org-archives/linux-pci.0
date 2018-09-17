Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B9ECE563
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2922088F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 14:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2922088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeIQUK1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:10:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbeIQUK1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 16:10:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F11A1706D4D9;
        Mon, 17 Sep 2018 22:42:46 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 22:42:39 +0800
Subject: Re: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
To:     Andrew Murray <andrew.murray@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Will Deacon" <will.deacon@arm.com>, <dann.frazier@canonical.com>,
        <bhelgaas@google.com>, <andy.shevchenko@gmail.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <suzuki.poulose@arm.com>,
        <jean-philippe.brucker@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <464e07ab-797e-971a-0839-5fd55e3e2ad3@huawei.com>
Date:   Mon, 17 Sep 2018 15:42:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917144232.3HEClXSJ9kavEP6JXmb18tmvksBnqam16BkVU1loBOQ@z>

- dead e-mail addresses (Zhichang, Gabriele)

On 13/09/2018 13:48, Andrew Murray wrote:

Hi Andrew,

> The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> prevent users from making I/O accesses outside the expected I/O range -
> however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> contradictory to its other users.
>
> The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> mangling the given port rather than capping it.
>
> We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> implementation of ioport_map by using the comparison operator and
> returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> we don't break existing buggy drivers that somehow rely on this masking.

I wouldn't say any drivers rely on this - for the only device driver 
which uses the "Indirect" IO space region above MMIO_UPPER_LIMIT 
(HiSilicon LPC), no child device driver for that host uses ioport_map() 
[those being ipmi si and 8250 generic+of drivers].

Regardless of that, it seems better to return NULL when the port is 
out-of-range, rather than masking it.

Cheers

>
> Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>  include/asm-generic/io.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 66d1d45..d356f80 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
>  #define ioport_map ioport_map
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> -	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
> +	port &= IO_SPACE_LIMIT;
> +	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>  }
>  #endif
>
>


