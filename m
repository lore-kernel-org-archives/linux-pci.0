Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459426;
	b=EEtQLwpK0H7tpcp+BMLPNw1o8tYftJVfeAi9VhnavoGvPiIvPGS4saiNPG8gAyjor9cV
	 R8/67A98rJcNRmw8F+/TQ9fY6HhosWjT6r5iR4ajQbfs3JsQMsFdTDEZpaKzuIflBDdh+
	 76Hw1GSFDoLoZxZeT1y+acFnSMD/Jry9D+CvyT62ZwqFdS5zg1vtFd2/FqiBQtkLxC2fF
	 MPVDNYntjmoUwatZh84TAkSwEZP6NZOodvvU6uGMYfIHQ7oBCUqHlc+FfCO8DZSD911/p
	 B0xIQKw+fywGXzxHwn58f5MiUoaBcJPWKbD0Qmk8DUKRI+TqG08B++PJl437cVFU9Aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459426;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	b=y2aDUMRSuu0Gp0yg+5qE7lvgTcuZ09rO0r02hKN7Z9LnoXgF/oMS7h696vZa0mkb8uj0
	 XiJFGYZw7r1HNPetikcMM2x4awt/SHrGwsMRlGUWzVRZaoVpeSK8L/fQFtna90/QEXnMi
	 6fITldozHh46KPrtliEWQN25jzDFCcnr0Va67bziSCQuon31Q+NoqzEzjq+aRBilMrY+B
	 xaSl/X6MAp9EYv/CkA3uXY98oODBwIsxRk2Rm4B55hMUuoDT8eGHvmIvhbmZoPBcQhBeH
	 yN8MZafYxHdhaTh6zHvY3pfLnxOTKx1lZ5K6C1a6IQoAjBTDXr+T2dxJEr2A8rkpK/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaICRG+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93D606A334;
	Mon, 23 Nov 2026 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaICRG+P
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459425;
	b=rS8/BpRu8JViWn+uNqzMThet9tLlOrGwVslpiPi3R7aqJmTiCv8nnIRmz+z80SVxEOSK
	 usET9LKy8Ap9o4w6C5KoIvjRCU1ztJBKfBKF5NIO7We4tQ6dSh3ZzU9qwA1mkLL9cdSx5
	 L9sJV/nwKXi2FijXyZyFZlTAdjhihUyYug4NBtN7+psz3dTo+U6E8cWNAandl00eb/K91
	 81KH1yim8xOedZDzsrAZYb5RLcjM0vS/ZOjR85lYgJRQASffLXBHvFb0pgRS+idC8EE7X
	 kbrMvUmfUZfXlellOf5aJlLMdUw7NkE9Q+eV//aLqa2QGmZyPuw61OY0DnB6g5wDMoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459425;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	b=oi8DjRiejntaobIbm6ARr0zB0EKoDT22uDDLVvonQP/+ov/UUSHAz6/fsqevH47P6KlN
	 Ail1aiNPQdjKLbTIhsi8gkefow5oElpW+kwI2kUPRXNCD+05wTQ2DcRnZtk3OS0egMr9Y
	 bn5Bm2y+tstKrlY+q16EBC3m9rbXnheHLnK+Ude0axrrYTdTIowXW3krAIaJmXWzcSpMl
	 4kdSuS6bhMKsYm/Hsk+75iNhFUUz+Xnv6IRf1IlFP0E1NFC4VNg3vRKJamwaXKGFIO1Xa
	 pHxj6hZ12thBx3nEeSdRiLA+S0vE2sKbiYTq9ci4NwSk5XCfP/EH0AbPEFm9vynnm0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A1261F000CA;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459425;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZaICRG+PuCQK60fTxvNdKR9GV0MoPdOeTGvRCALhWL6hhkHfcAthrT5/PgBL6SwCX
	 7Z5/5dnwVajLkhJsKFqNTRSrxA4GzpryMYUjGYXqW1GWJWD3ITaBeWTRnOoEJ+7dYr
	 LjirD/7nTQ3vmkkJFJVIHmkrg5fQ2yN8eve6K7vH1hoQAe0AitGOWeF8vXfSaMqG9M
	 77qO0D3TtCnIP+Qpb23IR8i4t91nnlMsfjTe4rSVi636CA3vPgkOM54v2P3UftkdHj
	 YdZ9LRTM18Q4Yb+iArm3YXIAhySYqZ8aUP8qer17f+grXkSVvUhe5xYYJ7Y3os1RC8
	 TmSZKddzNNtVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DF6F94C5D5;
	Mon, 23 Nov 2026 18:43:33 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:43:29 +0300
Subject: [PATCH 1/8] PCI: dwc: Export the multiplexed MSI interrupt handler
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
Message-Id: <20261123-b4-cs7542-pcie-v1-1-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459409; l=872;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Mna9V2FvctfGCov2fj28CrWMP+FmQdEcH5a5uq4pt5U=;
 b=qNvzbOacLh6x0fSN7zTi0mn1WbwON1SuHXMEhUFL6l3FtIOVmrgsRFMGLDeZuslgdgYoJHppc
 LWit8E7cf8GCfJgcPzOkf0z529lNCweFuB2AAzTM/guTvcrVyYhMeW7
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Allow modular host glue with a combined application interrupt to dispatch
the internal MSI receiver without installing a second chained handler.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bbb02458a..1d076bb62 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -85,6 +85,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 			generic_handle_demux_domain_irq(pp->msi_irq_domain, irq_off + pos);
 	}
 }
+EXPORT_SYMBOL_GPL(dw_handle_msi_irq);
 
 /* Chained MSI interrupt service routine */
 static void dw_chained_msi_isr(struct irq_desc *desc)

-- 
2.53.0


