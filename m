Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101683;
	b=ES99uNIiI408r4/kKOAIBbK9YsQYejsXhOOqaD7blebha1vnRFdr0u+n+XWHmdOGxx9M
	 CPhabMgxnOwFppl/aOSsiiwqSZy+Sc9DgzVtT7Lp1fXXGIpUqUWg4/Rcdx0zgng8qvxu1
	 GRlV5CnfnL9R86uZX86kqDdJpuHOycjbfCaV2nZcBnFeZhSMais0rjbW86ATnPAA457wF
	 hUOWoej3qS+U7fNAnEoINOWiylo6ibOJFiqGowAlPCQsJ2aEo4RiyLXezu8PnEfT455UK
	 TNy3hC4ttKdjHijVWf7ezb9+/BQeg0LwYYgcmgs4H0xA2WpV/4PwZjfAFFS3NEkoL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101683;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jP5R0hiwF8cPUc5aa7ofvcurmINMhxrJaW/fyXdFY8M=;
	b=x0jxpdDla25dLhhijEjji3bZXSrAzr1CeuJvlf83mnG80umdZyFrM1AmgM+5dzFzKvNp
	 1ncuNDuNT5tRv2hBrXboVJC01KNsct8pNiy+RKi9yteME94foA3Cjp6p9m/QWXK3oWIBp
	 Q6253MtP6fDp/+McLBSMu2TyAvTYKnbrgtBj7R1XuhCwC8uRjZ3yKQM3g7CtzYPg8NjaZ
	 p4FSS64wenxxXpIKp/j2/RnuIvnk9oLCWOR0J87tWNcTTMzhUGnRksgo/T5cDhsSVbVX0
	 lR26NuBLIWDB3d4WS0l7oSK2a8aKF8oJZN2oOFaJBxBn1G/4eskDuXyARiEeV2SEm1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nwKezIz/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E204606A323;
	Tue, 27 Oct 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwKezIz/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53BF1F01828;
	Tue, 27 Oct 2026 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101682;
	bh=jP5R0hiwF8cPUc5aa7ofvcurmINMhxrJaW/fyXdFY8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nwKezIz/ZPTcw2UOCvuBX2XjLbhwhV7tVYqBPun3BxxdfGxfhZlkqFMHoTxdxR2ln
	 48yDLkVjRkj0WoHExDVhJtp9TLF7DOZskEWvmRkWDKAtORUekwxNrdYokzuWFXUMho
	 +mLSCEmIvqRradZTCiqXdsh9scoq2IETQQg8d0QZQv9hXLRFMKPQ36KEocxPLCoLAR
	 ggj0QEJJY5UZsBeJjEe3qdLTQwmEO/0fUcVSXu8v1V6AaeQG2x9dpMndzZfJhexONp
	 1bH0EueUQnxjVhi+ooTKT8JuQAO4JPeuZ7c2lNLbB33ZfPNs6x4djOX0kh2NROXplx
	 fRPWQKVINrTEg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>
In-Reply-To: <20260923180749.3906547-1-fuad.tabba@linux.dev>
References: <20260923180749.3906547-1-fuad.tabba@linux.dev>
Subject: Re: [PATCH v2] PCI: rcar-gen4: Fix device_node leak in
 rcar_gen4_pcie_host_msi_addr()
Message-Id: <179310167143.5889.3369983512237009866.b4-ty@b4>
Date: Tue, 27 Oct 2026 17:17:51 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=361;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=HqTG5LbYHSglUjHnKu6oj84sGwknU7rjDDCd8F+zNHc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4I9sNf9SRHJkQL3cylE0Fx61MgQ+sRWi4M3m1
 ERQ9PJ/87OJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauCPbAAKCRBVnxHm/pHO
 9Zi/B/9zK56Rs5kTHRqao00gtG2CubEr6QPNABOW0xCeeD4SX5ctZAQmGhEYyTvcRnvABSvjF0d
 LNGVcgGUI6I1Fl1MqjQyJkasJHq4Lhy7jAiPgDLgCZHdpA3GS2uN0EH1AlrLbtl1x5ZEhSBDkrY
 wpJbWqH2YFAe9yfccPtHjIillBQDyu/KWPmLyHqrikgH1GDIxwmQAZRO/sQJbbBQcN3LCnXgPau
 G0YbyiJkGZbmfFGcN9KNjVy+XOr7P/BGNOrBaU+ihu03pJXRGYd99FYYLv72AQsIdwJg56kFlFn
 +JerZJ/E2XRbPr6iy3T59IPk1TShdZ+Ec9W6PblJhFXapiZe
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 23 Sep 2026 19:07:49 +0100, Fuad Tabba wrote:
> PCI: rcar-gen4: Fix device_node leak in rcar_gen4_pcie_host_msi_addr()

Applied, thanks!

[1/1] PCI: rcar-gen4: Fix device_node leak in rcar_gen4_pcie_host_msi_addr()
      commit: 34fb13a4a9620658e43be79f818ac5c456402c54

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


