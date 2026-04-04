Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0B1C84DE;
	Sat,  4 Apr 2026 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775272566; cv=none; b=g/lT/bfDlHR4Cc/RdhLzWCrFL11JPnsZXz9Bna27A5ABsb2OKjGPFyg/09C6f0/HKtOg14ua5wgJKJQpaUeU+B/QAYXgsAVcyX9oWv79+6NCKrU+StO4qxcs0kgDgH0/8NtZSs/HzcTLY7lc7NpevDvYpie81bMy+2rzH5U7c0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775272566; c=relaxed/simple;
	bh=OiA/EBiA4K4f20ZyYpTH5r9/Q39LqAb3VffWQuH4Eso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNfCf+1SlwIiK9V7iLRTMD3su1/BSL/nI3gWuLBVvd8rJ4Bqrjbl9x7DAqZXUi/zSbJfnHKPu1u9DwutQ/fT18G8sIoBP/e63+3QyZOaE5WcqVe7n0VPEh4x/KBCUW3t1NvGd6CK9HzwjbdT5fkMArT6vYmwNMPBflWymT1eeug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2odijld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2odijld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78915C4CEF7;
	Sat,  4 Apr 2026 03:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775272565;
	bh=OiA/EBiA4K4f20ZyYpTH5r9/Q39LqAb3VffWQuH4Eso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2odijldKRSXMKo82KQ4jvLQMRFRbMeTHsNQpO+DxWFaDFNEle/K/QX8raBqNLTr1
	 OEGAskf7B3vQDbGLz4jTTidoIeyF9QjeurdVpTOFnuFuxdLPInK21Ng9V3pmPb7fIa
	 GqPuj+CXYy30WLrhuv+bqySLqmsxPCZegYbdOIDgEi4bHG2TKQjYMSckqj13gG62C9
	 sWpZ4qEsOT4ObMuHhfhTb1Qv5g0C1E6X3W2lKYObOnXfZvXA6dwcwY1+hivt6maoc8
	 AthMfNPCWIAwMDExdkaXpIpSKgNR2WUY8hdGEYanaRqQxjHl0zuewFIR1QJXvgyLVc
	 tkeaTLgeFkghA==
Date: Sat, 4 Apr 2026 08:45:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michal.simek@amd.com, bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add amd,versal2-cpm6-host compatible
Message-ID: <iruxyxjoaozkt5xigchqnqvik5blbxxy7vubmadtcn5jyjnwzn@lvdnttblbx3f>
References: <20260402180006.486229-1-sai.krishna.musham@amd.com>
 <20260402180006.486229-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402180006.486229-3-sai.krishna.musham@amd.com>

On Thu, Apr 02, 2026 at 11:30:06PM +0530, Sai Krishna Musham wrote:
> Add "amd,versal2-cpm6-host" to the OF match table of the AMD MDB PCIe
> host controller driver.
> 
> The Versal2 CPM6 host controller is DesignWare-based and supports
> PCIe Gen6 operation at up to 64 GT/s per lane. It is currently
> handled by the same driver and match data (NULL) as the existing
> MDB host controller, but CPM6 uses a newer IP revision and differs
> in legacy INTx register offsets.
> 
> Use a separate compatible to allow CPM6-specific handling once legacy
> interrupt support is validated.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 3c6e837465bb..325bf7aad657 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -511,6 +511,9 @@ static const struct of_device_id amd_mdb_pcie_of_match[] = {
>  	{
>  		.compatible = "amd,versal2-mdb-host",
>  	},
> +	{
> +		.compatible = "amd,versal2-cpm6-host",

As Krzysztof commented, if the PCIe IP is compatible with an older version,
'amd,versal2-mdb-host' in this case, you don't need to add the new compatible
to the driver. Just document the new one with fallback to the old compatible in
the binding and let the driver work with the old compatible.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
