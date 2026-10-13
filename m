Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B33D4129;
	Tue, 13 Oct 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899296; cv=none; b=RG3cSvhNUFIRvPPq9pk6GYrKBqWW3x6njT5i97mHZ9ywvSl5SI3xdrUFXn7KO+Pvz2Y+EaOMV5rafcMdPdYLVE9qg0cwFYzeSdAJ92k9fGXrOM5qzi5Bxj6rWuPd7vRrVlu2EjbS+qyoQIHDpxRbNUBlDnBarAiXuJyt1GD0bpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899296; c=relaxed/simple;
	bh=amT7aqe/w6pa3z0a+Mw7PJPTPVw33fQVa7gOBdlrp5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dYKuM6dtj9sD4JWiwSyfBK1msYQcLX8fy/dtOXLVztLHaqqE3tJcnBspO+by20YiEfsDy218xd2cmm8bHNAY17tQT1udESN1pi1LGhVZ/UZN9lJjqaNg5qpBMvgjEs+P41ZyfRQQRq41b68soaLHWwKPEMRf714Z00+fd2KEZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqqqnXTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqqqnXTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB31F000FF;
	Tue, 13 Oct 2026 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899295;
	bh=MwsHrhWwBAqFC5XDIDWmcboOdLh7zz3XrR9XYaXosSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZqqqnXTXL5JQQBVpDNrKTM+tmsrFuh0quFdrhPcnKsyO7YbA+lJycODBdX98wdONc
	 xUDQCxz05TL7W75efE5ASsLNQRZLVN5/dBp9WD573ytfDG0rg2Gk6R7d3M/iNI88tL
	 RXJb6RL0tTmjBoZjyP/89KYnxPitqQKJ2XWJyoLAyjiE3wbbIVMxyquN7oWk7nKoNs
	 G/DNMOqBz69isfb+qUI0N2FHmmRXZndeYKJs8ErRvSxrMPnyE7FdVH504bw8/T3/9U
	 V0v7mrpEZLQLR7Z1iMbD/vHjPrNTjS1Th3v8OWXdvYA4WVEeKVP1iPVbQHnszEI5Qh
	 LSdKlEbgaI3Yg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
 Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1781622998.git.geraldogabriel@gmail.com>
References: <cover.1781622998.git.geraldogabriel@gmail.com>
Subject: Re: [PATCH v7 0/3] PCI: rockchip: 5.0 GT/s speed discouraged by
 Rockchip
Message-Id: <179189927768.12828.5970294502454132706.b4-ty@b4>
Date: Tue, 13 Oct 2026 19:17:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=mani@kernel.org;
 h=from:subject:message-id; bh=MJ2L3Ts8++Q18HVodqsi50qgRqQHnU8MLJbv9TbaZZU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzjaWuJsyJInKTko4kslC28gQaP58gTARVbj2t
 UDexrJ/9uWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas42lgAKCRBVnxHm/pHO
 9W4rB/9dfTBuarNvfVBSNUuYe2/Gdg9P5KVqDROq9kkrp8mxE5shnJedONgaWeuv7GI66sIjIjn
 rD8FbCw8pRxng8BoATEhuSMlZq9QKbV13RebbzDMgpYoPdBjw1frOv6uMUZ6kgyMtdpgUZYOO2C
 6W410/kMupZjqqanx7W73Bg0LNMWuga+2rwyzOr9Rle1AQMco1hT/dcrVbMzU6NKDOmENnyC2G4
 ZFyrxo0ZSnXNk044fYyMemjU2ZwBwMiy3hR6fO4hCWslzj52aK4AN++wb3smZb7GQGuT1yVJU2B
 NGzRdxzYXeyLJH+Yber3rvaSu6wuzO3i3KToeCmVjn3+03YS
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Tue, 16 Jun 2026 12:24:48 -0300, Geraldo Nascimento wrote:
> PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
> 
> Dragan Simic already had warned me of potential issues with 5.0 GT/s
> speed operation in Rockchip PCIe. However, in recent interactions
> with Shawn Lin from Rockchip it came to my attention there's grave
> danger in the unknown errata regarding 5.0 GT/s operational speed
> of their PCIe core, including data loss.
> 
> [...]

Applied, thanks!

[1/3] PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
      commit: 39f89dde0a76b229df7eb356aaf6f444b4f8a636
[2/3] PCI: rockchip-host: do not attempt 5.0 GT/s retraining
      commit: 5988a53f5bf758b2d41cb6e0832c19b9692c76d2
[3/3] PCI: rockchip: drive at 2.5 GT/s, error other speeds
      commit: 62843031ca1f11d1b8e90e7f558c1b3c4cd77184

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


