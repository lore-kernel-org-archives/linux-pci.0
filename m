Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028035;
	b=ellMxUfLQKWFPzB8lIlfze6cDltr9/2P1wsnu+kVeQmRI8YJItZUgUM57VkKP5RhQwOz
	 8UapOGRy6unJqe6gDCt6uICUePfouD2WFhHs9dNpNh5Ap115nvtjPLBg/+jwZVDhiX0th
	 JeEusYllIRSfuVpzNIRUdUdkz1SR3Afuxwe7Hq+3q4bHx+unZTLUoIoA45smAyoANLuAr
	 GfuXK5atidxhZ9rtiHkK6LdIFJydOahqkAdL5kz25ohD15wP5a/0OWMpAq3wuI3eHsfj0
	 4idyHYzq58t1apyCIsD+VQBI+81u6SZUL1nY0u/GJbO0Lkqm39wDsPXBtCHRy3QGXdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028035;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=saM6ukN2tGITKKFGX4cYvy9MTPH6zkPj1P9puRht9Bk=;
	b=x6CtFiguMzrkqjC89yySWN0/rg1gWUkuIftwBnBmlVfaB6O151pH+IV94tW2CC2nuHgU
	 3HqiE4vG6uxIcvIFh3FvdGiko4ElXYRdan02q85ICeAJCS2w+3IB012V/Wb6LGPMUvxAR
	 CPZp+07OE+js9RzcjE2eADxnqeXEGAnRKb9IEnvhrSnwEFombXKqO/j4FZDZKbTxUl1aA
	 kU4v8g1pnsUf3vTTRw+MdhBfGG6j8Kj3dEs8Em99dM3dhCyZhotnhiCdQJp77QOBdS6d0
	 Bhu23gCSztCB5F6x/w1MiYraVf7rd8CledXZHeXpzGmpdjoSlLCC05bZenn1PUgFXUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PBf/L2ru";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E42606A32C;
	Mon, 26 Oct 2026 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PBf/L2ru
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8D71F031E0;
	Mon, 26 Oct 2026 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028034;
	bh=saM6ukN2tGITKKFGX4cYvy9MTPH6zkPj1P9puRht9Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PBf/L2ruq1SLMs0cRulaRZ5XwFb0lXaPo6JukQlPMdlD2ofs+JCMuFC6N04xvgfr4
	 Cf7sbqZVRMTKaHa2Kme8nbOEDdoVLkxMzqj2XddIsWuxmetD70IGo7Ez2Sn3qE1CHh
	 QLsjYQRN19r/VamFnkRpUfewNhzl7z1B9plT3vidAGT5DqvNEk6y3o4bhix/63R1HB
	 m9qLN/nFmLeyb6BEGLfJ7u12uJN/+MbJinCFF0xAo0WivkAxWDf941SYgQQXeu49zt
	 Oss9ZlXdeGW3OxWvhIr/qpI6SVF2ixAG3YTpr5X9e1mmQH68BQKu/pRKN9EdJ1Cevx
	 JVSo6kfwMpqRg==
Date: Mon, 26 Oct 2026 09:20:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nikita Vetoshkin <nekto0n@meta.com>
Subject: Re: [PATCH 3/5] PCI: Add pcie_capability_user_read_{word,dword}()
Message-ID: <at9vwXpNUofIzxPl@kbusch-mbp>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-4-thepacketgeek@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025000836.58294-4-thepacketgeek@gmail.com>

On Sat, Oct 24, 2026 at 05:08:31PM -0700, Matthew Wood wrote:
> pcie_capability_read_word() and pcie_capability_read_dword() use the
> kernel config accessors which don't check block_cfg_access, so they
> can't be used for reads on behalf of userspace that should wait for a
> reset (or other pci_cfg_access_lock() holder) to finish.
> 
> Add pcie_capability_user_read_word() and
> pcie_capability_user_read_dword() helpers, which provide the same function
> using the user config accessors.
> 
> These are for use within the PCI core, so they are declared in
> drivers/pci/pci.h and not exported.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
