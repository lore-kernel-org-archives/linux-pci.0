Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465958;
	b=fN40pwkYLtKCUTWQoXa8xf3jEvn5EFy2xnE0UTjVi2+/WFYLal/blpqyh2kpKOTJyzcq
	 1FLAOh0zFwVm4SYhBPD0E2qw5ZbWl0Qb0UhP+ENXYgNmJc/3jlWemFw1KMWpssBI/hxkE
	 uUJYhAsTmS+XGz+Nfds682gQtLuFq/R2uJJhJhW5MCUYzBPKb3IafGJYYboONkWtKpNje
	 mXBOL27G3dPHo3HjCou5eyRStuYqpjLmI1rOpmqqpjzNSGvumv1vXbDanDsD7PMr7ryZC
	 pHuWRwFJsppABSisP+d+XiJ4Vs8JpkkbT/8onweffpCneR5WH8FfSj8COaCe0kZbgsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465958;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	b=X94Hs1ghZB0oKrxzTHUY9bia7zYIxTl6j9O5JjCJCUahXP11JgohvUgqTd59pWPRZCEs
	 dylIX9oPD8g1gBApRmyBkfX529SLvWKsQxhqPSyUVNamdoj9dnjqFqJMkzWPuOYN6vz+I
	 nQ1FEG4lUls9XxMDD2R40gcqFgsanA713a7SNH9L6TmwkNR+SaCD+UAxAtjC8s3JWqOXA
	 3q3pg0XBLZ6ISrFFz8r50OKK5IPNZy8jNOm7HNx4YGSnb+/EX3x2tFFUh6eHrjeIMFeWt
	 Yhz3IfFBLGtWrhT3h0dICAZpE1AKt06Odjti5v2IB1+vCKDfcsukv5WasEG/gf1qQ+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQNLeil0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23485606A31E;
	Mon, 23 Nov 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQNLeil0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465957;
	b=iOtjEsL2Q+i3LzgiE3w+KuJluBjxBbo8EwFX/moGyUba1kn+UbIuLex6pPFm5UeHFvwM
	 H8ig3agIoHRCwwAunmlZwX97AMxtqOHoGlWKGT1EGb8JqLmM/gMIroTAT2KTR9qDfcueo
	 zjblP0hyjnZN6ba/DIXf/y6FsZrDJbUxVsUnsWWI6fVbVV+Omq2hvBr2ArRGsAmT/+QWt
	 vwEnOc5GFFDMiJj7Xyv7r+PX9Gr+UuThajO/M5OI1guQfwEWNqaxut7Nwk/utZLNwWUVV
	 ejCn1PmvuyXnT2R8yVeixCOr+daR4TqjN6alCpOrKTBNdExupWsQSJeRYemPSd9axEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465957;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	b=z9dSqIBGAboFrpQnMo61whta9IURKSojLxc9ri2KnSbBYbMYyOhPLoyTlRc9cNjszCwf
	 PkH3D2rXPc9XDqbmNukH9j+1AW/VhrhMVJqg0jj9k2AaAk6pUKF+2HcoSD1tao7Bg4OCs
	 wcb77IF7/QahfMs5CMJKz1IYLdydkkKAaUFzsU3bxM1pFhtofvDcsrTifK3ilV2SeWUWD
	 JeSOc3wCnMmxC7J1TWE27yZ1irO7Tw3Lwl1j+vQq9Dd49t31mDqIBALGWaFcamQE0DSVM
	 THM9swcm4VhGHluEQ4Gk3KuAs/dbKkNOy7tB4HT49jlw+dGvf4iPYAUPh7nwilLCDHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DC98B1F000D3;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465957;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KQNLeil0pnY3SrpZpmzEetia+5h2ujIhwz395ANnl5+CGDA4FJrm6su6cs0RtKQR1
	 b9qrMND+GQ4PWNWC0tdvTwcrjjFt9HXQV7Scq5uXfnixwVAZ/gdYI6AldMGh94GSpH
	 aA997h2qIxXWaumeCqUxezbRuMZ0abYn6PlOQkT70461iQS7lz+V4J4kToFJ4UdZFb
	 WKPJ8G13SlT1HYrc76oYGqBSEe1PqxyAWVw7RtvkurczwjVIPpvvNHaCISMiltdMQs
	 eTQ/cDaZU3EvFhWcNB9pw7H9cDHSV+ZU2+g0u53vUm0VDHPya55EU9ii81hnS6L49r
	 kagMxuPPI0wsA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E1B54C6FF;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:32:15 +0300
Subject: [PATCH v2 1/8] PCI: dwc: Export the multiplexed MSI interrupt
 handler
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
Message-Id: <20261123-b4-cs7542-pcie-v2-1-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=872;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Mna9V2FvctfGCov2fj28CrWMP+FmQdEcH5a5uq4pt5U=;
 b=iPA0bYRf79FFPZCfNmPxcL55dq3dCI1ypOQzRlCncf7ujc4VHkSd+c3JzvJjVekdl6zTVt/SN
 I53Le0IATu0AVXqUzEOQetC/fcE6WJgt8jFDHqqTTa+3cqZRXGvbTNs
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


