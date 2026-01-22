Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF53D1CC6
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122084; cv=none; b=a+qaV37fIE+HQTkYBl/3jIc/PuJV+jm1gNi/sabhyMCKwIAU0vKm3CF3XA988sY2vJxpqEScNv2gEnre4Iy5l1+TkUJJKRNFHOLTq/BIvhydLqzlglqg8m85mhjeUlw858HdzK64/g6zqITfn0ZfoX0QpXTowU4fDape7Bk/9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122084; c=relaxed/simple;
	bh=jU5e7noqWx9PVWPQw3XtjrMhGiQdZsNYbStInrjuEmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP8ouN+F0+bxOOCLo0K7Pcn+kFfzwzlc8fIHj4/LSi7JmdV2Ug04VDfwTZV+i+p8QaYA5pKbZTPNKrv/i4qmqwRauMdK4fiohaaZoaqzcSh0nHsOwnmLcAWA+MI1YNw6ViMVOrgPqdQBlTo9k2BpPctbmSPvAR3rzvERLOUSu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkfxs771; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkfxs771"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21346C116C6;
	Thu, 22 Jan 2026 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769122083;
	bh=jU5e7noqWx9PVWPQw3XtjrMhGiQdZsNYbStInrjuEmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mkfxs771pvjikJDx7dvdE9gja2jBxyZBFLZ2qsJVbfv4spd8LMZg1+Hn6DzV7qgUD
	 qemuan/nEzGSL/+LZN5VFcgiorXOcqM6SdScAhRz86pACQxoRNAGRkk5o9UNJJP6p6
	 R8Lu6aVk7GXwe64AKhReiY68B1klclKGJmkn++vvSPqFSSdwGnxx7Ac/NDkKchpsr4
	 p0GRTvQxqvQW9We5zlGiIxeFCTR4vZDsHSLtdlzWkrYk3JX8G8ZtaeO3op8P5K5Zyx
	 iDQe6B1WgTXb2fuE8rsfsF1IYG+mXwPukNA2RHLFtyI6QUuIZDfdbIcCZXe+Oz0j3g
	 gQtxxZwOvLOog==
Date: Thu, 22 Jan 2026 23:47:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Frank Li <Frank.Li@nxp.com>, Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: dwc: Clean up iatu index usage in
 dw_pcie_iatu_setup()
Message-ID: <aXKpHS20vHDyh4fL@ryzen>
References: <20260122222914.523238-6-cassel@kernel.org>
 <20260122222914.523238-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122222914.523238-9-cassel@kernel.org>

On Thu, Jan 22, 2026 at 11:29:17PM +0100, Niklas Cassel wrote:

(snip)

>  	if (pp->use_atu_msg) {
> -		if (pci->num_ob_windows > ++i) {
> -			pp->msg_atu_index = i;
> +		if (ob_iatu_index_to_use < pci->num_ob_windows) {
> +			pp->msg_atu_index = ob_iatu_index_to_use;
> +			ob_iatu_index_to_use++;
>  		} else {
>  			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
>  			return -ENOMEM;
>  		}
>  	}


To be even more consistent with the while loops,
this part should probably instead be written as:

 	if (pp->use_atu_msg) {
-		if (ob_iatu_index_to_use < pci->num_ob_windows) {
-			pp->msg_atu_index = ob_iatu_index_to_use;
-			ob_iatu_index_to_use++;
-		} else {
+		if (!(ob_iatu_index_to_use < pci->num_ob_windows)) {
 			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
 			return -ENOMEM;
 		}
+		pp->msg_atu_index = ob_iatu_index_to_use;
+		ob_iatu_index_to_use++;
 	}


Kind regards,
Niklas
