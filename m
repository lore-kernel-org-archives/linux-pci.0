Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893339;
	b=3MZhaDpPiLl3ltZ0Mh+NHj/zuqf8JJ2XI6RvktS1iDygX5bFgI4T4w9uGE0UqQmFkhI7
	 3wEeXdzowLqz1puINCEKRbWvm4jY0c/6DZualzczlkmzwIv4YRbYa79p64hihzJ6P+8tn
	 CMMAmm9VTFHBP6TXO5PH5BmyTHNoIzhgdrlYIjL5FumJrElP0oYwkm//BjaWX0UOCsgCN
	 Xi1gi3uS4ivH282zjVej/UfEwCMoG/Bin1aS3AdDmG6yVmdSF602KaQPHbOX2wJKGd/Da
	 7mrxF6xlT/7+xoqn/pLCEI/nm85t0uan/S/l5pau1jzpL4chaAE/sk+d3bNQ16h85Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893339;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1XoxhZQuWCpWR6i2ysnsmoZiQuV1dhOeh3iEX2MAi1I=;
	b=u9PeVt2sQRhazqTgDhuElQuRlY1Z/KdoIpjXcbfJllbtJg4OCerAtAK5Mq8aYtnN4ni2
	 HeixXd+1ysWujX7MHSNW8j76SI6cR6+1KMs/BbcHFaIVhqqKlr2DlvbgzYUEevUJe6+rj
	 UmjAfTGrRl1m0C7q6Te8bN0qKrxLa6n3vXQ2dYTISAe3Q7Nfu6hTeOWG1qYEsUOC+uddv
	 jEkxH+T7oURYL9aqrmjfQt4neXWC4q5NQ8jUJqxoeyzzrvJuFpwpzIpb/jspV8vFqWiQB
	 WM5k7QomJP8f4Hru0Kb4PWH35lZBOcEVL1RO3uqtwpaPV+t6xSukQkFvfuRlyumyNQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MX4JOnf+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68D606A31B;
	Thu,  5 Nov 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MX4JOnf+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC601F000C1;
	Thu,  5 Nov 2026 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893338;
	bh=1XoxhZQuWCpWR6i2ysnsmoZiQuV1dhOeh3iEX2MAi1I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MX4JOnf+Hwpy/aRs6nuA4WRva6s4PkvH4OvbOFLujC4MtleCBbI+uW4QEP/D750+p
	 hK2cc3eNZSjTx/+8jXUvjNh1D+fuOOSbryjnYemuR/+l+79yBy15SUffVorif+vBmI
	 wnrruQyJva4GS2eMnlWo5lReuGjGGmVVJk/4C82mqkmw/+dg0TZYB6ZNmPGrYbLEi9
	 4CO3lHVaDaqgNgz+hao26qu+Qao8PaMzXCSpxDiASw1eLIm9gIaEt3KQOzWjZ7R6oq
	 hL+mO1Ni88TLGQErQPxpt0uP1QeZIOP1zuw3Pdao5AUSsFrOSPIDs3Bm6lXTgoW+sd
	 tw2ICX7E2Dojg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Diederik de Haas <diederik@cknow-tech.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261021101533.609118-1-diederik@cknow-tech.com>
References: <20261021101533.609118-1-diederik@cknow-tech.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Message-Id: <179389332686.20463.1542966785422218800.b4-ty@b4>
Date: Thu, 05 Nov 2026 21:12:06 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=315;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=yDeRkgBLXRtw1UNPYCqbWGAbbL0ZJAQvlVqWUU6oUNw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7KPZMKvYH9neUuYEjJ6Ov4o45k/neydHQumCV
 gVgO8yyEgeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauyj2QAKCRBVnxHm/pHO
 9aN1B/452DI7Q5hk9krngeRYwL5+6KqtGh7eqd66KN7MAvp25vFwoXR/eDujdU4RvXYnaUjcvto
 0EVJYXUEVO+FgzWdft+YTXpCGvGiGEtwo7uY9XJ2zucTHi29KFwgtJ5k9vjDF2WmzOBxgAtrYH5
 22c/1uvuVQMl6rojgauP6WVCZTUU9S+KVbKanr6N93ncBS7RzAktJdOuuIabj6RabR96q3CG6ih
 JpeJ5FVzaaNS4gxYZYSMIXC1aB3HrzsRPoY9m6MswkuNcLRXoAugbLz1MBfPaJaCCawa6+RmLDR
 b4tyXfmLMrxkLTq3QqeUQJnkWXf6fsLA/gxk9EnLfL2tt12W
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 21 Oct 2026 12:14:57 +0200, Diederik de Haas wrote:
> PCI: dw-rockchip: Remove redundant dev_err()

Applied, thanks!

[1/1] PCI: dw-rockchip: Remove redundant dev_err()
      commit: 0da078b4bdc56bfd48bb52fa64809942f771bb12

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


