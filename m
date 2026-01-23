Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B137AA94;
	Fri, 23 Jan 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163388; cv=none; b=dHh5BU4zTN7sxTx7ktaTRXZfWMuRHfIGJnMmQL6vKxz5zoNswom/kErZLPvRMROYv3TxVJzIOF9/2LNqEaQNj+mU4IBBZtyjNGPBLsh3doyyX7BvqhxC71X0qBrE146fQZZrOnRMWiFX1U+T+anjfGc3R3S0E7l9tFe6KuKst0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163388; c=relaxed/simple;
	bh=LHiWz2GXLUFcvdST+ncyjgDivbqvuHHRX/etuBiFbIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlB+lahnU6zt+eJ0dYUBww0bsc+hdNOx7MKe/Tbnqkl6MWLF5r5150XWyqqCWEk99f+qMiG+ws5Ycw7MMI2JghCFete4nFqP9+EfyJQK4Q3/DV7v7woCuD2dtyDRPo01Y4oitM8c5C1Ua3SjpIYoLyQCmGTDKlvtelSNpVzHEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuhHpv/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuhHpv/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF7C19422;
	Fri, 23 Jan 2026 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769163388;
	bh=LHiWz2GXLUFcvdST+ncyjgDivbqvuHHRX/etuBiFbIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuhHpv/KquUUNXUrsrUrBXaogFfFw3YYCWS6QfsX0v5+9zwz1Jqh6tdwouKmyUF9B
	 jG4nTztIpuxMDS/F5JkAaGioCastHYXWoQG4dWkUPMwgQAWcFtWcRE4WhYjNCoM93g
	 9nhKkfDk/K36+1Q8WjyLWOWoDoWreUlE9zkO4EsopYuf8RmqLgtL4eJ8pLK5uxTzix
	 WD0Oq+rRiKhuAZ2XDJaGaIV5VlIuYwn64z4/1/6Sf7omsnJDjqh+bAwYRiBninbMan
	 gKeUvGvIyEbl4tSQporm/+HVnqebLVUFWkmMVOLiGfv+9tvoSAJuWn4635NWSHVA9d
	 G8NHGgpGFeNDw==
Date: Fri, 23 Jan 2026 11:16:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>, frank.li@nxp.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXNKeKmkclah0eOp@ryzen>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
 <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
 <aXMytcJTIeBHatIF@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXMytcJTIeBHatIF@ryzen>

On Fri, Jan 23, 2026 at 09:35:01AM +0100, Niklas Cassel wrote:
> 
> pci_epf_test_enable_doorbell() simply does:
> pci_epc_get_next_free_bar() to get a BAR, then writes the BAR
> number in the in the pci-epf-test command registers, offset:
> PCI_ENDPOINT_TEST_DB_BAR                0x34
> 
> However, the doorbells are most likely very small, so the chances
> that reg->doorbell_offset will have a value that is smaller than
> BAR size seems likely... but not guaranteed... and there is no
> 
> if (reg->doorbell_offset > epf->bar[bar].size)
>     goto err_doorbell_cleanup;
> 
> So it seems that this doorbell test just ignores the problem...
> 
> Frank, could you perhaps send a patch to add something like the above?

Frank, I guess the check would actually have to be something like:

if (reg->doorbell_offset + size of the doorbell > epf->bar[bar].size)
	goto err_doorbell_cleanup;



Kind regards,
Niklas
