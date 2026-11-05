Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897571;
	b=lWc6XsGmBz/FJc/p4/UraC4dwwIcIqVaJ+6kfMwWiCzWzbAhqHYz2aFKKI/V0596atS4
	 upm+vi5d9DoUHTMKxvTypaRaoa9tWNiCL9iqihU2LSInoGGH5VF7U5u/7mc71aI2173oR
	 el3icpd/1VWVrVqsY1Bij0h80t7nRJZPLlg2X2UUxdsDMxnAcv5mHOrZRAHEiVDp06yqq
	 8dLiKzYsQLygrh834aWd2zHFn/dZsMGh5fyKhu9df164nnZOYwoZjlyaNPXe/Lv918NHQ
	 AEN5Hr5OvjkT5SO1FI/77eJIHE6y99aRNUQs7DCqsnqejWec8Ves08i1VCsCsiwj6bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897571;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5ClyxcVNRUBw58MS7cvOxBBYSMcOxqcur1d8Y2OEb6s=;
	b=uf0i9hjvjaAcg1DIoXPzTEZRK+RSNoyO+Pnoxnc+GDslvNCx126DuO5FHBWrftBcY76/
	 uBQsMhS5CLwZtea84eLhGO44mOfigk7gSIByNLcXbMZbyhuH7XuNRNbM573whqFRVHWiA
	 PzZ4xLPYMeuEt1zXW8HJTt+DF+MHfTVnU6RB5hwa4c0fRjVqyU2fBHnY3MvsbT0qzaPTW
	 vAwU4Adclx2MFVk/uvmk9xLUNMt0/n6uD2P4KX9uuLpG/kCClp+xy/Tihp73e5qpnSBPI
	 eyNCb726V7LOOcwD9GitEGzIXaBPEjoyv8DpJi4BzNvlibRAspW1wdUaE+7i7QhU0TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FctuTck8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4BE606A336;
	Thu,  5 Nov 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FctuTck8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A341F00A1A;
	Thu,  5 Nov 2026 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897571;
	bh=5ClyxcVNRUBw58MS7cvOxBBYSMcOxqcur1d8Y2OEb6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FctuTck8zzh71d1HjLIfV7DFpqxAi4No3awXAOHaTv6fkhxvA/GMKYLZQfriuYMSZ
	 TxqFAfmVtG4btGh/1oygIFE1gfIrkJZwotx++22ME68gWJJtNJOY0ofvp5UlevprrB
	 NgyEx2nqFrysY+kWInKfjT1Yz+TXeeQgWJc+unoLXerqoBN7BPxfeU/H1mFhEBpWAA
	 lzifm66OmknuxtDx59CvGU7qEJMu6EZjJc2ZtLYwH3JSJdEgwn7ctja0lKHdkpMW4i
	 1obJ3jz5t46u5G8U+9R5PeQv7HDIhpCBUwcQ3g0I5NDzYxuAIPSgtRG3TCT5RaRAKP
	 kY7HMo8Tx8mRw==
Date: Thu, 5 Nov 2026 09:52:47 -0700
From: Tycho Andersen <tycho@kernel.org>
To: nathan.lynch@amd.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
	Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
	Shivank Garg <shivankg@amd.com>, Stephen Bates <Stephen.Bates@amd.com>, 
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 19/25] dmaengine: sdxi: Encode context start, stop,
 update, and sync descriptors
Message-ID: <auyz2Zgdfx9VdYeo@tycho.pizza>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-19-3668ccc7aab8@amd.com>

Hi Nathan,

On Tue, Nov 03, 2026 at 08:50:00PM -0600, Nathan Lynch via B4 Relay wrote:
> +int sdxi_encode_cxt_start(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_start *params)
...
> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_stop *params)
...
> +int sdxi_encode_cxt_upd(struct sdxi_desc *desc,
> +			const struct sdxi_cxt_upd *params)
...
> +int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
> +{

These four can't fail but return something, and their return values
are never checked or used. Maybe worth changing them to void.

Tycho
