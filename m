Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468434;
	b=A0q8R7beusEZTZ0EYWz6fY84YC4QLyMrHRKOQIOmWb4ppvmmAP/QjvfxjXhdJdRrErhl
	 KdLCJYKrEpJ9fqClX1m9UvWkYABMIYT2p+R8O5s+pA/bMTBAWJuODyai+ZcQ9i7hXUqgE
	 rI/j6ljaoR3ls5WtgR/sJLtZtITwEID5mawQm2XkqaQvdF/Fx5fHrecpD7s6wrwpUIqIM
	 8wmltHp40W2Qx7ckdsfVUTH4aglUIyLx46AUs3md8NtxuRWBWcxgwCL8f24qDe0SJdU3s
	 9cX4XVlqV+CDeDGKGZygAa9frFbA2uEB68Kqdlta2+ADXnP5sN6XTgLqwn1z+DzcYEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468434;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+7k1NaGz5TOnOiTpgvvEXdv7k27RwmSfbCON8FW0kxw=;
	b=SxDQRZkKnpexya9mbt4/pkpJBskt459auzH+lbZI1y6SBxm1IDHUeuHA93LVfUQ0ZUI9
	 lWr3sKRadofcSco3mz4ZWp6RiPmGh993EXYI9iZfxdsuc6AU67awZ5rpQJ+34LahvKFPi
	 bF5B5K+YTG8WLHXSTTUObTANup+g6SgegrFZobD1kjS0qBpbaQVQmmzrPRLH4elkPcfiA
	 sPgXWyfCQ6BLP+KPXTNztmFPiJuZIUBRz9gO2eyUCBsCtn+WhYXnuHOG4vP25+XTBU3Ky
	 LuqEVGdpYF6CvAQcrmyg0popW46uR1gKwGNJ49tVWtikdX8mVUR5XXX4vvsFyUBwu7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JDN8500/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359B606A31C;
	Sat, 31 Oct 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDN8500/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38571F000C1;
	Sat, 31 Oct 2026 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793468433;
	bh=+7k1NaGz5TOnOiTpgvvEXdv7k27RwmSfbCON8FW0kxw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JDN8500/3P01cYmIsV8CpwYjOiXOUz0EXUq3PVUNx3UQEgfh079uahNBYdsdnp7xd
	 9Z0PxyBRM0ydrsTs18AviGmMAR/WZ2bgPvgHQa5LgMWMQEnJmC2s0GllDuEHOXUG5m
	 tQG3Q7Fcz7mFT3Xm36W+WChrVIO1gvC1aERSBIc/bUjif+jXwykHli1gmykhSNXjts
	 h0E9r/kk4a1J3B+/QyTs56S4JwipW8ZK4WahKjbdMLm4uc/L8/T6k/n7Sa/m95XGvP
	 PTNbkjtJibfDvtEceuvAC6lbElu8kpf35yeFtzfc7hdF3//I9B5z9XYff6hIYLQle+
	 7m4LvgHHUrtiA==
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
Subject: Re: [PATCH] Revert "phy: qcom: qmp-pcie: Skip PHY reset if already
 up"
From: Manivannan Sadhasivam <mani@kernel.org>
To: Michael Burch <me@michaelburch.net>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev
In-Reply-To: <20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net>
References: <20261013-qmp-pcie-skip-reset-revert-v1@michaelburch.net>
Date: Sat, 31 Oct 2026 23:10:21 +0530
Message-Id: <179346842169.7309.953613001579327741.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2212; i=mani@kernel.org;
 h=from:subject:message-id; bh=MIzTd1itZPpW7FCl5YwWGtQIeJPAAhpsZ38f5D6eUQU=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsh6psGZ4fnkq2XWt7t1x7msGUP7WBYY5yqy6uRa+v+1D
 dVMnDalk9GYhYGRi0FWTJElfamzVqPH6RtLItSnwwxiZQKZwsDFKQATCZrBwTBj5WLWvc4VcisS
 HaoYj84p8Iyq+C3byiB894p1mfriqZVXfiSpSQv7X9OdwHvsn51Je96ctn+a0XcktNxffSgp4l4
 o45OS6VmeX/3vQPGjvXY2bJKbMn4fzQuZlvHaxnEzy5ffMQlx84S/JStMvHohTDugymCnh/raSF
 9fg2522fs8+5mtn3n9Uwq7dWvBU5kdDxccYJ+0u7lO9a2NuUZm4vP2D2+Y1n223Tmhf1HMLDvXm
 Plz1Z6wPWMV08l5fOLU0fi4f3/DZBQPmp/mTA8oLw9I1nvQoVq0Uvx6lK6OVzXfid5phXsvu3us
 U7RMbcjQ4g6dNGcdy1XedSyldpKPyyTP7hRZclvV418VAA==
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-13 09:22 -0500, Michael Burch wrote:
> This reverts commit 910b828b22b7b91054b3bd4be676a017444b0e00.
> 
> That commit skips the no-csr reset assert/deassert (and the 200-300us
> settle) whenever the bootloader already brought the PCIe QMP PHY up:
> 
>   skip_reset = qmp->skip_init &&
>                !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
>                                cfg->phy_status);
> 
> and states its own assumption explicitly: "This relies on the assumption
> that when skip_init is enabled and the PHY is reported as up, the
> bootloader has already configured the PHY correctly and the link is in a
> usable state."
> 
> That assumption does not hold on the Dell XPS 13 9345 (X1E80100).  UEFI
> boots from the NVMe behind pcie6a, so the PHY is always already started
> when Linux takes over, skip_init is true, and the reset is skipped.  The
> link then never retrains and the root port comes up with no endpoint:
> 
>   qcom-pcie 1bf8000.pcie: Device found, but not active
>   pci 0006:00:00.0: [17cb:0111] type 01 class 0x060400 PCIe Root Port
>   (no 0006:01:00.0, no nvme at all)
> 
> "Device found, but not active" is dw_pcie_wait_for_link() reporting LTSSM
> stuck in POLL.Active/POLL.Compliance -- receiver detected, training never
> completes -- so the machine cannot find its root filesystem and drops to
> a dracut emergency shell.  v7.2 is unaffected because it always performed
> the reset.
> 
> The commit was applied on its own as patch 1/4 of "PCI: qcom: Add link
> retention support"; 2/4-4/4 have not landed. Without them,
> qcom_pcie_host_init() still asserts PERST# and resets the controller
> before qcom_pcie_phy_power_on(), so the link is down while
> QPHY_PCS_STATUS still reports the bootloader's state, and the skip's
> precondition never holds. Revert it until the rest of the series lands.
> 

Ouch. This dependency should've been mentioned in the cover letter of the
offending series :/

> Fixes: 910b828b22b7 ("phy: qcom: qmp-pcie: Skip PHY reset if already up")
> Signed-off-by: Michael Burch <me@michaelburch.net>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


