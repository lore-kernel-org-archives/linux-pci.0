Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225478;
	b=jAaDIlyTvUikFLCML8KH7WfJbWcF/RU4h6TgcjFhtQXVPd2pV9eJdiZtHuCrLG8XGSgm
	 AMkRSUKuds1ETVAbUFS1xSpxBfuvyzNvvlplfCYuEzd8QkNJSF8MrU9YaNhdR8WZcBqOd
	 RyeIB54QW0cvw8KgOP6aXAOGevfVeA7da48vOvWEe4xrZ658YTjZ2PzNI5/eVkTiWWvjD
	 XE/4IjwFx1FDrJ8W98jOc/w1+Z2GrnU8vJlVHPQBOJUkvlSk62QZ28q8J9o8L0D1CB0US
	 l+uzHRyHdk2PwC2EC4W+Bxkk5JRxKjPj7F7ZEpb2vzio0W0NLC0sI5XDLBTVaPMjcbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225478;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3LPJ2HrlKN7oBMUZEavDpBpJi9yr4o7ZrCUYt7Dpr8Q=;
	b=Omo9ojoZUajdkuyoNTUv2zHD5RjeUP+qhrUn88+M8hIVhhahR4MsFbxmk2VPAcAp81oL
	 EvVNPakzxSxXq4RNA5dkiqN8hrmdbAIVkrHbOqNT9vVd1AAlhVf9q2OxDrfE/8TlWwKJ0
	 ZaYeusHjPuObaxftR45SvpdyJ7KLjcLjj7AUB4L1LJ6M/23L2tGXrrBs7zXb+Z2kzLI+P
	 bxlTlZWOAWoGedpTgEtYeSDCIvlVd86C9NQaNExg5J1waLXd6mkZGmRHVpHkKIDfUnurx
	 O8cR4kIGLY7wwpvA7lSKF/ifYe0tD9EH7254D1awdHDUGoyEicPLOXpxCWNcDXobeXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDF606A326;
	Mon,  9 Nov 2026 11:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DDF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 9 Nov
 2026 19:57:48 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 9 Nov 2026 19:57:48 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 9 Nov 2026 19:57:44 +0800
Subject: [PATCH] PCI: aspeed: Drop PROBE_PREFER_ASYNCHRONOUS to fix
 enumeration race
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
Message-ID: <20261109-aspeed-pcie-sync-probe-v1-1-71cc9e718623@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIADe18WoC/x3MQQqAIBBG4avErBvIgsCuEi1Mf2s2Jg5EEd09a
 fkt3ntIUQRKU/NQwSkqR6owbUN+d2kDS6imvutHYzrLTjMQOHsB650853Ks4OhMsCPWwcNSjXN
 BlOsfz8v7fi+WRZZoAAAA
X-Change-ID: 20261109-aspeed-pcie-sync-probe-fa1d96eb3ce9
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, "Billy
 Tsai" <billy_tsai@aspeedtech.com>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794225468; l=1635;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=s6Law+1V/WSTB0M0wQ+df/1sBAiY3koHL3kisdnpil8=;
 b=LUMFJRsfpnYqDcQzTsKxiRuUo3UGu9RdRs4M0DD8r19Mo94UXrSlUGkK4aZ/qKCDzkk8T4S2+
 QRj93BW4SwtADPkEpcmNMfvJwqPuLiA0vtNXhKM0+cEhtqH8E2JXCYn
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The ASPEED PCIe RC driver opts in to asynchronous probing via
PROBE_PREFER_ASYNCHRONOUS. This allows the driver core to probe it
on a kthread in parallel with other drivers instead of waiting for
it to finish during the synchronous probe pass.

On boards where a PCIe endpoint driver is bound early (e.g. built
into the kernel or probed from an initcall that runs before late_
initcall), this races against the RC driver: the EP driver can start
probing before the RC driver has finished enumerating the bus, so the
EP device is not yet present and the EP driver fails to bind.

Remove PROBE_PREFER_ASYNCHRONOUS so the RC driver probes
synchronously again, guaranteeing that bus enumeration completes
before any downstream EP driver's probe() runs.

Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/pci/controller/pcie-aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-aspeed.c b/drivers/pci/controller/pcie-aspeed.c
index ecb7562f84c0..def5591010ca 100644
--- a/drivers/pci/controller/pcie-aspeed.c
+++ b/drivers/pci/controller/pcie-aspeed.c
@@ -1104,7 +1104,6 @@ static struct platform_driver aspeed_pcie_driver = {
 		.name = "aspeed-pcie",
 		.of_match_table = aspeed_pcie_of_match,
 		.suppress_bind_attrs = true,
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = aspeed_pcie_probe,
 };

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261109-aspeed-pcie-sync-probe-fa1d96eb3ce9

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

