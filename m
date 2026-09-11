Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC05486431
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162808; cv=none; b=UGSEaECJuLqqgOoU3DR5CaVidFYS8f66N3rSsduvGnhxi4VcFPBHuS41//wcxZiyJY/oictaT0HovplsQszPJaJoZdGPguIZ9PUPIZUkM8qQpv04z17dIIsh7XoLc/X56BRiNcqmMcF9I/b9cCvLqNGEkGlefkBCpa06MtmOybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162808; c=relaxed/simple;
	bh=wUUTuEwrfC89Bk6zRIwGjO7vwt3E9SQDT/CGRnS191s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7KOmzaECSk98cu6/L3fpy79BcHmZJZVWSx8nO3nn5PcBBCwzyx9ai61l26KEYJpwioz5jiYG188OKp9bbMQy96xdB0MVJpmKf6UnEU6ZwzTVNEV7TnPhJ/ikFOUN+olGJ0AxrZPN6NqtsB6qz7cDcLwLygoDQWQw9P4v560Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtQh8mlK; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtQh8mlK"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb65437so21984a91.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162806; x=1789767606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CeQ7vx0KvkM9NOKTbl9EpM89WcQPA8FtwRV02R2rPEU=;
        b=OtQh8mlKggldb+caUR8zOiecvOeowoQwazFVClbnwmltHISn64SZyHI9k3iEeKJCQH
         ipbiZqU8MOJdmhpmXeYnGHT1FdG7D+64BblsEu5lSKXonvWJPmROcvYmo5K7ZCPEtF9l
         nUxFDDt2wss+ejXQjwFTd0+T1K0gzXIlYCeoER6rAgHCU9eZztiCfNrSkPrjtdkNkx8k
         c2kfEu9C2j0rGkJrY0aj8DFr7v7SmqB4gSy473ofJh2xYVCADPji9cF8ZV6mGOdEro3g
         MHI8meSNUA4ZcfdG6zivYx0gZcz/PUPqGSqgLd6OqyOAcMoU9vH/oReXI4R96YTWn+ja
         jJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162806; x=1789767606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CeQ7vx0KvkM9NOKTbl9EpM89WcQPA8FtwRV02R2rPEU=;
        b=S9YhOzYzeJ0GKPGsEcnSEJPZbpkaQ+XlrSY0KclnbwJqXefjYzii9znG2RwLBh37lJ
         8a3CDoCbQTq5SJHlyHEXAaAF2FAPZZ+LifSzCPPGb5rnOcO5RQ1x1ki1ewJRcFC/sfJ9
         CDKYs5R+Jtsm2Jh79qvhPeU7MZq8t3hDtAAZYGsLdjSrKtDhfEeU8wJv1BJUkTKZhV0+
         3iW7fjK0Z7KV34IkKKQaox1etK8KW17VbTiATPPpL6dTbGSkcLFT58VqdhS2feqmDiAg
         8EecCheruAfuz8/MNi2SaqyP3smNqiQO7DCU53aRFRYNwtl0xpei/IgxpxeJkZtlraYp
         cQXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxARArkiRtxNIQ1NFTUU4gflM2SkwI69zw85NB7IUg0WHg4xRvSnoJS6gowOuazyb+h8bDvxIQktGc=@vger.kernel.org
X-Gm-Message-State: AFuF++kNPip/Vlk7G1GjQwfed6q4Teh2vh3rry6Nc8iaYb1B81hEfcoq
	FJ4cXdYsoogTePRfWMgxKSXOwsU1gW1nBozmBP553wNA93sPFM4E1BRyJIAkag==
X-Gm-Gg: AYBFou2bp+bVea530QWq4JJLKmD+IlXn5xx7KHT7C4mDhEMlcbtDxp5gib2cudzYQ1w
	GVqQc/UmWQqXQZjobYoKEyRWHraz/RAkfs42FMfWDdHs9orjh1BqRAW/ulK26EEtFijtat94o8m
	TmmfrjG5UkxbAo/8whf5qfTqpmgl59NA3L7g0LbEyPl8MP/UnX360OqVwDK3s0zZvV2qJ15E49e
	jWg1Qfp/ktZTeUrhhU4/QLe4cj1OKWeXlQ5LbBMa46GrWLNFC5giSZm1tVBPs84Z844f+8ASbzf
	Fa7c0myoo1+XXfgy7OdhbRAwqCM+9ha34j9lSbx+k81J9RH0rD2UhJccP9xVntqk7gqw4pl0rdL
	2y5L+YMiWM0mSSiqNl3QGpz/fSaN8CTCLrQe4n2b5UmwOIMR/RsbvgjIDaTGw8QqPxFoQ3o5vKV
	nSgW3JnIcbK/ttlEy7LsoUCvPGlt8RkSRNKjI4TbrBLSlb/5+Mg5FcNXN2ukv4Jw7bcmZ/cQDPt
	vaTyrKqOnUM
