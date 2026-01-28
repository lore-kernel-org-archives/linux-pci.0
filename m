Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850929E114
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769582571; cv=none; b=TrqiHwiidfSkI85vH4t0Var+Ldki+ewqBI1XFWG8bVl8Snu/ZLCe6fK5o7NFZinCcBhxXXYlCyj/jNRIJrrw2kjqvVeJU7B/xIZZuXxmtjuO56I4CPwwGOSlxxlfbzk+7rxjqF9SILGNcRmCzQ2Od9mhy6ahR7F4TUOCUZlTWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769582571; c=relaxed/simple;
	bh=kh1mvFOHKgqBooZw/y6lqdpStWF+zuPqTBN1qemLe48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeAT/7SxZnN/byozjf47caWuj+sc6AHVuGjF5meN93Vn6Yiqa6A3EXbBRVNTAM5Cy3KL6kiFC5CUVq2Mc7cGhoJkqDu1sL3jKcjGj4NmTlrXRrtqlG3ETcuQ3lRePFguqPj0N9VLaLwsV/4stwFJqXX2fs+iAuviZdmjRB2NOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CECzCSh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CECzCSh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E4C4CEF1;
	Wed, 28 Jan 2026 06:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769582570;
	bh=kh1mvFOHKgqBooZw/y6lqdpStWF+zuPqTBN1qemLe48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CECzCSh4sWVJ/Qus3LhQTvqlzDCq5708HWP2V03TysSZTTuoYNlBewfwPAHxn00GV
	 O22p+ce0R3WnRwVk3bBQlqD78Xbtzc9ZFxzLDAI38AGy5OvbwQTFxj+9G1HOoaIqT3
	 p3C7fnpaju4xxBhHKJS8PEHtITcilJZltWYanEPCv3nC0qEUQJWkFH3a5hExUX44sx
	 Wbm7Q+wdYLEL4/r2cSr8dWzi2idP/lLWcEnsLRTNMw2JAA5cRHLE+8mcN4JwqJu9mv
	 fsUL5E1yYcik5U98ilEE5trvegOmGdXj99r5OyzMtReLky+sNZO3aSBaPb4SmeI0Kx
	 au75HV4ttDm0Q==
Message-ID: <ab6f9322-c52a-4fbe-a426-c0d752a75022@kernel.org>
Date: Wed, 28 Jan 2026 15:37:50 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: dwc: Clean up iATU index usage in
 dw_pcie_iatu_setup()
To: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Randolph Lin <randolph@andestech.com>,
 Samuel Holland <samuel.holland@sifive.com>, Frank Li <Frank.Li@nxp.com>,
 Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
References: <20260127151038.1484881-5-cassel@kernel.org>
 <20260127151038.1484881-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260127151038.1484881-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/26 12:10 AM, Niklas Cassel wrote:
> The current iATU index usage in dw_pcie_iatu_setup() is a mess.
> 
> For outbound address translation the index is incremented before usage.
> For inbound address translation the index is incremented after usage.
> 
> Incrementing the index after usage make much more sense, and make the
> index usage consistent for both outbound and inbound address translation.
> 
> Most likely, the overly complicated logic for the outbound address
> translation is because the iATU at index 0 is reserved for CFG IOs
> (dw_pcie_other_conf_map_bus()), however, we should be able to use the
> exact same logic for the indexing of the outbound and inbound iATUs.
> (Only the starting index should be different.)
> 
> Create two new variables ob_iatu_index and ib_iatu_index, which makes
> it more clear from the name itself that it is a zeroes based index,
> and only increment the index if the iATU configuration call succeeded.
> 
> Since we always check if there is an index available immediately before
> programming the iATU, we can remove the useless "ranges exceed outbound
> iATU size" warnings, as the code is already unreachable. For the same
> reason, we can also remove the useless breaks outside of the while loops.
> 
> No functional changes intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
