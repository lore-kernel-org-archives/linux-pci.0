Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBE17736;
	Fri,  6 Feb 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366940; cv=none; b=hWHjVGk+zlbL9qVtTXmDMdrVctALHZtlPTaSJpLqX2e3HGDHkFEw6OqiDwlbMUO3XkZwi/Rebthzij8AxHQbPqRTK1VyDoXqem4abgX6+sh5j1ghGmH4UyDoeAAR4UUsH/Z8D4wNc0/aHF+LVO58cBQlN2SOHn3egR22zgsNYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366940; c=relaxed/simple;
	bh=gUgEChUYvZH5tl2tqmaDJD0FojcavERgpFx9E7kDMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMPfALM6m02do0HS35Ct+6JTpCfe57ACkiMw538yIDZzDf0aIpkqz0z3bpKh9Nou3gW5ZW1nVqRYNO6+ocF5dkJwdg0Nwo0DGDKjByNFqh1FXd/TLDBocarkRv1fGa1yN1Zf+VRSxIxj94R9nR2WjzCla+BwzbWemgg89IDuPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGQ4Bduc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGQ4Bduc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC79C116C6;
	Fri,  6 Feb 2026 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770366939;
	bh=gUgEChUYvZH5tl2tqmaDJD0FojcavERgpFx9E7kDMOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGQ4BducwTiGoJBLr0+a+FwrwZcBMSgzn2qr5y2Dpaf7VbvQbCTNwyo3KmE+GFuyg
	 l+V9ovGuGowudYzcAQb/8jq85pzq0eLhRwkO4SqgWKOm1cg0djPe0JHaijiOkhiI59
	 SzfVkgrGlDoRiTAM/KS4Bnfk1sBjAVWV/wdzcGNRoKh6H4AiW24fd6b3zpGQzbkshk
	 o3jNZHFwFeKbl1ci101tTucXsiMKhT/mHmrP+XVkMcirQ9VT/T45dOmNTibAlyT3uo
	 tSqAuL72AZj9yIDQp1ZdgrM2qBLSJzBXjRo0GxG3VPyFti+BQ/oyGCPcDk/iA6jmBi
	 bVb1vRF+HRaZg==
Date: Fri, 6 Feb 2026 09:35:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] pci: endpoint: pci-epf-vntb: fix num_mws in error message
Message-ID: <aYWn1n0l6cuogxqU@ryzen>
References: <20260205113040.240354-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205113040.240354-1-alok.a.tiwari@oracle.com>

On Thu, Feb 05, 2026 at 03:30:37AM -0800, Alok Tiwari wrote:
> Correct the error message that incorrectly prints "num_nws" instead of
> "num_mws".
> 
> No functional change intended.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
