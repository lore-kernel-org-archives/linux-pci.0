Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B1273F9;
	Wed, 25 Mar 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426546; cv=none; b=BvVmRdGmENKPQ6UUUnSlJwOfyQzwWNnUjaFIkJuITHDm8FsqQ6j9aeUvnSFON6VT+oZRE3a8n5vFfAWDZCw26+sd5QZj4IUZng7uBT7tzlUp+dzBh7y/b9Xl4G266KFEsi/Whh5NUBp595JXjmwf/xcKaH+uGMoLaiOCt6ncKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426546; c=relaxed/simple;
	bh=yhal9WIBWOpAZrfi0kPJNzKNaCf2tiGF3x1eGl3VeXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HpVIzO7zsSDJojC8nZTN+WgU0oQitEUtzuNsq9XuvpIRkxtRSqcsoY27DZ9eUFngBF8fudNIIjCVdwXPkaLhwgeIoRS46XCv/Yy7EsoAanVRnvGWNoGA9p2wf5GMFsyjal/+T7yKJPbqo50/Lq/mwK6nuI7pogGpMLfM8rBlW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McRwbuwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McRwbuwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EF6C4CEF7;
	Wed, 25 Mar 2026 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774426545;
	bh=yhal9WIBWOpAZrfi0kPJNzKNaCf2tiGF3x1eGl3VeXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=McRwbuwoD3WxQYe8+iU3nkP5k7ND2lpoxIbE9KzGobvHzRNqrH4XJx8qLe+7/Npbt
	 /H65rAohhKa3TdV+4ERgpHOCB5iEoUiv/KmNl/3C1dTjvLoBPyD4M0XwA03lTHAnQk
	 WKsH96+i7/o/4+ta0vBZG7l96bHJisAICfA9pCT95pcJcNbJeM7DZa6/f4keknKYh1
	 jKpdKHsKZ3neEkNJt3ML3wFLoLIOsqwIkkfkNUDrBrcY068g0tbBhYXpXDfF48PIh4
	 n4fANORdEbEmLKF66EHOh7kfxcwM+C3/ohVAFTxvXA6EpyFzq4mAdSh2zfLHVqX7yz
	 8/wVf/TKYoIZg==
From: Thomas Gleixner <tglx@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Inochi Amaoto <inochiama@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq/msi: Introduce update hwsize helper
In-Reply-To: <20260324014754.4973-2-kanie@linux.alibaba.com>
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
 <20260324014754.4973-2-kanie@linux.alibaba.com>
Date: Wed, 25 Mar 2026 09:15:42 +0100
Message-ID: <87jyv0fhox.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 24 2026 at 09:47, Guixin Liu wrote:
> +int msi_domain_update_hwsize(struct device *dev, unsigned int domid,
> +			     unsigned int hwsize_new)
> +{
> +	struct msi_domain_info *info;
> +	struct irq_domain *domain;
> +
> +	if (hwsize_new > MSI_XA_DOMAIN_SIZE)
> +		return -EINVAL;
> +	if (!hwsize_new)
> +		hwsize_new = MSI_XA_DOMAIN_SIZE;
> +
> +	domain = msi_get_device_domain(dev, domid);
> +	if (!domain)
> +		return -ENODEV;
> +
> +	info = domain->host_data;
> +	if (hwsize_new != info->hwsize)
> +		info->hwsize = hwsize_new;

This is incorrect because the underlying irqdomain has been created with
the original hardware size. So just fiddling with info->hwsize results
in inconsistent state.

