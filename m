Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356726158C
	for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776359486; cv=none; b=g6FkDjGLj21qBrAbd/khWguBof4vtZxsOJHHQZC5W7BsM0wKtFBSGO6TkRdBt5Yt5Ilc6bF438apG6GyQyZwevZDrcBGGCOMpZISND7wmyhmPi1pKfvYuS2u5r8qO2AXOqRbWR/UqOUurgnqt1jz6W8eWmj9/XVUTT7HdWKy10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776359486; c=relaxed/simple;
	bh=UeZHfyGs1tIaUr8eaZMz+XjGFzS1NiRWeYyTd0eK7qg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XSWYuBhqcuM2PguRU9oZKhLDQkd0pvubYvo07TABFU3oIpgmm0hKwqBgMHIk2iPEgxhCsjhKRSaEBjQYDW2ki7ZpOvJWnN2Nq1CgTrEMq7e4q0FF8R/oUEjLiM6JbCmiLOS27/uk7k1MGDP90d4/NOD6aWbf826vNZVVNuCiiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKyyeUeW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKyyeUeW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35448ca4689so1243162a91.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Apr 2026 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776359484; x=1776964284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeqmdJUNwyihZL8VfozVxzk8qrw3SLaKZYTKgL9iGNs=;
        b=cKyyeUeWusWB1i/r50clWxjoPRaHHbTLJ9mAH0Bc4AZk4BTUUDqLl0QGPPUo4VhGD/
         EjbXD24w7akMU9VGU2o3L81A9/oVP+rgeZwF3wiFwQHNCRiTahmK8T0bna4rt3UMU2is
         xmHDFfS83FA4solvZbi4NKUX43Dhng9suEBmVVShvEONpQhnN+lp7Dd/yYQysckz7bq1
         NJ3yf+EnZj2DJy72eOoHM6owxfOkVrbqDXGws8watfFV15U9Nul9TdovZDap0z94qu6g
         nzJjkaV2t2RS3CQeUkPtNX9puf2fV90qdTpnmz4dc49+Q+7gMb6DWWOuYRpPty4qYtDB
         VWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776359484; x=1776964284;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeqmdJUNwyihZL8VfozVxzk8qrw3SLaKZYTKgL9iGNs=;
        b=r3UK8UvQePZCtKoJCEIPLeqwotWBMBDIqI16qMsKBnGcyh1/ae7TqRdzLnOaVSRY/Z
         j2dw3Wcs0LEbF6UZKSxL6E1Bdc+9K3QFMoNLXhwHtJ+gXxppvADDyUGAvSxTRKw5kxyr
         sxJffJA7wct2zDf9q3WbrrOzkO61wbcqcFzhkyoihs0K2GR+xXHOy3NlKLq+yIAb25xz
         t9lDU+XvnNFCO6c5v6k/95Y2sy0fVyJBaf29OTplL+5GJmSFB7ZUvqhiNuGmfifjMRkM
         lK/MPA555GO17w2txu9bIxUmHGdYHtxYQDSntnLARUPYjCcVt8UVq48C8qyc+ZrVk0jP
         f6Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9WU1+Cp1rMOiyYwarvGHunp4ZVePeCd3GprZRTF7f4VHHRYAaBfAv1zFYorMnL9eJKb79G45SCoAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN22IoTYjgHc2DQbkvyx+G1PLLEQepeTY/fviIxyVbH+Y9Af7f
	VBJXt8QHveCjna5qHd0EJfIS8UHiGNtjUSXxJ98L0SQaG7EKmj/KseYq
X-Gm-Gg: AeBDiettYZAisdNnKv70C3HAzbFBVBSjYFjNjcX0o52YNJMUI09M91QxKzskyAm6lMY
	5UnoW5mFNi+VMsj8VLhZASbu5ADFdBz7NW4htEMwlwC2LP5Gfn+QHeKbMx/Kad4jkk4yUMbEi1e
	iKaZ8PxFjGcejkuawESnKna3QvTVh9QFLAOkxAPDaZ0Jdtp6t1Xwb13Vd7GGcNzzGMX3FHX3sfG
	LC8Fq/zhCHDXktweBmyCrESQuOz+l+ABITJc6eb7wIBKOpf3XzQH56/BUAWo3IMTwuH+mBZAepc
	j+7PxKWrRYKV9n4UYRCN6MNJLE5ih0FCKrPbutjHhwGzLv2O6jC6TvZ5t3RakdKwiBBGlejudfp
	tz8gMBvkmK0+q0E5t4L9BPizfl2EhK37V8uQhXc7qK2wjvh0iHYvEvDyatgz6vPQMxdSZw0ZQt1
	fZDHzCil8YHqDkXgQ6OWP1Bu/e+LLXk6ONyatqPsp69dbOKDU1L6K6YQNWS2HRAShV8UY=
X-Received: by 2002:a17:90b:184e:b0:35b:e4ed:4f60 with SMTP id 98e67ed59e1d1-3613e00e269mr89748a91.5.1776359484057;
        Thu, 16 Apr 2026 10:11:24 -0700 (PDT)
Received: from [192.168.0.100] ([163.125.228.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cd63a8sm3644769a91.12.2026.04.16.10.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 10:11:23 -0700 (PDT)
Message-ID: <4dfb0f17-dee8-4f42-aec6-f089a99bf221@gmail.com>
Date: Fri, 17 Apr 2026 01:11:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yangyccccc@gmail.com, linuxarm@huawei.com, linux-pci@vger.kernel.org,
 jic23@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PCI Trace and Tune
 maintainer
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sizhe Liu <liusizhe5@huawei.com>, Jie Zhan <zhanjie9@hisilicon.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
 <20260416110619.0000678a@huawei.com>
From: Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20260416110619.0000678a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/4/16 18:06, Jonathan Cameron wrote:
> On Thu, 16 Apr 2026 10:42:19 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> Yicong left Huawei a while back so drop both of our entries and add one for
>> Sizhe Liu who will be looking after this code going forwards.
> +Cc Yicong (Sorry!)

It's been my pleasure to work with you. Thanks a lot for the help along the way (of course not
only on this driver :) )

>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Yicong Yang <yangyccccc@gmail.com>

Thanks.

>> ---
>>  MAINTAINERS | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d1cc0e12fe1f..79efa7b94c9e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11572,8 +11572,7 @@ F:	drivers/perf/hisilicon
>>  F:	tools/perf/pmu-events/arch/arm64/hisilicon/
>>  
>>  HISILICON PTT DRIVER
>> -M:	Yicong Yang <yangyicong@hisilicon.com>
>> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>> +M:	Sizhe Liu <liusizhe5@huawei.com>
>>  L:	linux-kernel@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt

