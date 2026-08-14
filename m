Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29D35F172;
	Fri, 14 Aug 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716026; cv=none; b=Is0AYtyJN9IbsmNKiQNckWG54y2zPfmblf6yyALd/LbuYq7IjBphWF5VHgCSJdNPJCnIIrUbG2sgFmFdytGtgZltGGVynEN9utdSQ0by5ydoDQNKBxA5AWaKlqQAqvFYpfKmSibZ37pKar/Fix7NNMNl4E0hT90JGikQG0WcrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716026; c=relaxed/simple;
	bh=acajLWFvreu0v+67dSUOp6HlDXvVqFbhUHFzPUxeL7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXHz1NZPKavuredde3HuiVV/fHNeM6Sob/PD3zbw+A5yum0/YE2k4wUa9gJt/ZaN6/e5W1YV1E5s60BPcsDKEAyA0LwMIEfpMslyJya25fczM4CJd1x/LSUW+g8+TiRKdfxw+6Er62p/cmUzBmF0NC5RBASSh0Mwczs9kpoYOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5zBvcMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5zBvcMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130561F000E9;
	Fri, 14 Aug 2026 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716025;
	bh=dFwWUyFAOTIzOArd8P3tOkBRHzvOk5ExFxDR/QFXUAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i5zBvcMWNZFz2y5n0bpkUtYsa5yvIvqQmD/18F70sem+F1cPnegQ6YE5tkW4oJ92Z
	 k2wFe/FW7LZKtvJVzMM2egnBmPVmOa57V9iYqlBNN7SSgCk3SiYWzi1oXdJBRCRexd
	 RD138vkV3Q7X8YdTqe2W2etpiMYb3YgTy/YDfK/85W4arDoHwrqWQP2WOGXBd8IrvC
	 tVfsRU2x9ffwjk1WmVXDGmfX5TJqJFgiywESSTBd/c0kvIrumzOb4xC8cNhKkE1d6d
	 1gzAvkb8fo5X4HMfZzvKaEd3XFoYbhGtTa2kcVAhNn/NMXpeJ/JLVaRSop0eldZvkt
	 xESmQAovyLCSQ==
Date: Fri, 14 Aug 2026 16:00:15 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI: epf-mhi: Use a define for the DMA transfer
 timeout
Message-ID: <v3o72qje3vv44rybwtpswbvo6zr25ngjbhjvdlukrso2blc2ve@4ee2xbwgheot>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-3-c12bb05e42d6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803-dma_multi_sg-v2-3-c12bb05e42d6@oss.qualcomm.com>

On Mon, Aug 03, 2026 at 04:01:45PM +0530, Sumit Kumar wrote:
> The eDMA read and write paths open-code a 1000 ms completion timeout as a
> msecs_to_jiffies(1000) literal. Replace both with a
> PCI_EPF_MHI_DMA_TIMEOUT_MS define so the value is named and shared. No
> functional change.
> 
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

Since this is not strictly related to this series, either this patch should come
first in the series or you should send this patch separately.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
