Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA461C10F0F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F3B21850
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfDEHrZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:47:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDEHrZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 03:47:25 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 407E4D5E79D3015C7FFD;
        Fri,  5 Apr 2019 15:47:22 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 15:47:20 +0800
Subject: Re: [PATCH 3/4] hwmon: (smsc47b397) Use request_muxed_region for
 Super-IO accesses
To:     Guenter Roeck <linux@roeck-us.net>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>
References: <1554402838-19008-1-git-send-email-linux@roeck-us.net>
 <1554402838-19008-3-git-send-email-linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <16a65cec-9d92-773b-141b-973401c77a52@huawei.com>
Date:   Fri, 5 Apr 2019 08:47:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1554402838-19008-3-git-send-email-linux@roeck-us.net>
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

Acked-by: John Garry <john.garry@huawei.com>

> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/smsc47b397.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
> index c0775084dde0..60e193f2e970 100644
> --- a/drivers/hwmon/smsc47b397.c
> +++ b/drivers/hwmon/smsc47b397.c
> @@ -72,14 +72,19 @@ static inline void superio_select(int ld)
>  	superio_outb(0x07, ld);
>  }
>
> -static inline void superio_enter(void)
> +static inline int superio_enter(void)
>  {
> +	if (!request_muxed_region(REG, 2, DRVNAME))
> +		return -EBUSY;
> +
>  	outb(0x55, REG);
> +	return 0;
>  }
>
>  static inline void superio_exit(void)
>  {
>  	outb(0xAA, REG);
> +	release_region(REG, 2);
>  }
>
>  #define SUPERIO_REG_DEVID	0x20
> @@ -300,8 +305,12 @@ static int __init smsc47b397_find(void)
>  	u8 id, rev;
>  	char *name;
>  	unsigned short addr;
> +	int err;
> +
> +	err = superio_enter();
> +	if (err)
> +		return err;
>
> -	superio_enter();
>  	id = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
>
>  	switch (id) {
>


