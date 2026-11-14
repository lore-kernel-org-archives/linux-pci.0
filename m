Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794617542;
	b=eMCzHL5EM6UxZuUHe0A0U8IPy/U38x/XTHh79y955TuYCwiAMwLkTuVN0Pes65zS8kMQ
	 wHdBHDWKm2OObh5/NgAmt/FfWjZQXrRA12BTLlx8txTY6hXdJNB5gHtPYA5b4OU6sh6nM
	 haOHPz0v6XU00SpXS58YPZbRfG0myY0/2IXUHKFEA7P8OOhKIBdK5E1YLGeQrYh1xwMIe
	 tLQiGJTfjym4sirJo0jfPUloEeFXZSwXf8lEE2gUdxihawPNYjYiZnUyRCsF8Y4sf70o5
	 wngzGdNGu02SYH5U6y1fIBru5O98CHKO/n2bogTX9NFOhmPEVhZHX8d3lSJtJ737Fng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617542;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kf5Lt7yzOAUQ5ueELRwWwf4JNFuNEzgr8IOrFVpUyq8=;
	b=gBsB/wx7L+EsEaIeTausHAQnco5MflrUOr//yV/yKLQxU4c+dlodumQ6yWRH3Wler/ey
	 O25CmHZPPX3EFn+D9vs53hLKZJDuo2lIPCrP16qqyXHloYf683LQkRRYLTY0Jc0B8tVoD
	 6Z5LpSiiFAhvRDC2Dhylq5PrBTNWR7ko+DP9lwmdNcegXp6fSlrPHWyQm4LtDqCTSRkcu
	 pYs6E+3xlBpbDTw7bl9As6cO+zS0OFQ9cWY8Y1QaugZGDngq3ZLNd0n6Jwrg3M3trQaTw
	 cNPH/zs7y2jNngCDL3I1SZcdfnDIrAO3DnX10MRE3Fi2Z9aTUwqXDVaWg+Tdpcg7zSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kwd5Exqc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA922606A337;
	Sat, 14 Nov 2026 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kwd5Exqc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794617542;
	b=FNX5M15F5U5VS3C8zZDSE9YVfipPmI+kTzQy4A1uTXNTPdC6l+Q4uAKQpi6gRjseQTYu
	 wVpQj9RBuF95C9JQpPlPm4aTIL0pEzh/+YQoAJPW9TXxb5c9iHCps/Qqq6DCBSDo4W8b1
	 1YOh5Le2CdTXyubqD4ddRBF58AByfKONnBvul900iWxJk9G2l6T/c2VEwglNQEqvxLXXP
	 rzInpQ/rIhuWK2os1/UGbwEzyJb8V/KE0JKtLsK4hpWsrYf5u6MrxsnVo5azFq83dm/Sq
	 f1kZu4RsomTQDCiE0qX4LlcV7VnSiR6wyjkrMd9NMyr//P0HezJ80NcVgMKS1ZedcxQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794617542;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kf5Lt7yzOAUQ5ueELRwWwf4JNFuNEzgr8IOrFVpUyq8=;
	b=KWXXkWScFAi0HiE7r0IfMaHiR2B55p1KmMJjAUxKLXb1fwXf8TDm6os7aJWYq29UopiO
	 9a0YJUsZcrn1As0Rm6JFrKb2sY0H9tMpBDMF/f90AbQjyCV0i2eB49zg8y6LUj/+0UToQ
	 Rd9g9GBr8t+XAJnKCZhMq88/5GNhPuKrcoC9ITRBldKcXQ9/TUe5HuQ94Ja4NSw9mpD/Y
	 f8fVENPlqGRAJWvm+eKnYKsP9gNmfsqgw+fapzZ2hB3eFlRPDQMMnLXzmSn4v5uzHRCIX
	 iBXerOyfg6axLd+Cm5LCKtsS8JgXaJP1X/lnlnNfUQAmQTDBfp8gNrg7tpTazj4MIFQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C3CC71F000C8;
	Sat, 14 Nov 2026 00:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617542;
	bh=Kf5Lt7yzOAUQ5ueELRwWwf4JNFuNEzgr8IOrFVpUyq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Kwd5ExqcLXQ9Pg2oGDBqJ1goYBv79NFE2f3Ajw+WLCSQop6EWRz9Niy4Uc+RINgiX
	 WdeJeHev62ZJiotAuNoXdhdJ6N0i1O3ARb5kiADV2AE3uPXLkySYsBLgOPkRwUAQdc
	 QewPVfDtd90Ime/cfbAPr6Gz6LbkQrn3iccC/vLJ9DigKrzmYp9gfv3ZfXaF586Kk2
	 t2fobkQBp6nJ3xnSwEqGzWCPyCvJ9uHgJdoz6BsGm/WqkQqVTqvimgqV+RXkpEYR8J
	 Gw6nLb+PPV4A00kPxeUdj/qZMppCSMejzUlDUbbrkjf36c2BbamleXnZx9up2CVRp3
	 ni4EjG8UKV/lg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E01F449BF0;
	Sat, 14 Nov 2026 00:52:20 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Fri, 13 Nov 2026 17:52:19 -0700
