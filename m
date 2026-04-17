Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18C26AF4;
	Fri, 17 Apr 2026 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400478; cv=none; b=DdIpxreY0ag+9/ds4Sl8qcjxEhxjLFrdN7RE3xQaUs6stWc5e8yZfytWA+UjoVAsR/k3a2J3BJm+U8agA4AAQ8nLDVrnSwZA27PlXtdCNKlSaEWFPkVauPwKwO/xpGlua+xdrRi7Ys6H4dQxSOjx6tx8r3Q9Ppf+rtTotdpcl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400478; c=relaxed/simple;
	bh=73Syk7R0BMM+zog8ChwWI/OEfkgwAiBg55WtaP/l6uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCoWbStMd3U6cJa2ajZYVfXttvgy1kCwZFHjZmMQ6phHHvFYpFGvjzHNV7b2oH24/18tk6BxMk2b/q+b6hfN6DMfdkTqpNBz6b3uvZkUEbJH56FvopzRcIxR8FYGEWfVGdlMozK14AXNOStMMxlnkywo2hJF+8B1Ly4hgbmqHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 9A48BC22;
	Fri, 17 Apr 2026 06:34:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6EC4A601495C; Fri, 17 Apr 2026 06:34:26 +0200 (CEST)
Date: Fri, 17 Apr 2026 06:34:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <djbw@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com,
	a.hindborg@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	tmgross@umich.edu, ojeda@kernel.org, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aeG4UnyYd1FKdt1D@wunner.de>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
 <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
 <69e19c80b892b_fe0831000@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e19c80b892b_fe0831000@djbw-dev.notmuch>

On Thu, Apr 16, 2026 at 07:35:44PM -0700, Dan Williams wrote:
> Later in the thread I proposed an alternative that instead of supporting
> 2 flavors of uapi through "authenticated", instead implement CMA as
> another TSM driver [1].
> 
> [1]: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch

Please keep in mind though that CMA is just the PCIe adaption of SPDM,
SPDM is not only needed for PCIe but also SCSI, ATA and possibly others
and so implementing CMA as a TSM driver must not preclude use of SPDM
in other subsystems.

Thanks,

Lukas
