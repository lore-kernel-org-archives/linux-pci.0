Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538DC10F00
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A434E217D7
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 07:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfDEHqe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:46:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDEHqe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 03:46:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4EEF6AFB79AB21C628E3;
        Fri,  5 Apr 2019 15:46:30 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 15:46:28 +0800
Subject: Re: [PATCH 2/4] hwmon: (pc87427) Use request_muxed_region for
 Super-IO accesses
To:     Guenter Roeck <linux@roeck-us.net>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>
References: <1554402838-19008-1-git-send-email-linux@roeck-us.net>
 <1554402838-19008-2-git-send-email-linux@roeck-us.net>
CC:     Jean Delvare <jdelvare@suse.com>,
        Linux PCI <linux-pci@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6e61d629-9a49-a9fc-8e6a-edbc39750314@huawei.com>
Date:   Fri, 5 Apr 2019 08:46:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1554402838-19008-2-git-send-email-linux@roeck-us.net>
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
> Fixes: ba224e2c4f0a7 ("hwmon: New PC87427 hardware monitoring driver")
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reported-by: John Garry <john.garry@huawei.com>
> Cc: John Garry <john.garry@huawei.com>

Acked-by: John Garry <john.garry@huawei.com>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/pc87427.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
> index d1a3f2040c00..58eee8fa3e6d 100644
> --- a/drivers/hwmon/pc87427.c
> +++ b/drivers/hwmon/pc87427.c
> @@ -106,6 +106,13 @@ static const char *logdev_str[2] = { DRVNAME " FMC", DRVNAME " HMC" };
>  #define LD_IN		1
>  #define LD_TEMP		1
>
> +static inline int superio_enter(int sioaddr)
> +{
> +	if (!request_muxed_region(sioaddr, 2, DRVNAME))
> +		return -EBUSY;
> +	return 0;
> +}
> +
>  static inline void superio_outb(int sioaddr, int reg, int val)
>  {
>  	outb(reg, sioaddr);
> @@ -122,6 +129,7 @@ static inline void superio_exit(int sioaddr)
>  {
>  	outb(0x02, sioaddr);
>  	outb(0x02, sioaddr + 1);
> +	release_region(sioaddr, 2);
>  }
>
>  /*
> @@ -1195,7 +1203,11 @@ static int __init pc87427_find(int sioaddr, struct pc87427_sio_data *sio_data)
>  {
>  	u16 val;
>  	u8 cfg, cfg_b;
> -	int i, err = 0;
> +	int i, err;
> +
> +	err = superio_enter(sioaddr);
> +	if (err)
> +		return err;
>
>  	/* Identify device */
>  	val = force_id ? force_id : superio_inb(sioaddr, SIOREG_DEVID);
>


