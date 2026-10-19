Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446916;
	b=qA9T81X5vMUiJFfP77F4Nx2r/KBTlpnbL8EF9LysP3Lyr3IY6y3sU6a32uxveoGZN7Ph
	 Lw09bXUsmEJwFMrbhymzUUywsyvaIAh9a0i71O2iXgR1z6T45Yb1H5buVZpCJskTGplfb
	 5HgsAsC5x0CC9+EwyTwdIdUY2L5OvP4J5vigZolLWSAgpA8Em+GoIGXO1YbCHaGV5UrS9
	 Om1Vluliw2IwpDUn20zw4LqgjdvTCgKjLCsgWn253sU4xvQBDWOIsw49CcWHKZ9L8zlGu
	 zwc0SSfRJuNSNmQnVVM85l40qjkhmhIVx6rWylBVeIrMMSRy1mKMmnHe6ae49CLgAPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446916;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=goZ/Zp6Q82TM5Za7gWzi39XZKqw0sAGT29tMh2jymvM=;
	b=favFk0VwubFwBSHO2zWZiv3D6XD4YodV2i7eyMfeDNIIin4XjJj44qZtAigfV4zpLtY5
	 wALEZLBh9TzSW+ine9zQXS9dMlUyf0c62b2riSzP7sD9uEnLRzywc5U1a368cXtI0c6lr
	 WAgQXPdtBqmKdrcYPgKDtb09C0a6jljF0dtNHWEcSi3qljCx8QHczSQqhbNMcHfPQA0Ew
	 mJAP2awy0jAo7rLkJ2XQSXjWnZhJMa+0N2EM5qfCjH5/52VjjiPsj9HTfMo3QE5jJr9CP
	 Hjy2JGIJnZ8zV/jDvuC+8h/APIKaqzJAKCiVLgGmSxLAekbh63r0mdj6gu8boYJfpxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQQfCNXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3354606A319;
	Mon, 19 Oct 2026 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQQfCNXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEC41F000C4;
	Mon, 19 Oct 2026 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446915;
	bh=goZ/Zp6Q82TM5Za7gWzi39XZKqw0sAGT29tMh2jymvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QQQfCNXoeY8Li1kLMKrrJ2BB2+mTC11mr0tV/Gu8+XZcC5JyRmtjcLvY8EliI0CTa
	 2gh9BuU94QDKboaFromd6FJgkHBEZV5Yqh/GhUV0R/U57YBqKo/GawAoWGClPhT0Gh
	 UVRs0muBq4aMp2I8y2ZRQwwCCpYqIBIgaaTX83/V+aPGwR29q76HfMx7q2h4Yp8OrZ
	 VG0Wg+rV6UDOTyqF937xG6Np5EGEbCddkdi118KfpJCDlaAy5MenMBLt8VIeoUrGWS
	 SH8DZTcW1gq4h9iV3z5NRwRaPs8dG4WEqzPuvk3aYheYttUqqaLSj1zmlxXUs7LXAn
	 gl0DFd9gGHPuQ==
Date: Mon, 19 Oct 2026 16:55:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <20261019215514.GA2267032@bhelgaas>
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
In-Reply-To: <atBkh5nZEL88Gr6c@debian>

On Thu, Oct 15, 2026 at 11:10:49AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 14, 2026 at 02:20:49PM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 08, 2026 at 11:48:22AM +0530, Sumit Kumar wrote:
> > > An outbound iATU region matches any local (AXI/application-side)
> > > address that falls within its Base/Limit window and rewrites it to
> > > the PCIe-side address programmed in that region's Target Address
> > > Registers before the transaction goes out on the link. This matching
> > > does not distinguish CPU-initiated transactions from ones issued by
> > > the internal DMA engine (eDMA/HDMA).
> > > 
> > > Example: outbound region 0 is programmed with Base/Limit covering
> > > local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> > > CPU-initiated accesses. The DMA engine is later given a descriptor
> > > whose destination is the host address 0x8000_0080, which happens to
> > > fall inside region 0's Base/Limit range. The iATU matches the DMA
> > > transaction against region 0 too and rewrites it to 0x1_0000_0080
> > > instead of passing 0x8000_0080 through unchanged. The transaction
> > > then lands on the wrong host address, causing data corruption or an
> > > IOMMU fault when the rewritten address has no valid mapping.
> > > 
> > > Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> > > programming outbound iATU regions so only CPU/AXI-initiated
> > > transactions are matched against the region; DMA engine transactions
> > > bypass the translation and go out on the PCIe link with their
> > > original address.
> > > 
> > > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> > 
> > Thanks for the fix.  A data corruption is pretty disastrous.
> > 
> > Is there a Fixes: tag we can add here?
> > 
> > Probably also a stable tag?
> 
> Just to clarify, there is no reported data corruption due to kernel.
> Our internal teams saw corruption in the bootloader with overlapped
> mapping between iATU and eDMA and fixed it with this BYPASS flag. So
> Sumit wanted to do the same thing in kenrel to avoid hitting such
> scenarios. That's why there is no fixes or stable tag.

This doesn't sound very comforting to me.  Unless there's some reason
similar corruption can't happen in the kernel, I think this deserves
Fixes: and a stable tag.

The fact that nobody's reported it doesn't mean it's not happening or
won't happen.
