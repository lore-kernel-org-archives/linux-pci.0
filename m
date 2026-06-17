Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D837646B
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721879; cv=none; b=K0hNNyBgBYpGaAfvJxLWlX9FmkIX62p/JaASNDag38rudzmIZlLhHHqgdivnT9mfTxjPf5bWUNJmsn+m4woA63Qul6rlFAOlK2uYbQfLAEUfwt2AUR01yZ2LZbXO7ZdSF9o4RQEODLLk5rwLiWY6T7fr7ebKVDMdeLYExpoKHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721879; c=relaxed/simple;
	bh=eDq4m7UZfAPnpdH7sRRMWLGC6YxNvMKBIFq7QtAyXEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzS1ZGYqWVEH/iIN4KIpKUsPd1J7Ob94rDVtamL/qXMmImz6wHlVQtCqOHSFYJwUyUK2Q0j5mAJjRVHI6w5SuUHjFtpLWKws58vIXGJGahrsSKeOsWs9XGWLZBsmYdhK+50O5ZkkHtcBDqCSbOvYGJcUGrk7kIYNFqcSvwmXy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByEkJuuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByEkJuuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA711F000E9;
	Wed, 17 Jun 2026 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781721878;
	bh=4Qrc59+zIokh8fs0JKNG4MO+Rw0dpQBwmRZDN3GGNVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ByEkJuuE9nbyaIp/AQKOc7BgltZ37Y5pU5hWDI+iYV9uecqDARXLR8QnGxnoxHXpA
	 ECwi2Abi8sAtbXOMDmnQIPj7Ec8bAsFsz6UCVVIi23EiSkWjXv7Z3w7D4tHNQACcy9
	 LfLcaJ/EpDqnWTuIvIY8lfAzxfNtQAnn3sIphFQnhslUDfuKRi3coIZQE/kYSOce3G
	 R5f/fZyDbIojYvxRQJ/497rmdKN1tay/TDgvkzwSh1Mcu4TFI+dVU54Sh7ZYXedpPb
	 kYV2U7MGaIaXx2imIC6lWekOXUFrqUWVcj4N9frjZKXbSEJ0P1lDz0vmGLCiSuqGZo
	 zitDiw87+blag==
Date: Wed, 17 Jun 2026 12:44:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kangfenglong <kangfenglong@huawei.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangyu (Eric)" <seven.wangyu@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	duziming <duziming2@huawei.com>
Subject: Re: [BUG] nvme/pci: nvme_map_cmb triggers WARN_ON in __add_pages
 when CMBSZ.SZ is zero
Message-ID: <ajLrFQnair8i978C@kbusch-mbp>
References: <ee28ccf4e3a6479e8851b7b196219244@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee28ccf4e3a6479e8851b7b196219244@huawei.com>

On Wed, Jun 17, 2026 at 07:01:32AM +0000, Kangfenglong wrote:
> Proposed fix:
> In nvme_map_cmb(), add an early return after the existing dev->cmbsz check:
> if (!dev->cmbsz)
>     return;
> + if (!nvme_cmb_size(dev))
> +    return;

Looks fine to me. Do you want to send a proper patch for it?