Subject: [PATCH RFC v2 1/3] PCI: rockchip-host: Skip downstream config
 access while link is down
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
Message-Id: <20261113-rfc-b4-v2-1-d6b14f95c1d6@boondocker.io>
References: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
In-Reply-To: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794617540; l=2087;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=dQmkjngK0wLJ2jAFS1PjdlLb7zJkoCy2sJ8WeTsPps4=;
 b=9/6wJ4fyi0li8ktfa0g1y80t+yToemwpZHRpl1FuuUR8wL8NcQvQf5YZ4ISCzVYGGfIX4Nbbp
 60UfS2buuMTDRX0VvcUOUgovZRSmUUdjXveUqPlOyYx8G0qNHPWZfLK
X-Developer-Key: i=matt@boondocker.io; a=ed25519;
 pk=WMnh3kwFFRkrqamL/FbDcdl1/9rBF2uT03VdvGGP40k=
X-Endpoint-Received: by B4 Relay for matt@boondocker.io/rk3399-rfc-20261113
 with auth_id=1517
X-Original-From: Matt Thompson <matt@boondocker.io>
Reply-To: matt@boondocker.io
Content-Transfer-Encoding: 7bit

From: Matt Thompson <matt@boondocker.io>

On a RockPro64, a PCI bus rescan with the downstream FPGA unavailable
faulted in rockchip_pcie_rd_conf() during a vendor ID read. The rescan
task exited with interrupts disabled and the watchdog reported a lockup.

Check the controller's link-up and link-training status before issuing
downstream config requests. Return PCIBIOS_DEVICE_NOT_FOUND while the
link is unavailable. Root port config access still uses the local
controller registers.

This check cannot prevent the link from dropping during the transaction.

Signed-off-by: Matt Thompson <matt@boondocker.io>
---
 drivers/pci/controller/pcie-rockchip-host.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 5b071bd..35105c1 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -143,12 +143,23 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static bool rockchip_pcie_downstream_ready(struct rockchip_pcie *rockchip)
+{
+	return PCIE_LINK_UP(rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1)) &&
+	       PCIE_LINK_TRAINING_DONE(rockchip_pcie_read(rockchip, PCIE_CORE_CTRL));
+}
+
 static int rockchip_pcie_rd_other_conf(struct rockchip_pcie *rockchip,
 				       struct pci_bus *bus, u32 devfn,
 				       int where, int size, u32 *val)
 {
 	void __iomem *addr;
 
+	if (!rockchip_pcie_downstream_ready(rockchip)) {
+		*val = ~0U;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
 	addr = rockchip->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
@@ -182,6 +193,9 @@ static int rockchip_pcie_wr_other_conf(struct rockchip_pcie *rockchip,
 {
 	void __iomem *addr;
 
+	if (!rockchip_pcie_downstream_ready(rockchip))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	addr = rockchip->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
 
 	if (!IS_ALIGNED((uintptr_t)addr, size))

-- 
Git-155)


