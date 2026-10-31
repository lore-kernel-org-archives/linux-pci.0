Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431490;
	b=d+yWuRJAO41E+HEZMtT5dAvQJC1/q4ldRIbchjmY2h1PqZXWANd6w8UGk2Ruhz9UrfY3
	 y31Xd6HHZRkCPGYFNchrF5++ha6mw6K4RX7heRjSoe9nE66+0yFM7oT6jSyRhEHMRBx6U
	 xeqMM/chNEG7Qs8X1UHVHe4A8wehlFaH61oQLWOGu4wVCSGXjk23Wr022EJa66uDy67HU
	 MIi9NWEKAYNFVct9biY1/ZO4QcpoJhBYs0VxYMltMUbEDpTL0th5+enOV6Tqu5rpm6hRu
	 WaGbIyiznnCPnPP58vPX8iKpK4FkHZjwJ/qzHhSPqJfV9LUxDUMxFTqLQI/7UTax6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431490;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=z308Uuy0CuNp+NrHVjt5QkqbLAOcCgTFjS7lHppI8DE=;
	b=R/DswqQm1uKOXb/FfqgDEwEzudghek7+BN+Mi/13LHoO6QJfgpOHI/NrJhBaQ2zxTmY6
	 mMIrmp+V+7TzV75uJPcCqR0E0gjP9TIeZbMIlSv1EsvdZVd8Yj3zH0Z85cqTAcGfMTde9
	 v3ZmEqq+CzqA+tsp6lqGBK20Be5T1mv5xguzaM4oZw1lYft2syXvtN2z7wHSmnlJb+Otu
	 iUejc2+DnNi7BQrxU6qFz2c0GyLCuSX3aWkMxgPEtJHKNKkx/RavVJsIWIHYvQ9BvdpPu
	 9Z5MmjcEcQwhcsSwImMA6O9Y/G/r1GLjrwB1F2vpYLsd4TkDm//q7ODsUZ2eWuHKcWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mArOBj9e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BB606A31E;
	Sat, 31 Oct 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mArOBj9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF271F00919;
	Sat, 31 Oct 2026 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793431489;
	bh=z308Uuy0CuNp+NrHVjt5QkqbLAOcCgTFjS7lHppI8DE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mArOBj9ebVmYSJXvxzakwhwnL8U1FBBCwqrN3/0zd2drpQSwkNNWjBSHdeIhDLNJr
	 5/Eky3ONzfw58n5Px6hZAvD0ZV4njcHOWjpGhkgVs5W8ulVdGkpB7WOBqqDWMlGUw/
	 UPHT3dYfyL4ejsEWMsdx1euJk3GQQo7TJI8vz02Ws6ZFKve8SA29cvRr4TacRHy3Tr
	 MDQMo1ciP0MlNKfBUgMfd0Zvza7dYe8V9EwX48YuZkJm5zFbkyTZ102mn53TINKVje
	 8xKuPS7AX6VNl/k4gotv2Oha8eBcFqreEPNUlx5hMuWwItYgUcc5pz/BN5GeQnpP6Q
	 eH8BwlBT+8OpA==
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
In-Reply-To: <20261017172122.225861-1-marek.vasut+renesas@mailbox.org>
References: <20261017172122.225861-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] PCI: rcar-host: Free MSI IRQs on error
Message-Id: <179343146971.4244.10697548642594569315.b4-ty@b4>
Date: Sat, 31 Oct 2026 12:54:29 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=298;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=OTmVYPHEflDQK8CNfMBEumrl+j3vcv7oQpl3h095BLE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5Ze7gjlO0+g/37XxgK+peM69ebiz9MIeNr4O6
 Zt94QVZMz+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauWXuwAKCRBVnxHm/pHO
 9evXB/9N/u8VxIx5Ia5fvvq0nbzIPVLoWUVGc1bej1CNRA/2EKTcHYyqZj8zuoFa7rXwmAcR1UJ
 hwPQk+XMV3eARtdY56Vrgzz2V0ZuOJITk/J+xLkoE+W1EVcfz9vT48IEt9J3/3SxZW+GXES6W0h
 uxpRViEbtAJgH9XHpq7xqTzXBI3Rq/QAAIFyTzq+HOsCumtQ+Y2GN9W+en5h+XexEotM20Ndkht
 qnM7djLhOwPsYNUYhFEKQnC2SqUdmPnHr4xU7aRy57DTw1aitWeDRm3+nnxZ+6IsTNHuIoe7N+b
 UTdRQkW/DbIEyYPpb36vK87kXqYj/WMuYsom53T7uEgDaFWv
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Sat, 17 Oct 2026 19:20:21 +0200, Marek Vasut wrote:
> PCI: rcar-host: Free MSI IRQs on error

Applied, thanks!

[1/1] PCI: rcar-host: Free MSI IRQs on error
      commit: bd3f9176579dd568257b6de8d7ba8f3ba2779028

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


