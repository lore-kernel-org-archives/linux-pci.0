Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487299;
	b=Qj2p2SxoYqEBizjjun5sXWyIp56JYkrfpv2yY20ryuO40tj1rEEbQBihAVV77vyYYfNx
	 dDul3Cpryb2NzdB07EwiGDk1MUSjP/k1sLROz+0svsCEQDkv0qg1WgcDXLPu2uNV7ODLO
	 iQTfKcJg8NA+wcvGUQhIx5QLyn/QXjvtLLjPDI0Cb9Ksmk5WiCfXXMDx13b2o7dX+nr64
	 L4Jb2t4azW+PpjnhWO50tKWUUGah0A0bCKoXXUsC9Np1VXLgC/uGrawxIXm892x/6Rszq
	 B9yVD/dTYlCQxIJOcizEM/X0wh5lJlYnPYn82SvRYWKTh7RqzKRJP1nRpZiRfuZFH3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487299;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c/mxp7V/VRtv8rYf6QERZex7DqIj3GY/QslfqdH8fgI=;
	b=RHWy8+zJZTdIxKuqIAsi2MkVztgMR6WDngF47YoskpGHLb8iWULZvpV7DVo+QVZwRI4k
	 G9ADuBYgLp9QO/fdLVtkfbhPse4lhegt/znrGuf5VmIQIK6EVrxtqVIpDh20NKD1WnKD8
	 oTgBz/0YMSfvJSqMmlFN7Sh/t9YghyFnKARK+XHO1X3gqlmeqn3/gp1TtIPE+lfq+GRJ/
	 ZtrHMHYy1kEXdGFWmdlToGnRCNRyu7R6HPe7MlIY7N3yBtgb9bYemw/aeJjWdAskG22cO
	 5j0OQSx2eMEVh1C9eQ4vwT8ZTd6Mxw6DscF6zUaUcgkng0nIsghtheubHpmapCx+QAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkvlZ4w9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311C606A319;
	Tue, 20 Oct 2026 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkvlZ4w9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE23C1F000C4;
	Tue, 20 Oct 2026 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487299;
	bh=c/mxp7V/VRtv8rYf6QERZex7DqIj3GY/QslfqdH8fgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NkvlZ4w9Qs/YlaotQaMOoWnxzeoVuX2QRg7kBJD16ppFseUZzmRzmS0mBmZZNLVND
	 IRd7iUqOluzTHKuMVpOCl5pW0z+vindc8ypoUWFUQlO495bB1kUK5xJFNkyJPdhPq/
	 /J/2MC52FnlNKCWj5TtWFImSVE9J/gnXa5NPigcXwKZTNwPub8mDxgmRvR2YzLcyWZ
	 YPJqL34NShBfOAJ4Ugy0YJY+rqrWl+G6jWdsULhfVXh9iIF3lJVc3AmxDTAUaDJrJJ
	 L2TbJwyCOtWEK9vo+i/kmHVn1gPxklzLck6EpcUOHvxkt8WVi17aR50PaoiKHrmLW4
	 vNRWpnwbyG5pQ==
Date: Tue, 20 Oct 2026 11:08:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xincheng Ji <jixincheng@ultrarisc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Jia Wang <wangjia@ultrarisc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
Message-ID: <atcvfrhVGNIbN6d2@ryzen>
References: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
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
In-Reply-To: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>

On Tue, Oct 20, 2026 at 10:37:35AM +0800, Xincheng Ji wrote:
> No outbound iATU translation is required when the parent-bus address
> matches the PCI address. This is a DesignWare controller property, not
> an UltraRISC-specific behavior.
> 
> Compare the addresses directly and skip MEM outbound iATU setup when
> they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
> CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
> use outbound iATU windows.
> 
> Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU setup")
> Fixes: 8da2b970ed4c ("PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000")
> Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>

Looks good to me:

Reviewed-by: Niklas Cassel <cassel@kernel.org>
