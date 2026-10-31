Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431366;
	b=BIy4ejSeXBrp+sTeZJGXfDx1NpT4kocxCZKDfNH71Fdno7PUOR5Lp8MJIFja7PLg2Mfj
	 S145uh9slEqiXkmavALJYfZIS22f5sfXhKTkKepoLYmQ23YcIPe51SKf/0LfIOlhrLS20
	 q6oVGQVgQYckdFhdnH8IknZWb/JNbSzy68iYFbePQkLO13TVGSm+rhgenM5J35i8SM6vV
	 JBtnWAl/N+//qnbEb8tVPrj9mHXj53BWtyveweFjFzeKQQvXKxfmiShslfxDIJ2X3g9xY
	 XQ0mVI0XyVi4aLj+MrLMJ8ASJNk16uqyu37o/oGK3PasfYDHcCO48HHLvLtJAkD0XBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431366;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5YS451aH7BjdUiL4Cdv8gmc07Um4Vxfbtd1cKp8cA1s=;
	b=qRWAgStLul7nC2WpBw9sAqhbHFqpOzNqJUjngZW29t8gMzfgRByHAmzC1gl3oETdHcB1
	 bRrX3P+UFyLfUIOEJgSoqwNm8ZqB5E1Uai3gdGaR8n20Op08o+k/2FIgUJJHImqWmBOiv
	 Jqw3fzj8KgzvxKC8z+EYzvNnkToq4basnJWw1x+DoCFfHPtZxk0decnZjkFdddyvG8og/
	 yOc8zNna0feCOq8KUS2V4Qyj6bzfdw9/0j6HlvbThTgqmvMElfeLHgCN2GslZ0O82fHoM
	 y4KFQg9LEapiW4lHAqbLu0faW8xavMk3WMlRu/TpOhW6YIpiWdlFSdSqZyLq6J0iqBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuRSeiEi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237E606A31A;
	Sat, 31 Oct 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VuRSeiEi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4211F000C1;
	Sat, 31 Oct 2026 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793431365;
	bh=5YS451aH7BjdUiL4Cdv8gmc07Um4Vxfbtd1cKp8cA1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VuRSeiEidT8Ilk/Ye7plYe6QYxyIXcaPjIJuHH9S9XB8xrTVh1sAkiEbSSv3edT/R
	 wlIgUweauAiGkQry3C9uCdpqlbefPFYZkU97seHTFzNC60aYEAbT0i0BESyNe1Mzn8
	 j+Va0rsjO0eyjB5v5tDXGl33p4jEfIE0IYlac+j6e1bqHkyFSMICcd8FWxF9YzJLv3
	 JQ4anw8PLzxyBOQSjuXimLtPl38gezPWRH34ftAfMFFbwOCA33dmHOKCVoV1U9VKN9
	 SQa17H6d///AD0Dpu2uHOK91QpHZV7hKmy8PlJYTetzfxMHaKqIwcc8gYOyKuSOAku
	 ae6fhC0zwRbTA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20261017171845.225769-1-marek.vasut+renesas@mailbox.org>
References: <20261017171845.225769-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] PCI: rcar-host: Validate IO/MEM resource count in
 DT ranges property
Message-Id: <179343133806.4244.3780785790526005076.b4-ty@b4>
Date: Sat, 31 Oct 2026 12:52:18 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=358;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=dVE6tEVmuFHX+4AIwK5e18OMgpp2JH5syzMLOzqC6ug=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5Zc5z+8PfoQqPy+RB2bMnEhIYaKda/FUQsVmd
 IhC7LRwQ8uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauWXOQAKCRBVnxHm/pHO
 9X6aB/49YrBp/hA5z2fQM8buhDGgAicYNBFgA4l3X+ZGWy3Azx4jMUCRNyLIz8PYviCVZsntYb5
 HXlCGIIkbBVKSAaAme9PYU/RtOG/NBPTFBSmjkIm1sB1JsSgNYaILxWODZMWa+0R7vl/sq7sLbi
 mOoNZC/ljPJa97TxbmMW8wAXsiIPUNinlP5vmV3BoSAIDQTtnHSWQT1Wr1HnS6ciU2vEFg79gtt
 vnChbd2bi9/Kquv93/GQGHYeRTbLaj2/iBWkObO1vR6w1xVck1WvGsC00k/PK23UNB8apEI8hbT
 xdl2GOMWPS47eiZXq/2aZt4vl0n2a9uZv0+buSeosoY8Ffs0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Sat, 17 Oct 2026 19:18:10 +0200, Marek Vasut wrote:
> PCI: rcar-host: Validate IO/MEM resource count in DT ranges property

Applied, thanks!

[1/1] PCI: rcar-host: Validate IO/MEM resource count in DT ranges property
      commit: f2cd763d71799392b2c500294df4c87201f29047

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


