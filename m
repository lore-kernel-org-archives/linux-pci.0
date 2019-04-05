Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7491C10F0F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA1217D7
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfDEHr5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:47:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730068AbfDEHr5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 03:47:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD0CBF52F5D387172A57;
        Fri,  5 Apr 2019 15:47:52 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 15:47:49 +0800
Subject: Re: [PATCH 4/4] hwmon: (smsc47b397) Use request_muxed_region for
 Super-IO accesses
To:     Guenter Roeck <linux@roeck-us.net>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>
References: <1554402838-19008-1-git-send-email-linux@roeck-us.net>
 <1554402838-19008-4-git-send-email-linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dc742840-7a20-701d-87c7-775f2f85a2e2@huawei.com>
Date:   Fri, 5 Apr 2019 08:47:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1554402838-19008-4-git-send-email-linux@roeck-us.net>
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
> Also, other drivers may attempt to access the LPC bus at the same time,
> resulting in undefined behavior.
>
> Use request_muxed_region() to ensure that IO access on the requested
> address space is supported, and to ensure that access by multiple drivers
> is synchronized.
>
> Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reported-by: John Garry <john.garry@huawei.com>
> Cc: John Garry <john.garry@huawei.com>

Acked-by: John Garry <john.garry@huawei.com>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47m1.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index c7b6a425e2c0..0736ca6a3aee 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -73,16 +73,21 @@ superio_inb(int reg)
>  /* logical device for fans is 0x0A */
>  #define superio_select() superio_outb(0x07, 0x0A)
>
> -static inline void
> +static inline int
>  superio_enter(void)
>  {
> +	if (!request_muxed_region(REG, 2, DRVNAME))
> +		return -EBUSY;
> +
>  	outb(0x55, REG);
> +	return 0;
>  }
>
>  static inline void
>  superio_exit(void)
>  {
>  	outb(0xAA, REG);
> +	release_region(REG, 2);
>  }
>
>  #define SUPERIO_REG_ACT		0x30
> @@ -531,8 +536,12 @@ static int __init smsc47m1_find(struct smsc47m1_sio_data *sio_data)
>  {
>  	u8 val;
>  	unsigned short addr;
> +	int err;
> +
> +	err = superio_enter();
> +	if (err)
> +		return err;
>
> -	superio_enter();
>  	val = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
>
>  	/*
>


