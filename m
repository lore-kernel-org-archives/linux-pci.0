Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5069BC10F0F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A4921850
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfDEHpn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:45:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729142AbfDEHpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 03:45:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 269A09C50600479DC1F0;
        Fri,  5 Apr 2019 15:45:39 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 15:45:36 +0800
Subject: Re: [PATCH 1/4] hwmon: (f71805f) Use request_muxed_region for
 Super-IO accesses
To:     Guenter Roeck <linux@roeck-us.net>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>
References: <1554402838-19008-1-git-send-email-linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <246ca687-cd96-036b-28e7-a4038766d333@huawei.com>
Date:   Fri, 5 Apr 2019 08:45:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1554402838-19008-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2019 19:33, Guenter Roeck wrote:
> Super-IO accesses may fail on a system with no or unmapped LPC bus.
>
> Unable to handle kernel paging request at virtual address ffffffbffee0002e
> pgd = ffffffc1d68d4000
> [ffffffbffee0002e] *pgd=0000000000000000, *pud=0000000000000000
> Internal error: Oops: 94000046 [#1] PREEMPT SMP
> Modules linked in: f71805f(+) hwmon
> CPU: 3 PID: 1659 Comm: insmod Not tainted 4.5.0+ #88
> Hardware name: linux,dummy-virt (DT)
> task: ffffffc1f6665400 ti: ffffffc1d6418000 task.ti: ffffffc1d6418000
> PC is at f71805f_find+0x6c/0x358 [f71805f]
>
> Also, other drivers may attempt to access the LPC bus at the same time,
> resulting in undefined behavior.
>
> Use request_muxed_region() to ensure that IO access on the requested
> address space is supported, and to ensure that access by multiple
> drivers is synchronized.
>
> Fixes: e53004e20a58e ("hwmon: New f71805f driver")
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reported-by: John Garry <john.garry@huawei.com>
> Cc: John Garry <john.garry@huawei.com>

Acked-by: John Garry <john.garry@huawei.com>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/f71805f.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
> index 73c681162653..623736d2a7c1 100644
> --- a/drivers/hwmon/f71805f.c
> +++ b/drivers/hwmon/f71805f.c
> @@ -96,17 +96,23 @@ superio_select(int base, int ld)
>  	outb(ld, base + 1);
>  }
>
> -static inline void
> +static inline int
>  superio_enter(int base)
>  {
> +	if (!request_muxed_region(base, 2, DRVNAME))
> +		return -EBUSY;
> +
>  	outb(0x87, base);
>  	outb(0x87, base);
> +
> +	return 0;
>  }
>
>  static inline void
>  superio_exit(int base)
>  {
>  	outb(0xaa, base);
> +	release_region(base, 2);
>  }
>
>  /*
> @@ -1561,7 +1567,7 @@ static int __init f71805f_device_add(unsigned short address,
>  static int __init f71805f_find(int sioaddr, unsigned short *address,
>  			       struct f71805f_sio_data *sio_data)
>  {
> -	int err = -ENODEV;
> +	int err;
>  	u16 devid;
>
>  	static const char * const names[] = {
> @@ -1569,8 +1575,11 @@ static int __init f71805f_find(int sioaddr, unsigned short *address,
>  		"F71872F/FG or F71806F/FG",
>  	};
>
> -	superio_enter(sioaddr);
> +	err = superio_enter(sioaddr);
> +	if (err)
> +		return err;
>
> +	err = -ENODEV;
>  	devid = superio_inw(sioaddr, SIO_REG_MANID);
>  	if (devid != SIO_FINTEK_ID)
>  		goto exit;
>


