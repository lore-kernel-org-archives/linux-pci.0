Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070215;
	b=CD8rFc6AwSnpY9Aq5rTEyAdZyeOwWuxtJ3pXsq+3DI941jG7JNKmf9nY7nfGJpQ6CBM/
	 a3BKJ4rtryrH02bZ2FjtrUI3w273myH+w69cD0anQqOTwllsEacj0fB18sVKb5TxWth3F
	 cj0aJ5/6HB9cm0Z+aru83Vc49nD1f7KFQNM18TqD7WGFPXeHvwzYqrzQEKFe4oL45Sv8+
	 pFus68LfKksu2/axDDCr8V5082a/kGJ4RaYVS2UBeSL3RauQwBjN0niggIZYePP820sJS
	 dOhEMcGebP5Q4zAn5LiCwgj2kJZSNVAVCRVo+nvxoVPQqUt9T/1KoWjEJraj+iqyvyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070215;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WIiNEYkLhMH5xuFtxYEiUHUtjORSiFNExa3B7mBjdCk=;
	b=JKKTHL+rowSA9pgvbvcE+uuVXhpFYmfg/zy43/sQYBC2hTiodMYjFw3RSa+TonJPwgGy
	 EqVtG5wpewh9mB53diXRQ+/GdL2n4yRNj4QFnjr/kYh+2Tdo5oVV+a76i0htvKiATnsg/
	 Vt/W3MpVgqS5r06HHhC1rOaN9gnhtGD2pl6a57ngj8dbSx42Ejf0n+IbDuT2eNOlVpEg8
	 9AkrUrZw/6dLWLz1i+1JYa3DePCg6DXsw69mf1ufPxI6hxTW1kTzmfnHdhEUvBt8STk8N
	 Z75JEWgLhF39LD95SslaJIep17axp1GXI0LH3NYSYrLYKg8zPIYJbokRc4DNS4rpQEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27900606A32C;
	Sat,  7 Nov 2026 16:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458ED1F0089F;
	Sat,  7 Nov 2026 16:50:13 +0000 (UTC)
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
Subject: Re: [PATCH v2 1/3] PCI: Match the hierarchy's MPS to a device's
 MPSS as necessary
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Yue Wang <yue.wang@Amlogic.com>, Hans Zhang <18255117159@163.com>, 
 Myron Stowe <myron.stowe@redhat.com>, Jon Mason <jdmason@kudzu.us>, 
 Keith Busch <kbusch@kernel.org>, mx2pg@pm.me, 
 Lukas Wunner <lukas@wunner.de>, Frank Li <Frank.Li@nxp.com>, 
 Mahesh Vaidya <mahesh.vaidya@altera.com>, 
 Ricardo Pardini <ricardo@pardini.net>, Shawn Lin <shawn.lin@rock-chips.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20261020122854.1500883-6-cassel@kernel.org>
References: <20261020122854.1500883-5-cassel@kernel.org>
 <20261020122854.1500883-6-cassel@kernel.org>
Date: Sat, 07 Nov 2026 22:20:11 +0530
Message-Id: <179407021193.65886.10216169012699853081.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=gaL3wNueCo/HvDyg1kFxOopxgOdYw80UWB+aqepzZZw=;
 b=kA0DAAoBVZ8R5v6RzvUByyZiAGrvVsTInrT0Pll9D6vInKFH58cxnZijtGd7B8RJwLpOngEH0
 4kBMwQAAQoAHRYhBGelQyqBSMvYpFgnl1WfEeb+kc71BQJq71bEAAoJEFWfEeb+kc71AyAH/0Ix
 nPG0jYqoH0yBuKYVpSVfHgY6sDoQzWhRp9qobUH0/q0R6FpW42MM7NwUwBUQPu0WnAOwjnAcsWv
 EPI8UdWyazFzVbsLPJz2HgoxwZP4aJ4yoVUgwd7hB5p5KLY+oRu/aA3R5E0DPm4rFvktjB1QBkm
 a+DlSle2fsiuc51PcgFw6bzXYgs0Xb0F05axu7tOlTcrmbcZKhJj/xzuc/bMYuuGNmULlLdGQgJ
 9Ay2G25uLu99f7oZTC8RcYHyKUBm1ELRSPSsMz6XQZmtXPm6Qim1aSCJYeEAvz/pPH+xPxcaX1w
 rcBXDAXnVYPk4KKMPstsIvTB9nhFWLReEVLuTn0=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-20 14:28 +0200, Niklas Cassel wrote:
> From: Hans Zhang <18255117159@163.com>
> 
> pci_configure_mps() enumerates top-down and programs each device's Maximum
> Payload Size (MPS) to match its upstream bridge.  When a device's MPS
> Supported (MPSS) is too small to match, commit 9f0e89359775 ("PCI: Match
> Root Port's MPS to endpoint's MPSS as necessary") reduces the upstream
> bridge instead, but only when that bridge is a Root Port.
> 
> That covers an endpoint directly below a Root Port and nothing else.  With
> a Switch in between, the Switch ports have already inherited the Root
> Port's larger MPS, the reduction is skipped because the upstream bridge is
> a Switch Downstream Port, and pcie_set_mps() then fails with -EINVAL for
> the endpoint.  The endpoint is left below a port programmed for a larger
> MPS, so any larger TLP it receives is treated as Malformed.
> 
> Multi-function devices hit the same hole from the other direction:
> reducing the Root Port for a function with a small MPSS leaves the sibling
> functions already programmed to the larger value.
> 
> Walk the hierarchy from the Root Port down and reduce every device that is
> above the new value.  Reducing only the ports between the device and the
> Root Port is not sufficient, because a Switch does not split TLPs: an
> already programmed sibling left at the larger MPS could emit a TLP too
> large for its egress port.  As a result, a single device with a small MPSS
> now lowers the MPS of every device below its Root Port.
> 
> Only do this while no device below the Root Port, other than a Switch
> port, has been added or made available for driver binding, i.e., during
> the initial scan, or when devices are hot-added or rescanned into a
> hierarchy without endpoints in use, such as an empty slot directly below
> the Root Port or a Switch with nothing below it.  Such devices may have
> drivers bound and DMA in flight, so their MPS can't be changed safely.
> This is the same constraint that makes PCIE_BUS_SAFE limit fabrics with
> hotplug bridges below a Root Port to 128 bytes in pcie_find_smpss().
> Like the Root Port itself, Switch ports can still be changed: they don't
> do DMA, and the port driver doesn't change Device Control after
> enumeration.  A device added next to endpoints that are already in use
> is left at its current MPS and pci_configure_mps() warns and suggests
> "pci=pcie_bus_safe", which is what already happens below a Switch today.
> 
> This only affects PCIE_BUS_DEFAULT.  PCIE_BUS_SAFE, PCIE_BUS_PERFORMANCE
> and PCIE_BUS_PEER2PEER program MPS in pcie_bus_configure_settings() and
> PCIE_BUS_TUNE_OFF doesn't touch it, so all of them return before this
> point.
> 
> Fixes: 9f0e89359775 ("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani


