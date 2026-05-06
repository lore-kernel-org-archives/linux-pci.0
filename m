Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DD3F167C;
	Wed,  6 May 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075649; cv=none; b=fINQcwyqLMO5H/8nd8nrOxQIINKHMqqAlFRjaz4ip+gHyFYUAvqeT5lgosu8P+YIX2tIKP58bMz6T18PydN59vy71Nl9A0OSC9hEykB7/1ktCvl9LrJ7OYNtzKfVEEZWjw0REH5Sg15ihre27n7oQrFfMMzi3zbh3Sy4Zt8H+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075649; c=relaxed/simple;
	bh=NoI8j3F1YW25tR0zL0cDFy/lvZ5oPDxPYyIFiIeRMtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqBEKQsuGIGcTbNa89Am2LPqvsN53iuRjyjkZirX9ITsJDTqtTb8WVvt+TGsl86o4Vw7gasEqAFAxpGIwJwXNe3Ddsa9sHwW3T7Erdk2nLYP2kQJPwalsn6kKCplgHHw729aXsJEZJneXQBGKVd7uHwsUUty7YM6o/pEwCF9/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EztVb4Ma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EztVb4Ma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134EFC2BCB2;
	Wed,  6 May 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778075648;
	bh=NoI8j3F1YW25tR0zL0cDFy/lvZ5oPDxPYyIFiIeRMtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EztVb4MarZed7S8kuN33gAfdyd2gdT1d8RmOJSSFKQBihDeycyARB7Zhi+PL+C9yq
	 R/+vcTzXRksxQ4zwZpvTD6wqftzB10Ga7gpdTM7GQ4zQrRzw55F+U/Nk3g+BS7rxAe
	 yJCHf5Cgg2KVl/CRkbJt8CbMzRcsR7MngJkPDmLw+woqflg8wXWdWsAFF/dbk7Qj8z
	 UAQfxxezNET+jbe/+3m39trZkzCd7adVhIZWKuPKj14mUbK2McYqK0Hc7M8eFXdL36
	 HmN2psbcmeCn0x/fBlXNQFIMyKyq79uNEbKjV+Z+dYpIXcyygxbfPThvTvfgp9jFDM
	 +nsbDI3QOR8xw==
Message-ID: <758ab729-dc5a-4837-b255-9462aaa6b0a3@kernel.org>
Date: Wed, 6 May 2026 15:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ata: ahci_tegra: Explicitly specify PMC instance to
 use
To: Thierry Reding <thierry.reding@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-1-a6de5da7216b@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260506-pmc-v1-1-a6de5da7216b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/06 15:41, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

Applying this through the Tegra tree is fine with me.


-- 
Damien Le Moal
Western Digital Research
