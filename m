Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BA52E07B;
	Tue, 13 Oct 2026 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918061; cv=none; b=Lt4nHmm8HkXkWX0MWUbthYsGxHLFeN1xf1vvgHJwyEGsXV2qVsu5G+KRs3Bw6d2fL4UqDH44oia1B7MSbaHEuCQX5sheWSYU8V78prLTmz+ohF44tybpbm8MWJLs2B1RN5wFVHSjdM1hDmzkcozqSS0rCo7Y4VJbxDLxYzyuLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918061; c=relaxed/simple;
	bh=Y/6mPPWKq7E18fzRTOG/n3QlkZ6WM9IzISukY3UCJbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKL+sbU+i8o67/FeadSJyaNpzXXjd27ADDqv0oCOY8qolwDKS6hZhZ95wLwbVeL62qns8jbwQX1yVojuiSnqipEagHZ2qvhOLki94kZSYql1oModMf2Q05YSkjVi4DigbPLzjeQCgTatOzYWSWEI/qTDBjmzTVij5OhbMKkEIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzhQ+C0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzhQ+C0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C1F1F000FF;
	Tue, 13 Oct 2026 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918052;
	bh=/dk2eoKePmFRqFrfQ1T5+wH+aOEM18zHWbV9dOaYIig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fzhQ+C0MUDOeUxrMwtbnjOwDW8TSV+r54qirvQfAlGIbF42zAu25pTZ5G9eqjwN/3
	 z982B3lt/rb/sJT6+LPPPhAq3wNEWAXcRQHRZwrEAT0GETF2Ns+dkmzWA1oVW0ph0G
	 oKfeYPWMj9QJt6lCoKsvvfGyXan7D9fYO+gM5VAwRINl+xXGTRvT4FEz7RyHz0nT5z
	 /J1XHie4yd4op+fEh4wkQzd8OFPZaAb5AFkajyj3MstPjiTUqVOrx8d2lJsyz7D7OP
	 +49m7Yr/AOsLnFErny5qD7vkqrIoccphWnsyTkdhHML12A3L98IEcRKoiICvYdgtxJ
	 kA3XwweUsLFVw==
Date: Tue, 13 Oct 2026 21:00:46 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <as5_1qSjdTfwcTD6@ryzen>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
 <aqAk6nXECt239c2g@ryzen>
 <4nxyshx26bl5r7jjjnghsyz7k63lah6zx77cuea37mziww7kb4@iij5g3om67ub>
 <aqbahGslz11TWIRo@fedora>
 <179191191767.12828.2752703637384946037.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179191191767.12828.2752703637384946037.b4-reply@b4>

On Tue, Oct 13, 2026 at 10:48:37PM +0530, Manivannan Sadhasivam wrote:
> On 2026-09-13 19:16 +0200, Niklas Cassel wrote:
> > 
> > Without the patch in $subject, on a DWC based platform:
> > 
> > pci_epc_mem_map() will setup an iATU entry, and the eDMA transaction will then
> > be translated using that iATU entry, before being sent out on the PCIe bus.
> > 
> 
> No, that's not true. While the pci_epc_mem_map() does setup an iATU entry, eDMA
> transaction doesn't use the mapped address.
> 
> If you look into the eDMA read path:
> 	pci_epc_mem_map()
> 		-> Allocates map.phys_addr and sets up an iATU entry
> 	pci_epf_test_data_transfer()
> 		-> dma_local points to address allocated by dma_map_single()
> 		   (dma_dst)
> 		-> dma_remote points to RC address referenced in src_addr
> 		-> These two were passed to dmaengine_prep_config_single()
> 		   ignoring the map.phys_addr passed through dma_src parameter.
> 
> For eDMA write:
> 	pci_epc_mem_map()
> 		-> Allocates map.phys_addr and sets up an iATU entry
> 	pci_epf_test_data_transfer()
> 		-> dma_local points to address allocated by dma_map_single()
> 		   (dma_src)
> 		-> dma_remote points to RC address referenced in dst_addr
> 		-> These two were passed to dmaengine_prep_config_single()
> 		   ignoring the map.phys_addr passed through dma_dst parameter.
> 
> So essentially, the address used by the eDMA is the raw RC PCIe address, not
> translated by the iATU. In fact, the Designware Databook also doesn't recommend
> setting up the iATU entry for the eDMA path. So the allocated iATU entry is
> useless.

I see, you are correct.
The pci-epf-test.c driver is very misleading, because if does:

    ...
    pci_epc_mem_map();

    if (flags & FLAG_USE_DMA) {
        dma_map_single();
        pci_epf_test_data_transfer();
    } else {
        memcpy_fromio();
    }

    pci_epc_mem_unmap();


This suggests to the reader that the mapping is used in both cases...
Why else would the mapping be done unconditionally?

I strongly suggest that the pci_epc_mem_map() and pci_epc_mem_unmap()
calls are moved into the "else" clause then.

Since this patch is already touching behavior related to this, it would be
nice if the patch author could also write a patch that cleans up this mess.


> 
> But the issue this patch is trying to address is, if the raw PCI address or the
> dma_map_single address used by the eDMA happens to be present in one of the
> existing iATU mappings, then at that point, the address can get translated
> causing wrong address to be sent over the bus.

I do understand the problem that this patch is trying to solve.


> > I am happy that this is getting cleaned up, I just don't like a half cleanup
> > where we, after this commit, will setup+teardown iATU entries that will then
> > never be used for the actual transaction.
> > 
> 
> This should be done as a follow-up, not blocking this patch.

Fine with me.


Kind regards,
Niklas
