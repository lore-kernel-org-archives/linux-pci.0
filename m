Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C439E6CA;
	Tue, 24 Feb 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940319; cv=none; b=kTJHdMbz/DwcJo/wjgljOxyEyL+BEkX9Vc9F8WUPPJmEukb8FdmjU5pZYk6mINncChxGZlu461gsBlX3f4H1cM7+KmUO/zQpyuma+r/Y8dnHTksOitL7xYhnCyv7JY2UL5nnSpA1HD2gOom3wK3di9wDeD7PM+a2jBm5yR4T6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940319; c=relaxed/simple;
	bh=D6KDP7mLfC7K9PBYKLx9XDujyOIToWseGbbi633OOLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilsuBcH/lThtr5RiT6I97XOitqkT/tVd1sQ775K3ZUcaXPyvzC+xKdLOHTr9rycu7wWMAsyO3Lh5p7wkcygQE6WWwLdThivxxkTa8MDmXT0vbpBVoJifyJxjBlhPTtnIqfnZk2C8r+5c9wNV1d1+EmfIIkLiRpc59wW4uZLzkak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuV/3bWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuV/3bWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9D5C116D0;
	Tue, 24 Feb 2026 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771940319;
	bh=D6KDP7mLfC7K9PBYKLx9XDujyOIToWseGbbi633OOLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuV/3bWaV0MvVBZJ/zWZCp2J6s24t7UDVy0m0GiSO24N2X4bT6Uxgl+P+3JKqgq6U
	 n3rR/QE9ajRDdxT1WZExIg51S7oRGQdawBGscOT2Rugb34S5QuzWyru6yyzktHgKUt
	 55TOh8EsEB+sLoez82FZ1n5z0u+v2GU8sP9gRAI5VMB51ePIuwNtOh5mUUq8TpL6j6
	 Qvpex8ClP1y8ftsg4gqQlZK+Iwe50FNCxvDiavtr9AvlHvz9UW00Dvx0jjIV7uVT4j
	 GExh3Aj4TZT/yeyPjIWpDhjQLTNNK9S/s9/Foq52qLXEehA53tD05YqUvlTviaw08J
	 1mmAWaEBUCOvQ==
Date: Tue, 24 Feb 2026 14:38:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
	kishon@kernel.org, bhelgaas@google.com, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Check
 pci_epc_get_features() return value
Message-ID: <aZ2p08thDzZdSdNc@ryzen>
References: <20260224133112.1356612-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224133112.1356612-1-alok.a.tiwari@oracle.com>

On Tue, Feb 24, 2026 at 05:31:03AM -0800, Alok Tiwari wrote:
> pci_epc_get_features() may return NULL for invalid function numbers or
> if the EPC driver does not provide feature information. Other EPF drivers
> such as pci-epf-ntb.c and pci-epf-test.c already handle this case.
> 
> Add a defensive NULL check to avoid a potential NULL pointer dereference.
> 
> No functional change intended.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

I think a better solution is to do like pci-epf-test.c, which calls
pci_epc_get_features() once in .bind() and if it fails, it fails bind(),
if it returns non-NULL, it caches the result:
https://github.com/torvalds/linux/blob/v6.19/drivers/pci/endpoint/functions/pci-epf-test.c#L1112-L1123

That way, all other functions do not need to NULL check
pci_epc_get_features(). (Instead it can use the cached value)

pci-epf-vntb.c should probably do something similar to avoid sprinkling
NULL checks all over pci-epf-vntb.c.

And, if there are any existing
if (!epc_features) return -EINVAL;

they can be removed once you've added the check in .bind().


Kind regards,
Niklas
