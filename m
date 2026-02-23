Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AB14A60C;
	Mon, 23 Feb 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857963; cv=none; b=VUGrkRNiXcPABbkMPXKFMEMCtc2tsl1bXKQ5WiKDnHAny6zbt5rC6xCvAZeV6visRrx4cHUkiKJcsCKs3hjgRLvNfK6JzfjrMLzQIG2ytsWS+fIPCBWltSdOJzZakMsB8GdmF+33cq0eb1juFDTfYIDTD6cTA/LNBnGVNGz515M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857963; c=relaxed/simple;
	bh=iWmqYcni0cz3MRc5Qemm8sPMRUd1k7zTynVw4lp1/8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Owmr1bLt0qN95gospWf6gO/9SsjDFl/LXFRSSteXxAF59Z9/Hiyo3Ztfjt3JYLkznqEfWKlpcyMkqu3iZ11yGACk6mgAfo5xTqTUUAvCTNT6KkFhaoScDDnm2YLvfLfEuMsN/hfHnY90QyXsOiMBpZfzqw18wOEQm/awcmWor40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDuLuz7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDuLuz7F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD58EC116D0;
	Mon, 23 Feb 2026 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771857963;
	bh=iWmqYcni0cz3MRc5Qemm8sPMRUd1k7zTynVw4lp1/8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tDuLuz7F+vhwJItu7PNkRG/g4DPQ/DVxPV7ffTW+G9hazgzovDU0WgPEG0BgXGVcA
	 ajP4bIkMIfUJR/yTEwTd9zmhm4PdP6k+Wtb1ec1Q45PTpimi6u5uo9ZBBPPg9BdNbx
	 RRYPzGDjMwYP1yFdegrXIOoBqufXWaVaPBspy+KG2fo+XhnfHVJc2xDhESCngvVE7z
	 hcTayj3BaZOhGCUhyxZg3pgcIKpoCJAJeHRsdhBMfpcm7l20pjHcBsrIEl9wOKEZx6
	 sPjpJgL1hreO3WlMl98oV54e0opvFRnSfPwzzpLqdduwSDrP4E0vp9alMSEJ9xvzBj
	 Duza/Hp0cPuvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365AEA4FC7;
	Mon, 23 Feb 2026 14:46:03 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 23 Feb 2026 20:16:00 +0530
Subject: [PATCH v2 2/2] PCI/pwrctrl: Only create pwrctrl device if the
 device node belongs to a PCI device
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pwrctrl-fixes-7-0-v2-2-97566dfb1809@oss.qualcomm.com>
References: <20260223-pwrctrl-fixes-7-0-v2-0-97566dfb1809@oss.qualcomm.com>
In-Reply-To: <20260223-pwrctrl-fixes-7-0-v2-0-97566dfb1809@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=C+DZSejy79J+txqGCNv0wX73UYcOZysDCQlY4IL7Iwk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpnGgqzSl5jRV8X8rKF8Q9KRccqVgEhgq/xbbmM
 xWDhExESTOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZxoKgAKCRBVnxHm/pHO
 9TO9B/9IRnAAzaAi2ocvJBj+ICEUmVjCXX7kNpexpHjyGteK51xJQCj5Me6fpQT6w/dgf2zAIiP
 9xv1D5aEUAz3hd5y8MD08TDoYdE3Id5YKuxtAJTN5brvNAfdggQI7B4TOwqBuabcaI4znQS9+NL
 TPqLXkxnjNi8oLZ1mI13pi9fCe1cbHMsJDQag+bVBusQjMXzF1xN+YuXkZFhTufUW6JwDfxua2l
 qU6B+JBpnDhHaT7bkGWgl1sEE0y246QPz25zxXmVZBmzYg2D2lXHxjQWo86L85G15dHGhtlLgae
 qs+maqeAPwG9RbnbhtLA+gtXWYc4mbw30kxNSZxIrcox64hE
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The PCI host bridge node can have non-PCI child nodes as well, like OPP
tables, USB hub etc... So the pwrctrl core must ensure that the pwrctrl
device is only created for PCI device nodes by checking for the 'pci'
prefix in the compatible property.

Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Closes: https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 8325858cc379..7754baed67f2 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -272,7 +272,8 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
  * Check whether the pwrctrl device really needs to be created or not. The
  * pwrctrl device will only be created if the node satisfies below requirements:
  *
- * 1. Presence of compatible property to match against the pwrctrl driver (AND)
+ * 1. Presence of compatible property with "pci" prefix to match against the
+ *    pwrctrl driver (AND)
  * 2. At least one of the power supplies defined in the devicetree node of the
  *    device (OR) in the remote endpoint parent node to indicate pwrctrl
  *    requirement.
@@ -280,8 +281,14 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
 static bool pci_pwrctrl_is_required(struct device_node *np)
 {
 	struct device_node *endpoint;
+	const char *compat;
+	int ret;
+
+	ret = of_property_read_string(np, "compatible", &compat);
+	if (ret < 0)
+		return false;
 
-	if (!of_property_present(np, "compatible"))
+	if (!strstarts(compat, "pci"))
 		return false;
 
 	if (of_pci_supply_present(np))

-- 
2.51.0


