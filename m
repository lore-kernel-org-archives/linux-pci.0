Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456143FF88D;
	Mon, 20 Jul 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547822; cv=none; b=pLIcvRTEkqRSEXLIx+EVzYUw5ojs2/fNPfA3ljEiWHhVTx9RQE6vsQqyW8sujrzPn4DV/zBVvbDQz5OtB85Z88jJ23CX9rSu+qQombHtjzrBfVuJkZTKa0dgWPhl4sxcUeQ5VhorpWWJnd4VcHzbgY/LiqXneexd1SQtqeRA9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547822; c=relaxed/simple;
	bh=kd23Wt9l1yXTtVitaC/Q6dLfJbzZxX63DPLDDWMylv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DwiGYsOCNiWrOibQut9ZhnkG43/wHlN6ZJ/IxerWaRbJq2hMrayyPL5KdMGAOZjiPw/Wsu4EKP8JhHJPjy/yMqyGKYH5pY6JxaKOnyqQ2zNMJtzT05uJT+mhk3mFcqiyqzdxUPLO59XKvMIATv3kIVsutQFYXnh0KmDD41wLO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlLL+xWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlLL+xWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037831F00A3D;
	Mon, 20 Jul 2026 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784547821;
	bh=pWL/barBtInChl02bEndoQ2DFelEZZZkg+gCxWYVwpk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UlLL+xWkGRdTFUk8ZiUPuJp+MT6KUB0KlvY8qPiQiQ0PeN0hGkf8+IAbV8jjNL+vu
	 3oHtXNt6Fjo4stwMoP1tl0G4nVnR691ovAQMC4/t2+kdyUc/a4USDTX1TMCcrtAWXA
	 Inbbtcmavu/fHSb+bfZklOeK2Y0HJbC8LJOA9Y62zFFb6VVkIi/ArkmAPr+F8DOZJo
	 1KIxafyRWb2uAihkiwsUnsepzP/QAB1iBg0C2QYgpKmemfia+xKalXa+PUHnEFHkYE
	 MXd6eiKLpmU//wPA/NSH6ygNwk6zQtZeUB+gOc7yuaILWFSt0jEImpcopORfmhvF/s
	 5Idv1tcVjuziQ==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
In-Reply-To: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/4] PCI: qcom: Add link retention support
Message-Id: <178454781557.1388616.15635571686533105234.b4-ty@kernel.org>
Date: Mon, 20 Jul 2026 17:13:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 09 Jul 2026 12:05:15 +0530, Krishna Chaitanya Chundru wrote:
> This patch series introduces support for retaining the PCIe link across
> bootloader and kernel handoff on Qualcomm platforms, specifically
> X1E80100. The goal is to reduce boot time and avoid unnecessary link
> reinitialization  when the link is already up.
> 
> We are not enabling link retantion support for all the targets, as there
> is no guarantee that the bootloader on all targets has initialized the
> PCIe link in max supported speed. So we are enabling for hamoa & glymur
> target only for now based on the config flag.
> 
> [...]

Applied, thanks!

[1/4] phy: qcom: qmp-pcie: Skip PHY reset if already up
      commit: 910b828b22b7b91054b3bd4be676a017444b0e00

Best regards,
-- 
~Vinod


