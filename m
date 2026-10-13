Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323054398F1;
	Tue, 13 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911931; cv=none; b=uTPkKuKk8eAwJzMIulICBvENohjrQI0RfL9IZg2xDN9ngZANQrSoHsea+GE8RrCqY5Oy9RD9rx3d8bikxKEUCAqry24O0YGKf7EAhYzP1bQKj3adM9JkUhKFXbWxrbTlFPozeGS+iaBGDOQAqDPTkjL1mntOaioF/NdTykwFYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911931; c=relaxed/simple;
	bh=8PqwQUWFfVghebMz9z1kAMapTMuwsHDaGj4XEMNSP/g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GjwqxHHsmsc2B/vka1IYJV4edO0D+3sslbyf+AOASwF+yZ94lHgP6xmN1owlFLQYbINrWiGcTJAEd5XoeZKRk/9ngtV/4VbTUtcj161i56G4fZOEYsOoc6QHb3n1yklZioIpkUzEQUPZlZE5D2bSgnoqtDpLQsNNQkcPZItM5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AG1e9nLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AG1e9nLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5171F000FF;
	Tue, 13 Oct 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911930;
	bh=DaV//0Jk7M97S39ZwsdcpB+1W9eqYBvkzOhD9k9vV/Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=AG1e9nLS8EsscB3nsQDaKaav0BROgOxE4YMbZIEyin08r6IfwPk6dWyZ/uhBrq7YN
	 T6kpponQVJYJO6i4I3RPki1uJoLIHSjxliRKuskb5ELUNP2RA+/TAZ1hEqmUHkSaVL
	 69WCaYKkE3kQt/8Z+9VOWwo5jPT+/sSdDvsBopCC/dxLm6ubz0ZwCvZlrDfqEM65tD
	 rjNhyaB5K2WUIZP+tqvUL+LkQs+M3BWe+rZFY7cfzoiRNInpvIEHz3ogPRAgIPkaCA
	 dwaPWpHd/du9EVs2J/4wtCzlLu+/oiNuibtVoJCnZtPHHs5j0xSZgDr8fWcjaP/mwk
	 U6Alldl4Q8fjQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound
 IATU CTRL2 register
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aqbahGslz11TWIRo@fedora>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
 <aqAk6nXECt239c2g@ryzen>
 <4nxyshx26bl5r7jjjnghsyz7k63lah6zx77cuea37mziww7kb4@iij5g3om67ub>
 <aqbahGslz11TWIRo@fedora>
Date: Tue, 13 Oct 2026 22:48:37 +0530
Message-Id: <179191191767.12828.2752703637384946037.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=mani@kernel.org;
 h=from:subject:message-id; bh=8PqwQUWFfVghebMz9z1kAMapTMuwsHDaGj4XEMNSP/g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzmfwFAMrCKxMOcbMcmBoP8ps9UP1Dl0MH8zRD
 pGaqapdwcyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas5n8AAKCRBVnxHm/pHO
 9TjrCACSD2GVH5IhWwVcX2Aah6BHGKLKFKchRjtkdA0G4pH30dmKrOUrjAnr/V6phBL4BxTLRfo
 QFycM0pq8LznSstG41qv3P/mPhggml9dw3PFaoX/E8ezgfxZ+/Qn2TW8YmkuAgjvzlm5oMh17wa
 UzHSM2zlQdtmPW6JjxNIUPeTj3pNqDliB3OBSIc9ys1mQWnb2z/Y1OB7mQ5lFIPTo1pPZT4aMup
 IVPmPkAHE8qtemOK1U4epJVnaXANXBPwQl+cqMZk2hE1tmlbD7lCcyNFTewTgc3so2KLKfh5Bw+
 n3xtQDM8BjAGTcDddmfLKhZieRgDWa344fFA73cDocmOZEqB
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-13 19:16 +0200, Niklas Cassel wrote:
> On Sun, Sep 13, 2026 at 11:35:59AM +0200, Manivannan Sadhasivam wrote:
> > 
> > pci_epc_mem_map() is already useless in the eDMA path today. So this patch
> > doesn't change that.
> 
> I'm not sure if useless is the proper word here.
> Redundant is perhaps a better word.
> 

No, it is useless indeed. See below.

> 
> Let me explain using pci-epf-test.c:pci_epf_test_read() as an example:
> 
> Without the patch in $subject, on a DWC based platform:
> 
> pci_epc_mem_map() will setup an iATU entry, and the eDMA transaction will then
> be translated using that iATU entry, before being sent out on the PCIe bus.
> 

No, that's not true. While the pci_epc_mem_map() does setup an iATU entry, eDMA
transaction doesn't use the mapped address.

If you look into the eDMA read path:
	pci_epc_mem_map()
		-> Allocates map.phys_addr and sets up an iATU entry
	pci_epf_test_data_transfer()
		-> dma_local points to address allocated by dma_map_single()
		   (dma_dst)
		-> dma_remote points to RC address referenced in src_addr
		-> These two were passed to dmaengine_prep_config_single()
		   ignoring the map.phys_addr passed through dma_src parameter.

For eDMA write:
	pci_epc_mem_map()
		-> Allocates map.phys_addr and sets up an iATU entry
	pci_epf_test_data_transfer()
		-> dma_local points to address allocated by dma_map_single()
		   (dma_src)
		-> dma_remote points to RC address referenced in dst_addr
		-> These two were passed to dmaengine_prep_config_single()
		   ignoring the map.phys_addr passed through dma_dst parameter.

So essentially, the address used by the eDMA is the raw RC PCIe address, not
translated by the iATU. In fact, the Designware Databook also doesn't recommend
setting up the iATU entry for the eDMA path. So the allocated iATU entry is
useless.

But the issue this patch is trying to address is, if the raw PCI address or the
dma_map_single address used by the eDMA happens to be present in one of the
existing iATU mappings, then at that point, the address can get translated
causing wrong address to be sent over the bus.

> So the iATU entry is actually being used.
> 
> 
> After the patch in $subject, on a DWC based platform:
> 
> pci_epc_mem_map() will setup an iATU entry, however, because of the DMA_BYPASS
> bit, that iATU entry will not be used, and the transaction will be send out on
> the PCIe bus untranslated.
> 

This is the current behaviour as well.

> 
> So I would argue that it is only after this patch that pci_epc_mem_map() will
> setup an iATU entry that will then never be used.
> 
> Yes, I think I understand that you are trying to say that, for DWC based
> drivers, we could theoretically skip the pci_epc_mem_map() call, and send the
> transaction untranslated.
> 
> My point is that it feels silly to set the DMA_BYPASS bit without also making
> sure that the pci_epc_mem_map() calls are either removed or (at least for DWC
> based platforms) modified to not set up an iATU entry in the DMA path in the
> first place.
> 

This I agree. But this also needs some careful analysis as other DMA controllers
other than eDMA might need the mapping. For eDMA, it is also not straightforward
as we do not pass any 'I'm using DMA' flag to map_addr() callback.

> I am happy that this is getting cleaned up, I just don't like a half cleanup
> where we, after this commit, will setup+teardown iATU entries that will then
> never be used for the actual transaction.
> 

This should be done as a follow-up, not blocking this patch.

- Mani

