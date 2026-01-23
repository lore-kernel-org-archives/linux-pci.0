Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EE311955
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160800; cv=none; b=ZBsUburigQZju8Olm49Sz7FWEwTMoA8VFAhHiWSALWh0Rmi+eOnRJz7JmQ7C4adovSC31brhVz+crqpt2t81LE/rqUMiLGuAbMMqU0RhlqxxrU3/jdBY59JKvAr84LlJHQWl/y2fvxw9HmLC6BwjkHVs+0AqvMlBq/QIZ+CNhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160800; c=relaxed/simple;
	bh=hmfENqf/sd3/VRtj4wnxTAZRV2UiOajflbJWh//T/pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyewaB/BBAyr7UPM0Xyu4ua9IuNhC0RdXvfgZtAxx2PUTey406w1lfDFXKhZNmKrUfdI23aP/4NSrdpod5vegTQY/OxI3oYVQ8yqHLC/ssxbvN5Nb2MiNpXOd8wKt5V7qjY1qUMyV9JkYGmArr3A/GousWHcbhoKs8JZPVBFHoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT549tZZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT549tZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8793C4CEF1;
	Fri, 23 Jan 2026 09:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769160798;
	bh=hmfENqf/sd3/VRtj4wnxTAZRV2UiOajflbJWh//T/pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT549tZZzlQFtsgkxwA+KqbRPX0uASkRPLTQhBD9clEwMfPm3sLqfhPersbA3Cch3
	 hLme+g91CCyLhwPF60s0Iv58RPoLeFZMiBJZnsobO8eWGeAPr+l6B2HUbI7KcHyR4S
	 kESsZnpMU4Sfyl/hkaN/wjDi7OIgx+ySc1hOKWhy+35GQQPPUBKo456uCtCyumYIOW
	 aoZc7GqBhWVVDcI7Kx62wELKfFdWArvITVN2r3kq4obPBWJEN4cJSLCmNw3Lj0XFll
	 A/Xhota8DE+l0KmiJGFpfdO7U8rA+b+hVLGS1lzwulxtjc12EaQ2Fjh7JBaa4P39kN
	 tQSSIDxVVvpSA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: dwc: Improve msg_atu_index error handling
Date: Fri, 23 Jan 2026 10:32:11 +0100
Message-ID: <20260123093208.593506-8-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123093208.593506-6-cassel@kernel.org>
References: <20260123093208.593506-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=cassel@kernel.org; h=from:subject; bh=hmfENqf/sd3/VRtj4wnxTAZRV2UiOajflbJWh//T/pk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLHeQ/3+D5OPeh05okWUaViU6+Udd6Vzm9TrS2LDdhU 5hizePSUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImk/GP4Zxc6zzy5UubX96sb A08aqhyfulj5z73v2xKd0pPP/LbepMvIcOFeeGTImcw1N6QtX545t6Ju7xkW53srrhWdC4yUnbp BgQ8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
If use_atu_msg is not set, it is completely useless to bump the index.

Additionally, if use_atu_msg is set, and there is no outbound iATU
available, return an error.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ae5f2d8a3857..d7f57d77bdf5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = ++i;
+	if (pp->use_atu_msg) {
+		if (pci->num_ob_windows > ++i) {
+			pp->msg_atu_index = i;
+		} else {
+			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
+			return -ENOMEM;
+		}
+	}
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
-- 
2.52.0

