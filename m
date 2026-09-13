Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FF38E8DC;
	Sun, 13 Sep 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296988; cv=none; b=Qyly4BlXUHP6ZiD4pp7HfxxCtR9S85c7zS52W0FpDaI6t0xHiUVNhI3GHCZeZnIhM/5nvHnu4St+MOipbdS2QTByhOr0oehJbjt7wxFT48YD7POyIp7NzIa4Y3ATiwTTUL9pab8Zi2MwpRRc537DoZ+8k6N9WqU9zFfxegvB5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296988; c=relaxed/simple;
	bh=DkYudfRAWYULI4l2ud6apHWGyNTThqZZabQlOBJNcI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D5BgALuKO+/1+9V5sR3wo9UB4PBG3BMROM7mIEHX8JV2+tksWFlLf2MrCWtzCg8YV5GsDfdV6dXfiqfUGU9aHp9olx5st5p7ssUhVX/wtPIeZqYYq9gV1lmcg1mYvHoRUYKvhDx5YuD+V/SmleK9F2YbeY5mcOfFjBmn8hlYvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjMB8AUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjMB8AUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7D61F000FF;
	Sun, 13 Sep 2026 10:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296986;
	bh=LR2A0Swu9+UzeDAUKc/L2DdjU8RKz9nn4+AWjlmEqkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fjMB8AUdSITAF7nA00nrqb7Ty6ZtwllLb6boF66Hj5HGG/ChDxWlFrf+KNz04LBVS
	 r3BKs+CUTY8kO4ZwSPTARfJghGQ/zGwI3jaPLlc+RachUlBF7YxirxP47uEBElTJMN
	 cvMJR5uIFfZmOFDv7a8rN1Av/GaD/KHYO32q7KrVA2sZC7rFBpYGAjnzCqmCSzhbnJ
	 Q3CGLYaa+F4vBrYVK6mMEaUk2wXap6yWeBnP4tqreF1JkmOemj5q2AwtenePglyCyE
	 tWQwVbvGeEYPlJ4fMBob8vmnYnmqK6fNfxa/4eq67P4Io43xE0QxAxUjuGNNetLASE
	 nXnJBU8JAepyQ==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/5] PCI: qcom: Add PCIe support for Shikra
 SoC
Message-Id: <178929698100.215437.3521119233132524977.b4-ty@kernel.org>
Date: Sun, 13 Sep 2026 16:26:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 31 Aug 2026 12:56:00 +0530, Sushrut Shree Trivedi wrote:
> Add PCIe support for Shikra target, by adding dt-bindings for phy,
> controller and corresponding phy & controller drivers/device-tree
> changes.
> 
> Shikra RC is connected to TC9563 PCIe switch on all three
> EVK variants: CQS, CQM and IQS. The individual downstream ports
> of TC9563 connect like below:
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: sc8280xp-qmp-pcie: Document Shikra PCIe phy
      commit: 0f654af456b5e347dd69d58c2fc6d7e17c36a6d1
[4/5] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for Shikra
      commit: 3518d967d8b64485f9dbf90bfeba1f341ef4c131

Best regards,
-- 
~Vinod


