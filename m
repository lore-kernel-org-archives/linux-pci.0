Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92F4D0CFA;
	Mon, 28 Sep 2026 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603300; cv=none; b=uYYqWoLBNHWaet/RPEaPI2XK0dshF6fUkY+d+oVFfzpHA79dXeRg68qqnbwzkOV2XzIi/1Rq1ULvL+WJbzye304TfvT/ZHAn73zCBjmZ3HPxWo+3Sfgs5Gfzn4b6r9wi032rDrEe3oF6NuNrDVw4cDdZ9F4czz9qiMla15yYtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603300; c=relaxed/simple;
	bh=0T3U1aXBXMuP/XUFiuZsj0r9Vk56wjPuqVb7adaAvic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qdWbP53kywAX0i1Z82uJW7lrKiLd6xl1jFiTBZQ1xZmtnbQqm3ArqKZp0lBJdM5mZNU57bU0kKRwsof8VLpaccyhKVd7LMEgl8lpzDSIJya7n3YP3cAfBaYxcR8BrUH1o3ikCRmcDRMC4mTu7xJ+6jzjOWcr+fLp4pilw3rhSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knBf0MIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knBf0MIz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD6DC2BCB3;
	Mon, 28 Sep 2026 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790603299;
	bh=0T3U1aXBXMuP/XUFiuZsj0r9Vk56wjPuqVb7adaAvic=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=knBf0MIzn6sk7yr3oA3wKkTe2rroEzCAJZWyp52BmFNmOa1lqkQh1tyuWDAPyosnb
	 sRLsxsO0HxAR0+xWGkBn70bhL0cU66TYegfPjv1SFz1/UZM8TSzQcFuwnP8eoIr/mb
	 wDtz3DjKFTEybFFVb3yqT5JN45FI5LJRLeeczEi2YWm8LoA5lC64odJfDplJvpEpx3
	 dtyDkxANC/jT5L40zHzZEH469oGLN34eRu9Z8Hq+SxqwFLvOvksF31Imn05xYu6SD1
	 7j7ty5IvHBUP4DYHJGgBPE4pyb3QbjTZVQO6y7gynZrd+tbZNPAYrlXjKJmVdoSttS
	 CmLhK5PB2vTKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B0ECA5FA5;
	Mon, 28 Sep 2026 13:48:19 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Mon, 28 Sep 2026 15:48:09 +0200
Subject: [PATCH] PCI: layerscape: async probe by default
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
X-B4-Tracking: v=1; b=H4sIABhwumoC/x3NTQrCQAxA4auUrA3EwZ/Wq4iLmKYa0JkhUbGU3
 t3B5bd5b4FQNw04dQu4fiys5IbtpgO5c74p2tgMidKBhtTjVBzfNV6u/MQqhg+e1UO4KnLMWbB
 6uSpSvxPW/UgDHaHVqutk3//pfFnXH+yB0fl5AAAA
To: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790603298; l=1374;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=FiRn9OiNUjwkWfk6TfzHBQosBVCt2Ztr46nw5buAh4w=;
 b=61ATACnDyWjW6rV7RTXwL9RyAdZDzlU6eY1kSxfh9+/akDvP2PLaEXFhAq3GqnDqV6ZPd/ELZ
 2Cg7PafmqWID96UsYC+Ox031k8ImTNnycQ3by9yvKvgRkTiJ4assXMc
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

dw_pcie_wait_for_link() polls for up to
  PCIE_LINK_WAIT_MAX_RETRIES x PCIE_LINK_WAIT_SLEEP_MS (10 x 90 ms)
per controller.

The controllers are probed one after the other, so, it leads to slow
boot time.

On an LX2160A board with 4 enabled controllers and no link on any
of them, ls_pcie_driver_init took almost 4s.

Probing the 4 in parallel allows to have it down to 1s.

The controllers are independent, other DWC based drivers are already
using async probing such as qcom, imx6, s32g, rcar-gen4 or stm32.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 14d6ac4fc53f..7f37a0537159 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -419,6 +419,7 @@ static struct platform_driver ls_pcie_driver = {
 		.of_match_table = ls_pcie_of_match,
 		.suppress_bind_attrs = true,
 		.pm = &ls_pcie_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(ls_pcie_driver);

---
base-commit: 94e8d4e94266bb9737a5963810a3f9365cb2f39d
change-id: 20260928-for-upstream-pci-layerscape-async-probe-084cae5d0907

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


