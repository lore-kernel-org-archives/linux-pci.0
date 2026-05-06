Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630023537C0;
	Wed,  6 May 2026 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106629; cv=none; b=jnndyjvZhzVVWG9Baw6JBTEf5ySL0FWeu2VWyXEntiA2cEb10Zy7BRjyLIBGjVdOcaQ/IdPALq4ndAmlYN4XNIrPtw5SBiIbowQbACezfDC+OApFCOEuh3nm3xnXX24uQpA40D1UfmR3HAPxHRxk9Sde+jgJySbG4ztqyDKVdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106629; c=relaxed/simple;
	bh=HQbyiaoSpXeRyZXUu7ANkKCNk454t+rbNqH+vwci5/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gd10p8AHltck/7OfHxEwgNOANAis7fbS9SaNed/glm+wrtdcpXWMtB3sRAd/zKZVIU1Tm1nukIEYIggdDLTF+S28bpGtx+9REakoWKET/2J4nFzrsfxLzXh68rQDRWgHlgcyyUn915Te+ovxQ7J6RxQV8beZdqo2wxkAT0JzZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USLmCduP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USLmCduP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0656C2BCB0;
	Wed,  6 May 2026 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106628;
	bh=HQbyiaoSpXeRyZXUu7ANkKCNk454t+rbNqH+vwci5/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=USLmCduPuFo5qGxdmErnbBBNDt25yeEhmhwEX3s1VhlVqNw+zVFeb1b3TtwN5rvj6
	 DWE1Pb92TWIN3DISAxDJq+gMqPkPyPiNspAemQR8LlasgJqkbeQ+Q+Ac8gepQ6/wOi
	 /Kjp+JR5yRBxf4+hm0lT4U9QGCJ0HZsKt/qJjMcxkgpN+MNQpA2ELKX9XLW4fhucRg
	 C8W/1KzpHhX9Mh8ZgUnUzQTevzK1iboFXUkaWJJmHZgfe+u139TbtrinKRPU1AX/fI
	 lZGrSqtjC9Xajx6BoVlLCPzrC/dyqdtMC9LTawfGNaMNPvPKM/AoS9MJLjOu1cWfpq
	 b584iSv8bcsoA==
Date: Wed, 6 May 2026 17:30:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Matthew W Carlis <mattc@purestorage.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>, ashishk@purestorage.com,
	msaggi@purestorage.com, sconnor@purestorage.com,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
	ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: Always lift 2.5GT/s restriction in PCIe
 failed link retraining
Message-ID: <20260506223027.GA890441@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>

[cc->to: Matthew]

On Mon, Dec 08, 2025 at 07:24:23PM +0000, Maciej W. Rozycki wrote:
> Hi,
> 
>  I've figured out that backporting will be less intrusive if an update to 
> use `->supported_speeds' is posted as a separate follow-up change.  So it 
> is now 2/3 in this series, after 1/3 comprising the original patch, only 
> trivially updated.  Then 3/3 moves the maximum link speed determination 
> earlier on for an early exit in the PCIE_SPEED_2_5GT case; maybe unlikely, 
> but essentially free now, now that we retrieve the speed anyway, and makes 
> code a little simpler yet.
> 
>  Please let me know if you'd prefer me to fold 2/3 into 1/3 after all.
> 
>  Previous iterations:
> 
> - v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk/>.

Applied to pci/enumeration for v7.2, thanks!

Matthew, I know you saw issues with some NVMe devices [1], but I'm not
clear on whether you've tested any of those devices with this series.

If you have a chance to test the series, it would be great to know
whether it helps.

[1] https://lore.kernel.org/all/20250702052430.13716-2-mattc@purestorage.com/
