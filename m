Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675F299A82;
	Wed, 10 Jun 2026 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133681; cv=none; b=PP8/v77ABocUx6Zx/mH9Zb1rATWR1++xb36J5kqxy26wGiQLJojgh0fai3R7LgTvCiSBcHzPqnUHoO47Ufh8HI/9w31fEzRvPcucLLxyhJ4O7RKth9fxu6h6ef42+YjaadNoTrEY2xBuGUU5w5gohHFgnrO/imHnLnshKzYPXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133681; c=relaxed/simple;
	bh=0ADfnQ8czZLpWCsiojUzxdOuhYUqCYDerD2scETEEgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSR8pQCTzrYdU045Wjn3JHdZNrFHEFsa2GzDl+s+WumFEoSuYUhb6catpF9EcKq87epQRXRxj9P/fZeJAihdQqT6ZTmB7Rshj6pPW3PENJ2xY7ChUAIaDq1CRE6eVB7vsZgywlfL5mSoAh91wrAmk2V44xI9Yz4UAoAUnlGKPRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U3qJBmhZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U3qJBmhZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9wCKYk9ipCH/BA7MdLEIq6BkUVsdEsoO78w2x/7sZ2o=; b=U3qJBmhZf9CRxCeA9tY1a8rgQK
	VvNBvitBupG4j41A1Ykgftr3bSAm13ZJ0N4DoyA6EgcFfHoTyGTgf8MuPFhEJZ4m9+yAQC6GFN+0F
	4eYxlOSCkUY77IiU3VRCOxJ4e4USN+ibwSWtegvdo8Szvr3bac1IP0a7K55skCtAYL0lVB6ZPzBij
	+4cAGwMm1CCKcvgjGXt424jkhsEIhvieJf+HCnTRRxv1grn1ByCaUJasJDvzgsHlgeUQAULnTnKXm
	TmLpaw9y0Fx0kGpVnJVnsyF40yPZN68nSv0J7V1dhsXi79IA5S3d26gLRYcNvvt4cnNTCC/x7XnR6
	ivK9G/5w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXSEX-00000008Sdk-3Vuf;
	Wed, 10 Jun 2026 23:21:17 +0000
Message-ID: <cf1a1f6d-df63-45cd-b73a-cd3e26f2ce4a@infradead.org>
Date: Wed, 10 Jun 2026 16:21:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] Documentation: PCI: Add documentation for DOE
 endpoint support
To: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, corbet@lwn.net, kishon@kernel.org,
 skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org,
 alistair@alistair23.me
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
References: <20260610100256.1889111-1-a-garg7@ti.com>
 <20260610100256.1889111-5-a-garg7@ti.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260610100256.1889111-5-a-garg7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/26 3:02 AM, Aksh Garg wrote:
> Document the architecture and implementation details for the Data Object
> Exchange (DOE) framework for PCIe Endpoint devices.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> 
> Changes from v4 to v5:
> - Updated the DOE Abort handling setion.
> 
> Changes from v3 to v4:
> - Updated the maximum size of the DOE object from 256KB to 1MB,
>   as per PCIe spec.
> - Updated the DOE setup and cleanup sections.
> 
> Changes from v2 to v3:
> - Rebased on 7.1-rc1.
> 
> Changes since v1:
> - Squashed the patches [1] and [2], and moved the documentation file
>   to Documentation/PCI/endpoint/pci-endpoint-doe.rst to match the existing
>   naming scheme, as suggested by Niklas Cassel
> - Updated the documentation as per the design and implementaion changes
>   made to previous patches in this series:
>   * Updated for static protocol array instead of dynamic registration
>   * Documented asynchronous callback model
>   * Updated request/response flow with new callback signature
>   * Updated memory ownership: DOE core frees request, driver frees response
>   * Updated initialization and cleanup sections for new APIs
> 
> v4: https://lore.kernel.org/all/20260522052434.802034-5-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260427051725.223704-5-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260401073022.215805-5-a-garg7@ti.com/
> v1: [1] https://lore.kernel.org/all/20260213123603.420941-2-a-garg7@ti.com/
>     [2] https://lore.kernel.org/all/20260213123603.420941-5-a-garg7@ti.com/
> 
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-endpoint-doe.rst         | 333 ++++++++++++++++++
>  2 files changed, 334 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst


-- 
~Randy
