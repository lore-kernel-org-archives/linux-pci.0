Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474231;
	b=gcWA1rvEkMVVzY7uZYglu3A/NUEzH1Kt7Z4ZuaqFyeVzCXfw7eKTpKNE28GFdNq6dDXL
	 yLk3vWvxifo2MZROSiB7qtiwi7ySbbOljUAT2muEJhcQlFgRkjiwxUee1xZVeszoAQWLZ
	 IT62JBhkEIhJbKK8xqdy58JZ7gRJ5U252wdSz66HgVzbJRs22bhLJiGXo+XhpbMBY0en9
	 raEwh7xQ1DIYoCd2OZRuChX9iscFUeNDD0eBVeW9mESR8EFIy2QdshANBvpWXq6oJ36Oa
	 XGqeN4S7nqnkhVjoLl0tXgjZcPuKmQcLO3zDq+3gq+9FHDCONqpeesQJkx/kKcx4sTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474231;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=WQnZsJLH2M1dTlVyLgeRf55jDtYtcurGIQfRD7ez1uU=;
	b=pmfXGAkANUf5+0vVrxQeQPOYwUxrysaC3UUwp1Zy/mBXlxmAGScgPxS1ahBFVmfBpFGM
	 h1zndH8mx130lxCHVuVay4fNN8dRMA4gDEec70K4DCx6J0MfulcXtBQQ573yyIdGDR9rS
	 IQCfDS5ZRYtRUNC0IWjmi50RXvBI1+ZJDiATaj2sUohzna9bXGF/SyTRxSPlv/u+5bXYJ
	 9Fc0NloHzLd4ZA+tTC+cYMhv/nNJE3sYpp6m/au+KfoJtbWYZEPckhUF0p7MOztBwlJeW
	 xWLqMB231P3Hc/TbUkjfKgjO7oN2tVhVmkDohDZDHSo/lDMqBTbkZ7raIWKjMBEuXwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nsIowRd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE31606A32D;
	Thu, 12 Nov 2026 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsIowRd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333F81F00A05;
	Thu, 12 Nov 2026 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474230;
	bh=WQnZsJLH2M1dTlVyLgeRf55jDtYtcurGIQfRD7ez1uU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nsIowRd/5N1YLDeHmfHPiMGlzrFN2dGE2GgzLzxhtfAivRapUQJ+KGa6R/M4zAF97
	 8mmGmoPhVs0e+XTfOFfgyOvwi6ii1WS+hIq9K9BdbaVTta1pDBhc4IFDzkAnPBG74A
	 yqSeTerwr0Mbji8FX0ZjfbGOWystLGKVp77SHvzHIlIkkIEE4F5aL91TjQq3Tegsuc
	 2wp+HnxFhV/Z/+hBk/zm/pznIVxrWAuvTFgCZsCJ/XFp3ZDkdSynv5mv5Lo8Y6BP59
	 wyDgKwxombqRHlS8k+BM/m1HDL1YWC0TSxynkv1ue+kvrVbnybhT5rur9/zvgHvAI1
	 kfuEQmox4QlwA==
From: Vinod Koul <vkoul@kernel.org>
To: Michael Burch <me@michaelburch.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
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
Subject: Re: [PATCH] Revert "phy: qcom: qmp-pcie: Skip PHY reset if already
 up"
Message-Id: <179447422684.428158.9271110060803827650.b4-ty@kernel.org>
Date: Thu, 12 Nov 2026 14:33:46 +0530
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
X-Mailer: b4 0.14.3


On Tue, 13 Oct 2026 09:22:49 -0500, Michael Burch wrote:
> This reverts commit 910b828b22b7b91054b3bd4be676a017444b0e00.
> 
> That commit skips the no-csr reset assert/deassert (and the 200-300us
> settle) whenever the bootloader already brought the PCIe QMP PHY up:
> 
>   skip_reset = qmp->skip_init &&
>                !qphy_checkbits(pcs, cfg->regs[QPHY_PCS_STATUS],
>                                cfg->phy_status);
> 
> [...]

Applied, thanks!

[1/1] Revert "phy: qcom: qmp-pcie: Skip PHY reset if already up"
      commit: 9a07dfa7f6fe34e230de183c02a8180529091649

Best regards,
-- 
~Vinod


