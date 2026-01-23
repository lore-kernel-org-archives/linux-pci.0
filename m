Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBD310652;
	Fri, 23 Jan 2026 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182018; cv=none; b=UdYhqfG0XO3KP59bADsvp9iBna8hXREjatpfoIVS9v6DGRmlUVvahL+juJUJBE5I604OQWa2XR5xE5QP1szvuJEdSLTQ1izZSKh09peSxYbecOXCBYTMPw0zSmbYSfaUBW+TxUV7tt0Ps6LE5uxWi5aUiHynzR47h3DWcL6iAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182018; c=relaxed/simple;
	bh=d4wpaWx5ORbvwJBDLcX+V/I3s5UELrZTGcPCzvsTwys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIzdrhnE1F0k/46j73qZCFJM8sto7Vx0uu8ZkzJkxTDfWaHx8D1wimfhCvqGQ9fNo0ANAkPo0UPkfHHYwzXmtVgXM/A/LEgTvGuUGYhyUe8XBWGCG/yIkyVHmacdNfkLOtZibPnHfyT1j1HXJHGFf8sTBw+LclhWBQqx39gFxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyTUlJ7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyTUlJ7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD977C19421;
	Fri, 23 Jan 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769182018;
	bh=d4wpaWx5ORbvwJBDLcX+V/I3s5UELrZTGcPCzvsTwys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyTUlJ7ABtmQXHrdQc/TA8t7GGz2s6fmFaFB2N8RgLtoG1uV/HmNoHbZup7IS12gt
	 Ga+fZmoMN8sfVCCvkfm+pUXtU9mdE46BqaccBPfB9coQozMqsbo5WYAiiyPkF5t+3R
	 QHU8hLDEln6mehEgRvY6gGCoonM5CQMi7HddsQgA8RmUZLH4TYSLMBdxy76fzMKPUc
	 gnlWeFhivq0wrZ+jHGvokPK+3rUJUhHQgQaWNNOdomBJQxvHRM8BX+0RcUrJIne5+d
	 gn6NHOG1TTdD/cx+ivp+FEhzN+eDHhP+PIcrMZNdWZ8lrmucIKclYM6VpcdhPU/MQt
	 DpV/PQ7rmmS7Q==
Date: Fri, 23 Jan 2026 16:26:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXOTPnSsfqluUiVw@ryzen>
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
> On Fri, Jan 23, 2026 at 04:11:08PM +0900, Koichiro Den wrote:
> 
> pci_epf_test_enable_doorbell() simply does:
> pci_epc_get_next_free_bar() to get a BAR, then writes the BAR
> number in the in the pci-epf-test command registers, offset:
> PCI_ENDPOINT_TEST_DB_BAR                0x34
> 
> (Which represent the offset in struct pci_epf_test, for
> struct member db_bar)

Correction: Which represents the offset in struct pci_epf_test_reg, for
struct member doorbell_bar.


Kind regards,
Niklas
