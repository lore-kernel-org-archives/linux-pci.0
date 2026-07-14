Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC4448CF7;
	Tue, 14 Jul 2026 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032590; cv=none; b=nb+ESBqYiG/pBblSx/Lq1SoBsEm7j/RpcnyDqEin/4JZlGXL6rtjSyi0jvcqk24sEpbrDkchaGo9STiTy7Vzxz8PHWkW7LMvaLreYnqKnSvusDD9kOhH78nt8iiedNYDlEAtqSNiCvn5vkZYxuf8nJJ1wMukwh5cLya1J+8/DYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032590; c=relaxed/simple;
	bh=BkLijEV27x3cqmPtkeIbS8HAe4OmMjmXmE23E8oTnkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JJ/z32chT1UR/VaFP6zEwiWpElZRK0TUBPPboWsQXDes0F3pM+pg+T9zNcCkhKglyVVx5OrbkQsC9iPOffUKj1wU5Nt5+6aOX5nVbrc4RLE/UsHJcIQhBAFdEdfO2Wx5R1YfHekW5MAx7cFQhVYJNJ0b+EQQKdy7pDfqKaPc1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Ka+0m5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Ka+0m5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909D1F00A3D;
	Tue, 14 Jul 2026 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032585;
	bh=M5kNHTeVQeP6GA90VID8S6a+DIOg6r1Qlofc1FKuYhY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=b1Ka+0m5IhiNMZQrGOdYPQHY7nnbXwbJ0JQdG7Pe9UJsXA/9unW1haAOfURKukdYB
	 2PMXMxCo2FV/rdg8wjYEvcuQePofbEqZmJ0UXsdNi93xRqua8mDhsOVkUUorZz46Xh
	 mX31ACfz4CwYHQs60UQltFIZebLZ8mWoQiw03tV34OEX3n45Z78UXqD9zP8/eaG9oW
	 Rtg1g9Wrp35vS+jmARlVwXRwPnOsQR/HSWZA7sd/O+RG4j335Eqsm7qEixAqJESrgt
	 MlQi0LNpWCjOXk3yCvQTbi2/uGNbR9E1yxCS8mUCNi3MIR+B7LpJmEu1lRjdpulPge
	 JmBBgyXfcsYtw==
From: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>, Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
Subject: Re: [PATCH v7 00/10] dmaengine: dw-edma: flatten desc structions
 and simplify code
Message-Id: <178403257915.822807.4369626855004661951.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 18:06:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Mon, 13 Jul 2026 13:03:18 -0400, Frank.Li@oss.nxp.com wrote:
> Basic change
> 
> struct dw_edma_desc *desc
>        └─ chunk list
>             └─ burst list
> 
> To
> 
> [...]

Applied, thanks!

[01/10] dmaengine: dw-edma: Move control field update of DMA link to the last step
        commit: 99c46385edb155cfd2919b4a44d97f9ea811639e
[02/10] dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
        commit: 07680003068a8008b4585423d533ab9e86a8a4d3
[03/10] dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
        commit: 956028c5dde9fd1a8a462db53609c1c547cafb5c
[04/10] dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
        commit: be35502a14726e916ac41545840c5d682c5d54e6
[05/10] dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
        commit: df9c5515501c8860a228ade47b93aff5b66544ee
[06/10] dmaengine: dw-edma: Add callbacks to fill link list entries
        commit: 2cc7ba6b168f2d0bd79f47ccc14168352a3c6cd2
[07/10] dmaengine: dw-edma: Add non_ll_start() callback
        commit: de60121a08799c4db503d44a9028856976f1cfff
[08/10] dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
        commit: 0d7a2719d85f9940b05eeed18e5f398b0b3219b1
[09/10] dmaengine: dw-edma: Use burst array instead of linked list
        commit: 3f3fa81cd2ace2c95a0368f2c6e6d1a1d983281a
[10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
        commit: bed94a469f2ce783f17ac0699f26277bc3c74118

Best regards,
-- 
~Vinod


