Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893765;
	b=hf7AySnngbDwjw1tHN7VnSBauIinaHBkFfgY8EBcrOPgWmygpiM5un9SAe9+8vIJwjVY
	 5armSP55iKJ8maDiJkFNhxUMrfskihDC4G3qyapWWFJIi5wR/zZuhEoizfIS44CEdIjg/
	 yq6kC9mu8k/UKjdppe+20GdGUL74LCfGpXX0R5RjkKmqmpQRyvQQVhdBCxLuntrWjD8KL
	 P+W5yMaBHwJLcXh2X93SYoaA8oA2jqZnUcI8Sg8w6lHAEOW2YSUFFEw4QPlX87AI8D+vG
	 YWk/wKn9r7C3CIPAl60S55jwkfZKqCDQ7bBJeOswdDy1r9IvbaNR73I7URHKB5CfvnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893765;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9zFz7+PPYVZJTQ3/ZpvUrrZfGmrftPk/bCN7gEvbSq0=;
	b=AETtiE/eQPohPq/gs3s70KXZTNpQrB17f3fccPMcsVmdhbOLDM3xP6gILebiPpcujUlQ
	 1funWpm50W0hXZPhjruSPizaBkBzFKwT3is7lmNcpM0IVGGRzO1UA+oUXNROJJEyzagTW
	 qevBE+wtkNTD+xhihzA7PJGh1u4bItEb5Y2l3xV4WN22Le8MrSwzvcUHzfleflM685/c9
	 NFPtOLAe1CTQRZeorv8H0EQ4zQMGT4wNIZqZvp7zFF53+Ay2qRo/xyFTUECA2a5QqSLwR
	 /EorLSLSXZtZ1ciusjdDu7YNvNdn57rtB9gw6S8zjfyTunNA+kL/ThyNZFO82GAl5aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSNdrXIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18C60A2604;
	Thu,  5 Nov 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSNdrXIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ABD1F0093A;
	Thu,  5 Nov 2026 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893765;
	bh=9zFz7+PPYVZJTQ3/ZpvUrrZfGmrftPk/bCN7gEvbSq0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OSNdrXIGBDn2Is4O7siYodKnF6Iu1De6KbdaZKjHTkJM55KXW2LoPCLXiuY1k4SiD
	 cX6R4uzXZ/bQ6se4qLTfJ1nhHuJA4U0uZt+gbORDJJlBYEgE5KMznliYKl5op0yCAd
	 c8o1ZLZu1u0Hs6eH3LFAnYLgj87vqUcRTVMkj5J41L+mZx8QWKcDszqmw/6Bdcts2Q
	 ackzMWlpsvbyTObYJFhg0ty/pn+3AI/KBRUTKR8F/baansJZo1dQnIuERyQrj7mIDU
	 FLaICm2DlhkRdbglE2eikwNh/f+5vXkYZaLYta8UCD6RTZm7ocmh5ouwCUUuRGPfIj
	 oD5k9TgfJfpLw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261104113235.1634024-1-peng.fan@oss.nxp.com>
References: <20261104113235.1634024-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] PCI: altera-msi: Convert to subsys_platform_driver()
Message-Id: <179389375533.20463.12488111572193444461.b4-ty@b4>
Date: Thu, 05 Nov 2026 21:19:15 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=329;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mMCsj8y6f7x9ED3OE/BGcTQuk1Ei20/hgMPU7FSA6LY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7KWEShu2lKVP4pBj6iLuhXI8B7hRgDCS7/Iu1
 PldLG2B6vmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauylhAAKCRBVnxHm/pHO
 9XezCACLd7wJs5byf5/72l58wzI5+cXNFyMH/qLRR0Id5b4Qjp7XAe4QoTSOACSo0th9L1d6ROY
 B8ddbpInDoId8NZ0ZVz8WObLpudXQKfoxlEea7jkx805Cnqt5Un4wEcvHn/Cuq8Wv1flmwGDuQL
 LNTLMkv9dqjDiPj5cYWXwSnqd0v10nA7A2r3cos//M/8grFVO5G71jkr7cLKX9jImw9InQWLBfT
 HnJ77ns+7FzfMJ5CauwLH9GXMYZdaNGKGxTo6gjkM40WNj/pbmSYd8bibuoy8d9xvbGash8c/Sd
 RzW8M2UzQ6M463QFnyasL9d1vQu/1JnvC3gyZiRRTvO8A44Z
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 04 Nov 2026 19:32:35 +0800, Peng Fan (OSS) wrote:
> PCI: altera-msi: Convert to subsys_platform_driver()

Applied, thanks!

[1/1] PCI: altera-msi: Convert to subsys_platform_driver()
      commit: e5b8af7c98f184590b82d505f8ade025ba7cafae

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


