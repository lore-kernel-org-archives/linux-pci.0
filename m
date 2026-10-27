Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101818;
	b=WMFGLTK2R8MI4cppWoLlFetsJmnUaRSfEoxQlRZanXXS4vuY485ZEXH5x9q86Lcmkr+R
	 /KaU8yVoH6iA4APThOY+8bKtR3b+N4RIJ91mKbkYt88elSXwnPr8C67lyGe3NKgN+cY83
	 DiNVhVkQ7A9iQQLSBorgv/ut9pWxMitclFH+oJq/IbFs6sRg5j+B7SfiA0OOciCXsKl2g
	 ta5GXD0VLHIBOpm2FgXOlKKrnRZTR8I/1TmgPsrAPcXp3ZqfNPiwtowpgoOeDv6wS4rOd
	 FXtT4Ti4NqRxsC+bwEpfbGQiiaCE94Mr10C4YbVBQ5OguRyZcAI+8XNBvRi0KQ8IIWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101818;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8Pox6L4wQ+PxjTQjIVCbNIBdH2zdMOEyFCO2vv40EVg=;
	b=pp+SIkO0YPjaqid78aFgUzo9+ze93upK+B/N5Sj/LyTEb6ciVYI+6XiJGawKw78AV/P3
	 kPgbDzDueL+r7uAa//Sz3BS/De767v5UKVpy+klT4fHyWdnxohd7EDmKhOvE4xAkAZteD
	 LtXZiv3muyeD3COueEOtSBFvl3sAUTcVF9CyPAtXfzJX2es2SXXo33c2rrjt+cTwK50dW
	 vkqQjOxdsKdmd1MvjDr6BjYxFsgA1VpQ/TXoSGuKh7exIOLEJBSvffTMHxquLA6VYaWXw
	 TA76ygOkc39OCz4bePnuUlkBwm20wTJxkGh3f9jKRjobjX/EvA4hGUk5OwX/Vx9IKYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsHHqYpX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A8606A321;
	Tue, 27 Oct 2026 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsHHqYpX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125611F031E0;
	Tue, 27 Oct 2026 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101817;
	bh=8Pox6L4wQ+PxjTQjIVCbNIBdH2zdMOEyFCO2vv40EVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NsHHqYpXd5msR9zaaOhwOo6UyCW063Bia4SGHgWuDKhf1+KoS/qL+TijXekj0mw/W
	 ZEOR924III+3WYDmMBGE3Gtqf+BPP74P6Ga9f76aqftd+jEOR9cNxrCjz7Nuf1ufc9
	 S9aD4uymhsn0IYxa3sEFNSSGKOUH8aEEs6bjNYZqWpCQabzwQ1qqB6sHjRnfpfnisJ
	 yrGZjb6CIFG4VG0QksUf5qdJqAEGdRWU25ys3VV3P0c025bnKaP5TfIprol82herAu
	 GkwT5FDFmOk5j9ZQY1IrpjGEqTaRr7mstA7LgFQPsMy8NYPOMPjHpUTM5VykAu+jyf
	 NF7YdYgrke5qw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuho Choi <oss.patchbox@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260924010418.726980-1-oss.patchbox@gmail.com>
References: <20260924010418.726980-1-oss.patchbox@gmail.com>
Subject: Re: [PATCH v2] PCI: rcar: Release temporary device tree node
 reference
Message-Id: <179310180828.5889.10256778854026128027.b4-ty@b4>
Date: Tue, 27 Oct 2026 17:20:08 +0530
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=330;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mnZxg1es0t8jDK+5ygiJyrtcXXWqwNs5TLiPImjvoyU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4I/1Yio4iVvpt050d2evAWM81+I7FWBtENDj0
 CSBW4PI8kaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauCP9QAKCRBVnxHm/pHO
 9W8yB/98em5OFW66fxPSxXwM817NNPhKffPJWY/1nmkaKvu5V3K0xvjXgz70SNLdyATJHl85f1Z
 aM1dJrZ5/BsHb7WL+A84z9zkbvyjm3vHpsKAifnYb48yV3F+B1y8FXVr6rhBaHYY2HH8bb5XLMW
 8z6BMC5XjMyDM1/ujsKqlKQwVRMT3K70QmJR7Ytf556Q0iGJYsCSAgpHrXZlPMFXIO9N+TVnfU6
 gf6HUdcnm/0qq67u6G4JX6rEEgn9CrV1MgbtQasUJqL/V788LrCtJo2DCt8Etsd7giRYDXS4vmh
 kpuNwt/85UqODgUcTQJ1r/YsdUW39V6Qm0ajX6gFH/my4+2f
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 23 Sep 2026 21:04:11 -0400, Yuho Choi wrote:
> PCI: rcar: Release temporary device tree node reference

Applied, thanks!

[1/1] PCI: rcar: Release temporary device tree node reference
      commit: 186da40837a4a2472b8afbf7dbccbe1b1e0f16bf

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


