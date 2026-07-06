Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C53BE647
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362937; cv=pass; b=bILbQoOAgJLhPcv4CHU4SF81jZ+l3uhPT/AmOoySZ4bDty//pSfhy9jPQfjMhQu1upeU7DV7fD+xHHX3fZJkRBc6N+i+xoyv9tVB435/JV//JoMRkFryAyPg9MCCQ6lAP4WLR++x9DlLUa52GeRwtcMgZdkf1qHH99ZYgeWCql8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362937; c=relaxed/simple;
	bh=HPrlRjR/87Sgv7afW4R5TLpUfuybQzJj2nJz3LNjgt4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPrZIpBKdKKxAxWFyWcNLs2mp4kZlg3Ipjjqe8oHvf8pJeRl6rixi5LjmTwFjgJtxj9pz0spOSEOHztzg7FceVx6jrIckarMyqD9RoWpR6f1KgSxsguViX8rQpDGPHupL2O8+wTabFavxg18rP41JZp+Gso5tjaOXyHpl0lV4VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3t+io6M; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3t+io6M"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc73e322dbso19077925ad.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 11:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362935; cv=none;
        d=google.com; s=arc-20260327;
        b=VAImQ/+v6LOYeiyWCkljAcjpg+7BtcPO86dEn0gaWll2nFr5NpXus7kaWj9hVY8lTE
         6hxKSERPmO3cs+GJE3iqNMQkgpg40y3nspDubFV/0dhfQjmpvcyBV84ghg2ofUtO7Mj+
         CMpdzL5GRVadbtp4Kg32zJdBi3x1E8anDKldxHrIjxXfp9ZXAHwGf/kga4KrMxidiFSn
         G+0WBqxPKOBBCwNpPx65P373zSJhq/b8gXScOUHzZ5zj2oD2/Tc/7YoYOUmBLMlOMvyM
         gIgdKbWwQpVdRFrY9+3UR/+1JIF5yABjyb/Uccb4RF1XO9HMKR8Q4yRHIOAosj92Lmio
         xHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WnS2RNIXat7zDN2phUDyBGT8PFFJ5aIBlxvkpKQm44c=;
        fh=lj55TCxuIvGu/DAw7Ox6Ff7WmYL2ZYccA6wmE0yAPbQ=;
        b=iMIlrmwNxAcAhbliplxdAO1mXj6YzGbqHLuE1HO2YQ02uTxIBNqPTUROfoXS/6ZWGq
         V951TdgV/YXfs6twytVYw/iRHImhxf62b8M1vGUWZxXZqPKfmy4NRKgbX3O5xJd69Cca
         VQb5imM+ZFexMLdf/mH/y5jZZinIjk+dgoLihjrpPM3V4+IurfN1auYraTuEGTj/NYP5
         ro52LDmK7bVErzcy6Pcca1OvXVkek1urNDg+EgFbPiELgrU8CMuY+ofXjl5eBeiMJCWo
         eZ6W1CoOc5TSkJzAXnQ1xHMlGavwmjVTIxoy1gfOHPsVnNDqRKWY6Xt0uNx5RUWEDUeJ
         PFkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362935; x=1783967735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnS2RNIXat7zDN2phUDyBGT8PFFJ5aIBlxvkpKQm44c=;
        b=n3t+io6MUV6oVZqKUv+EkZCGqFBDhvPkntajDpa81/Yf5U97GTXkqgXGEW+YkLEjZS
         e6OS9E16hSOVLibDCiLKl9aWzML+644BdraflfYsGWR53fgiNAF/8hmbzSSZ53ZFbqf4
         kfk2OA9AKl95zdx2xIeWsQatUWKGPbJOlwOZ9KVzQEu5v1/++oKX5veR2FcLCWhDJ5c7
         Stbfg3VeDpCzLHM3PjrsODPYAY2cJwzVf8HoQhfYoiQ5WxcFZwKAVpZNwINK4kORCGfe
         RApZGiLYRXFhQ3WAJT6D2o0D+xbiZE9gvbxjXueQulU4axzExLTv8CbBb9LM/Dm0fSvJ
         WGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362935; x=1783967735;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnS2RNIXat7zDN2phUDyBGT8PFFJ5aIBlxvkpKQm44c=;
        b=qoXCELAq44RN5xVrGVn76Cxhn6NEmEn+8JlAvdl4KkhCPUDljAyZe0e305fmz4p/ky
         ZDiOxh/CuyoiUdkmTd4EZ1MHq1hpt8uETWX6bwUelcWgmoi45CjCM6vccgd2HmRURCBI
         B7mMP23Uhr9ZsMEtguTIg4Uq1MIJUWwRtgwCWItsXaL2pkng2MAX5jZDB8IZKbWr8bzP
         gI4uCtCiyT//X4Ic3jA+FwOT/42nrFkPeY62ftiQQq7+kRNWlBWHIUhui0baMyndgt70
         jyt4ar6O7pVQqkK5jMcQ1m6NxXTH9DYXUVnPag5On2CDHNyCdogIo8Tc3SpVsCW1+raU
         uRCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1hWrNPYbQw76KDTuhB6d53PGYpBv952Mw6EexQvkzvv9S1uZq+oBA+Wn/gKgZ+zhKw//OZaZDvu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkOQH3cAts7roJMD9+ddDsrdRrRiqR9ZXuUCFN9CaumBrOGcy
	UcL67ehPuF3aozkFPrjhoAzUl08h1TSHcJ4rCHEulW9XgYDNCknHO+nAfVrPwicYgPmxGbJ3kW3
	wU9iqa+trl6mqyRmjN12ar2va4ILreybeErt62jTx
