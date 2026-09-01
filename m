Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335BA33C192;
	Tue,  1 Sep 2026 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272948; cv=none; b=iPxFZXtxt3cTsvRwVmjVXe9x4MvHKrrFxLvoLR003OMeOjVPl6RGnw/JpyluN7iWdIaPMJky4GcCqYsYS0MRlqU4lcSMf9aAdpB5c2BKXMavyQ1YOCftLMgKaAxUH8NGPg178FGH4I/Mr+TFLvsBp9ynLuHqgzNPlNGP7R3dENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272948; c=relaxed/simple;
	bh=meufiOoaUZajgpTwtRL5RV2Vdq7prItAC18AcnZJCIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tsBqNCzq4zjJuxgktBZVJSDtunu6wbFBRZBBpvFVK+thicNjTKnrDzlOvfU2fVp/vafhZNfuSYuQxi0Cua4+cpw8VQ8riUKw03Iq7JaJjhIFU6XndlalP6LgomqBkUsYEqfwI27EvMJnLrwbIMTvrVv/hLh4PTka5IVa3YwLkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCC91F000E9;
	Tue,  1 Sep 2026 14:29:01 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Koichiro Den <den@valinux.co.jp>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
References: <20260821122808.238248-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add .post_deinit counterpart to
 endpoint .pre_init callback
Message-Id: <178827294141.64947.13285393994093818780.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 21 Aug 2026 14:27:49 +0200, Marek Vasut wrote:
> If .pre_init() succeeds but subsequent initialization fails, it is
> mandatory to correctly undo the hardware configuration which the
> .pre_init() callback did. Intrododuce .post_deinit() callback to do
> exactly that, undo what the .pre_init() callback did. Usually, that
> means stop the clock, assert reset, and possibly program some registers
> to quiescense the hardware. Invoke the .post_deinit() callback in
> dw_pcie_ep_deinit() to retain functional symmetry.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Add .post_deinit counterpart to endpoint .pre_init callback
      commit: c73f79e49b030e2a64591f990629b925f0926ca9
[2/2] PCI: dwc: rcar-gen4: Use .post_deinit to handle dw_pcie_ep_init() failures
      commit: d9113a8a6bdda348d590845da014ab0e01afe638

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


