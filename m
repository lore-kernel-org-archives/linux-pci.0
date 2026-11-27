Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754137;
	b=FfH6SVyU8c5HR4c5oy0TeGU2ZaJYysbRF/Zm/Qh1OCOj+EPNxNqRVakIBb1KN1pFyyZl
	 FWSy+UKmRchEf1mqai3AQg+DC5dcoYxsQhDUzsancx0Z+IGKSfwpvlKwC95mr0DGQaYfN
	 /Py9oh6LRd7XtrLHexzPYEk2t4ry++2NMYum1um9T1RZrJEMoDcnHMhhOYzRoNJdmVu+R
	 amHlNuRNvFwgCo5OGBRrjh2/I7AddFzmDWpR7aqbfB47SlCvFvlfUSd/rK6pO8RUNlncD
	 FxlEMeYSLL2VStHOEcrDdpW0NuqiRUxXVPxHSk3FZ60u7YC1tWy0OY7Y5pA+H+iLh5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754137;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UUYHi0U86N2FbjxZNkMxeXK0M+RDXoUdFlp5RZwqHtI=;
	b=sNbpsU5YqoJ5IqhBAW+7UkqOhAYMQhWtHT+3CoEz/kfacvPiwW8xpKvsvyJW/6grdd9J
	 wr/u4pYlnjnv1sVJsOLrIqyy3hIQRJpYr5iOhKFQcZapAhXLgGcOW3WstA3M9NMN6bjxr
	 +oZBZ5t9bo/KI7S6QrlIpAIWQZYK/CC/pMTEjSZjoRmOjBhgGebgXuwUyIdmqNqqfLMZX
	 +nZ0eJZ/GpxW5n+nRyF2BnuoXVvD2BR39RpiTLhEliMvt/N97Z6kZz7sEo/wHv6/prpMU
	 N3YzPeRZzCo33/jPkwftKzB7lna1eqK7h4Rm/e5qFHvFbORt7mX1QOUqAD1QvNYKspg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9qd908l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42290606A32A;
	Fri, 27 Nov 2026 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9qd908l
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754136;
	b=VmITl57pfzAXlfg4V7KLo28lKFUADJXL4pOyFTAWjkz/ZRQMOx6IxJkQoyW8jVRNjU6Q
	 pICvtZG/JxGikwRtVGyStl2wcSBwwvtHx3RcMQfkGhynsTZR4NEfSAf9fnAvoarvpnnw0
	 dDENJEptctABFYC0zef/sHV6gdI4gpeTE+sTBIzv+YX/xP7LUDj+dlfrZYbCvYeLkyXuK
	 Og/BaAtj7jF4cQmnnZfEwsdlkaCVnVMdfrpDY1kmAdg6nUeMpsbCQZ8eY0e5OHM3iWwdE
	 6jjye5KiDQq3wlqUz9FjgkLqu7ktlpcTQr1gZF1wEZX/9rx+l2fppo7dPS2r/oJNS0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754136;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UUYHi0U86N2FbjxZNkMxeXK0M+RDXoUdFlp5RZwqHtI=;
	b=zPYdUWHvRtiWRaI20fmT98lXX5dfj9vJ1lOgJB7gTVodCAMCyGCJH2uz3ttoB3G5Zgee
	 HUqCLy32YI84AiEnM0mdjXlQmSFZ63V/KO1naHdNPa7uME8z9QWHsjbhNrD1CGTOqM+YQ
	 Ln748UqndsdOCWe2MQDOpUo1lRL32QeqQOyOuB4lKzrcymbusvkHGGIWCqPnY5lGv9fU0
	 YmK8cSvBIG3JKw/5eOGsOny/pYRfYv24MEIwNuJ7m6yWXmon1ie7RxEyR+sywCBkNaV8j
	 mNHGhw85Tl2ZO4KmKOg8U6RcVU392r7CHCaoox/BJ52FBbisuUaJFFFM561SKtbQL/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 84C771F00893;
	Fri, 27 Nov 2026 04:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754136;
	bh=UUYHi0U86N2FbjxZNkMxeXK0M+RDXoUdFlp5RZwqHtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Y9qd908lZlDKXDIwZSlL8ABmD1VM53EEz+T6ziMf8ub6pT8KOtS8UovGBxAwq/ayQ
	 fYZpd0SGIuNUKe4JFl4crvsnSoXNF1Gve/U6xdKI9RV0v8eEPfjbaj9vFK98Y9Dj7D
	 geuv86ahMy7T/CAUvQgoV6/TU3Dld5rEITxgRBsy6j44DSN2X4jlbcRxn6GmEKA74k
	 u9YYP+j/begA9cE5J/WyORT+Uz1ZoxFXtSUWcDl5lz5y8NZxz7hsQ4W7Bvt/93E/1w
	 CAtfKdP8xoVrWagwjd9mM0rT72h0hAatU4e3CdpU+CMflXPiTs6+KcvOzXJtMIE/zs
	 BK1HKYl+Qk6Aw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0C5754B588;
	Fri, 27 Nov 2026 04:35:21 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 07:35:24 +0300
Subject: [PATCH v3 6/6] MAINTAINERS: Add CS7542 PCIe support
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
Message-Id: <20261127-b4-cs7542-pcie-v3-6-b067875c56da@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754119; l=1340;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=UkNEp3aTxpqmCVLytwCu3R3LsqauciH/R0akRPMKUaA=;
 b=Sg73wH3Og/PYHjBQcgAyCN+dAMPoenI60bkb1EFIHty0rkK0P5DXLafHJhfdNHqxCbcLJch62
 W8CFLaHlBXrACWIsj6nReMYSD0XOeJszo+IZ9IEU5HpqvR95EyuZ5ZW
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Cover the PCIe host, SerDes PHY and their bindings under the existing
CS7542 global control entry. The shared clock/reset provider and reset
specifier header are already covered by the prerequisite series.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 703e95e83..8921c91a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2949,13 +2949,17 @@ F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/util/cs-etm-decoder/*
 F:	tools/perf/util/cs-etm.*
 
-ARM/CORTINA SYSTEMS CS7542 GLOBAL CONTROL
+ARM/CORTINA SYSTEMS CS7542 GLOBAL CONTROL AND PCIE
 M:	Fil Dunsky <filipp.dunsky@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
+F:	Documentation/devicetree/bindings/phy/cortina,cs7542-pcie-phy.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cortina,cs7542-pinctrl.yaml
 F:	Documentation/devicetree/bindings/soc/cortina/
 F:	drivers/clk/clk-cs7542.c
+F:	drivers/pci/controller/dwc/pcie-cs7542.c
+F:	drivers/phy/phy-cs7542-pcie.c
 F:	drivers/pinctrl/pinctrl-cs7542.c
 F:	drivers/reset/reset-cs7542.c
 F:	include/dt-bindings/clock/cortina,cs7542-clock.h

-- 
2.53.0