X-Gm-Gg: AfdE7clDMdjqEzW7DZkqjfCfIqy/BqurQ1AWY7T/fGg7sBUKCc0UJFuc1RaVqkxZ8DB
	vZonsQopXt5mJYl0X179TFdJwL88YAc7m6u4wdr0UaYcsNscUr0XSiY8ctmuC0hmjVBK7cW9A02
	MH0jRYDcohhyB9gBD1UJxU5MJ4tWy2xT5UgMn3eXmF37zQGhCbw/wJXFg9qEJk9AdaHm+R4mK5F
	qUfcmzCOTMT49GXPavWIy7coxHUVj9pIwlCmuf7HGzycQB3iKSHLC7vgAWGdbx17ISsOvBsxzIc
	kgg3ZFPxXF0cOMIIAwiVWF14ETFPBxw037i6HpqUnVLgpwve2XxV6y3PChg=
X-Received: by 2002:a05:6a21:1f83:b0:3bf:6c04:a812 with SMTP id
 adf61e73a8af0-3c08ef1dd4dmr2080840637.51.1783362934943; Mon, 06 Jul 2026
 11:35:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 11:35:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 11:35:34 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-23-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-23-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 11:35:34 -0700
X-Gm-Features: AVVi8CdqD5g74lv_vdWGXV2KWJo0HCHGQ2q9sBsYTjhrRT829V9HzSMACy2bRlo
Message-ID: <CAEvNRgG-6aOgtW9cB6zE7278B=0fB9KSEH18Kw8qNF2sBtUBsQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/31] iommu/vt-d: Export a helper to do function for
 each dmar_drhd_unit
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Enable the tdx-host module to get VTBAR address for every IOMMU device.
> The VTBAR address is for TDX Module to identify the IOMMU device and
> setup its trusted configuraion.
>

I think this commit message doesn't match the commit subject or the
change, unless I'm misunderstanding something

> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  include/linux/dmar.h       |  2 ++
>  drivers/iommu/intel/dmar.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 692b2b445761..cd8d9f440975 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -86,6 +86,8 @@ extern struct list_head dmar_drhd_units;
>  				dmar_rcu_check())			\
>  		if (i=drhd->iommu, 0) {} else
>
> +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *));
> +
>  static inline bool dmar_rcu_check(void)
>  {
>  	return rwsem_is_locked(&dmar_global_lock) ||
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 4f9571eee1d4..eea9ba691f99 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2452,3 +2452,19 @@ bool dmar_platform_optin(void)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dmar_platform_optin);
> +
> +int do_for_each_drhd_unit(int (*fn)(struct dmar_drhd_unit *))
> +{
> +	struct dmar_drhd_unit *drhd;
> +	int ret;
> +
> +	guard(rwsem_read)(&dmar_global_lock);
> +
> +	for_each_drhd_unit(drhd) {
> +		ret = fn(drhd);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(do_for_each_drhd_unit);
> --
> 2.25.1
