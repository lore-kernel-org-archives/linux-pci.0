Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267415;
	b=SIH+5uf/aSHCetaT0O9B175SsG53C3u4Z+dm+V9BxAKMy/VwZhK8yR2JbyhUE1fHLOwD
	 aiMJy/8BNcHjaI1x1oqKpSNCJ6yNPYakvk+6DWgOIWR0OtAoYrSL/5d1UXlkjdbJxZThz
	 aktmVhlVM0Y6WylgdeQRla0wyxLt8saePNviqAe3gcjm7tJKaRCNTPkBpZrSBaUm/Lo5o
	 +E3IK4jgFWY/kbG9bBtSsBN+cXasFhQXPsoNU4uA23S8oLX7eIsR44F+SFRdLHmW1Wldx
	 akSPi7PWYqloODgigcL9B2m4nCs/D/gbTCO3lNVJNVivnynvS3VMojjNxi7B2ZVtfww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267415;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PV3NgAozrqWqxEQMaX8OxVWRTrAfPuHUQuyLRIB/awY=;
	b=DTBTb+asaDQ18dVFsXqiXS/k2I2AKeH5JxyGC/sCz2fUpJ0b/UKQcllM0b6v/Fm0u7LB
	 LuofETf/WwVr+g/0/nf7wfed9Ruj2njL2zf2gR77Iy745CZD6V2WisIPl6orUCwqjzXrP
	 IqSy9PVvJvfLn1XJf5rAyMX1VDXg2sRQ2TCQq2mMP3nL6UOhqqzkUwrmjqfW+oqVnY5gy
	 M73SsHogS+WfWb+qwpCnESt1zXcPJ4+XMjJKTYQUJMFR8vgEwP+yT/0fZrLVF37aIdr1g
	 R7L4ALG7u4D1g7pX3w61RsgBb4vYBtv6da7Clws5wxjIEx0ZRGIi/ZZRPJdFlHnEIQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB6bYnhx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185F606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB6bYnhx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04571F0089F;
	Mon,  9 Nov 2026 23:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267415;
	bh=PV3NgAozrqWqxEQMaX8OxVWRTrAfPuHUQuyLRIB/awY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=iB6bYnhx6g6QEs7lsu1UTZqFL75zvpk1qGfm79ao77Hqt7va+eT8Q66FpHlIfYcEU
	 OpEui55VyqIAT8xuu5i0bo153L82kfvP9GYeHBy6ZFR0IAZJeUwlweKqw6NcVQ0fWm
	 eRAVCH28/gQ4zFjCnM7dxwEm5JjwsJuvdNlY+bJjsqY2zqepdXe6/acRq6iq9Atpjf
	 AiCB++lHxqdbmD02KPmNlbcCAvAw4YzhY0aRUtDoFTpuQ8UoHSfaAbIJ0TvCe3gHaP
	 LsrzxWZRQ84RapPwXp/G44uw+LUhjOamcTTXF/eGMgT8jGiM3S0SDRbL6uO1ByH0Tu
	 m1kau6/jNpKfA==
Date: Mon, 9 Nov 2026 17:36:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 0/2] PCI/AER: Improve Error Source handling
Message-ID: <20261109233653.GA349541@bhelgaas>
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
In-Reply-To: <cover.1793982724.git.lukas@wunner.de>

On Fri, Nov 06, 2026 at 05:38:00PM +0100, Lukas Wunner wrote:
> While analyzing log output provided by Alex, I noticed that the AER driver
> fails to find the error-signaling device if the Error Source ID register
> contains an invalid, non-zero value.  Fix it (patch [2/2]).
> 
> While at it, fix a potential NULL pointer deref in that portion of the code
> (patch [1/2]).
> 
> Changes versus v1 in patch [2/2]:
>   Reorder a < b && b < c comparisons (Ilpo, Bjorn)
>   Amend kernel-doc of find_source_device() (Sathya)
>   s/subordinate/secondary/ in commit message (Bjorn)
>   Document behavioral change in commit message (sashiko)
> 
> Link to v1:
>   https://lore.kernel.org/r/cover.1793697480.git.lukas@wunner.de
> 
> Lukas Wunner (2):
>   PCI/AER: Avoid NULL pointer deref on search for Error Source
>   PCI/AER: Check validity of Error Source ID register
> 
>  drivers/pci/pci.h       |  7 ++++++-
>  drivers/pci/pcie/aer.c  | 37 +++++++++++++++++++++++++++----------
>  drivers/pci/pcie/rcec.c | 14 ++++++++++++++
>  3 files changed, 47 insertions(+), 11 deletions(-)

Applied to pci/aer for v7.5, thank you!
