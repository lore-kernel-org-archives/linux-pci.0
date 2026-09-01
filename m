Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F572FE056
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228210; cv=none; b=rP28eB9pBfvxEyD0SoiVGuExGH2sQ7Oj5YamM18nLEdk6lKlONrq2wXK2Tu/4dWkQT/9v0lU+KaJNeM5z66xBJQRclSds28cRgl5zm6VjuBYL5LOAL64noeBXcmrwj523AWTRHXNaGRcBmIToE9k4n/hDDEq9q6HWNGkLuQYCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228210; c=relaxed/simple;
	bh=TX6r7q1YQURmuBkaszMdOQ7QsmdJGZBe7gLlm0x5dJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVmrB4muT9Mowi5mlnofJke7PLnE4RgC953Gcd79j+X1XztFoM+mhZ9/WNW2R7MaNHwfpd2Mq0jt6ZYBB1LPZFjznMi8hsz4nGWcuu64w48A75hfXluRsk/O2xEeGwDZSdPPHxPEN6qHL5MCwH2+Jz+E47BeNYtONPOBIME71D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=wH/NsKt9; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wH/NsKt9"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52de50e77ffso51055451cf.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788228195; x=1788832995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEaLnco64T9D+NWKBTWVLYxPTE2JIhEmYG1CXe1LYlI=;
        b=wH/NsKt9s9O5Z04CHSbSZTX+Om9caC1RyVFdV2kxMigm8hzGkvbXcjhviZ2i6dQor0
         WQgl5L00ZaB2gob5bEJN0hwOZcmX60TYEkcN3qqGHe06gOuiaFcWV3Q93vCVX5HMoTb6
         aTN+u+Kt0Ez+Qa2sfi5YaeQB37pB2JkeFWJ7bRI30qS58Pz5Yl4kLdVLsu/l5NGss3ny
         xkxWiaFfj2O9UnDHjVY8qPtcP6d+Ad9YJIVWZ7c/b5mZtA328dVgOJiiZfhKDs/YtzCb
         dk6mq+z2+nKBo4G+OhIiqSu8fKzJ839eLB8EzrKVKu/ohze8BtZEIhgQdmXwQzric2oF
         iTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228195; x=1788832995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEaLnco64T9D+NWKBTWVLYxPTE2JIhEmYG1CXe1LYlI=;
        b=Xh7RWYTXsjySOoQnXWWQxs7UXP/jSinfoQNB7bQT0mnETr3bvw17boVNgs0NKzaLJp
         HAZJr2eXs1M/yMniDU8pc4vqVO7wvT5F/Vm+wa50/Kk7oACtjvoKWN32gsIeIn8wp/6/
         BzNdzax1O5PcReROyoL8gq9aaztLCqWNcIwho8HhCMVZ/g9DFRWBIqD4VLdFGaPUw4lW
         yaFBP+zDSuHHiDXqHuMFmRq2mx3wCFhzq2Hb+g6ZgGvCp40BWngbnU0hVK8EbsrZR1H+
         awWq7Wp9Wd75HGD0I1ilKyy6ZpEsmlbUJRSvOLKgb149VMfx1/opA6T0n9tKvMzBlqS0
         X12g==
X-Forwarded-Encrypted: i=1; AHgh+RrgCFl5SXCySKoh66kJGFex2PycEjgZEa0YjqRZFihWujvUXlR5u+PQeCw7MZ4b+A30w7rA7KJ618Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lJx6ex21RfcuyVsFy1x8OHgWQnwa/3WLsQs+fLnq2VtghBRAWK
	G1TB21otqhrygx6Diq3ksV1wlBtbULkgbMhTXYpCCi7Axs1h4zlGv/zgWgoVmRy0WZ4=
X-Gm-Gg: AR+sD12fqsc8B32g9LKjTzs0peQiNZZzT1/T8fDfkjf5P7mzaKZ6j9fM8OPcLLYdGPU
	w+lkTe2LmbA5w1+jqPVTzw+AbRiZwSElWM3pelup2nUCS7TtgkGiPZ7/3lOyD7uW8/ffp3ZYHgL
	50XaIMuQBoNxG/Byo4VgeRb1XWi2/ucxiKniBuvgr6yW+X0aQ0baUOhr+mqBpx4JDnPHh476KqQ
	G0j8QB4CTDl0ZQECvxQGD6sI+avcwgP7xaVaVJSzZOkU4lhbZtXmfZS8vmF49GgZbooF4t1MnpU
	YnV5ETKw9+T6HY1hlxgmrd2qBgCi+zcMmWhmwWq1FIH+po/mSPN9p65avCgWNcrqqJ3nGZEJGM3
	U75SQsZJ6Xt3Qx5ixEAfk6RQ2ZENq0IWrWoJ9rEhIr7bLOrS0pRGPBGs3/Ii7I2k5KG2ytNTfjx
	T3z/PDEKhLLgJEfmiSy69fqCQZkGTFLdxjZn1Fguw92iLABuk4l+DwvLLOX3mW
X-Received: by 2002:ac8:7f11:0:b0:52d:78c9:9377 with SMTP id d75a77b69052e-52fb9665892mr352804801cf.36.1788228193699;
        Mon, 31 Aug 2026 19:03:13 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce44f5157sm97576386d6.24.2026.08.31.19.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 19:03:13 -0700 (PDT)
Message-ID: <50176d59-0f7e-4b38-8760-551eff80bb88@riscstar.com>
Date: Mon, 31 Aug 2026 21:03:09 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-5-elder@riscstar.com>
 <20260901011827.730521F000E9@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260901011827.730521F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 8:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Outdated comment in `of_bus_pci_match()` incorrectly claims a warning is issued.
> --
> 
> commit 0ffaade5a7eebd20cc4d79d7c8ed0d49f6da1857
> Author: Alex Elder <elder@riscstar.com>
> 
> of: address: kill of_node_is_pcie()
> 
> The of_bus->match function for the "PCI" bus type is fairly liberal
> in what it accepts as a PCI bus devicetree node.  If a node has no
> device_type property, it even allows a node named "pcie@" to be
> accepted as represnting a devicetree bus, though it issues a warning
> in that case.
> 
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index 499d37ceae210..ee2eb44884d85 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
> 
> [ ... ]
> 
>> @@ -156,7 +146,7 @@ static int of_bus_pci_match(struct device_node *np)
>>   	 * "ht" is hypertransport
>>   	 *
>>   	 * If none of the device_type match, and that the node name is
>>   	 * "pcie", accept the device as PCI (with a warning).
>>   	 */
>>   	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
>>   		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
>> -		of_node_is_pcie(np);
>> +		of_node_name_eq(np, "pcie");
>>   }
> 
> [Severity: Low]
> Does the comment block above this return statement need to be updated?

Yes it does.  I will issue a v4 of the series with this correction
after others have had a chance for review.

					-Alex

> 
> Since the patch replaces the call to of_node_is_pcie() with a direct check
> of the node name to avoid duplicate warnings, the comment in of_bus_pci_match()
> claiming that it accepts the device "(with a warning)" seems to be a minor
> documentation regression.
> 
> Could we update the comment to reflect the new behavior?
> 

