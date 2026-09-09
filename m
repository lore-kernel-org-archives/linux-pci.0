Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0D34F279;
	Wed,  9 Sep 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951411; cv=none; b=JiaZ36SxsZvSL6qze4DlDwyAPKXqOOs3UAri3t/xf0V/ksFxWcB4ujNGnlxne5h5GiO7txTt8ZsJZvwmu99s2V+xtIR74oHunU6Zjua2GDGF1ywSaDTEKKqI+YvPhAdZewyQRWZ/ls0+8JEJpFXQW5rUrnYFlveJ7NS32PUBYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951411; c=relaxed/simple;
	bh=nWpGW8t5rqjtui94NB9lkPTHAwmp4q2qrFmraBe5EVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQC+An0On8Ndv8DcDC3D2vlCXTo1pcWmnvlOn5AWfVxrDZyJtF5RJDE9lYXxp6g72RiHI24TRg2PMbayAPIBMfuurcm0zvKcQcct1Ufm5YeZx9nTFJR/8bzyH3g0BlXJjCKlPcpktwWlQVEnhxx6kyVANSGnzavUGCZpoR0QsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXOOb0EO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXOOb0EO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70561F00A3A;
	Wed,  9 Sep 2026 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951407;
	bh=Wq/9E5RYjTXQRo7/hmjNNNVXahpqUhOQr9k2MAKnD1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SXOOb0EOhl/10D4xMHU3t9wa67aECs78259Za3w78gmdN4T4IIfJ8X0QrxXl7tLoi
	 nSeNJ/o2C2wVdmQI4AhdYOsUx8RmlXcG8VV/WloXRymY9wQ2RgDqF0evDBpTghjMEO
	 j5cfb9mVf69sDGNXYv1TwdIZun/DINRWlRzmq+CRXf0tqbGAW3qzjqZuT6KDXewqSE
	 ir0mGH6336UEi+Tx27Ek68kgNsQOY0kQVd1rt9Kp757KZvQFoSG4nTwCCNUMoFko7J
	 HYwW9r9VXaojyLhI0Zw/cwYxO90cks7YGBntQl+5OHNTduuWobcUz8p7mPgpYB6Ao3
	 +GmUOD+0x8nFA==
Date: Wed, 9 Sep 2026 12:56:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com, 
	cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Support PCIe switch
 topologies
Message-ID: <nmptitirmhbsxqttf2b3w4tpetoteayfp33u5bvafzxqje74nd@tsxzryh7c7sc>
References: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>

On Mon, Sep 07, 2026 at 05:51:29PM +0530, Wei Deng wrote:
> The PCI parent OF node check in pwrseq_pcie_m2_notify() and
> pwrseq_pcie_m2_create_serdev() only looks at the immediate parent of the
> PCI endpoint device. This fails when a PCIe switch inserts one or more
> intermediate bridges between the root port and the endpoint.
> 
> For example, on lemans-evk with IFP Mezzanine board, the Toshiba TC9562
> PCIe switch creates two bridge devices (upstream and downstream ports)
> without OF nodes, so the WCN6855 BT device appears at depth 3 and its
> immediate parent has of_node=NULL.
> 
> Add a helper pwrseq_pcie_m2_pci_parent_matches() that walks the PCI
> parent chain upward until it finds a device whose OF node matches the
> expected connector port node, or reaches a non-PCI device. Replace both
> single-level checks with this helper to handle arbitrary PCIe switch
> depths.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

I'd have fancied a device_for_each* helper, but that's not a big deal and
probably an overkill for just one user.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
