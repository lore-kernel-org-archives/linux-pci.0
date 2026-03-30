Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD80236453
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877508; cv=none; b=Hf0NjJ3Mf7bKuuYxzkbheJw5bIh4SoGZCtvnxfI0bs/ibDwDzd3/dotCZjCctGHqSAaEA3P4Jr1YNmzMkTB5CVFrhSowhnr4GzHmNCMqmQuPi0TJEJpcMqUykKICvUaHAxl1vpOtGTKbg7WyMQnR4CpXMCQZ53U/UMK+jAhdMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877508; c=relaxed/simple;
	bh=woCJP45a6EA21SxJu6STX2rgJi9X1G42iPDRT5kx8pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGMnRTzorjspFHkzW4yasQzHyALmxLS9tZoMv4NwwP7JNWpgT7vFtA60w/k+k1BVigsxcusbmy/JYHaXmEbQrIWwCjQ5Jfwuuwk9+++RkxFMCr/pN53AW/9krjddm0KJxTgdaVWaYPWWohhHfISy31dQZX6rK8Z5PZcLvlBJoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WsVY/+pW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WsVY/+pW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso45255505e9.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774877506; x=1775482306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jYIEqXC79JFDsMuBE9uscqcAqN7ideMUIHhPBH738yQ=;
        b=WsVY/+pWT09fXuWibY6v/EBES2IYeU2ypLkfr/yf2DkHGafdaEY0od3XH7JbUHVeYQ
         RXgqJGgV5Imf0FCtSx0eHJO3v1hCLvYfztLAnVnyrfYyTlROLZ3W6IVpYLEBK9KZMY7v
         UNpzA5sAuxZADsldPtUXIXDY0NdFwHVUZs4hzhJ4EDSrugPnrORzyQ6XWed2Fo7kIjws
         znfFzkyn8j4uqXwGAgdUit71oSpA/7T3D7HSXzZdCGthlxAzKpMZIPV5gAu/EGpTHOD+
         NLVUEWXFz07sVA7HbkHGsEg54Cwa8bBqMgdeApOIX8GLuA47HRdzNf1y3tOmDPmv4Itz
         EddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774877506; x=1775482306;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYIEqXC79JFDsMuBE9uscqcAqN7ideMUIHhPBH738yQ=;
        b=O2rgrYjzAwhD/lGvV9DRXV8FlIXAS3HFxdCJSaVabGFatLNKKWtVnloM/q54pWbce/
         F5K8T3LcuINWUsWbkSJvn0aOwrSdC8uEFOAZF9LdkEh//OBnNwFtuo5Kn/9mEtZki2R4
         EXyeO9r4mQsI6VIuNfGpi+ZSjX81DJQluoiPb/anIkPk7PJDAQ2SDjgjO9ZIjZCMVCEV
         J8UvGosj40x36YzQ7uMlGx8ms7nC+xylKDYaFP6Q63Knh4hPibV0V5rSohmVsaw6gdQN
         4ppkzFI8YrSYd4U5sRzMIBXKIgMR9AjpFGZ9ulEYwulOI6xCVjDRRpxA2l6ytfxDpTwK
         IqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyK9KtiAbxBZImSbDIlKsypUW8qoPwc7d8doFcAYD2VDg4PxCNHtMLRfxAVsTp4MYUFT9n09q3VQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Kg6j/ZJbqi/6DviYuZ24GzDQ35gCD2+/bnZdTlg+reXCgTkL
	+7RdicG74TDRHBWmFRCsdwC5nBFpGbQZGY1uqOyPEv6QRRJsk62d1uT3J3NVL6xdGB4=
