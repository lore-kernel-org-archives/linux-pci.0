Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58E34EF01;
	Wed, 28 Jan 2026 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603490; cv=none; b=UHkq2KbQjjlAWjK6aic9+bT7tj6HeTF1djXYTXTToD8xj2SvYXlcxq7XJoooeq0ar0T/f98eFlOtC6RUUv95GcGOgfGhS2rGN+SZ4hIGlDbraIgYSsGDCpZcqoOwRJ+CZ0L6a2A79VlsbnRluALyTRN4NVR53tM3p/5XtQhvVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603490; c=relaxed/simple;
	bh=T3R0BhT5oIdz6a1RhchbT+lxRgrPzQOXBfKtTS/eIeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nc73OdSBK8y8Sk9H7TvCXmQMbMKWZdsek4O+l21UxEeTC7svWo8tVLO3RIOWDP/vzEPthaTHeodsGISg1i+0WBhXbll+yQxtM+j+KF0Y6iWACU56OeYlX81FXqD37LAbqVC3AxKJvbSZSdJ1pbq+b2qNXiNMbLOa/e2MYSw6hKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=feQ+QoYz; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="feQ+QoYz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769603485; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tWaNz6nGIvltazfTcuVkbbMc1q157SSgKquCVG51bDI=;
	b=feQ+QoYzFI9xlJuBAT36MHREaCxwvASitoNKkqZXHrvKfPHTvutDWaiETBQgIxr3JVmAN6mwY0wECCeY7PqHFaFUFHePozFwtylQjEoI9L3UTZ7V9X84bIlww7CS+WDphGK5ZXjmzklYbuiZ6SviVgqcpla7/kFUmomjkEp0fcg=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy3OTp4_1769603484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 20:31:24 +0800
Message-ID: <1af3cb40-778e-4035-870c-30f2062f080d@linux.alibaba.com>
Date: Wed, 28 Jan 2026 20:30:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
 <20260127103931.000058bb@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260127103931.000058bb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/26 6:39 PM, Jonathan Cameron wrote:
> On Sat, 24 Jan 2026 15:45:56 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The DPC driver clears AER fatal status for the port that reported the
>> error, but not for the downstream device that deteced the error.  The
>> current recovery code only clears non-fatal AER status, leaving fatal
>> status bits set in the error device.
>>
>> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
>> status in the error device, ensuring all AER status bits are properly
>> cleared after recovery.
>>
>> Fixes: aa344bc8b727 ("PCI/ERR: Clear AER status only when we control AER")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Shouldn't this be first patch in series to make it easier to backport?

Yes, you are right. Will move it as the first one.

> 
> Otherwise seems reasonable to me, but others know these flows better than me
> so hopefully we'll get some more review.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Thanks.

Best Regards,
Shuai
