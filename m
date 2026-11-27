Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754123;
	b=1VwfF1f7OS89J5SBl6SycEqUkdfacMZJhvCJlf13UKxTaL5z56YF9sA3OHO8+W2igff2
	 gIyFtuiA7pZ4Rc/5cYBXlrusTbV8Ab20v8F3p4kgle+Fds2M7IBM0PMjeSlnGgn3XRd8D
	 5qR6RQwRG62LqO/G39FXD04aDEsP52TjGsC2KxYOTWudhZgo3GudEilfneWTUQrlBhxT9
	 w2rwY3XjRMvayA60irnxW7xW8nDljxRhl5SSDaBFe6Ru9dW+BnRxcI3fkSXstuxPwWnDI
	 l2RxcTlJbdL+jN0wz86U2Rx+K70m7Hh05CQ1LKfVL+XK8RgIUHRh09/k1ftbk+nThow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754123;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	b=Lzzx6d9BxjpmIQi7M5Le2pybed/v7U4oxxo/bRSRa9BGdqBKT6pd0TkYz7Jj6/wYOi3t
	 Kb8s0aGc5DkxhF46Py/2B09olYI+4HtxKjtTjOLKh7rTYek0v3GAd9V8IkAQssdHXU4qE
	 zwGlDeJXEeFTA+TAAeF7pVOreNLyjLCKMKCs7+kH+e2SnRQ7RbxK0anpy55o2YA6mGQpg
	 Wo0jDvIlUqqpsde8rA7T1XK38P8VFtZi9qywSxIT7InQd9aK4SPnEYvYYzehu94V+alFW
	 ysQwJopIB1Ak0MOsNai1zRjc9CvUaGfG+dbN+vo4Ilqxzhj9QgH9GxHAwivWgEVDTlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiiqhIQj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDB606A31C;
	Fri, 27 Nov 2026 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiiqhIQj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754122;
	b=J4SasB5eTiud8Gk42wc0+kLcWU12tU4NuUKZ5VR7AgSuR01VXADuDS2b8MpBrAWCT7Zi
	 TEMrho1pM8yhkHmDZGNzh9Q7ppZpbZfaR80bJVKvsk0mj0v471Hbw37tsxDNToYkw8lOE
	 liC+bz01vQyaaisb4HQBG7bmPCHIHX/HNdVyaR57muQ3EEB9paPheWpTzohQp+GvSaVNK
	 3v8ciZt01kclxFZfiYaknB9/R422J+TuRAgSGXbKI5BV8yUq0LNcsrDqaC4CcgrQCO6rC
	 yXHULNOK49HBXbGumzT7+6qSvvp4cwitMwQ3pK7R4OP9noxOkm5RNwvlYljrPeeztxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754122;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	b=TYDRwaNjHY/R87Tg5nvxkQXuROWySAY2aXJAlEzrZbah+kI5m5r4VeRRQrLLKgdiIKAt
	 1x7mLRwpPNGJps0MPt3m6WJ4Efs8AkGlZMdib9WbTm669TcqpwfxRPnbKJ//XZxgtl+V6
	 5VeNMJUbnm/WSSi3JKWS7vGg9i2XMK4TyprA6tgiV35tiKdOodNLCjcV38Ws3JMB6WzvT
	 0pMbLqi4qF8ddvMJDdcGzoCjwed0xCRAsuLo4NNy2pQ5zbuuCF4bXVJGubcYrGqikZeBP
	 7iS918OznUSXUI8GTnaXYYFxBylLiaD+LrBa0klTqMrpf41VfbL2x+GOhe/l+NnePxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C561A1F00893;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754122;
	bh=9tyMkUr9+zYWv3mAdl+/oTYNIcjMUy1JAChBbK6vIio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jiiqhIQjyTeTxxZLPAR4cwLojifhRwKvaEI966qxcgObyn0n+7xthW+5PyRbmbWDD
	 Zb3Cr1Dm+J1DrilIEQaEGcQM8oYzG3d2ToywPDVi2ljLKhU3SWzJ0jvEBiZS/jqpAA
	 U1UninlUzRkoR6DP3hiH/MHkGCGqeZJTZTDYWP4ntdLENCrHzINyJIImxrKumsMvXH
	 R73KiwXwRXiBqgoIk3KpDu5ibPo6iQfhWAJ3PqVINYWie63G799W7U7EiK5Y111h0t
	 D6zdYzQ0bror0O6NXMcg8Rgjz+Tlnmevc/FWBWQVMjF6BqSrMjXdiFHJ5TrT3sDAD6
	 Ep8M2x5f7/J1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 59EEE4B576;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 07:35:19 +0300
Subject: [PATCH v3 1/6] PCI: dwc: Export the multiplexed MSI interrupt
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
Message-Id: <20261127-b4-cs7542-pcie-v3-1-b067875c56da@gmail.com>
References: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
In-Reply-To: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754119; l=872;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Mna9V2FvctfGCov2fj28CrWMP+FmQdEcH5a5uq4pt5U=;
 b=7kroQ7/sWAM6ZvMKi0YRIOONOSZbjpsXWWVqDT4YgFzGkzY7/3ZGQTzfKSsaw79LPe6o9iQ5X
 exkHJuVQK1fA29EyrmMUJbgePoFEJGFcDJb+6WrTXCPs6OBgPXGcOYD
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


