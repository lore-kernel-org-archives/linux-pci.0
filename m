Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784D3D0914
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741968; cv=none; b=dMT56r/rnVn8tODNcNWjBsEBIkORqJsrMh6YnWhnNZs9TCQyIIl519HBTN4YX2am2k4hzUYo0gwSnoEeg2uAWj0TqfZUhA9WqaSu8l796I+XiRvOFXWy+xN9BfyEAShaAz4/iogBIHgQboDiY/zHdmTeOyt+gyXXJAhRDCnQF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741968; c=relaxed/simple;
	bh=AjN2p3mxzjx7SAwitV51h9k3PHnKA3dOKWmxDVtBn3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl3ww27vLg8f263lhZTDVSAR/7e3UCeDmhuPaIGmCc1WS/MyQmI8s3/QBzh9UoClgb4rlRNJNs+m4v5ERuk2PFanztewfZAis2gEBIZVVGu1XXsY4Reh8vWQOMcImefsdy2qF9yyqV341epuH+A7cZ4hba7Drosii5DfogWex58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id C19E8C23;
	Thu, 14 May 2026 08:59:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 896D4601804E; Thu, 14 May 2026 08:59:18 +0200 (CEST)
Date: Thu, 14 May 2026 08:59:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko@lists.linux.dev
Cc: alistair23@gmail.com, linux-pci@vger.kernel.org, ojeda@kernel.org
Subject: Re: [PATCH 04/18] X.509: Move certificate length retrieval into new
 helper
Message-ID: <agVyxrFLL8xI3sB1@wunner.de>
References: <20260508031710.514574-5-alistair.francis@wdc.com>
 <20260508033917.B5873C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508033917.B5873C2BCB0@smtp.kernel.org>

On Fri, May 08, 2026 at 03:39:17AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The exported helper `x509_get_certificate_length()` uses a flawed logical condition (`&&` instead of `||`) that fails to properly validate ASN.1 headers, leading to parser differentials, incorrect length calculations, and functional failures.

Fixed by:

https://lore.kernel.org/r/782bc59d5939aa69b58cad42f71946f1c0a6dccb.1778741457.git.lukas@wunner.de/
