Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5DE41C2E4;
	Fri, 27 Feb 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204788; cv=none; b=QKrNo2jL5pqyVEK/p2xOJxmPVJX1ICfHAnP0meumpxcPkCo2xAs/r3+82huOAmtdZSVgF8Ti0XWDkYb2/i+5HZMbudKb12nHmS3cP4GyhyfxjSCSt3fnVY3Ow4oXVxKvFc9sFXwvngxq1cz9LhjaZKS6cRvAWoRG0G4SHUA/xIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204788; c=relaxed/simple;
	bh=aNAnNa3SKgbiJYH2fguLKoHPnuJ+A4SqSTlZsNZrSlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcO+b/vZxLCwbbpthBspO1DEYpDD2bAoHI4SJDUj6SWtUjALrbTeWVVGD8vU85zvTvxMbzabGW6tNf0VtUfYeTq/ZX5JLBgEvby6wTCnfkd74HiYsLU18mMsPSc5shqbqeSCiOAQm+6aJj8/ljNA0Dzy722wtMWKhwEXdpw7FwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGdQhWRK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGdQhWRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B29EC116C6;
	Fri, 27 Feb 2026 15:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772204787;
	bh=aNAnNa3SKgbiJYH2fguLKoHPnuJ+A4SqSTlZsNZrSlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGdQhWRKnQzmvvo8rshWrzSkNLsAia6Uiv51/sHhh0r99KOHgr0oHoi/0IpveUFyN
	 7hzdXjSwaGitiKChulX+AqiXZ+Ytii6cUy9bVZYOeP3qQwtRQMc55ibsNij2I94jG1
	 GSBN48/uKsT42jRZmIupy1tx9JAS9Bz3qIW6dvexaRLC5qDAEYuZpGUOi/pWjqWjBG
	 IqLqhzn9EfgMJXievTans3e9Sat+a86NJQ9+9+7diFRNik499YxpcTvKQIgtovRTZH
	 GBxPtnwSoEDcoyYM3AcUhZbFY67Lng03jyjdwL+/VYggp6CCVynyLCUtsnYtjX3cAV
	 kry3gNRL3PeWA==
Date: Fri, 27 Feb 2026 16:06:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com, mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v9 0/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aaGy7aBtg_wcjedb@ryzen>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>

On Thu, Feb 19, 2026 at 05:13:11PM +0900, Koichiro Den wrote:

(snip)

> Tested on
> ---------
> 
> I re-tested the embedded (DMA) doorbell fallback path (via pci-epf-test)
> on R-Car Spider boards (with this v9 series):
> 
>   $ ./pci_endpoint_test -t DOORBELL_TEST
>   TAP version 13
>   1..1
>   # Starting 1 tests from 1 test cases.
>   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
>   #            OK  pcie_ep_doorbell.DOORBELL_TEST
>   ok 1 pcie_ep_doorbell.DOORBELL_TEST
>   # PASSED: 1 / 1 tests passed.
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 

For the series:
Tested-by: Niklas Cassel <cassel@kernel.org>
