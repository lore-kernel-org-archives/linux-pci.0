Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682265;
	b=R17EWldiBC1+th+tUKjSOoCREjeKXUBuvGLOGdT4Gh9dVqN+hhF8UcYJctfGo4YER25e
	 da910tbyBPetHilNH7xCgOO0+rspsKHtt3H53wkcuglsm+E7c/idyRf5rERrcgvU+PBPQ
	 q2piEsX/FYldip8Jj0EgLD+COLLv1WJuMa8s22h1plAWDDF0/otAuh3BjsX8UU25MDDQ7
	 ktBIpsIqgoS0xnTV9aoPOX0aW3YN1nOeb72Z3bjHQaQ5n6yNgpovo2NvUJ2vPmLTkwJ5y
	 DRDy3GxG9O481NIwuVla7FSRQXdtpORGing1wkCK08RO8eRDv670rOD7TnuXkogQ3RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682265;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=bFVHMyzkGfixAo+lRL0UOguXzFYdiMJeW/m0ohIh0Xk=;
	b=uwSVZPsbKOlozgsRjqMLZl1Zxofdq68qgz5RKlS9rrFUQm4D431sscGyEYEZQCGVBtr6
	 PjhXvwlk2I5WSUBKAUxGABTHfP9Xz2r2bxPdFiuDX2skVWLPDmrS9s8NUvDgOHS9/hz09
	 +rPGywBjYKH+QbBGXlZ1MhDg+rAgV/uLxi5sM1LaD9LqqYIP1LHjrjeNZa21Ai12kCgwW
	 9KsTn1qVg8Gj3G5McwgFOa+PiRx7aAGbE0IzYgBIxPN89LFuwT4m1X3B2yLut0785PtBo
	 xbB4qNmYpLJ6F4neXfZ5qBAI4E7DG7rWKfFCHqQ2y09trORT+fIkWkjhwOflOGJXJ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P5raJoft;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB62606A31C;
	Thu, 26 Nov 2026 08:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P5raJoft
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bFVHMyzkGfixAo+lRL0UOguXzFYdiMJeW/m0ohIh0Xk=; b=P5raJoftMjwMsstp6HiooF5pVd
	EHnpaYILK8l2F8zyGp50Ik1WNNF7K9mAih5GimXrDHVsaZRc4bItu1wVPy1pZyxbfmFRZKWPUT9+6
	sa5OaFjVFhMoJoMA/w4chw5RYE9Xqflp+DAiRI+mImykmPfTft5YEYxmHygTCqiCkTKX6T6+CEHal
	AUQ9CP0gcY2RF90t8P/MCr0cNa0o1V6OAYdS99m629ZI0/oS02PuSHBB3GcrrQuh8Aiy+Iak7ZA1e
	jcOOAuhHy0AyPj2n+WgnLJnzSFr6JO4kXF3GpeWwEPKXCJstdmd4CE8kMEESewtVvIl1bOdMJxDQd
	siV+nWXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWUz3-0000000CPpJ-1WGD;
	Thu, 26 Nov 2026 08:37:37 +0000
Date: Thu, 26 Nov 2026 00:37:37 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awfv0WKc6iblVA9E@infradead.org>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
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
In-Reply-To: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> During stability test, there was a bug that running 'mount' on a type
> of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> error and panic the kernel later, when using "pci=pcie_bus_perf" kernel
> cmdline parameter.
> 
> The NVME device has MPS(Max Payload Size) capability of 256 bytes while
> its corresponding root port is capable of 512 bytes. When enabling
> PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> both set to 256, while the root port's are both set to 512. But the
> NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:

Please add a quirk for these devices now that you have identified
this problem.

