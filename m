Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521133;
	b=y+7/YNh9jOfLzKaK8qzU8X+M4DrYsMIWie2httB67ZNWP9tYwnSAqLdReqFpFcagyYBc
	 HhD6OBU7lrRb9BX1Wl2hcF5HyBimLM92ETcUd9HFh90IMEyqnHV4sAQ5rqTGsrb98dhjk
	 sT0Xrq9K5sKMP92ma1RdfY42ZeibSCaL6sn2hwEe4G7RX9zenzN5yyHqnvK18m3DQZ/Oi
	 HIdBjH7hyqnLyd34E6nArXnK6zSG3Y4pfDyUO+lmAHmD/i+p3a4dw30IbewCFtfiOwaEM
	 kR2rVxq0eRtt1RQLidfxuL2PaFCYBX7PHnsxwICyP7mOm3lAeHgU9raCJX/Fmri1S/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521133;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=6fKmbn4U8uFgEHsJDa9xvCQk5gvh4Tf7oN/Lic3t9Ys=;
	b=0ANesMSrGbMtvubWiOERj8q/tK7mC9kuwhknAfolLosb6vDcmIYeESYlhkGYH/0M0/om
	 nfL9JthKHf+LjXH2eNJMA8P3Qi5DWcggV/WpgMfpNgqxGZUdhITa3xDV0W9Z8I897vLIj
	 Tutmohsd8qVk7hiCI9E6QV1aEANokz2o8HYuX5BnFG2J/ow+O64dzZJcX4iBYCKVLECd0
	 JoUydbG8GmlO4CFQLojBQz34hSn3qwnvVvR9TR7tmQg77r3eFVKDhhNxnwr5Z3zSDpeb2
	 wzdn8j8yjAXiiqRiI0ZPwOdJvXnmrSjT7XUJAHWr/IeBIHGUovuhJWyZMgsmvlzq2iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbIV07jc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8635606A321;
	Tue, 24 Nov 2026 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbIV07jc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB28F1F000C0;
	Tue, 24 Nov 2026 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521133;
	bh=6fKmbn4U8uFgEHsJDa9xvCQk5gvh4Tf7oN/Lic3t9Ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EbIV07jcBG/0lZnyO0vieZAOyDaOXXVD8N8ZdH1F5fuPk39DBRAXUmsygX/CKbP+f
	 tuv24p39uayht1ehUTYUPVxB10hjlaxoNnDCSpF4jkKoLrY1f7qYJXY/8oE8av7RUh
	 Z5l4JT4YwNYhnItWXNFivPS+MxIv9ETeFcfHFLYj/ctfGw0URwgw/knkUf1db/O77K
	 m53yAJgXCjRb0bLSXAEREZS6nR+kUI0TCIisTo/rwrN3MreF1586oTexR85f2EvILH
	 VMqNrRpSL9pth49cLUZ2+PLF0R+Ds48VWpPLet/QtyKfrg+ngfL0KVDBSso5+p4Ncd
	 nooaBqKq0zelA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261109195206.913231-1-robh@kernel.org>
References: <20261109195206.913231-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert HiSilicon STB PCI host to DT
 schema
Message-Id: <179552112944.34028.695689141960169137.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:52:09 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Mon, 09 Nov 2026 13:52:03 -0600, Rob Herring (Arm) wrote:
> Convert the HiSilicon STB PCI host to DT schema format.
> 
> As this binding uses additional vendor specific resource names, the
> common dw-pcie schema has to be updated with the additions. It's not
> exactly clear what the clock and reset names match up to, so it's a best
> guess.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: Convert HiSilicon STB PCI host to DT schema
      (no commit info)

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