X-Gm-Gg: ATEYQzx+2y0W7/JOPEV7vIrnGauXQD+/RgMq8LQT7VniRxxI762TqA6oY9ON2xM5Vy/
	SC82j83Kdw3k/dBYnkWlkChVllRxvVyHlcXYVvldI8ZFw3EccEsm8J+aTJxkxEbk+9Ef80Mo291
	0Ikscmbj86y2nZkcPUDkx+4v9e6M5NRL88nACsMqyTbCNsZWtseQBltgyHtmJ4cprrA4IlW8DGV
	PWKsKYkeniAtDb9coipsFbiYKFLjIbinv9B2Gf9B7+TIF1hAj01dSxRVS/h95RmgwgevTnoSRmY
	YeymdPCcOcrtpQ3YYYExRrPVjetSI0aD1itmaov9DPjn5UQc26Swpp/9uzAmIN2xLZ8U1w7I1rn
	IDHCypjtL7Ero9RiZwXZ+pZWHlWJ767cPR2ZxEw7UULtpK9yJDIIvok1h2d3ZOz0iSmzisgfjxJ
	RPRfPNV5JYkV9Z5jAEkCT4o7RmhA==
X-Received: by 2002:a05:600c:c178:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-48727ef16bamr212768095e9.27.1774877505632;
        Mon, 30 Mar 2026 06:31:45 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm537578025e9.2.2026.03.30.06.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 06:31:45 -0700 (PDT)
Message-ID: <4af194d0-f1d7-4acf-aeef-cf3bb3a4b10e@suse.com>
Date: Mon, 30 Mar 2026 16:31:43 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/31] x86/virt/tdx: Add tdx_page_array helpers for new
 TDX Module objects
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-4-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260327160132.2946114-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
<snip>

> +/**
> + * tdx_page_array_ctrl_leak() - Leak data pages and free the container
> + * @array: The tdx_page_array to be leaked.
> + *
> + * Call this function when failed to reclaim the control pages. Free the root
> + * page and the holding structures, but orphan the data pages, to prevent the
> + * host from re-allocating and accessing memory that the hardware may still
> + * consider private.
> + */
> +void tdx_page_array_ctrl_leak(struct tdx_page_array *array)
> +{
> +	if (!array)
> +		return;
> +
> +	kfree(array->pages);
> +	kfree(array->root);
> +	kfree(array);
> +}
> +EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_leak);

This instantly raises a red flag if by design an API has the ability to 
simply leak memory. Under what conditions this might be required, can't 
we do something to gracefully handle the case when pages cannot be freed 
instantly, i.e queued freeing or some such ? Simply leaking them is a 
big NO.

> +
> +static bool tdx_page_array_validate_release(struct tdx_page_array *array,
> +					    unsigned int offset,

This function is only ever called with offset of 0, if it's intended to 
be used later then I'd rather see this argument added in an explicit 
patch with rationale why it's needed.

> +					    unsigned int nr_released,
> +					    u64 released_hpa)
> +{
> +	unsigned int nents;
> +
> +	if (offset >= array->nr_pages)
> +		return false;
> +
> +	nents = umin(array->nr_pages - offset, TDX_PAGE_ARRAY_MAX_NENTS);
> +
> +	if (nents != nr_released) {
> +		pr_err("%s nr_released [%d] doesn't match page array nents [%d]\n",
> +		       __func__, nr_released, nents);
> +		return false;
> +	}
> +
> +	/*
> +	 * Unfortunately TDX has multiple page allocation protocols, check the
> +	 * "singleton" case required for HPA_ARRAY_T.
> +	 */
> +	if (page_to_phys(array->pages[0]) == released_hpa &&
> +	    array->nr_pages == 1)
> +		return true;
> +
> +	/* Then check the "non-singleton" case */
> +	if (virt_to_phys(array->root) == released_hpa) {
> +		u64 *entries = array->root;
> +		int i;
> +
> +		for (i = 0; i < nents; i++) {
> +			struct page *page = array->pages[offset + i];
> +			u64 val = page_to_phys(page);
> +
> +			if (val != entries[i]) {
> +				pr_err("%s entry[%d] [0x%llx] doesn't match page hpa [0x%llx]\n",
> +				       __func__, i, entries[i], val);
> +				return false;
> +			}
> +		}
> +
> +		return true;
> +	}
> +
> +	pr_err("%s failed to validate, released_hpa [0x%llx], root page hpa [0x%llx], page0 hpa [%#llx], number pages %u\n",
> +	       __func__, released_hpa, virt_to_phys(array->root),
> +	       page_to_phys(array->pages[0]), array->nr_pages);
> +
> +	return false;
> +}


> +<snip>
