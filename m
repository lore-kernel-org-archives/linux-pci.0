Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676E3A6F00;
	Sat, 26 Sep 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437188; cv=none; b=IFcmrzvRe4AARlJay76tK3CQpHsndrnhE+tl1SHxMPv8dudcd9k46LVHMP/zos0IkDutE2Ny1/XOmxN0NNQG9A3vmis34GhAptxTlYY1DfuxkpkvEDkZEeyQ7eMOuYr4tYjDatBvmphSCk3Jk6Pa37Aq2GuhSwX/S9GkUMXJnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437188; c=relaxed/simple;
	bh=3NGIT8bJA1fLBPd33BoO8oqnHe1VsGa56hmfKzg0KK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EEO7BbPO3nYwzE0l0VWE71vaJjzPLsh3biIUHp3D3zx3LxPC1j0uxyK0finhh6LNU8WGUBvhJXTY0cKXHPF/N0haTOd3bEYSSsuVyCBsveGhWmz7AQh0mH7PUi9QH2q2d4noZ3xAnkBgE6GtsBSwnUCH3r1GiQNE7i8hp3g7snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dJoGBJQJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dJoGBJQJ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2D8C2408B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1790437186; bh=dM8gUrqhTQP75orSiBGVM6r/2REmnDbC+GraiUwen9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dJoGBJQJTCGkh2cacaVua2WQKeT5gdGv0sEtWlzzkCmLPnH6ysL8YXz50SZ/Wl9pL
	 qfNx2aFlr4ENQQohp9UcTe+mJ80D70mFsp38uzZ6KC+QBZDstuXCCxPmtqxNgNCVtX
	 ja5ip8WxZPoUPXBFkvng0gAfcW7SSY5b5BHzVN3Q0xCbItPVG8YD2pWbkveYDpZ17+
	 BSJwGLF10CyH0ABLen04rVyNzf5yaBGgPFxv/43Ck5nqLldic9h5EZWHWCA/ZwA1AB
	 8hggWM3f53aW32iUAmQys0OMenrtU+uRZXnfa99G5/N08BFTnIsJwdj0mkzIBFCjab
	 8mRzMRgfVHt+A==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2D8C2408B3;
	Sat, 26 Sep 2026 15:39:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] ABI: sysfs-bus-pci: use literal blocks for commands
In-Reply-To: <20260921044637.91089-1-rdunlap@infradead.org>
References: <20260921044637.91089-1-rdunlap@infradead.org>
Date: Sat, 26 Sep 2026 09:39:45 -0600
Message-ID: <874ifc3ttq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Use literal blocks for console I/O to separate it from the
> surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
>
>  Documentation/ABI/testing/sysfs-bus-pci |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

jon
