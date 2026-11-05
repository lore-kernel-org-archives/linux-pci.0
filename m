Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893463;
	b=Hzuqeno2xp6U0qijrKEcYEPw58cQIbOPOcZHB7HzN4iFaz1HrIFX5TZEiCvruqNbJStt
	 tBrjriG865qRQUjt6A/Tlr1/mIdC/wHtg0YB18oxECTY3fqDirfQzDYilT5cVP8NfbcX3
	 RN4mG2lHtlWgcJ99TwW82p++45mBiv2imBoVbCrIIqjijttFCl4F/rmyBAMFXNvBTnPUp
	 yv/T5UNFe8oFE7GLpLLU4j7T7HrSKT27kERtH3oxntEgq5iZuUrmpw4RnWH5+vqko6CVE
	 1GW8hqeW0EOjIfyNycftfYbVpdqa9cGh2VVOqmShx3J0L2IYIZlIn/GIUs8fSQztJFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893463;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vUZYNYP+HlSxJDxKR6PlbRdK/bEVEhte9YIsZkClTjw=;
	b=iGBjQKr9Z2vsx/Xi76x1A/h1PX3V2jTl1TIutGtt4HEDzrGs77rJjYGKBdHGAKPU6JXj
	 zZAqZNuG9aWpvCO7JjsdoDc4f+sFUhBxmNZOh/wi6aT7tN+Wy+Odd+voltGZTexLB8qU7
	 jqr9/g5/hJJ3ox9Xa9//hokLNCaa8UC2CLb//Fh4WV+fgHkegoC4n8i4u6GgIwQylu3oZ
	 n59gCfJp+3ZPXv5X7vPWYKuFkHUuI/Fu+wPzN3tR2vdrUx7TBtkULf8dLl1jAoNDB4W+P
	 fRKOhN83XI5NUwGDH3q2o+6fgU4R+82VolTUBrIbyPJL7N0CfqIr/kPKgh3PiOtiy6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKlrWqyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C6606A326;
	Thu,  5 Nov 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKlrWqyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A87D1F000C1;
	Thu,  5 Nov 2026 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893463;
	bh=vUZYNYP+HlSxJDxKR6PlbRdK/bEVEhte9YIsZkClTjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hKlrWqykDo5Y6WVtvsI9GVmy//gFv5TKSkZjFcqR/LdxqQW8oa56Wk9dleYYfcTlp
	 yd+GP52ZyjFADjd9Od42iv78wUUfiwX+wdVoruTATiLZBru9/QjuNlafzRhMKjNORo
	 DMC5lnvRXi1fGN+VKhKNuQ47h/EhgQiNGgEuLagWeg3JhQn58jJiKa5A0IJ9frsOWR
	 d24QyoQx6LOMe2FXbCHk2HbujSJqNQm+USu39KqVrkLlty0B0IaxGvCj+h1+bDfM+y
	 /iIYj5qxGoHZqVni3SNekT+vvIMXYXD/8sG6n0aJ2sxi3SnF1ekVvBYQxnBzaZB5/0
	 z+vDKMrv3ritQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>
References: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar-gen4-pci-host: Replace
 sft_ce IRQ with AER IRQ on R-Car Gen5
Message-Id: <179389345264.20463.1333025624372387908.b4-ty@b4>
Date: Thu, 05 Nov 2026 21:14:12 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=388;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Igew3MpuryH+bhdXudZ0o4WGp8t19Sb83Yrwye+sXPw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7KRVI3QcRwxzJybG4KeYGMNfuZNBBlevx8+CJ
 UQvXQ4gKiSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauykVQAKCRBVnxHm/pHO
 9e15B/9/R0gbIwb0uTMPKubPnMWvMZspyoqIwBFHARMK4zGQEqiwroxSNW15pxsJrG0jWrroI3T
 /La+QJoMH9QXJjVG7tfDDrB8oJGxXTL2GPq7HtTPLoOK8V41itxkfMXrjsiadS8ZKwLe1IwCZEe
 nRbDFTrzEFqGh1E6CiVp5zK13oUXjaJ+aQSm0QFSJZ3GMRhRCW9Zv2ipnvFm2yjy+1MRE8jpLZH
 PIDL+TSDkyonurIv6FxpWkejJvLp342UMxzjRsfhr1gJEoYPZKIKGngj0ghFEBQZV5499NDagw4
 9U0J7iQPUkbXfWg9hTui6Rmfk4PtjgqpxDoQuTcC6es/ih1V
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Mon, 26 Oct 2026 23:44:18 +0100, Marek Vasut wrote:
> dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5

Applied, thanks!

[1/1] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5
      commit: d0373ae3a85d8bfe3f2e96f2d8acd2774b079660

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


