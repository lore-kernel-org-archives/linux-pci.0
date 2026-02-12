Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BF330B30
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931427; cv=none; b=Ea1PtU3l9e0h7AkYiaFBrCETN740veAo55ofc9a5y3HEKEu8JgPD3ffPCCbpYhn9hZcLRIiw9NS32kriGlOoqm0Kpo8IhKMHNxZfKt6zJWFnXU4scj+RzyDIwVKjbRn1UwXQc4rbRcBK7+w1kGWXrGD8/aW100gApU2onzNd/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931427; c=relaxed/simple;
	bh=Ts8Alz7BVoEODslTsLpnuIm6brE8Mh+h0usSK9gxUm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8eb03SLcuWEA5gtyQkpy1xcYQ/3XbKy6d5NcSOoIViESEwU+meRDDQnRmRk1P2aCMekdGxxa3cQmZrSslOtuM4HfqmNFny8JEnb2gVk7nf28SxWRNbetr5h9A71p33Xn+VviHzluCWYXfAhsnk6nPWsZg5hvBPXd7Mk5zTLpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzRS6y90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzRS6y90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7A7C16AAE;
	Thu, 12 Feb 2026 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770931426;
	bh=Ts8Alz7BVoEODslTsLpnuIm6brE8Mh+h0usSK9gxUm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzRS6y90C1/wmAAFD1JlWxI5zVZFHQMl1FD9nPnShYkVHrw2pCffGfiU9ID95MLlz
	 4NADDzFDEaFe28wYXuhPB6Z0yoVZaDDjK2xI8GG5eCPdGkih9TV8Qi2poXL8YxUBXr
	 8auNbuKEYwSmrM0Dmv9rT/aWNnfpHx3XYN/Ant/WrXyIHhWVqcXOgw1yjIjHT4fKZE
	 juMevj8RfG9HT6zcq2Rqkdm+O325bXK5Qj2kLonmXczwVAke6IEPZ6n0spS85GDoBw
	 jUjbLJLXB+zfHGicBfRXMzwHYEJ37n8A9t8HSTM5tZ7FbVIejkHXblDenr6WKp/d76
	 CDzCWmYeAjuCw==
Date: Thu, 12 Feb 2026 14:23:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Danielle Costantino <dcostantino@meta.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Message-ID: <aY5E4OWE_v0Jdyd1@kbusch-mbp>
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>

On Thu, Feb 12, 2026 at 11:50:54AM -0800, Kuppuswamy Sathyanarayanan wrote:
> In case of EDR, firmware owns the interrupt handling. It just uses ACPI
> method to request OS help with recovery. Since interrupt handling is
> owned by firmware, I think firmware should clear the interrupt status.

But the PCI Firmware Specication says the OS owns the status register
while it is handling EDR notification

"
   the operating system is permitted to write the following:

     * Device Status Register
     * Uncorrectable Error Status Register
     * Correctable Error Status Register
     * Root Error Status Register
     * RP PIO Status Register

   in the Port that triggered DPC while processing an Error Disconnect Recover
   notification from firmware
"
