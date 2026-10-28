Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793200513;
	b=iQyTb2ZgKwsNc3mVmOX4L2jha47HpYNos6iAFFaCP9N6/YbWYdsBRSaeM9SgY1wO41m8
	 S13t9p/Ec5hojv3CpV5ARNFdWXcQL3XX0trAbB8BdPzWdj30A6X2Df948Y7hIwiEz+iR0
	 lTmeRS+SIdJmJnvWQYioYgvO61p8QUnx7wSgvJ/Dw8SrG+SnsjTUIRvHaT0iv5ra4eBk7
	 9cP9GLoZZAq1qYhBZSnbIc+RmFTzwyJ7OkLYrvZ5ORQKol43DuATwgAcTvAHYTkvyWBGd
	 eqRBA1q/ZYF0D9fiZXqGPYzXmhG4BhJLHP4XMGDNkEhpBbP7fyjrD7t68Vfa8rYxdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200513;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=k+Fp/OwTzx46JAuGLMEAEXDppUMAlCveEqpA/Wat0tI=;
	b=3NkMm86U9JMWD8M00+F69CqLox3MhsBzFiATd+dkeWAnxHuFJR50v8tkpDQYIn8zHUVG
	 SYO4ROcc9WzJ0nq3U18U6S+slz10YcpLTcA/bZ2Za9auvoN6B4rBzza0Fq6tgRbn5M4F5
	 bSz4xe3NqDwvGwJfQAlUTUhziABEhzHw7GOt2zJxsNu0iNbBPXFzQcfBRLIBI5srVV1Y2
	 v+5YVyVKVl9ObRqkvgU5bmBrj3ZYgvzmo+6jkJqtjqjbJBeTQehk506Q/vFLBzD4/gvXk
	 greyxH87oe1mLelUadaKZPLMSaEZGdcQOJom9cZTRI1lBpfJA0JSYdqtSrIMsvchPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRcreA69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C99606A31E
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRcreA69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15321F01825;
	Wed, 28 Oct 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793200513;
	bh=k+Fp/OwTzx46JAuGLMEAEXDppUMAlCveEqpA/Wat0tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRcreA69M7B6WlrKXcfPu2ir2tg4ZREnbq+/kwGIkfG9ufiIDD0pqsLDo5ZwmGO4a
	 xmw+fveC27GyQe+vNrnIGMJGZ21L+mnYtKB/0lGkcbZm5QVUaYWm6+CJyLWyto5zh6
	 HEOZ6dSJt7cPhEhlSBSAD7Xrasod2f7PwHh4eIoZD0uqfYneXnQctimVih52OTD2IC
	 KhPldbarVr0SKDknGHB6wQD97XVUH9zzi5dNW5LlzxkOrtcdM7C4KkfhNQIhiVTd7S
	 Mx2uLEPiUt+gCeHvatvKITCkoLiOiIhBX7o+ldeGhmF24vmZw+iMKLJUgYVdwblzNw
	 g+navrRppGaEQ==
Date: Wed, 28 Oct 2026 09:15:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Fengnan <changfengnan@bytedance.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	tglx@kernel.org, namjain@linux.microsoft.com
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Message-ID: <auIRf1QATQjVDtkH@kbusch-mbp>
References: <20261013223543.395054-1-kbusch@meta.com>
 <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com>
 <20261028150712.GA16374@lst.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028150712.GA16374@lst.de>

On Wed, Oct 28, 2026 at 04:07:12PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
> > Hi Keith:
> > 
> > I made some modifications to DIM and then implemented a solution
> > using the DIM framework. 
> > Based on current testing, the results are now comparable to those of
> > the previous patch.
> > Here are the preliminary test results:
> > https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk0bTZwlJP1Hzzdk/edit?gid=188992110#gid=188992110
> > 
> > If you agree with this approach, I’ll continue testing and optimizing.
> 
> І can't speak for Keith, but I'd really love to see this going forward!

Same! This is a great problem to solve, but I'm just sorry I don't have
more cycles to work on the cause. I can quickly respin the msix noflush
pre-patches to address the naming issues tglx mentioned, and we can take
nvme in whichever direction has the best performance.
