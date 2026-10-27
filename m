Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102349;
	b=JmaWmyzebBMMS2F4f2/OyFviZDnCAhFXWrcPCm59rWuIePssRz0skolitfdrLeKLVvvo
	 lpvKks6sFF+LOjMaqhxRVGkBJNFH6UfAlBcPQneB+KO5doY7TCd+51sU7DzrKZgo4FHOx
	 pv9fAFlmtjZupYA606OubD+4uiB3wZ1TFRCP9Brtvm9MJj+uk+yrDxEpntaOSPjDt6D8b
	 U4D2HlzkbamkcYBcDP/qkC7GJ7i++6tis8e2mLm7NqnUz/pGl/vdJyTNr9neIgS9oXGOR
	 D1cawHx9nng+xBS4VnZMYmzM4y/fuaPjZl5qSDsiHtGOaP8R4ZV4O5kYYqYBE60J/Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102349;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6ghFkMGjgkKUVgJSsrNjglhbUuFeRKKfCk5oqXCgc0M=;
	b=G5SW6ntz42TEgSgrU60OFnQE1i6EZ4FV9MnUhRj6Ib5rgcumtNwifByc6dX3DvnTr5C6
	 HI0VLp+O/uy38Mtoby4eJ7M2gItAEIqVoSS7Wt9NIr7+0rniScsCvULPpROeupd8pUbNF
	 XTJjMoSA7yHZXdhBOQa2/vyv2oVFRikHR16pko/b6P8TURkqQWLgvUhZkJKCy9qRVXIc+
	 w6pcHIxvaElpS+nuj1PYWixuwVlVt5uYZIJlgc2vlzHccBBXxxA3oe3nVX3MYqUUA2l8B
	 YK0JRzk/d5AaNBdYDO6aT9hUnZ9GZQMoYbHLTTBf+MTYWBUM1/w+0ZCBxB6qRi61L9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5A606A31A;
	Tue, 27 Oct 2026 11:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB841F01828;
	Tue, 27 Oct 2026 11:59:05 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] power: sequencing: pcie-m2: Drive the Key E
 SDIO_RESET# signal
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: William Bright <william.bright@imd-tec.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <at9cGzb2p4VB8EfW@will-Legion-Slim-5-16APH8>
References: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
 <at9KREB4Fyf-Jl5S@debian> <at9cGzb2p4VB8EfW@will-Legion-Slim-5-16APH8>
Date: Tue, 27 Oct 2026 17:29:01 +0530
Message-Id: <179310234194.16692.5070156797811021066.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CcGfh8L5LVnxTc4Pe/8nKaGbUYPnKwSLFkzEH5+Zduo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4JIJEq2AjgSjdmWztpFe13hNRTc2OfVtt5TDt
 UGDACgy0DGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauCSCQAKCRBVnxHm/pHO
 9T8jB/9zokkwzoKWEqjBoUBsewBlSJalPolszQPsirCPgckJ5dtG8HnC+ev9CQMv87Zg1Br1q6O
 wclQoBmr5dlG4I5cWo5raCBiZJ/K0fmrBfXlz+44R5zN4Yokh/jIut8nP0N5gqRyaNijkl0MIUn
 MCjEOhNQ/PnGKdzeGtJaRpTDqLMj3v/qBQmDlHrwGV7Nn46A8PNQxtlGTjZrBO5bew3r1cRBpFi
 SM3VYDbs+zW4TPIzw0p/SaQfiMmvA9LAruN2YhZDsgyAIrVKZlc33ezcT1R/yTpgfyJkb2T1nVK
 GviX91Jo8qN9FiHk0DZ4KWGj9LnWfDSaKYgyuiXrIEFs9GIY
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-26 13:56 +0000, William Bright wrote:
> On Mon, Oct 26, 2026 at 06:16:38PM +0530, Manivannan Sadhasivam wrote:
> > 
> > Do we have SDIO pwrseq consumer driver in mainline?
> > 
> > 
> 
> No. MMC still uses its own mmc-pwrseq framework.
> 
> > You should not add GPIO control to the pwrseq_pcie_m2_vregs_{enable/disable}()
> > callbacks. You should create a new 'sdio-enable' and populate
> > pwrseq_unit_data->enable/disable callbacks for the SDIO_RESET# control.
> 
> An sdio-enable unit wouldn't ever be called until MMC gains a consumer.

Yes.

> Should I add the unit anyway, or drop this patch until an SDIO user
> exists? Maybe I should switch to working on this first? But it looks to
> be quite a big task.
> 

If there is no user, then the unit will be a dead code and we don't add dead
code in the kernel.

- Mani

