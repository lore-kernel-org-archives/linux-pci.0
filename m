Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537A2FB965;
	Fri, 20 Mar 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015441; cv=none; b=NZkKeNiGjNZhlIrYSShyLtg7ayQEUkfc4/0NRdxi+3BRdZY1Si6njQ3dxrMrbhNPahrRf36Kn805XyNT//dT8YBBUBgLOQTD2CyTPlZfCa8lRVeNXFxmvpvQm7ZjzO0Cmv4byjpwvL3SMGZNbYM5NaXUaahDEH2ozHExZOq5HSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015441; c=relaxed/simple;
	bh=qCSZ5Q3d+nUbss/z3W0256m0CFb+mhXFmy8to0gfj7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7DlaeDrEJ+g8Fta+nzUmnjQPgKA9wKxJpUhNTU5XqLr62XY+AwigoJDRHlz1PKMRs81//oh68REFTxdGwbKghH1aWChLuwut4PZe0hkAtadQdohOHg9+Pkmd94JBwATuPXPFCurfl8ZazgMODPtMbqC02pL1FHpCc+KTA/B3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogo/Ujwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogo/Ujwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53467C2BCAF;
	Fri, 20 Mar 2026 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774015440;
	bh=qCSZ5Q3d+nUbss/z3W0256m0CFb+mhXFmy8to0gfj7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ogo/UjwcJS3/ASdP1fbQt5m/gWovi+jf9+6ZHcsghw9EnbdxcSpgaqYOK+vi14c2w
	 khYnwqyZq5cEDa1yeiPe17LPN0q8kPCROo8sgv9o76EnnWqn6kS7uCw8IB4CPcvmdZ
	 plm4ztJEDxyljvOPPADqCPm00DuhCqDQIOwsn2/u7KUA+qyIl/7aIi0CdxDJNZsqmb
	 CzpyZNhP1oLk5hZWvgOfsjPORmUEyCtCAcPWoPEsI/7I84WPJUyIGYqhG/LGNhG4nX
	 vs+3VWYVz//LXsV3xzfbESWeBAqGtbsmMBxnRGHE2/erqHlul1tVG58RD8cWA5IS2i
	 oCHmGEF4HOQzw==
Date: Fri, 20 Mar 2026 15:03:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use -EINVAL for small subrange
 size
Message-ID: <ab1Ty2yu9Hv_LPxd@ryzen>
References: <20260320140139.2415480-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140139.2415480-1-den@valinux.co.jp>

On Fri, Mar 20, 2026 at 11:01:39PM +0900, Koichiro Den wrote:
> The sub_size check ensures that each subrange is large enough for 32-bit
> accesses. Subranges smaller than sizeof(u32) do not satisfy this
> assumption, so this is a local sanity check rather than a resource
> exhaustion case.
> 
> Return -EINVAL instead of -ENOSPC for this case.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