X-Received: by 2002:a17:90b:280e:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-39dbc0c3fa6mr241945a91.10.1789162805971;
        Fri, 11 Sep 2026 14:40:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e5c630sm7301184a91.6.2026.09.11.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:40:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 11 Sep 2026 14:40:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bhelgaas@google.com, clemens@ladisch.de, linux-hwmon@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (k10temp): Define unshared PCI device IDs
 locally
Message-ID: <8167c38d-5b9e-4889-821d-d05c7461def6@roeck-us.net>
References: <20260911191803.1522358-1-mario.limonciello@amd.com>
 <20260911191803.1522358-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911191803.1522358-3-mario.limonciello@amd.com>

On Fri, Sep 11, 2026 at 02:17:14PM -0500, Mario Limonciello wrote:
> Headers (now) only used by k10temp should not be declared in
> global headers.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'll need an Ack from a PCI maintainer to apply this patch.

Thanks,
Guenter

> ---
> v2:
>  * New patch
> ---
>  drivers/hwmon/k10temp.c | 30 +++++++++++++++++++++---------
>  include/linux/pci_ids.h | 20 --------------------
>  2 files changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 5414b7841864b..49a62d7349ca7 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -83,17 +83,29 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
>   */
>  #define AMD_I3255_STR				"3255"
>  
> -/*
> - * PCI Device IDs for AMD's Family 17h-based SOCs.
> - * Defining locally as IDs are not shared.
> - */
> +/* PCI Device IDs. Defining locally as IDs are not shared. */
> +#define PCI_DEVICE_ID_AMD_11H_NB_MISC		0x1303
> +#define PCI_DEVICE_ID_AMD_CNB17H_F3		0x1703
> +#define PCI_DEVICE_ID_AMD_17H_DF_F3		0x1463
> +#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3	0x15eb
> +#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3	0x1493
> +#define PCI_DEVICE_ID_AMD_17H_M40H_DF_F3	0x13f3
> +#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3	0x144b
> +#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3	0x1443
>  #define PCI_DEVICE_ID_AMD_17H_M90H_DF_F3	0x1663
> -
> -/*
> - * PCI Device IDs for AMD's Family 1Ah-based SOCs.
> - * Defining locally as IDs are not shared.
> - */
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3	0x1727
> +#define PCI_DEVICE_ID_AMD_19H_DF_F3		0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3	0x14b0
> +#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3	0x167c
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3	0x166d
> +#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3	0x14e3
> +#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3	0x14f3
> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3	0x12fb
> +#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3	0x12c3
> +#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3	0x16fb
>  #define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3	0x12cb
> +#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3	0x124b
> +#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3	0x12bb
>  #define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3	0x1243
>  #define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3	0x127b
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 63774ae2bf71d..7f2ce86695de4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -550,7 +550,6 @@
>  #define PCI_DEVICE_ID_AMD_11H_NB_HT	0x1300
>  #define PCI_DEVICE_ID_AMD_11H_NB_MAP	0x1301
>  #define PCI_DEVICE_ID_AMD_11H_NB_DRAM	0x1302
> -#define PCI_DEVICE_ID_AMD_11H_NB_MISC	0x1303
>  #define PCI_DEVICE_ID_AMD_11H_NB_LINK	0x1304
>  #define PCI_DEVICE_ID_AMD_15H_M10H_F3	0x1403
>  #define PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 0x141d
> @@ -567,28 +566,9 @@
>  #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
>  #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
> -#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
> -#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
> -#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
> -#define PCI_DEVICE_ID_AMD_17H_M40H_DF_F3 0x13f3
> -#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
> -#define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> -#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
> -#define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> -#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
> -#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
> -#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
> -#define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
> -#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
> -#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
> -#define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
> -#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
> -#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
> -#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
> -#define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
>  #define PCI_DEVICE_ID_AMD_SCSI		0x2020
