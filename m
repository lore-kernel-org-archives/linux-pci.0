Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794694384;
	b=L3dY9HrFkzMiEmuKuQAhbKgOQHwi3nUxHceCEiY3y3P2U6zLk+djZSJHWFYFPJ893QrA
	 3HXJE2KEFdjlEoC5hLW4/9eJKpuJGgFne37dwkC0RUlluw0Vtdey8ON9BQcqtmNCyrwCC
	 FdMzwCZsT2ED6RvgKibgI/rWW2e9dVWLqSoz5fnjARGdAVHv0exLBYtYsPzAI6zuGVJU1
	 ldBRhT0hW4AvsH01OWwpePHHgxOAbw0tXH1WcYNj1R/Rr1zi1pLhO5lWDVJcwAtMRlIYi
	 ipI+ZsNGv3MjNHRqHLprz+HloaccfBjTM0Wl5LyctgoVv0j/qhkNYTwo0UtXU08XoIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694384;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=xD0xEpGLTFZEGCKBw1uu0nGyfMUoZ5twgYLHOtEZVcc=;
	b=DigdAmPah4Pk+qCaExqYQKNonboBINwuzfZ7+dQx0SAKlb9FV5thayePuquFDYhPQt69
	 HrkKwhos5xCAyhRt0h7O25XNvuUuitLX4ayVhIxxhrv8WxW5l6WVVAJqd5m8qcTHxIB13
	 X7vyKpeFeg3SN6Aalja8gegr3Z5AU6TzzScybWTuCnF2PfoKU+Pnu8RUx7QFy6IOjwUo0
	 DZkiiK4LpsMeTIYNSVtzEVQaK1TpGs46+zu6uLcvHJFdqKqqMcCJY3yHwYJgQnHvsCZF/
	 BfsCNQtoTqNw+1D3y11XSbwV2UKJM9F6zaNP03K+0C42is1KwojCZ0WSsVEnUbZ0eCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ic4LP4E6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28716606A323;
	Sat, 14 Nov 2026 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ic4LP4E6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794694383;
	b=PGkdZKBRu6YAIrZp3TnMSfSk5NZwQ76bkPeI1r8wHzrG01AT1pPir4pBlB8l+sDkAiiw
	 3rxoODOY6F4gOJ8r3LqNWfZDoDAYqtgBsEFobHm783NtXV3zcOTLVy0Rp+1ooH8a3kRys
	 6NzahJtkV3/Q57+rSUDyXG/XzoYHTSYuLnf9UI7gtcNUDY1hLu0b6FzUbyRcNA41xhope
	 9eLN+vDUQ98vr2TDvgNhG1prAk3OT13ZbywaMA57YBgM4MCTsumftf4RR+FWZkRDcrXlp
	 Dgz2CSxukPxcbHcDK6O4LFJm6w03uyVow7xYpRHJU3LgZHf/8G3EpUslMcWmFlEie7g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794694383;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=xD0xEpGLTFZEGCKBw1uu0nGyfMUoZ5twgYLHOtEZVcc=;
	b=wMjbsL7p4sA2Dhvo3rr1Hw+XvZQB7k8MD/t9pYJmVbQMG/44uzFwElQLyoXmUx9klDEs
	 KUOqkKOlYFMwa444+J45/dfYsZ0MGJ5n4DMnZN5hfCXU7v949OouBajjMxKe7j9BrfbXR
	 fvBAJxprds4IxzfoKvH/A6+kqcDvS/Qv7vS/HUNJC+JGTt8TBXPllRlhG2eDgqPHf/TSl
	 AcygW6QZjOneGil7SZIySXWFG2swVVCqWZyEc0izZ3ZxOaZDL/gwQm2ynuI07lQv+HiBO
	 yo/8k5yxjHZkZBbFYdDB60lyh8g6XmoMaSEu0cz/8/4vTQcq9QgrPHXa9n41DSBsK0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2BBE81F000C4;
	Sat, 14 Nov 2026 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794694383;
	bh=xD0xEpGLTFZEGCKBw1uu0nGyfMUoZ5twgYLHOtEZVcc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Ic4LP4E6oMYtk1rZ2CEP4s2MllSFTCpTdqKniFLhHLjjCvcQRmsmKa9cTyZnypFlt
	 vhFK88TMsY5zfg2o6l7uvvzdEcvWF4KVEphKsTfTOxdrEuLj7MvLNNkHaQYhfpA6hJ
	 REpvMgRd2UHedpTMZuo3TT5BxPtJBB0jePQTx1J+4WUHabhe1w1QtlQ3NS7YoKVOTb
	 uIbDeCSnv/FBTobhcqz1hyTCEF/8fRmM8Fzr7C0PcrK5/V/fIQ1iJI072Ct7LEE9pu
	 aJ8B5ojSGhW7tFlWv6IqKuWv4EoRfMbqc2mLFp9PuLj9zACZeFmXOGizmRB2ou+tUK
	 /o6c736UaehGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ABDFB49EA8;
	Sat, 14 Nov 2026 22:13:02 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Subject: [PATCH 0/2] PCI: meson: Add system suspend/resume support
