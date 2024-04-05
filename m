Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989B16D4E1;
	Fri,  5 Apr 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324253; cv=none; b=a1GXY1BL3vv2HMW1PYASnWIlhpLvkv9B7ibAScSgDcZrXqbCZjb8SW7KoHGsMCOQTo4M0VGi7g4HDbJ0p//CgILHHtyDTVn9FMoYxviHLSA1c/ncBOymd+5ZXkOloM3I8tgp2zzLIMqg8sY3PdS9S3O2KQHJ479ZY6eHIZ4x65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324253; c=relaxed/simple;
	bh=erIF6D/fny9USFYzetNP8CRUx1a3CYG4GswwTMXaNzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boXpKPjmN4z+ONZoKVkUVnFh9CPZny3UTtpu3Tu12mFq5aVnc1ipEA0YW3hBZ5Hc9IWV+v7ZlmSpsDlI7+zqGbPCzsTHhxQ6lGnHzxQuimYorj14nOg0UgIbfAQXU+0dYQUHOPVfd4rFCkggccmaPU9dDdAZxXu/IAz+NzAIrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQeYOymd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQeYOymd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60F9C433C7;
	Fri,  5 Apr 2024 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324252;
	bh=erIF6D/fny9USFYzetNP8CRUx1a3CYG4GswwTMXaNzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQeYOymdsnpY58edFysi1vjMiF1pRycTgJis+C1wA8+SVz5UaC4pI957KysCP2VxY
	 zYbG3fwAzD1Yp2T5u02x23j1DziTJLabPBr85uHrhH6UMns1ZSN4zBQf7TphsGFx/q
	 gtgPvMAk/ZF0wfVeA8KC5fSAq/cSktlev9dqbTSkXjJcB1EVXXBcjbKJYYs6M1a9Mr
	 RgNNc6F5riYv2z7DJPN3LRzWiEL7QpAWYXvqnhWYpga7XpTX31xe0ItnMyDib1tOYe
	 8oUfdosAy3Dlbqy0YdkLE5W6BB5l5sUf16jrL+VAPSc1Au37+BnnpXGMunJzPsTE97
	 TsQuU2HnDDpIg==
Date: Fri, 5 Apr 2024 15:37:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 04/18] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
Message-ID: <Zg/+k1IMGNjTRRhn@x1-carbon>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330041928.1555578-5-dlemoal@kernel.org>

On Sat, Mar 30, 2024 at 01:19:14PM +0900, Damien Le Moal wrote:
> Modify the endpoint test driver to use the functions pci_epc_mem_map()
> and pci_epc_mem_unmap() for the read, write and copy tests. For each
> test case, the transfer (dma or mmio) are executed in a loop to ensure
> that potentially partial mappings returned by pci_epc_mem_map() are
> correctly handled.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

You probably want to rebase this series on top of:
[1] https://lore.kernel.org/linux-pci/20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org/
[2] https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/

As these both modify pci-epf-test.c.

AFAICT both these series [1] (DBI rework v12, not v10) and [2] are fully
reviewed and seem to be ready to go.

They just seem to take a really long time to be picked up.


Kind regards,
Niklas
