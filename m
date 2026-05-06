Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980247ECF0;
	Wed,  6 May 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083466; cv=none; b=mOs9/Sy3etLZp2JfIdP5a3XeJuL+zAHptzAY8x1+ng4oAD16MbvWiMeyCGNJDhYA4oUOhEXPHMhptWuPKAJS5C6LWHKAPxUTjAB6d0QnYmt2mQwE8gnx3q/hVh4gYrwQZxvIddtH7xc8scghB18Y9sWEZH2qp5WBchmDGwgCHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083466; c=relaxed/simple;
	bh=6FVEWNBCSGLEKdFaLuHudNfHQjAUWParHoWV/FsZ0nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mhym18WEwBR7D2daVZuCdCRjEYcRzX9BPMKG/1YRM2EBDFto7GJ7tJk7SpgIp2x22emyq4cW7cR93X9lRgNMPx+jISCJtKhMrpPEP6PkTwFA31EAV+QsDdUX+dkJ6Kh9cZiAoHxvGUWxkyMNcDKTAHo4CsgIAHvZWcTtjgOK8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6VD1Djs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6VD1Djs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C581C2BCB0;
	Wed,  6 May 2026 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778083464;
	bh=6FVEWNBCSGLEKdFaLuHudNfHQjAUWParHoWV/FsZ0nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6VD1Djs+ELVFmhOF0ioeTY8/DahRm6ZRoCGweQFimAHuF1bmhpEmvZmi9o5DG9yq
	 /87bwBvuuWRV7apF9HB8NGiBO8F4mLdb/S4YvfuNkV/EgSHNP/Q8OwjI4O26oW3J+S
	 EHhKrXX+/LY+AWNsYkwiQw0nXPhaumq0wuvQP5YWPY5zXv1IXCYMUiACmT6fTVnqmA
	 r0IEm0u/ml9HwI/WCvnxOwHikxK7IAaBD2K13w2ZGb1yVxo7oxdHarISmdXH12YY9H
	 WmBtCQE92qijSN64OJDYRBnAP/nwgfNLQeeUu6kTKdiOZVAib+Zopr1CC9fXsS3wk4
	 RIkU+e3baqU8Q==
Date: Wed, 6 May 2026 21:34:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	vigneshr@ti.com, jingoohan1@gmail.com, thomas.petazzoni@bootlin.com, 
	pali@kernel.org, ryder.lee@mediatek.com, jianjun.wang@mediatek.com, 
	claudiu.beznea.uj@bp.renesas.com, mpillai@cadence.com, robh@kernel.org, s-vadapalli@ti.com, 
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] PCI: j721e: Set max_link_speed to enable 100 ms
 delay after link up
Message-ID: <rlsvpbo4gcix3mmbfsxvmfebnnn4bqm3cv34x4qkxuv3zwydnm@ehi3el63z664>
References: <20260506152346.166056-1-18255117159@163.com>
 <20260506152346.166056-5-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506152346.166056-5-18255117159@163.com>

On Wed, May 06, 2026 at 11:23:42PM +0800, Hans Zhang wrote:
> Set cdns_pcie.max_link_speed to the maximum supported link speed
> (obtained from the device tree property "max-link-speed") in
> j721e_pcie_set_link_speed(). This activates the post-link delay logic
> added in cdns_pcie_host_start_link() when the controller supports
> speeds greater than 5 GT/s.
> 
> As required by PCIe r6.0 sec 6.6.1, and following the same approach as
> commit 80dc18a0cba8d ("PCI: dwc: Ensure that dw_pcie_wait_for_link()
> waits 100 ms after link up"), this ensures a 100 ms delay after link
> training completes before any Configuration Request is sent.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index bfdfe98d5aba..ee85b8e04f5b 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -206,6 +206,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
>  	    (pcie_get_link_speed(link_speed) == PCI_SPEED_UNKNOWN))
>  		link_speed = 2;
>  
> +	pcie->cdns_pcie.max_link_speed = link_speed;

What about other glue drivers?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
