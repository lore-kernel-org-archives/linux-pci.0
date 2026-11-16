Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821747;
	b=bU63fDMGBqk+ZpM7zIQhtZYinSAIOzjfy2e+Zc2f55aAGAB5gU2q2I1HMyL5HSOoSLqh
	 CgXbLmCPd+cl22G4nwgGZIHt87p+wAqbp7hwakXh3N2ZQrwqecN8GVEbFiOYZumcOrsj2
	 xm88z9nwoLbl+2099eBa7Jtw7IgolTvdU5j9J4iv0L4ydccMeLDB0X8k1dTpmssQNkj+s
	 m8wFZNmwFWjN7HGWdp8F0Oq62bKz+NCbtpPpsfRIL3YVYWrmZL15v1jKEOpeUzWWcr55x
	 viPSV2iw4OY0zwKmZ6CPp0krsSHXwfuDQ5r+zeCRw3iqQOPCoXe3FXuD332vso8s9ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oOWMbyn+xjdjjIrDX/w15MfmyYi+VOxzKvNZodzOTtU=;
	b=VxoydVHV2AB6JDfBHPbrMJmaA39QfhL/J+4B54TVCLjCEHQlhpa/Pal83f/nuxF1h3qT
	 rAj0vXDW60rb7CiCXWfQ7QfSJUD2pstg5r9FYkG1aDIZ/kJKtQB31DFaypvfe5FiJlVsm
	 yJa8PiJynZEZT96/Ft0tnKtgqwRpWvxIPUEKNlKrrNQJPoyidvOrmwQoxeuPULqSV9DVy
	 N9Kn1/XMiPCDYxBtCcYaMlj5AqHx9TXJC9SRF+7cMgPXrJsYuDRyEruJDfRqAzuTUKSbb
	 ER0yLBHyw2f37UMLiLGyHaEeqbgHYEe90trHeeRr2WFH4xHw8/oQqzH6M94WG8BNggA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMl25YwK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8429606A88D;
	Mon, 16 Nov 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TMl25YwK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794821747;
	b=SjHKn6OZuNI8DyzBng4lgnFfkVJO5VP3vbszWaLXJMyrwelz9vT4t5ojYL4ZCEe+bTrI
	 LGxM1qNLc3i60WtNYKjwswdlZ/Ocyc9Iv3wEhir9eROUI3zELhQJcF9Z4AthPMReoXld9
	 +l2i/01jL54hFRXp68BfKOmlDNIyIOMAsPadYMXDs2Y+RGLRAm7AImgRaOjdGHXdrf7zw
	 y46vk3jkXCxQneHhIAIt2EazVTGs34To4LjASd8Vo/17Kuw1KAKYMsaWU6OZ824bVtceL
	 8P8Yd4xcVz1x8Hyb84JTdl7j++7mOQilCsvrlD3EWQZjZhYLQdtkj6i+yViDNn0CcbQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794821747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oOWMbyn+xjdjjIrDX/w15MfmyYi+VOxzKvNZodzOTtU=;
	b=rxqSiELe5IHFi7mQsnVCVkkS28xSm6LYU/y6fXsPk3QKbVLsUlZK6Z1WmAXkSmZtzrYk
	 ELHktE6t0O1iwGcVwlBCW8XJmlph/1N7XM/pzQE1l/hHeVe+SVi66VXIrDcIQsu7UYa6s
	 1+AfZ4FYkk3N1L+7WrCw/uxSbJEYml7Khe1bSX1ieBWNrTW+1Bwonnv+thqTyKeCGM1Oy
	 kxaD3RWI0qVx2hJH1A5ww2l7VlpOa2oYF/ZHWKlMIs7/k6HYBL/p6ArLKfwws6dGVn1RO
	 mSKNbT3lMi7CB90dZCIoMY1Z3Aff5NNyV+wfmKcHVU7LdBsvoQb1BcHo9U9LjwD8BeA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F37DC1F000CB;
	Mon, 16 Nov 2026 09:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794821747;
	bh=oOWMbyn+xjdjjIrDX/w15MfmyYi+VOxzKvNZodzOTtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TMl25YwKN49t+AU8jAOFg3rxSfYcAhQWkttdcbGW+QDctHcmupMaV6xWCo2wUgr4W
	 wa/dAyLOL2S+WS08reF3OGlL16B9Kruwl3CfMbvo6CH+DrjUWDEcZYzqBAs/fpPU4l
	 j6B4P4o7UF3o0vEiR7PFYTgABbkJxbMg9BTu57YOsrIAnCPRctoisemgCRbbf1X6hf
	 XNwdxs/6Q1GSNdxd9QLPMARRx/24AZo8082PI/IgghIWRDzO5a72GIM8nxxCTRI6qv
	 8vj+ylFNJyAhSLMStqV987bbRAtESoHIBHA0k/b1XYVAnnKiOKVDplZI+sQDbZnwkj
	 ygojJ2swuaL2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF6654A412;
	Mon, 16 Nov 2026 09:35:45 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Mon, 16 Nov 2026 02:35:48 -0700
Subject: [PATCH RFC v3 6/6] PCI: rockchip-host: Mask the client correctable
 error interrupt
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
Message-Id: <20261116-rfc-b4-v3-6-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
In-Reply-To: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794821744; l=1536;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=ce3FAgQbXHJSx+KdqASGBJHjnYp6SNCbhPb8KwijOGQ=;
 b=Roa8HS4rvXHjevx86m6SGHzFE/Uvg8ZIdOKnCckQyQAhP/T2bbAmFPtUYp+bBt/mQYp8z/z+f
 Q3cGA20Dji+DvKbDPqSCsiGW2i2ULWqy5FZQpt8sDp0OfoYQJDvjq1k
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io
Content-Transfer-Encoding: 7bit

From: Matt Thompson <matt@boondocker.io>

On RockPro64 the PCIe client correctable-error bit stayed asserted
during link bring-up despite acknowledgment. Its level interrupt
fired at roughly one million interrupts per second on CPU 0 and
starved RCU.

Mask the controller-local notification, which the driver only uses
for a debug message. Standard PCIe AER uses root port status and its
separate interrupt.

Signed-off-by: Matt Thompson <matt@boondocker.io>
---
 drivers/pci/controller/pcie-rockchip-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d6c494f..a8c2575 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -746,8 +746,14 @@ err_out:
 
 static void rockchip_pcie_enable_interrupts(struct rockchip_pcie *rockchip)
 {
-	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) &
-			    (~PCIE_CLIENT_INT_CLI), PCIE_CLIENT_INT_MASK);
+	/*
+	 * Leave the client correctable-error notification masked. On RK3399
+	 * it can remain asserted after acknowledgment during link bring-up
+	 * and monopolize the CPU. PCIe AER uses the root port's own status
+	 * and interrupt, which are independent of this client mask.
+	 */
+	rockchip_pcie_write(rockchip, (PCIE_CLIENT_INT_CLI << 16) |
+			    PCIE_CLIENT_INT_CORR_ERR, PCIE_CLIENT_INT_MASK);
 	rockchip_pcie_write(rockchip, (u32)(~PCIE_CORE_INT),
 			    PCIE_CORE_INT_MASK);
 

-- 
Git-155)