Date: Sat, 14 Nov 2026 22:12:57 +0000
Message-Id: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnc+GoC/x3MPQqAMAxA4atIZgO2+FevIg61Rs1gLQ2KULy7x
 fEb3ksgFJkEhiJBpJuFT5+hygLcbv1GyEs26Eq3Sqka5xqDYzxITo9ySSC/oK4609tuNqZpIac
 h0srPvx2n9/0ANe3ZJGYAAAA=
To: Yue Wang <yue.wang@Amlogic.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=WDRaiZdaKfWEl03glQcVn0OXt/DJd9CPRnnp+NTL/5A=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk/7rxZufzRhJb192SkltcdWJYU2THlgliwe4DGbp7jB
 8wDkxeGdJSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJqFYzMsyucdxqUKj5M+3y
 2bsLl6Ud+el8J6iud4/v0mWiF8tU779m+Gd0g6cyZrKVi8deMcXNF+4YnjU6vlWTafdV55PPxN5
 /escFAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

On SM1 the PCIe controller loses power in system suspend and the driver
has no PM callbacks, so the first config access after resume hangs the
CPU; on ODROID-HC4 s2idle never returns.

Patch 1 moves the PHY power on and the resets into the host .init and
.deinit callbacks.  Patch 2 adds noirq suspend/resume through the DWC
helpers, for SM1 only.

Tested on ODROID-HC4 (SM1, ASM1061 SATA with two disks behind the port)
on an Armbian v7.4-rc2 kernel with this series, which also carries
Hans Zhang's pending MPS series (v9): 20 s2idle and 20 suspend-to-RAM
cycles, the link back at Gen2 x1 and the disk readable after each.
Suspend-to-RAM woke on the VRTC alarm via a patched BL301; the stock
firmware has no timer wake on this board.

Not tested on G12A, G12B or AXG.  There patch 1 changes probe and
remove, and patch 2 leaves suspend alone.

After a failed resume, dw_pcie_suspend_noirq() calls .deinit a second
time; pci-imx6 and pcie-rcar-gen4 have no guard against it.  Patch 2
guards with a flag; I can fix it in the DWC core instead if preferred.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Igor Velkov (2):
      PCI: meson: Power the PHY on and reset the controller in host .init
      PCI: meson: Add system suspend/resume support

 drivers/pci/controller/dwc/pci-meson.c | 108 +++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 19 deletions(-)
---
base-commit: 35f800669ce835aa77364a2ab5b61be19b778d3c
change-id: 20261114-b4-pci-meson-suspend-20798a7b9956

Best regards,
-- 
Igor Velkov <iav@iav.lv>


