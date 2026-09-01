Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6771220687;
	Tue,  1 Sep 2026 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265160; cv=none; b=ZPWoglxhXqFOjyncGmAvNDr+lrB0Vx2apnOZU5UaRH3li14k/AQo4BP54lF5DzF2a+WNvqniYBpaOxN9OvpxETPIjxLVqLUyQ2jNXefRXYdOBL9lCwTsUqJ++wQ2SJH1/cXEuqDopI9YeFrPvmuvXFmcBQAmZZsqfJAcMmkDc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265160; c=relaxed/simple;
	bh=0noFde3zGfUsqmruiJjybtClQanznrxoEUsR5y4F4cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsXNIkyMHSsSvBKAe6ALWAWFIYsTfGE1A4ro2niShE7GLpvRANfw2/yj6vsBAvFkvom02FRFxnt1DreIWmeKFOsy9tdVC5pGwld3W1+kbPozPx8zjCot6D14hupJu1rbh3+28xtvr2fahlHaiduihIl3v9k1g8x9xU+Yq62Szhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc63cB67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc63cB67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0ED1F000E9;
	Tue,  1 Sep 2026 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788265159;
	bh=as4Tmo3cFo1ViIaVNX6sWSjmrWTBeB8V0y9+kZYu61g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vc63cB67Vz/jl3Lf46PQSP+HA3We+q5o0KAfW/lRfhRslKTHQKtbpnGp/rnGhcHIv
	 xNUU5idYv49T9lg/dDrUXVCCfGU3Zk/zOAR4SerMOX4IRIyHwa4h9YGc2CH6E4UQpo
	 1i41SIQTPlHaGDUoHHzvTycuxUTF2Iy5AceXEpf59iOoT3GItrDON+IsTtl+dzuOjv
	 zaemLL4R5SkFniRCwG9I+Py5I0i8Q/ZjyCN9gmc6+Bgqyg7AH8NzaxvtGNXmMMGaAK
	 f8tO5g3TF/oPR+qydMmEaRK78aLEiOYyF/LdBowaVCPj9ngZtugjYQndLq6FhKIv06
	 stwv3/wg+X1LQ==
Date: Tue, 1 Sep 2026 14:19:01 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: vkoul@kernel.org, frank.li@kernel.org, den@valinux.co.jp, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michal.simek@amd.com
Subject: Re: [PATCH v2] dmaengine: dw-edma: Cosmetic Changes
Message-ID: <dx5jvko7ygrqugzkt3k74l3d7lk7iauikmxrzuhvn2b4bdv5ub@s2l6zl3alx3z>
References: <20260820091314.684871-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820091314.684871-1-devverma@amd.com>

On Thu, Aug 20, 2026 at 02:43:14PM +0530, Devendra K Verma wrote:
> o Arranging macros in ascending order as per the bits represented
> o Cosmetic changes, typo corrections

Nit: Reword the commit message as a single sentence in imperative tone.

> 
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
