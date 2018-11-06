Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA72C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC32086B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 22:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV7Q7O48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFC32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbeKGINJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:13:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45615 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeKGINJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 03:13:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id p17-v6so6410103pfj.12;
        Tue, 06 Nov 2018 14:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q6XPvJyrz0MTxOesByXKZn8qEoE7N03/+BVsgNnWuss=;
        b=pV7Q7O48QXd8Yhd2600WiatbW8dO7yiXtdoV3WtGdg19p6yye/V+GWimKyseVR1GxH
         vf8mkNyK+mY+v5NSG8FonH8ENGdODq+tGGhW4YcDDtvp0K3zXaWGpd8n4OLgIpC1l4sx
         de7mpJZTYd/R1KqnlZGFQ8MRFnXh6fTix+36Wm1uh8GmCbne0kkRabeiFEQcEvQLPhHE
         As0h820s9jUL3vXiCfbAw3Kk1154tV70H/20NgsSGnG0XxVtrjKeQ/BNPSY9kNxVlNVT
         X5XrFnQqbAm16x7kY2W0Sm4oA2OZkMtdEoRkne3iKkJRyUbnxi0lWC7dwGbhpn+ybV2z
         I6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q6XPvJyrz0MTxOesByXKZn8qEoE7N03/+BVsgNnWuss=;
        b=OAE3m0TDvqCnwITTR42fX7AIJsUw8aEwnA/hENb6VX1U/MoetpUl3L3nO0g6aO8Ox2
         tFpAQI7TAKxs1oKoBZ5f8fXCKod2GauwR02SN+bb/0otJ37xL7n5i2d9AtKyLTLcmEHB
         JjfuGg9fnneObVbu5M+5berwg8x/z3nf1uOIKLRz0zIv1qIfeMFjSDxJOX+O+VUzQzKY
         gUwCrKOaYSCOI3RHLkNpBvqqwDi7zlj2X9KthiD6Ka0H4TsT5j//3U5PhSC4hzP/JmJc
         sQ1m1u/9AANQ7Nek54ac75WXoqwh+NgX8JnP6qZXKZFfed+M3w/TP+KqX6cjwrc12Fh5
         jUYQ==
X-Gm-Message-State: AGRZ1gLjB0hw5iYR0oR8gifchyJJ/ZEVZx4YXtno0o4256q3RUP1Yid7
        02QM3MZ9sDZba+RGIZp/vL0=
X-Google-Smtp-Source: AJdET5dq0CP9Gdh/tITrLdnaoNzxrRlZZUMFwrhuNSQTsbeMHiYxPWnBNvbia+bfhGKuO8nW5x0HQw==
X-Received: by 2002:a62:29c4:: with SMTP id p187-v6mr18492678pfp.62.1541544338084;
        Tue, 06 Nov 2018 14:45:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13sm16606666pgf.84.2018.11.06.14.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 14:45:36 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:45:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] k10temp: x86/amd_nb: consolidate shared device IDs
Message-ID: <20181106224535.GA29024@roeck-us.net>
References: <20181106200754.60722-1-brian.woods@amd.com>
 <20181106200754.60722-2-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106200754.60722-2-brian.woods@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 08:08:14PM +0000, Woods, Brian wrote:
> Consolidate shared PCI_DEVICE_IDs that were scattered through k10temp
> and amd_nb, and move them into pci_ids.
> 
> Signed-off-by: Brian Woods <brian.woods@amd.com>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/x86/kernel/amd_nb.c | 3 +--
>  drivers/hwmon/k10temp.c  | 9 +--------
>  include/linux/pci_ids.h  | 2 ++
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index a6eca647bc76..19d489ee2b1e 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -11,13 +11,12 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
> +#include <linux/pci_ids.h>
>  #include <asm/amd_nb.h>
>  
>  #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
> -#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
> -#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 2cef0c37ff6f..bc6871c8dd4e 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -23,6 +23,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci_ids.h>
>  #include <asm/amd_nb.h>
>  #include <asm/processor.h>
>  
> @@ -41,14 +42,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F3	0x15b3
>  #endif
>  
> -#ifndef PCI_DEVICE_ID_AMD_17H_DF_F3
> -#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
> -#endif
> -
> -#ifndef PCI_DEVICE_ID_AMD_17H_M10H_DF_F3
> -#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3	0x15eb
> -#endif
> -
>  /* CPUID function 0x80000001, ebx */
>  #define CPUID_PKGTYPE_MASK	0xf0000000
>  #define CPUID_PKGTYPE_F		0x00000000
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1ba1a..78d5cd29778a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -545,6 +545,8 @@
>  #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
> +#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
> +#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.11.0
> 
