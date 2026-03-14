Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FA282F3F
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520766; cv=none; b=dPYozoRGpqP05DYafIrN9K4e+KkcNBeUuXbUbIxIEguyvbMHxKjGgXxz0ZiTGfzt0+uNGim1Hw7thZb74vaC7qF2LMbRt1N6QzmLJGhmNSQdK/aNnDJra34SfyxhaXFUEZzG1iXgTEIIomEEViv0EX/eMf+LfCwFpxKuVtUbqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520766; c=relaxed/simple;
	bh=t0b4Am2SaTc5Rzzo1GzW6/r13JVH+GhSKnA6pfhvMZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrxBRegfjCgqUsTwqqrUQEJIvZLphZaav39RY7beAb5ttBspmPz05sjvm+MrnvFYSFLOlzzBlu/M1UofbQq8zpowrFTEMROptLozKEKdV0YvkZ3QWMyZdpmstHRY4F7IgM+JI5P/aW7jMvp2CfwGdl/i1g5MzB/VtPvE+vDZ1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso1396383a91.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 13:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773520765; x=1774125565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXX5VKHaTVlA5Twk1yI3TOmkIkEJcCj90rxXtOUyRQ4=;
        b=k+tcw2NUoApj7/aQAjqWdWCoRhwiNibeWrgiH9EavxBWZYABc+SqB6olJ46bdTlMdy
         zKIx68M0fmu7tT996ybPytmTKfTabPwrHpV+aqw6u+UjGO5UBOfrCHL+VAVu/zR6IqQg
         6xzKHhZvEGi//ODdtxncNM44vl6ejg3ZVocyCrYDQcIPY8tfddBnWpI13c72aK/cDSxY
         6smdmVwHHycvQOoKy87tIKxa6TvzEoQgQ5OB67eB5m4SgomUwIIv+pPj9dqmcnQSTwYC
         gTR2YClUQUmlkYkTtWNMvUC63JvY+oBRgLoHssbdWBAHR3Ckvn5oemE3P9/q5TSClJ2B
         ZSvw==
X-Forwarded-Encrypted: i=1; AJvYcCXvbILKaQB2PrGwbG+2qSr7GQiPF5HKQx/Ono8698KNJFCkECKGqDGkKqtVEFg7By7DnxgJvJze8LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJx+UVyyq8yW/KtoJhcsEKCCudEZqESyRseterplIy3l8h08I
	NbokaOMPi9dFQP3XRBH692YXtRNtA49CIPJF93sjZ01ULPjl5imN2K42
X-Gm-Gg: ATEYQzxoLKkbdadHX8VCDTO76IikX8IcXzmvlUKRgE2S+T83up+Z7AeYPaPZzlIqf/n
	7UdRVAt66bHrfTZMnkvEcem99MT4MATqXlFhgo3tuJKpoI9lGICOisVks6emmHMR2gtTpl1EQQp
	okSgNMl50GMVaaill5gJd2Z0iu3UrVY8IRxI+HXV0+B/2ChPAnfsLnacsjnrKT9E1wAaU2f2JKx
	cuhQPhFY6CCTB06gnQUDDWgz9644/VDmi/OVSLBPrE3fBmrEN0uLTEm1Mo/l7daP1SqVV3/AlHU
	ZmXD+z2M9/DkT2fPYrebpVg+gnbGsjZlm9vLgxmey3XAbQAzGDxlDLFRAW2wG0/6jtF5Q8uB2en
	kRaewuIJ+1fpvI4FPoiD0tFHmDgeDPZhYfkP5hkFUJGQgXvXenkFcUAuafRZgmPEUgMKjyDdy0w
	Cy4joyP6YJALc1gC97m861lk3+o+1FeHApv+8+PbJ0YIE5Egn6rmGsnt3sqi4qLfeBNIhgXyOwB
	Cm/f8nenKU0Xxyy0t6jNd3AzrKIljOkj4AEFeBRNQlYOEW0+nY=
X-Received: by 2002:a17:90b:1d86:b0:35b:92ba:66e4 with SMTP id 98e67ed59e1d1-35b92ba6ab1mr1025801a91.7.1773520765158;
        Sat, 14 Mar 2026 13:39:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm14869036a91.14.2026.03.14.13.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:39:24 -0700 (PDT)
Date: Sun, 15 Mar 2026 05:39:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: smadhavan@nvidia.com
Cc: bhelgaas@google.com, dan.j.williams@intel.com, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, alwilliamson@nvidia.com, jeshuas@nvidia.com,
	vsethi@nvidia.com, skancherla@nvidia.com, vaslot@nvidia.com,
	sdonthineni@nvidia.com, mhonap@nvidia.com, vidyas@nvidia.com,
	jan@nvidia.com, mochs@nvidia.com, dschumacher@nvidia.com,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] cxl: Add cxl_reset sysfs interface for PCI devices
Message-ID: <20260314203923.GA672783@rocinante>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-7-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306092322.148765-7-smadhavan@nvidia.com>

Hello,

> +static ssize_t cxl_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1"))
> +		return -EINVAL;

Not sure what would the pattern/approach be for CXL sysfs entires, but
perhaps using kstrtobool() would work here?  It handles all the boolean
types user could pass.

Thank you,

	Krzysztof
