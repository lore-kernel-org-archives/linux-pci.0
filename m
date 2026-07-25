Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6539183C;
	Sat, 25 Jul 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969983; cv=none; b=boMBuSM6Zm19Zcz4ilHPeFzAkx3GROgA0EzZ/eIf/JGG+2Q1V/IgTcFfDlqyvaMRYDJxsuflrKU2/ba1y7VXfkED91JVbu1VIZbERgo58Sn4FIDR4YSUgVJcTkS1VvPjDlsBGVcU3I0qm6IfKutwSz2ZJ81jIJrHgO/9r0HNLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969983; c=relaxed/simple;
	bh=31NjIQUTeWZLc6fEIFAJVTJ8DcSVltuYCnuiJreAzYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NS67i7KkhW04j05LLbmnnZXBNUbztLQCZKiodkqNhT9FaGbmwxjsixYGh5yk1YjtDe4/yw1jg0xvHPcE032ZvPxqx3Efq99CdG7Gqq2ozb3yGVSWS1cJT5Yq1FOYnqzX+UaTWVpNwjKafHi5ZJNM4oEWV8UW/cnS0ioXgJxv2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOSKb71b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOSKb71b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD7B2C2BCF6;
	Sat, 25 Jul 2026 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784969982;
	bh=31NjIQUTeWZLc6fEIFAJVTJ8DcSVltuYCnuiJreAzYM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MOSKb71bQqY/G0o/D9M2NKEbVH7mqwhUT9OFbKU1AKLG5mSMXRmQgFiupDNWboZfT
	 yOygZz5oNn3nvrcuwJm1U2cOKF+hfAhM3rFQnrBZVGqtNp9jsYkucmSlBoUfpXzTlG
	 VD+g0fXRI/rEK1E7hFzBGxMxmyT+hvhgzUtbXfZdsy+EdMPpskbGOdX1aYKtWXDJ9V
	 KlE1JyoSIKdl8dwY91a3jcOgG+DTJWzWtdkEvGHPlcgpzPHfcutMs/YLt8ALwtS6zf
	 jCnlKS9kLWSP+MEbaA54A+GjIa0jq3HGZ4xIwtoQQF7Ynb5nE94Tm5Xi+GSf+ySr5H
	 Ks6PHGY5K3ifg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962ACC531FA;
	Sat, 25 Jul 2026 08:59:42 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/6] PCI/pwrctrl: tc9563: Several fixes and improvements
Date: Sat, 25 Jul 2026 10:59:12 +0200
Message-Id: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOF6ZGoC/yXMQQ5AMBCF4avIrDXRQYWriIXWYCxK2hKJuLti+
 b3k/Rd4ckwemuQCRwd7Xm2ETBMwc28nEjxEA2aosgpLEUxdqlyMfApVkK6M1hKxhnjYHMX5i7X
 db7/rhUx4C3DfD2Zcx8xuAAAA
X-Change-ID: 20260725-tc9563-fix-64eb7cbb1229
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=31NjIQUTeWZLc6fEIFAJVTJ8DcSVltuYCnuiJreAzYM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqZHr1zcV4JoKB7ZAz2UA4gLrLm9guZhHRTAzpT
 eaWDbd56eqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCamR69QAKCRBVnxHm/pHO
 9ZX3B/4nGwuzQaqqcm7w4n38qxllmFOlJvMCfWYo81HL2K2T2Yfmp5Kw7O5OH3Fm56MtsUgmQh+
 qsuRdYFQwuMmWsByL38GwABeFTgCq3pRXBN8H3TBlMbNDhCmDLDm/8GYVTJ2U9/JWGgA22rZWV0
 xSpbYjnPELIM6MkIUmxIebwrLyXGkwGv9VUNWv96okH/fPzZ/gcuH9txAnQDOrP0mhCZ8bnqdft
 vueLCccD7FQzE0Ep+3JuTVD8ubaNV/prAgxYX2Y8B74pbCDrF39DqytRNefNseFjO84yWn3r+zG
 8PSh95Jm20S9vIfvnzrjPaDhUm5tdW7fSMzB0mT0C2CHXTFM
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series contains several fixes and improvements for the TC9563 Pwrctrl
driver and the switch binding. Most of the fixes are related to ensuring
correctness in parsing the DT properties for the switch ports and the
integrated Endpoint.

More details are in the individual patches.

Testing
=======

This series was validated on the RB3Gen2 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (6):
      dt-bindings: PCI: toshiba,tc9563: Restrict Tx Amplitude, DFE and N_FTS to USP, DSP1 and DSP2
      PCI/pwrctrl: tc9563: Fix parsing the integrated Ethernet MAC Endpoint node
      PCI/pwrctrl: tc9563: Power off only the external ports in tc9563_pwrctrl_disable_port()
      PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning for DSP3
      PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
      PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint out of 'tc9563_pwrctrl_ports' enum

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  21 +++-
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 129 ++++++++++++++-------
 2 files changed, 104 insertions(+), 46 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260725-tc9563-fix-64eb7cbb1229

Best regards,
--  
மணிவண்ணன் சதாசிவம்


