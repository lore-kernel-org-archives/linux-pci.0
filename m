Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794616131;
	b=LwumfMHh9MES4KFwd0PANe4Qy4fqqODTZNOodKWcm+G4WLI4AByDRKnSCuDnBlwoiyUx
	 32iu0FZqTabK8kxiBwcJEuG2dh3uL1Vy/tVoNj4r4+sI3S9HSjh2GgWuZvxaNbs5k/V4e
	 C4N5u3z84SnjgSOBmC2o1aqPBXYGbGHQ+J1S18sdaTnGGi4op8CvgtnuSEXzUG8cxN+xD
	 Xv7n0EaKZmyLOBKtQvaBk1Wc0lNtUdrjXQWkYMzRAwJSWDh6Uupy57lnW5B6HcJoyMKGk
	 04usR0SlDhZxlkQR2kkrKk9v4jWT0miqUaZtXKHEE2wASgCs3uKtAMW7onqqcm6Ie1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616131;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kf5Lt7yzOAUQ5ueELRwWwf4JNFuNEzgr8IOrFVpUyq8=;
	b=W1fXRxC2IFS/kFH6ZQsgwFIPD17TNXXrNAgtWr2dP9/NjV2PSTia0jiYF6qA1gqc0RjG
	 q3i9qs3wuj735hbn0+HgM2UOZ132UuFgd7LaZVluSjadQs6E6Q9ze4qs9zIcMGP7BWTIn
	 6zxtMmZep+DSx1OOvf0jgdfyN2AV5F1iXEAMv4pKNp49PzImWBv56u0rYnDvwMFws2rQd
	 he8uiPjEb9mnlPtXtorHVyZkpIWP+347gcXXqoE6uADpK4ya7thox12FR8cZnSdx6YZR4
	 I4M48M5cMvP4LWy4/hdNIr5EVud3Zb9iPTWJuxncEpopLs/87XGcurD9e62v34FO1kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OG42TKth;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC8606A333;
	Sat, 14 Nov 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OG42TKth
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794616131;
	b=YQiOuav8So4UNAsPiliX3fAJmXQO8yqVUam7edSPaD+gGcmxwo9ZFPLfR0vKcwVaNTSJ
	 EhYL7KBg3f4dxH9krhYHeb4LIxqxQ8PPujoflwJQ7uyhS6IZ5I9JZtZqKH6U5NpHrY28J
	 clebEBhekqqFtSJdRYOyEKiIhZd5eN5B3RqMTNj5Giv/LdJNE9R9c7/Nq+9OxB0+oaSfw
	 A5CQ3SFuzKY/hlNR5FaNjD7rDqLEFfkKRAS+vTV+djlYyKxbPmpGLeVR3ZKWsBrlWaMkL
	 wX8lII2kGPHALEMmBfLCGHJ48GUidV3+qX6kUktFUKFYbi6+mNdkEGufM5zhCeDGLFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794616131;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kf5Lt7yzOAUQ5ueELRwWwf4JNFuNEzgr8IOrFVpUyq8=;
	b=qd5g7kpc+OMqU1G1eiwuWsY/u7fp6qShzx0mmJS6CuTdvrPBJToQmA5s20fgdeCAKJDR
	 ON4cdPujY+c9LR62Xg1/zG7QmwKWK7y84/jw3ncdM1pMAyYG2uzetjvMB41W8Imo3Idl9
	 GG5Qi6+VTIoJBQvw8fhRHhpDdZC2KYhIAOeDKX9CF5ekq6cMsISrpCTTOZcljwsilzSir
	 pNQCo/JIATjyVoXRiibt+7nkbmjm2nobSTDjcADQHBsldzv3N7D/B5K9IhjN1GPG32Mzm
	 JzfFD6LIIaBZcJpz9u9ejaD4CIglNWgvEq6P6SaEzrQ0BJq/9QSdwOkCABKQqfjI+8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BA3B41F000C5;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616131;
	bh=Kf5Lt7yzOAUQ5ueELRwWwf4JNFuNEzgr8IOrFVpUyq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OG42TKthNV3+D24nHG8puXdYOgOTtlQldzxnYKIdWABgYCmqKpVvtwjSP2z8oqFkN
	 oQiEI96p7xhPAfMSM20x9zNCpNxLTli4uvBtUOCpiaYFJtBcdPhbmABUvTcaEK1e3e
	 tOafL5nSVpxFxbYEjr1w8R9MYzcMDn0A9SJM8YkweTqbGFdiDPpzZtK/ti8iauhFXp
	 cRXFOI84z6f7truieORG+pAFeIlolCzq2FRFLpalTiGufI6de6SIfK/MmsLOsJcUPS
	 tUdkVpB2aXkOILbFq5YgRodXFEM0KPunX7Mdbkxa86n7gFXQHbkur1Rtustoz/MWt6
	 Y5CNz14BCY8FA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4440949BDE;
	Sat, 14 Nov 2026 00:28:50 +0000 (UTC)
From: Matt Thompson via B4 Relay <devnull+matt.boondocker.io@kernel.org>
Date: Fri, 13 Nov 2026 17:28:49 -0700
Subject: [PATCH RFC 1/3] PCI: rockchip-host: Skip downstream config access
 while link is down
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
Message-Id: <20261113-rfc-b4-v1-1-b91dcb502250@boondocker.io>
References: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
In-Reply-To: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794616129; l=2087;
 i=matt@boondocker.io; s=rk3399-rfc-20261113; h=from:subject:message-id;
 bh=dQmkjngK0wLJ2jAFS1PjdlLb7zJkoCy2sJ8WeTsPps4=;
 b=JR1YncO5hnReTvvhdAwSDCsA13bb6Uh5v/R/4psAbauJ2HbOSxQ7HxJxRJcKSmMovrv74WMdl
 mW6ULFx5WvtAmnsrDSHcGia9vEWR2Zu6zpVW62Hb7KUok9Or2TYt6YW
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


