Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491E2F746D;
	Sun, 13 Sep 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319820; cv=none; b=iV/H2h+/GpNljeaWeldq4K8lhx2FOmbD+fhMDCnKeKjWxSp3C8b8hcZEKIr55uRsE0UgkURMudwOYXwksOmemjb9mG3/zqlCFkvxfWoQR8N7H4Y8zIQ4GQhsm/VzA01t7OXWAnXkePlbFEVYB+2sPobk7itCf0ji20CTA7RPN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319820; c=relaxed/simple;
	bh=RlkRuX0iWTlT0/Hh++ZLAUZHy6/57lUQLkN/g+EuVmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n362AsQRkELVpVHvwEVSgd0Q8UxTXxNT8fM2XSX7/9Enx6gbwS5wGMygDSv98/X1yzHzXSuPknfW9AFvQcgZ+S7UgCQKEURYoqVQNMj8cotgTSs9Oh3lzJDgQNq+Qw+FwrbKVqLFMTWqJxsGY2uFdQIuXrrnFG4HNrbPOk/wO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtDgYcRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtDgYcRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDAB1F000FF;
	Sun, 13 Sep 2026 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319818;
	bh=uLU+TPgaFJtgy5u+UiiV3NyJIpHl0GhqPLTMlsqfHd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtDgYcREYZcA0H67A0lgJfALQqJRqg9SR74vAp1gR91Mrm92YrA7erxA94oWDLGbH
	 huyRAg5UAnA6rC/T6940EiV1ss78YiM7I0W/zkGlpII5SjOwhHl9Ucbu6N0SMClWMS
	 2xuPqFa0HA1V2VA7/LOHcEkdkXmPQz46yiqutyi//LfT3vQSQRPQ1cwC5LGbmGGy/w
	 0Yc71Uarv47p/u2DLlmJPESYveAhm/2wLOFoOnjuTsUrCAKd6gYb2jq7MMBhW0w4NR
	 G+efx8utDxbpxS047dsjgyFnpHQ2YS6K/HoJtMKtMEPVPEby3eVO4pdvqTDq0w+Lkx
	 XuHLv/AMEphgQ==
Date: Sun, 13 Sep 2026 19:16:52 +0200
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
Message-ID: <aqbahGslz11TWIRo@fedora>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
 <aqAk6nXECt239c2g@ryzen>
 <4nxyshx26bl5r7jjjnghsyz7k63lah6zx77cuea37mziww7kb4@iij5g3om67ub>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4nxyshx26bl5r7jjjnghsyz7k63lah6zx77cuea37mziww7kb4@iij5g3om67ub>

On Sun, Sep 13, 2026 at 11:35:59AM +0200, Manivannan Sadhasivam wrote:
> 
> pci_epc_mem_map() is already useless in the eDMA path today. So this patch
> doesn't change that.

I'm not sure if useless is the proper word here.
Redundant is perhaps a better word.


Let me explain using pci-epf-test.c:pci_epf_test_read() as an example:

Without the patch in $subject, on a DWC based platform:

pci_epc_mem_map() will setup an iATU entry, and the eDMA transaction will then
be translated using that iATU entry, before being sent out on the PCIe bus.

So the iATU entry is actually being used.


After the patch in $subject, on a DWC based platform:

pci_epc_mem_map() will setup an iATU entry, however, because of the DMA_BYPASS
bit, that iATU entry will not be used, and the transaction will be send out on
the PCIe bus untranslated.


So I would argue that it is only after this patch that pci_epc_mem_map() will
setup an iATU entry that will then never be used.

Yes, I think I understand that you are trying to say that, for DWC based
drivers, we could theoretically skip the pci_epc_mem_map() call, and send the
transaction untranslated.

My point is that it feels silly to set the DMA_BYPASS bit without also making
sure that the pci_epc_mem_map() calls are either removed or (at least for DWC
based platforms) modified to not set up an iATU entry in the DMA path in the
first place.

I am happy that this is getting cleaned up, I just don't like a half cleanup
where we, after this commit, will setup+teardown iATU entries that will then
never be used for the actual transaction.


Kind regards,
Niklas
