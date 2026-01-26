Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1EF271468;
	Mon, 26 Jan 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454518; cv=none; b=LgbvgzgiZcE66PyE46AtBCcO7YH87U3WXnrYjb676dJg1OCji3nUfokdspM0HvgFCJWkUl0B9CBNSkHHFZcg6WJ/1U64C76xKeFbxYi8MwHD0flpkGdarjbaEx/JBBeaVy9PbCddoFOYSadXhtJgeO48kljPmXgKqDF8+qJzUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454518; c=relaxed/simple;
	bh=SCcy6OLg0Cu4R54lTvmhvkGDK80DGLhDWhjVmNLwgi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMfGmGMr+1GHTD9CCPtY4wDSNHkM/gswMJeetJf49ilt2Cq0L0Kx35qzgVMb0YUZyUPqiX8uRxAFGln23DrDSzauPRDS0Vvgq2aCf3lbgP5enimq/Iuc8FTOrrzYTXOC5OhYjoi90R4Ku3YmiVHQCnvedKZ1vq1FFyN70jiPKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6+dbk+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6+dbk+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC83C19422;
	Mon, 26 Jan 2026 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769454518;
	bh=SCcy6OLg0Cu4R54lTvmhvkGDK80DGLhDWhjVmNLwgi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6+dbk+EFF0ZAnrouzwGvfYzEm1F1wguhqmpDaPF6WdRmEWblVG8WaR9dB/IN/I9Y
	 eUuNSQVA8GcjlZF2MGXI6aKrpFYOkHfJJVwkN9N1r5LSr9uvD+ufr8xKnvNrwi6i8S
	 ct3KKfncXF84vO1EFkyuS5lVRimp0Nq+1yXndQo/fmdFwqWSho9zcnJ0A/YYx2ATTW
	 yXxDsmYK52dli5O7d8pquUU61OSf7rD7uW66T06WT3PnBU13th9gfrS5q0GxFRqId2
	 3HHlopumCT5QvtL8+L+WPYncvXkb263/GKyJ7zwMhEmHJCcZDg/RgP5Iuwchi7A+e7
	 mOD7tKC4Rrb4w==
Date: Mon, 26 Jan 2026 20:08:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXe7ssERwysqJbT7@ryzen>
References: <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
 <aXI_ny1-5NlN8r_z@ryzen>
 <ajuq5dpbzzoghd2hk7cz6w4t6jzcxfmygbyiciqjjhhg6ipkoh@usuhzmne6cap>
 <nrvamhbpi4372c4qmb2q3h74irrqkntlb2rwfasiorgavylp25@rx2lp6ldk64j>
 <aXMytcJTIeBHatIF@ryzen>
 <t2hsk77mp3shacbehlqfnpjgc4az2phvo2cyjn5hkybqdmzrcj@hnuwporebhz2>
 <aXOMVYowDxHBL8kg@ryzen>
 <f7rkqbvq4rrpngafz5hr23zza6hfrslym5px2izgdsvlnvqvfu@v7zk3jks4cuu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7rkqbvq4rrpngafz5hr23zza6hfrslym5px2izgdsvlnvqvfu@v7zk3jks4cuu>

On Mon, Jan 26, 2026 at 11:26:53PM +0900, Koichiro Den wrote:
> On Fri, Jan 23, 2026 at 03:57:25PM +0100, Niklas Cassel wrote:
> > 
> > I guess in worst case, if someone actually complains, I think a nice
> > solution would be do to like you are doing for vntb:
> > https://lore.kernel.org/linux-pci/20260118135440.1958279-34-den@valinux.co.jp/
> > 
> > i.e. pci-epf-test could have {barX_size} in configfs, one per BAR,
> > and then the user themselves could configure the BAR sizes that they
> > want to run pci-epf-test with, if the pci-epf-test default sizes are
> > not desirable, before starting the link. (Some tests like e.g. the
> > subrange mapping test should of course fail if there is not a single
> > BAR with BAR size larger than needed to test the feature.)
> > 
> > But if I were you, I would just bump the defaults, since the defaults
> > are currently overrided for BAR type FIXED_BAR and RESIZABLE_BAR anyway,
> > and just add the barX_size attributes in configfs if someone complains.
> 
> That makes sense. I bumped the default sizes in v10, and if this turns out
> to be a concern for some setups, I'll consider sending a patch to add such
> configfs knobs. Thanks for sharing your thoughts.

FWIW, I think such configfs knobs are nice to have regardless of any new
features or not.

(I have personally changed the hardcoded values locally during testing many
times.)

So I decided to just send a patch that adds such configfs knobs:
https://lore.kernel.org/linux-pci/20260123180747.827357-2-cassel@kernel.org/


Kind regards,
Niklas
