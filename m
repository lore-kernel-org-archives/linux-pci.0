Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840B3AB277;
	Tue, 28 Jul 2026 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277794; cv=none; b=qWTGvyU4jUoB/22R/9bapNJj9Bf/dRxKVQ4bVKgLQ1i4fMqJ37H62OsSg9SKLsNGBS0FC19A98b7WPzoQS08ysR7kocrz7LNbDQpRGtt8osj6/gGByxEySpQDSWQ2hhC8+TS2nd1Xt2gBJufopFNhH+coa5fELM5zH/j++3RHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277794; c=relaxed/simple;
	bh=R/7u7/YMfgmj5VnzQZgLmQehQ1CbDEouGGv1EgbRmIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YLEUwvDkhWzxPO5W+RBih1IXkgZeI7eH9NGFXeYrCJ/DOgJic37Nb++TI3K3lxWam7+xLiHHsia15ENn830jGr26d8vxXNvMC4m96pkjrr0N5BQTQ3Uo4+lXOG+E4DcsB4jYAxDq/Bsfvb1sSPU10svFwODCSiev5HqrTM37lJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aal2cCWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aal2cCWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7EF1F000E9;
	Tue, 28 Jul 2026 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277793;
	bh=bCqlxYQz7akvTB8DSvsEvOnlBjfRvoV8OwRrJtg52Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=aal2cCWIzI75G17TNXT1K6C3OO/TWqwdOe1v/BL34qv/Ou+Tc/D6GF59L2htj1ktg
	 O1WnOeEwtVa942PMqjOF/HBo4gR/vYlWVT4wMkddmN9mLZG2WtETFLfUN8JXE1vQLn
	 03rEZG5BEFn/iJb/pJlU+Xo8NE4qgs207l8nw4lyKUUZu9PhK3sko6wTnioe8gc/5K
	 6DedTlbWcDwjs55KcNzXSzlAJJZAGEa9weklTl/eIkhwSyylrTSiLVFqXFEnXtaDme
	 HMfJsdWgKONTTnY3izpPzRdFKGUem6RkA2THu3FWhjfTSSvUqwCDsGzoBLCc+/FXOp
	 H5UEfDRaaHL5w==
Date: Tue, 28 Jul 2026 17:29:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com, pranav.sanwal@amd.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB
 PCIe binding
Message-ID: <20260728222951.GA1407610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728202044.1785986-2-sai.krishna.musham@amd.com>

Replace subject:

  dt-bindings: PCI: amd-mdb: Add CPM6 support

to match history.  The prefix already tells us the "AMD MDB" part and
the "binding" part, so no need to repeat them.

On Wed, Jul 29, 2026 at 01:50:43AM +0530, Sai Krishna Musham wrote:
> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
> Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
> per-controller interrupt register region used by CPM6.
