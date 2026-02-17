Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7542281532;
	Tue, 17 Feb 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323531; cv=none; b=VmOufF+Ej2QtsjKeTlqxeiNWbjWqEdKydjiaCFeBHvkwogx1et1i88aH9VDpJbnmHKc4yrwGb98s7M1pYf+Cou6ZcoaRfli6y79dX0WwmNHdz0JMGIBQLKLiQ/vm8vo28mmYjV3Y330nMyRNBm+IC3hflzVd/ybHBA2plLTvCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323531; c=relaxed/simple;
	bh=+FvIOo6LaMp1nwA9zSJb2lGx0Ul6585dauW/Ve0I6mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwG09uTJJOKhluuvbTrZxS1UA8udo6GLHpW8Ss25pDfEK5RFE/JffFSNoJ8mOzrr6aKBGMDthjYL93qmIoD9eKY9ze8RUBlad7y65OEF1uc7RP6LjqVul/71ngacRXEZGmBxg5Fb6dJEq4z2M+KkikK/WjNC2M+yraY2F9mZoy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMf6YQrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMf6YQrD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0AE6C19424;
	Tue, 17 Feb 2026 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771323531;
	bh=+FvIOo6LaMp1nwA9zSJb2lGx0Ul6585dauW/Ve0I6mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NMf6YQrDoQfqmjJ2yZ7fD2NOzKge4aBPHtJkwpiRBEAQsLumo1BGla4kSwq3uvfVK
	 BFwhdZmf1M7vKA5XMACq0FijQVb0mLFaLQ2j6MqMUrqdsEL+H36Wmkm4A9n1xAIRAW
	 4KgaKqVPB2zhNJld75OctGPfe9lRwBtn7AdjzShMOFMDi5eBzxuJ2lkRfrKrDpB2oq
	 Hla1K1kO4HpGFzov0YWK0phPZz7e7GbRfobLh/jyLZebcxIbRdr5xgpifyoX1dvddc
	 NVD+cVHBhhBcLo34qAlsUrOQ63Eh674xPE0JtvVP412fT9uv0prZrXAwUhNhH2UUzg
	 OgnJOEUzPTLHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A87E68163;
	Tue, 17 Feb 2026 10:18:51 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 17 Feb 2026 15:48:47 +0530
Subject: [PATCH 2/2] PCI/pwrctrl: Only create pwrctrl device if the device
 node is of type "pci"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=aNEcD1tWIRurJpHegw9tQESfw9DiViDCcnlJdYscw3w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBplECJBvvbUtKjqgm7Y5/W5vm/aHOgtEqONDvkP
 l078hE72uCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZRAiQAKCRBVnxHm/pHO
 9Y+dB/9qein+EP7oXQE9zMgLPXSx0XxeSLsxXSKneM6oVh6c/ypC+5r3ahlhx1AcvSWrT0Zvl+K
 icHW2vegkchJe2pHv1YYPe5OvJlsn5rmSF5Sk/IoKJs4q5F+WIwlbg+pB9o8rR/HfDsWUM5/S2e
 8lXc08sUyYAE7x5YsHsL3YNSkx1JQ0hPNIkh21k7Do5LIWyyWb1Xe6N7gwhudu3z+Cp/YIvckva
 NOAbFgNtINUWz28zMIGL317KwMdhZGhyFihxQKbE5BD96/oXxEUzuYgOzLvXdcapIURhJlOnvVS
 IhBA87WxKKlqX8xKU+UsIPszOX+wm1IPF+APCi4jJsRmNLpB
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The PCI host bridge node can have non-PCI child nodes as well, like OPP
tables, USB controller node etc... So the pwrctrl core must check for the
presence of 'device_type' property with value of "pci" to ensure that the
pwrctrl device is only created for PCI device nodes.

Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 8325858cc379..7404d48427ce 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -272,8 +272,9 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
  * Check whether the pwrctrl device really needs to be created or not. The
  * pwrctrl device will only be created if the node satisfies below requirements:
  *
- * 1. Presence of compatible property to match against the pwrctrl driver (AND)
- * 2. At least one of the power supplies defined in the devicetree node of the
+ * 1. Presence of 'device_type = "pci"' property to identify PCI node (AND)
+ * 2. Presence of compatible property to match against the pwrctrl driver (AND)
+ * 3. At least one of the power supplies defined in the devicetree node of the
  *    device (OR) in the remote endpoint parent node to indicate pwrctrl
  *    requirement.
  */
@@ -281,6 +282,9 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
 {
 	struct device_node *endpoint;
 
+	if (!of_node_is_type(np, "pci"))
+		return false;
+
 	if (!of_property_present(np, "compatible"))
 		return false;
 

-- 
2.51.0


