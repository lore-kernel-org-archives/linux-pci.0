Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354742;
	b=y6k3otPtUR5oVKAwrs2+DbRo0ywJrU6RyYUUR75QUNFx4oF8Vw9baOMJh8Cg8FhhSkAq
	 jtHUuHzTe1mDoY/5hhiD0FqxWDhW6rR3d604ftz2MrHLAOn9HqCC+C7QHkzsqfiK9lNj9
	 7lAH/Qfv8VB/7AzGs15DHTj0IRsbicOuh38UAdH+DnQc9xjKTnLj6bmJsM4114Z0A8b4D
	 hPduW/tMNNNycRfNtcHQepJn6gFxnvz/+VXoZplP0G4kl1XHSlnAqdwkveh0732kUcD+V
	 lftPjF++1mwbBQvRi3W2s2YRo7EwUudou1G80ORaSvXP1WHV1YAuAjyCvy42aRFY1KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354742;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=3Kjh/71rS7bSt01dnSb2c1FgQ0Wq48Nu51Ez0vLlm7Y=;
	b=eA7aPE5RrgVBF3Bw7WIHMY0STSyDz1MR1tXfBKMcygFFmQCk1nrATQHwR6gY7z1DhZqM
	 hb/LqLiXluiDvXT8EZpGE5W0N2z8wNqRedgJQR9beCKbl0jP69NX8ZrnbpuHuP8W3yO/p
	 2wPisapwxHREq+sqvbNUgNYWAlPtntoDGPRb5pZbWCbDbiflKQTt/kJLQ5LH4rHQA1mr8
	 nCV9TO5Xzb/o471rJStlFHSrNIUe+3nqMTqOw726zVL7W0qipSpta4ADKq56wAEohpZ9v
	 esoh8gipEmca3qxa9WDItXfJedv6Z0hMQYUT3DCm492BVl817Ea9H4eJwbdKSbhTsHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAmDVWTQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4061606A31A;
	Fri, 30 Oct 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAmDVWTQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978481F0093A;
	Fri, 30 Oct 2026 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793354741;
	bh=3Kjh/71rS7bSt01dnSb2c1FgQ0Wq48Nu51Ez0vLlm7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DAmDVWTQQ0EnpUm2kHj1UN2K+Uy4bgN7pSQKx51eCz4tGisFRtV62HYWTMzAeaLsh
	 +pl6k22EQjDXPGtj57yqPUSoULTf2us6Flc+VEGG51vvDp7HPb4su18RJUmL5FEHtU
	 ODORdxFiuhHznWOBRhFtl/652L0Y4pexh0f2VqXjWxE6teGc9QR06UO7y/w0NRRFw4
	 fUs9qwZ5PJHMTJpoxf+Ez02B9VfFbWUMI2pDaYDqWzGhJKLITkvHAjJ0m/uuWqFzxJ
	 IgtXfHkeFX8eKHlS92lQ9bwh+XOG9yH7sQfTLA/VjFyJbxznQS/mmZKIAzvzeQGQVq
	 yMrOMxQFjobVA==
Date: Fri, 30 Oct 2026 15:35:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, 
	Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczynski <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	subhransu.sekhar.prusty@altera.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>
Subject: Re: [PATCH] PCI: altera: Convert root port IRQ to a requested handler
Message-ID: <auRrmtLrRv3fOsXA@debian>
References: <20261014100723.1643089-1-mahesh.vaidya@altera.com>
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
In-Reply-To: <20261014100723.1643089-1-mahesh.vaidya@altera.com>

On Wed, Oct 14, 2026 at 06:07:23PM +0800, Mahesh Vaidya wrote:
> altera_pcie_irq_teardown() removes the chained handler before removing
> the INTx domain. Removing the handler prevents new invocations, but does
> not wait for one already running on another CPU. Such a handler can
> therefore access pcie or pcie->irq_domain after they have been freed.
> 
> Chained handlers bypass handle_irq_event(), so synchronize_irq() cannot
> rely on IRQD_IRQ_INPROGRESS and may return without waiting if the parent
> irqchip does not report IRQCHIP_STATE_ACTIVE.
> 
> Convert the chained handler to a requested hard IRQ. Request it only
> after creating the INTx domain and call free_irq() before removing the
> domain. free_irq() then synchronizes against any in-flight handler.
> 
> Use IRQF_NO_THREAD because generic_handle_domain_irq() requires hardirq
> context. Use IRQF_NO_SUSPEND to preserve the suspend behavior of the
> previous chained cascade. Request and free the IRQ explicitly because
> automatic devres cleanup happens after remove() returns.
> 
> Fixes: ec15c4d0d5d2 ("PCI: altera: Allow building as module")
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/linux-pci/20260430204330.3121003-3-mahesh.vaidya@altera.com/
> Suggested-by: Dinh Nguyen <dinguyen@kernel.org>
> Assisted-by: ChatGPT:GPT-5
> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>

Thomas, can you please share your review?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
