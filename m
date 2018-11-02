Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7EC6786F
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB68220833
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpUNNnxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB68220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeKCDcy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:32:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeKCDcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 23:32:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so195886plo.1;
        Fri, 02 Nov 2018 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vxkGvo12EDQHbqrXUWJQihJg/oN/UCaVvHWYSUK+NuA=;
        b=CpUNNnxl0LVPOAdxGmUAieaELUcw7tQmej5thUEQIygBiWnBI1zPDnpNXZVRTtRSJt
         s1eGW/+hGsSFyYhO9NrcvDEw5IeWB5m639crxBoxiO0zaMyH34ISVBYMh9SFJVMZJqBs
         vtUxo9BfyPE/62gGl7tG/gfw+emNrYxHT0isxHP75hrlNt5dHbDhaZGQNPiDUZqQZe8q
         hNgq3g2flAt8VQHuxk3ZO0sGt4S2oJz0Eb7YpJeFKKh7IBH5JE8ZpoycuTTBT4D4Qz2L
         losdX/+K9lQhrOVAV25PIA0WjvOIPDLjXCVJJ1+DcjnQc8tgGTw74w5SD/qiAtu8vaNe
         Bx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vxkGvo12EDQHbqrXUWJQihJg/oN/UCaVvHWYSUK+NuA=;
        b=P9Yes3Mc8EMba4r12Ubu6uE8ZEvMHO3NtDYuT8e70O0ygda0PpN4HmQ2XB05m/yzt8
         wtcc5sDThWu68O10gQVy47lpvfiX735xpdVaX580NuvDNPkUskWDwhrbjwKqYOWySqUv
         nT1/avWraTAmW3mFd2CEPL7uW2Rjyx94lnjDi6tXXoD0kRZkdfxBVxIWNB8IdqzBMK94
         GmLB/vq1zrfFMTG8LoJn+UGRfdIxpW69iEdYcWwHc9QdvCnemBQwHCen0yriz/OmWR/3
         XJzyWtCPpl+ENz6ymPT8GKK8+22cvUFVj7oZHsspJX6GLpBh/x7oH43uyeSdAqZvqDWz
         rMxw==
X-Gm-Message-State: AGRZ1gKEmNGni6Myy90Wr6lEbIeE76F/C+NvTlQLoKg2QuKuY9PxaN5j
        kmEFvqmoGFIqRT9HbGOoVzE=
X-Google-Smtp-Source: AJdET5dmACAu1D+WRAnAwgxXitg9XgmA3JrI+pjZNLxnIdSXA/6/jHkZYiDHfizPbQ571gmr0u47iw==
X-Received: by 2002:a17:902:b718:: with SMTP id d24-v6mr11240496pls.338.1541183086421;
        Fri, 02 Nov 2018 11:24:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p87-v6sm32637704pfk.186.2018.11.02.11.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:24:45 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:24:44 -0700
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
Subject: Re: [PATCH 1/4] k10temp: x86/amd_nb: consolidate shared device IDs
Message-ID: <20181102182444.GA5782@roeck-us.net>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-2-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102181055.130531-2-brian.woods@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:11:04PM +0000, Woods, Brian wrote:
> Consolidate shared PCI_DEVICE_IDs that were scattered through k10temp
> and amd_nb, and move them into pci_ids.
> 
> Signed-off-by: Brian Woods <brian.woods@amd.com>

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
