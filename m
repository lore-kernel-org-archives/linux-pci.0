Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F844D014
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902019; cv=none; b=foFqiiP5L2X3hO3CrmZYAh0AesRL2a5Y8CKF+ddj06sDIUWXZJbLzXO/h3NPsbZcj18goetCS/MNhXl+IcXz8E5xTHd6M90hjDlKdLpX3clofd85PfeIkp7KNKbxmOL/GXAeMoTdyWV+yw6XBzN3r13KsNd1/ACovulNkfGjnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902019; c=relaxed/simple;
	bh=sUh2qgnb1rvjNwwYWycAZ+HszzMtG96sy5yb7iUgUrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXJcv6Jbl06g0tDe3CwR37acRGrEj/YpwYVG4X9NI9+1rQk2UW0kqt+r9FEuMsQdsoGIHQPzFT5C71u5MleImDpcoTh2uNgeYADGmeaPGJv+tkCS8x9IptzsNoWUd1DV5ou4WFQubGLZQ7KSG5SL07332Wwi9vQJKoRebGEw3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kbPRowui; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kbPRowui"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R6bn3A2159480
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 10:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mF5ddP6Uato8c/uzw9iXykGIYPHqrtpIex8OCXzcenM=; b=kbPRowui4ML0
	YT114Vj1aVyNdnJJnjW848sZsqDgsQYxXf2af4lfe3yF9FH23tSklBFjrFv+o1wO
	ucJMCKwm9TylaOZQY0BhdJmQkngp6DAyA55R8lVRUQsexRgIwmUgj+H/mCR04y4k
	/GAEdHJqvYT6gQSouuHInLdwLedo/MVWAuYOky/jMujuavyWL/YFHal9G71FuvZm
	tUxMcxI1AwosqBr40clgGXAGZXRDcjjOD1Jq/WacVJpLsQehhEaY4Ed2cuHf56jB
	IOS9EOaVolYK/24AqeQ1zfm7jhCYBImKoLNKwH7NA+wFXFoDOJcUcF7lf4ehsFGn
	OeD1ICtoLg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4edugs37uj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 10:13:32 -0700 (PDT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304c46babe7so1945275eec.0
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 10:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902011; x=1780506811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mF5ddP6Uato8c/uzw9iXykGIYPHqrtpIex8OCXzcenM=;
        b=nbhL+z7ycdihUi+jc537fiHqvBYumGhOM/Hv2k+2nAiEDeT4wZkoYJrL+gt6r4keR0
         VhO4tCAC6XptSHundOktMjju+QiI+38jnkbCjFUPfL6QJ/xlQm9J/+jjgVX2i2iR0PPi
         Z3WrnJay7v96qVP3gKA/cKaRlhWbDX7HIjY3VFRDcqgQWLXfl9OakhDAFFtlPnOgw0Xl
         mf9m/EhToI9lrEROMma7XwtMWEH9A914C6nn3TRLErNiJFQGOXnvZjDR1HNe2cjoT64A
         Cd9jAat57FhPzHvMi+WK/XoT3aQsRm7MzecG6WFj3DkxZG6zFuAmBlYZPfvC1A7vqB3G
         MIlA==
X-Forwarded-Encrypted: i=1; AFNElJ+ae5UM9uuAnsgtgMBsTBAT3QTUtSfSP98b2LDmwcDRPPR7C5n4P4mOZQ/hggRdBsnqc1jyHcgCJ0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyCSAj3qZjF3S9VWwOS0S8M7exAaS/lfboNL3vDRpMJ/Vxzr7
	zI2Neh8MdwkjtZyydfyj9nIPPDS+czJQXTPI7qw/Onctu6u0G8Cm6pB8iOqfdyxEDXSVi3ywt83
	oupknFSeOzUxOITg1Q1RkYdkbBbMt9I5d1yvafjtcF49TBaYJN9uxWr2dsO1f
X-Gm-Gg: Acq92OFKfzh+YCp97BkluUvWnXpfsQfEAmPt7EYLjQZQCtsqH9vm6u+QUcW0qPjzPvK
	kg0XBgjscSHDUOd0+TfBvfQ7I4exhYQUq0WtAYGBNbUYGUKo6Icpk5wHqXt3IRG6ovuv8xdG3HF
	6h3H4DCbE6HCil++qXdXK/OHMu+nVRdzsrlbDbagEvuvnfHzeBrU2ZNO2anYsqlHTvrF1v/Rs+y
	bRO1EQjzJNbgRM9fP9utYyuSbAihhaGFyk/VKABKLohr3zoFD7MGXieGUD1Ptu4lj+A651osVvu
	XsvVOId1B4qHiXWTmeyYfd7LnZi5RTSZKZKnn84vYr7wMIzObKm5HNv4xCdQjUBwXccfsmN0KLh
	W4GSIOgx7AdMkzNoGEJjvVLcU4dAIe2zfFZI=
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id a92af1059eb24-1365fc7d7e9mr8777503c88.36.1779902011292;
        Wed, 27 May 2026 10:13:31 -0700 (PDT)
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id a92af1059eb24-1365fc7d7e9mr8777489c88.36.1779902010729;
        Wed, 27 May 2026 10:13:30 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-136b3706ad6sm9223289c88.13.2026.05.27.10.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 10:13:30 -0700 (PDT)
Message-ID: <1f1b9967-7182-401c-ac30-373b73216e81@meta.com>
Date: Wed, 27 May 2026 18:13:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson
 <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D4537PRj c=1 sm=1 tr=0 ts=6a17263c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22 a=VabnemYjAAAA:8
 a=gXLdhW2jAAAA:8 a=1nsJja_hzN5yKYYIz30A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=gKebqoRLp9LExxC7YDUY:22 a=Dn9eIPSr_RzuO0KTJioD:22
X-Proofpoint-ORIG-GUID: JV9bMmW0WkF7KSVG4xFUmIU05YVgXkvT
X-Proofpoint-GUID: JV9bMmW0WkF7KSVG4xFUmIU05YVgXkvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3MiBTYWx0ZWRfX9ACnFUhhtsZz
 GTLCI3C7UkfBcuZIwoQqI3t7Re7vuQ48Y5jYBj2JKkIj/fLl6trh/VsF7fSZzo0BJs2veaXYC1C
 GqEc5yNIYHYbWpx0qz+uj2QhJlyY+v0vsnwV0AWTuQ4Tz+rtJldWFollWbyNpyAzkWMQ3XQPBMu
 sFTMA036k+bTog5s+rHKFfuf9bIBJ8K85m62dxn9JJjS1ydcODsRLPA6Cw9ji7e9D21RzkhtAAh
 QVZ/NfBPGmaDDCeKU9P6hWwfERpq/YNpHYWckTZd/Q+qP+r7DLtx2Od/uiTSU+4dSsGU8yciEd6
 O+W3e25QxJ7H9aJwprPq/0gH7NJ7yJVfiWelvufccJSbAoPQoC9MDVshJrvXyjgExEKLfDNvVI+
 +ScLKqRZAqg11RGON7sBzwYSBdXRCblGxtGaS+OybnPUgfDX2Q+YbWTaiNwBnOtfcG9hMDodZoA
 nKOEi7Mj8iiq7IszPnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01

Hi Logan,

On 27/05/2026 17:07, Logan Gunthorpe wrote:
> 
> On 2026-05-27 04:23, Matt Evans wrote:
>> The P2PDMA code currently provides two features under the same
>> CONFIG_PCI_P2PDMA option:
>>
>>   1.  Locate providers via pcim_p2pdma_provider()
>>   2.  Manage actual P2P DMA
>>
>> Other code (such as vfio-pci) depends on 1, without having a hard
>> dependency on 2.
>>
>> A future commit expands the use of DMABUF in vfio-pci for non-P2P
>> scenarios, relying on pcim_p2pdma_provider() always being present.  If
>> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
>> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
>> when P2P is not needed.
>>
>> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE which contains the
>> basic provider functionality to make it available even if the
>> CONFIG_PCI_P2PDMA feature is disabled or unavailable due to
>> !CONFIG_ZONE_DEVICE.  Users such as vfio-pci can enable their own P2P
>> features based off the original CONFIG_PCI_P2PDMA (available when
>> CONFIG_ZONE_DEVICE is set).
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
> 
> Largely this looks good to me. I have one minor nit below that you can
> apply or not. Either way, feel free to add:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> 
>>   static void pci_p2pdma_release(void *data)
>>   {
>>   	struct pci_dev *pdev = data;
>> @@ -241,11 +251,13 @@ static void pci_p2pdma_release(void *data)
>>   		synchronize_rcu();
>>   	xa_destroy(&p2pdma->map_types);
>>   
>> +#ifdef CONFIG_PCI_P2PDMA
>>   	if (!p2pdma->pool)
>>   		return;
>>   
>>   	gen_pool_destroy(p2pdma->pool);
>>   	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>> +#endif
>>   }
> 
> I'm personally not a fan of adding #ifdefs inside functions like this.
> This instance is small and easy to understand, but it can quickly become
> a bit of a mess if we start adding more features. I probably would have
> created a pci_p2pdma_release_pool() helper which does the inverse of
> pci_p2pdma_setup_pool(), it would be called in pci_p2pdma_release() and
> an empty implementation would be provided in the case where
> CONFIG_PCI_P2PDMA is not set.

That's cleaner, I'll do that.  Thanks for the review.


Matt

