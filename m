Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019986;
	b=a+qFq5Wzl6eFTgUI4DVFyLlv7EcoZ7tHJJTqtQ06bSN4kFERAFgcQDRFyqBRG366u0oH
	 EzVl+JiIhEEV3JtQK2zlQLFeLiXTeVS/Iyag/268vIn/CXOBZpSBhLNP4IWcWZaESAmrv
	 SGFi4E9ccMCjiSFkAGYg9Los0UkdRtQOBQ8EdAneenGk0fj6uL7VkrvwJxI31Nr+1ngqU
	 bgWzMFFPdKoHNR7VtyyY2Yf/q6RlNwFxvC8rZ+nS8KlRq1xDjFn8CPY/IvfKXGs+VoZe2
	 QUFSeZ+8M9IHFqyC1T2BGbkG/6IWP3PI7QhDqRVU1hOnI00gJ0T11q06EU0Fm0sgtaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bh8psZOmC4bOFeg8VRYosIGA8CEyLOtfgzV/XgfIDhQ=;
	b=IKtIUxWAbAHvJpiD1Ssq8hlSx/MyEdHjDFg0xoy60DLrOzjZUpDtOsPr872xrN2txO/6
	 V0DuTT9pFv3229qZVJI+E4ujtLRCh4erlkCs/71KTMobPdMgpErfXKS4bIJO06ghfdIxM
	 LfgltolMrjq8+qYYQkPFuH1LNWMTP9OUSRJJO+4im9Is5yT5lENCfKuGr4+aS9hvygMVK
	 kQVjOf6O476f1uJpMOwFk7nE9aVxVGw6qN0/OWS+A9Dmgkubo0Jn8M0jW90U7xKYSNls8
	 2q7+ovQO2bvuKtpOjfmg9ZZNPcsqmOip/YJlHmB8Uo+/d1D9tKVQ6PZTTNL/Ive2BOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1GXwBK+;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C5606A33B
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4C5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1GXwBK+
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2898353eec.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 08:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795019985; x=1795624785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bh8psZOmC4bOFeg8VRYosIGA8CEyLOtfgzV/XgfIDhQ=;
        b=u1GXwBK+2acPTtV3x6/dWKjQkAEYAj1fKtbbBZ8NUywmLbBY7ZZWJKYNrC1R41exYM
         awNcOavT/cIbWqZIJ76ueUn7gOufU8nBekNpWjoIlDKKL0rtww7CUEapAMvFsS8Bx3nr
         zebHWBxsta1UOuQoPtDfNN4lBZ3vFVHCRZ4FNTqzTKGkkJGQEGuiNBxdGOgVSDSOZzf0
         EhcySgEdLqdzX2BSwjG3WCcCqOSgwlZUGSzO4q6FjuF3WjmfSPiUGWa3g4KRdmQEPHO7
         SUSOhwfABG3uyCNDLwacpcnEZzdi9DLlfTJsVGipDvJyyKYxXZ9yLPyS0nXNdPGPtyPR
         fmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019985; x=1795624785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bh8psZOmC4bOFeg8VRYosIGA8CEyLOtfgzV/XgfIDhQ=;
        b=Gt0GVLAXsURVTafqDVMBwgX/i4bu7DIvy9oMP962qJr1kgs92XAuNQxqW2Hn4arELZ
         ZDvD1fHWETIZaXOMxfE8XnDmGd41sTtTTScTSo+vKG6J79ecNfu4XIcdjtxGs1+ivph3
         7N05wkWmknH1TOTc5FFkUCDoyEDsKzMaz7PfgGGTjWiynZ2luy5KwJhEoM9fjDDL/i8y
         Xih97+CtK0mrDozTSz8RctwU1FzlJw+1Jyy+t5HfnPbImkwklQmKr2MpsVCWzHoLbYR6
         NxWYIxWhE3y2rBuohnKsnYn6LrnKQ7X+jZAWmFftp0wAUZ21RIVASiq/IhT/Y5wzu/Gd
         5+XQ==
X-Gm-Message-State: APuU4Z++n49adUE929vYllKMmUxFNXadabrZMebdKyauqxEPZriGi2VN
	mLzgBilT7aswZ6tC1i0OT1MUQK8PDhkKg3b3p4Sh97ZosN/qvwqbcBYS
X-Gm-Gg: AZFdTZc0Ug+fh8cGRhjvTW134UCjwGVL6/v68GOndeKdgTfVfdIQzvVLO8hDA3Qfipr
	PUiNG8RXlmbc7qejmvXgDLiTJV07Z3t3IGLpJUirWLX9HUp5yYZvYkSjt9131cL/mj89nxMA4Hs
	5NMFA0leM/QKiS3l/dBrEJeKQPPcqtPKYINwqxiFYvD/ifoa51/F6aFqrjjDZ0nrHi342QQxX+c
	QYuDDgZOCyZfZv5JU3yJYC5FpLqqA0T1HC0Dd/dum3ca2BTHoQWgJLw8+sd9zzkm+Yzf9Lcd/uS
	Gzo5DEIIZxfcNY8EiIXyM6Yo86yZXcrvFdIcbQvOPhB4GoaDu8paeYynfkyJ9vumtczwtQ687Tc
	tWxtmnATQGwV2VCT6NkHAEomp3gH1diiu9LZZYUVQPKf4epGe0+NvNVHri1K5UH2lgKU8X1/aqx
	6GKSp9+JwgSVjMn8cf4MeOv7zasCnC5fULPBMCgdTKMAdWXJNDy6sdRojxcuhvS94XNRWM2ZXb4
	7C1IiqIEmOsgx0puGxLuRJdHPuh6oUBcw0d/+UIF4JYHlZKuST0x3GJ0OKyOW/ynbRQm8kEVnAq
	6yXYLW7+CevFvrMP7MarBkkaK9sYxX0OJEhTxHRL/8liTCJefJSB
X-Received: by 2002:a05:7300:6da2:b0:380:d99d:ce1d with SMTP id 5a478bee46e88-3828016fed0mr4014426eec.15.1795019985119;
        Wed, 18 Nov 2026 08:39:45 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6df02adsm10232008eec.14.2026.11.18.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:39:44 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH 3/4] PCI/AER: Report the ratelimit interval in milliseconds
Date: Thu, 19 Nov 2026 01:39:32 +0900
Message-ID: <20261118163934.96979-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110215614.3931232-4-yazen.ghannam@amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com> <20261110215614.3931232-4-yazen.ghannam@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 03:56:13PM -0600, Yazen Ghannam wrote:
> The "*_ratelimit_interval_ms" attributes convert milliseconds to jiffies
> when storing. But they don't convert jiffies to milliseconds when
> showing. So the user is presented with the raw jiffies value.
>
> Do the jiffies to milliseconds conversion when showing the value.
>
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/pci/pcie/aer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 401cd3a1b3d0..32a4c9101946 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -699,9 +699,9 @@ const struct attribute_group aer_stats_attr_group = {
>  					 char *buf)			\
>  	{								\
>  		struct pci_dev *pdev = to_pci_dev(dev);			\
> +		unsigned long iv = pdev->aer_info->ratelimit.interval;	\
>  									\
> -		return sysfs_emit(buf, "%d\n",				\
> -				  pdev->aer_info->ratelimit.interval);	\
> +		return sysfs_emit(buf, "%u\n", jiffies_to_msecs(iv));	\
>  	}								\
>  									\
>  	static ssize_t							\

I found a similar issue in other subsystems, and this looks good to me.

Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Best Regards,
Sang-Heon Jeon
