Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521228;
	b=4EHiEGh2ywBfEMc8Dmkmpl4NIkwC6yv6FFdAtYukrpKqypfeTPcH+pCckyGQtgj8/0f5
	 YdjZIKxJ4mtloVe5kD2vC/CrU0DqwwV5AfaLVtvvjAeQuXiKTX2s4o136ANt0rCFKd3QU
	 CkYJdBXsM/HTkpdB+jzdFKbsOMXWh278SS9KKZamKtqggGEbSo+mIg0cmEsSratrItD22
	 t3flOGN2QUyTYxaXt7ofR+ZT72qOk1bQ8rKvUJgGW0J33wL+538bpEaOQSfvBRkpd4j0G
	 k5lV7W75aSet6S//O9pvtQuRUd+iGE6HYfS+wSqEWFe3ysO8CQvTjYWnmyrrqZ2wbFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521228;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=z4Y9dHJ0ZeVPS9YGhg84jRxvoO3miOq2kd20onnIAEU=;
	b=V3yJUeRte/7FR+3j1HurpcM/lRVJjLypvLs5zeLjDsnHeH72CwkTL5Ys0divijTaiLiL
	 oUrrGJrdQUV/jOC3JCw6gdC3cg5OCRHImGfJqxtXuHB+OQEBuhVb5hZsLEDWVaHae5e5O
	 CmvirVpAaVpMl/aAa2tcoheS6dAt1JcTgyD7tfVaIUIeE4kzE8LtXvLbGezO0iUtygNSP
	 qcpOA7Y5VktHJCyREbsue0WQUSekh1hecSy+mTKi+fqqRw/mRVu1Xe4KDyM+vcNLwHHKs
	 XkO5Q1UBq+wHhT+NYxvKnQdCw/yxq++aOf3wVKw5LmHYYFBbNlAN1/Xv8yXGwQcnjLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8DQrljj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34853606A31E;
	Tue, 24 Nov 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8DQrljj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25F31F000E1;
	Tue, 24 Nov 2026 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795521227;
	bh=z4Y9dHJ0ZeVPS9YGhg84jRxvoO3miOq2kd20onnIAEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=E8DQrljjt6Y9V0W0q/3UmGz40Z4NfF+SczkB2scmuxWSZFHr1krz0MSJ5KODrEWLo
	 s57LDSJqhEW+j1UYqHwNiw6c60ijJQH0vnoCjE7UIj+5Sz6kvr5xsslxfgA0Odws7U
	 T1Vv9fSnwkC53ovBZLJcHGARkwJyKpXBmyBigbFk5JZ5mBeb5OVbXqeAiqg5LUMby4
	 g7Xhm1igbfmpkS98mQARr4kvnrQ1Kan/W8hChUnGGRLlA8sIIbdIXxhCMLCRwKxyCx
	 94dgRARP5KhmeTRLAEiKDOB/W1COxoGKp08b+m/EiHrY1m/Sn17WIEaRMkULhGD0gk
	 HYpYa79TsSZHQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261109184948.477095-1-robh@kernel.org>
References: <20261109184948.477095-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: rockchip-dw: Allow endpoint supply
Message-Id: <179552122328.34281.17286958680139728283.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:53:43 +0100
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


On Mon, 09 Nov 2026 12:49:47 -0600, Rob Herring (Arm) wrote:
> Rockchip PCIe endpoint DTs describe the 3.3V PCIe regulator with
> vpcie3v3-supply.

Applied, thanks!

[1/1] dt-bindings: PCI: rockchip-dw: Allow endpoint supply
      commit: c72d9039a00dd28ce9f99ba73112c68ca0462b35

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


