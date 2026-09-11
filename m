Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCF4570D1
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162647; cv=none; b=MWqSvPBs/ecChVYp109OXMvzVurd1j6IOiD2aIComDXw/13Ub2Ui/Rmo50rodLHr6KPVjY3IMw65fQll3P4oCllMzBtzrp55So4WiD4gJhEOxOrS3MfY1Jh748yPbqCpzgM/zA9pbJRbJHHCaUfhIA5BoCvmccGy9xI+dYbl+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162647; c=relaxed/simple;
	bh=6gfZK/r3jRpcJkDtpDfh8FHtMgfEXUaVAq/Po63FKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H23D76ICuyMOkxhreAqiagn+DsNGZbIEk9KdqaENM0wS2tFcm9ZQXxIRciXhmioeqKSkmVTZmvXblrnidIAgY0WeJBgDW5lr3hD4BNCQEGXdgKCbWPtBmL+V6rgSHN+xdGclzNd9HekBI4iMsi8MfRjr34VSCtb6TEEcIbwcrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJvJVwxk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJvJVwxk"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-86959a6f7f6so1187767b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162645; x=1789767445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9sK4Nf/d2+ZKbGxGlDotG105Mai4PaehwRMmBT9ZKz8=;
        b=gJvJVwxk5eneGVCROQ5B+LqrBjnvWTG4xm9vgKRs2eQzY8gDD9/krEaWpdjQIWlErV
         6RCz0vWEzT6J+HK1gOABROUZkBUDRDS0do5lxxeeHn+CyDnE17pkS6zAvIFQNOWA4UyB
         cPyGl6lvfICQze8MnGJeh/84y4sX5sk3xkI94OAkg+T/6o2y+JXkRCdjpeEQUCCF1DGu
         0Q7VZ6A+0fGIWwz5bKaWfVLNcPXabsI4hk6ctRU6v1CF6U5skW4AlSbJDUevov6DM2BG
         /Y0y9D8TXwWmAOEI1GB7gvkkcKxa5IwL6Gr/qumWYf1D7SFdrfgikt6h/tjY/+vjA59r
         dZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162645; x=1789767445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sK4Nf/d2+ZKbGxGlDotG105Mai4PaehwRMmBT9ZKz8=;
        b=hmkPf1RvvDoJcXyVhngBNEsw5shOyTtHkRY3APsjZvkyrt1GLBZ9MCwLO/Nf1oT45Q
         Zp5BMGADmi0XEowOto+8L6EaYjux+aEiIZ6ACFQFJvrrhkXwx5y3ztH77/nYSYyLWll5
         NxhZumq+v2eEhAM7PkH5PqihC10qh82ATt6YApxEsVo2ehcpzkv4KwwzaT0JvHspTWXd
         VT1unYtTtBy0VWSQqe2Kgdjy9hceRq/r4lVbrODG9cET0pxzfGr9SCgNm0VIHUyHB/Jg
         opS9GFCb8IZAhyhO9GKZm8b2qzCM8OfRYDfuifP2FP5J9QMweOH7zvalVYGx5Z2kToAJ
         ZU9w==
X-Forwarded-Encrypted: i=1; AKwUvBzYfIBGR/7gxRY2h5/wXovPuQ+F0rNpIJPa5t/NZbesv5lm9d108W++ks0dB/iuq5w0OWh09jPngwY=@vger.kernel.org
X-Gm-Message-State: AFuF++mq29Wz51bquy1I3ABIzOWtTF7d/ji2Mo8Uoe3uLqXJuJpxX0C1
	WCwInswcznPcIk7gZLGX0R3q8Cz51gJtbUV/hCrbHJaGPHtGoodWxQTy
X-Gm-Gg: AYBFou2RjdnklrHm7NKE5tXSTgx/UIwIOGMUHAIAr5Fn2KXOgikZeMFKusp/5cJaJTD
	3YCzZqPjho+wc/yAFOFNjbkBMaOeDcdk/ghn654rkI7yIWa5lMsmtPMx+Wmc/xSHE0o3N8i/+6J
	ZeJ5WxUvFbNoHLHn5vuARK6uH6yi9dja8An15gbfe0dYoFlTbF/lxjUCMPAF6DzuaDPBy2mp6DY
	iqtcoGAcDg298/KdquGHqjetiymfnQkG/+LLH1rKSXLs0tDkczpXd3bmcgq13PUy3WR83kipxji
	yIRCoWpZpamDD2CK4kVel5miTFsCXAXPRKgBzLhioL7Inigsc0qpwJF6OMtrjo//k3G47h/59fj
	fHibtxrI8Q8TZNCPKJCc8+jZ2gzyxCQvtvgggSo29VQ2OgJ+KELxyICIR1Y9FRQeqZHaLog1ZQM
	beudLqK3mUKLl8UNGZ7AYJ/69O7qYKjsjrOEd3Ilysr4CcgzjOb/JYBoDxQHiM9Z+fqRv+b7EdR
	V7Xwx/qnFKPcMCjEnZvzzk=
X-Received: by 2002:a05:6a00:18a9:b0:862:bb07:2b97 with SMTP id d2e1a72fcca58-86b2fb17ef7mr8478943b3a.13.1789162644855;
        Fri, 11 Sep 2026 14:37:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b6139e3bfsm1486203b3a.50.2026.09.11.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:37:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 11 Sep 2026 14:37:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bhelgaas@google.com, clemens@ladisch.de, linux-hwmon@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (k10temp): Add support for 1ah/80h
Message-ID: <6d216040-a03b-4606-b1c0-7c9b780cd6d1@roeck-us.net>
References: <20260911191803.1522358-1-mario.limonciello@amd.com>
 <20260911191803.1522358-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911191803.1522358-2-mario.limonciello@amd.com>

On Fri, Sep 11, 2026 at 02:17:13PM -0500, Mario Limonciello wrote:
> 1ah/80h uses same base as other programs.  It only supports Tctl.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied.

Thanks,
Guenter

> ---
> v2:
>  * Move header to k10temp.c
> ---
>  drivers/hwmon/k10temp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 3e7e63edc6a30..5414b7841864b 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -94,6 +94,7 @@ MODULE_PARM_DESC(force, "force loading on processors with erratum 319");
>   * Defining locally as IDs are not shared.
>   */
>  #define PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3	0x12cb
> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3	0x1243
>  #define PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3	0x127b
>  
>  struct k10temp_data {
> @@ -582,6 +583,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{}
