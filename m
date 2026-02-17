Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE918DF9D;
	Tue, 17 Feb 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323315; cv=none; b=o+GYNNvUYzRJTfkmK6+9c7YnJSLbXjr0DyzZWdXreoP1kzrwStpuB+IzWJUhQzy9Yl4CDAcIzJlzTBYIUkZ57pfASQVD7Dekf9Qm4hM6/nfDccfoSdMNgf8I1WzsA8aDLgJ+zicVzIMKd9ocC3AYHgdIMNROnuNhIT8ZHfp1MZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323315; c=relaxed/simple;
	bh=OGD8WP2U6z3wfYpBqrc79dXSrFIB1z1mQYqmiQxCRSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh/PsvtGQTF9n9nz0tQF++it2cBKlsIefMt0rFdMGkPeKRldooD7JuQrJCpf/enWuUvDEuis9Z0ubhV0Gbo9CI9WqC7DjcuAt5X7sk1jSfwqEltKkq6WJE4GwbosZGhjpTspNMTUgclSfA1fft7HX6VpcjeoPxJKzZboiiuo96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUrmsjtg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUrmsjtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F29C4CEF7;
	Tue, 17 Feb 2026 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771323315;
	bh=OGD8WP2U6z3wfYpBqrc79dXSrFIB1z1mQYqmiQxCRSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUrmsjtg2NzB9GBijzWHyd5UlPbNQXVOSfa+2N4CkDQU7U3WdT/IBcnIWdw6I/b6H
	 a6M/ZpSSMAPNAoky6xNnpqZI4vIBYOkXUYalVkrwPmKVWgqPNYLwDQUDothtEJ1ttD
	 N5KYng6ICleloi6Ab8+IsMRyD86RQo9s/waKhFrL4TqhkP2kkMreFGzGq26I9bmI01
	 JKzyJUU9m//hKptt+Xr/lWAHuNbhKdYEXqRBicWGyM57oJfUFeOQBf68lDsUp+jCag
	 oXCD1H0cg9oFQ+778sztMPTxZrU1U3OSSaCSsVllU9BE2ViXUDfq/GKLR2JNodiN0n
	 xdpE7pOmhJJSg==
Date: Tue, 17 Feb 2026 11:15:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, shawn.lin@rock-chips.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 8/9] PCI: endpoint: pci-epf-test: Reuse pre-exposed
 doorbell targets
Message-ID: <aZQ_rEkzWnDeJrMe@ryzen>
References: <20260217080601.3808847-1-den@valinux.co.jp>
 <20260217080601.3808847-9-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217080601.3808847-9-den@valinux.co.jp>

Hello Koichiro,

On Tue, Feb 17, 2026 at 05:06:00PM +0900, Koichiro Den wrote:
> pci-epf-test advertises the doorbell target to the RC as a BAR number
> and an offset, and the RC rings the doorbell with a single DWORD MMIO
> write.
> 
> Some doorbell backends may report that the doorbell target is already
> exposed via a platform-owned fixed BAR (db_msg[0].bar/offset). In that
> case, reuse the pre-exposed window and do not reprogram the BAR with
> pci_epc_set_bar().
> 
> Also honor db_msg[0].irq_flags when requesting the doorbell IRQ, and
> only restore the original BAR mapping on disable if pci-epf-test
> programmed it.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

(snip)

> @@ -753,22 +771,33 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
>  
> -	msg = &epf->db_msg[0].msg;
> -	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
> -					 &epf_test->db_bar.phys_addr, &offset);
> +	if (db->bar == NO_BAR) {
> +		ret = pci_epf_align_inbound_addr(epf, bar,
> +						 ((u64)msg->address_hi << 32) |
> +						 msg->address_lo,
> +						 &epf_test->db_bar.phys_addr,
> +						 &offset);
>  
> -	if (ret)
> -		goto err_free_irq;
> +		if (ret)
> +			goto err_free_irq;
> +	}

I tried this series on Rock5b (RK3588), and was surprised to see the doorbell
test case still failing.


> +
> +	if (size_add(offset, sizeof(u32)) > epf->bar[bar].size)
> +		goto err_doorbell_cleanup;

It turns out that this check is the reason for it still failing.

You see, for a BAR that is marked as BAR_RESERVED, pci-epf-test will not
allocate backing memory, so epf->bar[bar].size will be 0.

If I removed this check, I could get the test case to pass.

As I suggested in my previous email, perhaps this check is better suited
in pci_epf_alloc_doorbell(). (As a DWORD alignment check inside
pci_epf_alloc_doorbell(). pci_epf_alloc_doorbell() could itself return
error if the doorbell is not DWORD aligned.)

That way, you could remove this check from pci_epf_test_enable_doorbell(),
and we don't need to care about epf->bar[bar].size.


Kind regards,
Niklas
