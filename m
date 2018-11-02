Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA2C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595BE20831
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2dNUPQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595BE20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeKCDeT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:34:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44545 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbeKCDeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 23:34:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so1316149pgs.11;
        Fri, 02 Nov 2018 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=geT1HTDkqkDzI17ehb/xsTQ0ZgAuLYo/0+Aibs+23yo=;
        b=j2dNUPQ2A7tarlsm3UEaLmLUUUuFMNLgL8TGlh9AZDi5cC2D5Z2TJ+5VY/PfQFOuu+
         nUev+zVEabm3iQcHArx7tiQsxsd9ZSy9wk4g+62JyCiaHLYQ2XD0OWJzeN5alIAq3Pj8
         zURlTTEXhYKQb4qlkzoc6dXQzDs3GvezEX3UKvy5NxeIoyzgl/7N02K+IRisAAQurJ5Q
         iCoia5WQefzjXBMBg2jpQRrECk+TRdGriTMSQVl1yYFKL2NLhCzqySb4KYCLclK4HMvg
         soOy1HGtpF8M7bpmS5uCjaNEcS4EFszS+VJBUR1rlycXmYEe6IzMLnXpsPDOU+ZH0ZKZ
         99rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=geT1HTDkqkDzI17ehb/xsTQ0ZgAuLYo/0+Aibs+23yo=;
        b=E2Itwo16/cYxweFAjDvbHZVYmXWnG/Gr8QMgLlUu4fecvFbkkjjnYZQYU+IOXuAMI0
         WPBgFhwzzOmMk6VVHXQzy/ox6T3qmK3w7ESPaBYNubnCWWM4icvMx5FfTEs6Ex3rP+xp
         qZMNQjTIYLN42PyluQy5c5UnfnhtBl6rl39zsH4i1PjakXVo3hGYdtRhZOHfsAebrKr8
         ic3gM8zRwE3dIMW/9RFYOLC3nkVCunR6Q6MSBPhfmqX/eRCsXv5DJ4r9d4NjDh/4JghC
         w7MY/yI/wNfA/zdIqAtBZsWuhM6MgYmlfAyXInvZf/aUIUIItohM+fRiBcAatkcmRnN/
         5C4w==
X-Gm-Message-State: AGRZ1gLPS6RmX0lObzWII7WA7Su3BW2TiHbkaKZYRlt1I9aIpTBMbin8
        ol62H80Mm1TbODudNvfh9opA4JCC
X-Google-Smtp-Source: AJdET5enmVllef/9f48hVEl66yhCaHYxfHEZ6rswSRwrA8VlCJ1iYFGL7OWBQ/5xdbl1cSqMcTWPhg==
X-Received: by 2002:a62:2782:: with SMTP id n124-v6mr12884775pfn.216.1541183171603;
        Fri, 02 Nov 2018 11:26:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b29-v6sm63064557pfj.183.2018.11.02.11.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:26:11 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:26:10 -0700
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
Subject: Re: [PATCH 4/4] hwmon: k10temp: add support for AMD F17h M30h CPUs
Message-ID: <20181102182610.GB5782@roeck-us.net>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-5-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102181055.130531-5-brian.woods@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:11:12PM +0000, Woods, Brian wrote:
> Add support for AMD family 17h model 30h processors for k10temp.  Model
> 30h is functionally the same as model 01h processors (as far as k10temp
> is concerned), just the PCI device IDs need to be updated.
> 
> Signed-off-by: Brian Woods <brian.woods@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

(assuming the patch will be sent upstream as part of the series
 and not through hwmon)

> ---
>  arch/x86/kernel/amd_nb.c | 1 -
>  drivers/hwmon/k10temp.c  | 1 +
>  include/linux/pci_ids.h  | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index fd69067f6eb1..e491aa4a1970 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -17,7 +17,6 @@
>  #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
> -#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index bc6871c8dd4e..9790f1f5eb98 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -360,6 +360,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, k10temp_id_table);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 78d5cd29778a..349276fbd269 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -547,6 +547,7 @@
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
>  #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
> +#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.11.0
> 
