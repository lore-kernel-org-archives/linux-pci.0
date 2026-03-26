Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60134AAF7;
	Thu, 26 Mar 2026 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512400; cv=none; b=TCSX1oQoSCUqvGN7wN9015NLJTWobWQpQ0HXhnJ6BHucQDyem0EAEIYx84uTohuNrWRcBPaDqqB9MdsgV4X9vTRtVNzfxBMqCfpSKWuhuseaR1exjC3S83Y26Sfyu4cly2iZ9RKnw8d1dYyPFc2V2yswZl8syTII60u9JeQQTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512400; c=relaxed/simple;
	bh=JoCqd4qTmhZAw9Ra/kUSAYchs5sr6tzJ0I7Nt266T1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKw+k21v0hRl8mix9vuts4GLB3m07jNZso2j4ZXtXIPe+z3wPFX5S99Dq3HfxaM4iycaCYCUo4wMIbPXDVj/T3AQQwsUNu3G5unCXr0OiP4bQ+6MwjRg97RJM190YDCbVqnJtMVStBJIgPzLolNxPxA/MIF9YNAk0FhOyw40UlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH1UAT5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH1UAT5h"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D0B7C2BCB5;
	Thu, 26 Mar 2026 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774512400;
	bh=JoCqd4qTmhZAw9Ra/kUSAYchs5sr6tzJ0I7Nt266T1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TH1UAT5hzIgtdqv/6CWQQ0xP26ZPa7fOqg5OIO3UWuNlu6DFCBCUr7Oxx26nkmb9o
	 5xBCKvUhIP+6lg1yCGBHCBf19un3s/QXxmaH6tYeioz2az/zHTRu1HAkIyJxlcB1g7
	 lP3vbLrpGIAAZXdN4B79V7R2f71WPR/7uQA4/qrsfAjhD87VFBF9DVHoCRjAFx4qrR
	 FiauoA2W8iRRbOj7y2yK/6EjqH1sX+5nIAGcPQ9Z1VQrTDWwBx0NZ2HOYeLUo2P4FH
	 TscDrsDCN8vr0m76+70UXWVNc9Fd5KMo5LdHuqVbhGmsB5BIw/K1lDnOLLgmEq09XN
	 6YMrbcMX2GxkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E953106F2F4;
	Thu, 26 Mar 2026 08:06:40 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 26 Mar 2026 13:36:31 +0530
Subject: [PATCH v7 3/8] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-pci-m2-e-v7-3-43324a7866e6@oss.qualcomm.com>
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
In-Reply-To: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=9JYNk+DMPq2LlZQfTiexJ4EeAYXDboalcaCh+TYovs0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpxOkNuIrEkkiuiXa2nFEPz20NZFPny5rmu3war
 entKs5o9PaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCacTpDQAKCRBVnxHm/pHO
 9XugB/0QT6xqMW6JkOSh7MAySgoIlQcmUPLNlWIwqE4SlCb7Rn3yZ7WFiAQq4NvkfO3qN8ZyH3t
 PsR5Q/7sy7CeFTRCM9adFS0899s58LIfq4dGt9GHpFVGfQZHzJOMQzJCbByGAcUcuD8P+01yv/O
 W0WqoVSvkm1KwNaNLPYVSnsUumUH3ASPr6mORH0oQ0VFadER5w9P7LDbZEH+h3nj12e/6nqLpof
 RVJsmFEijW2PKWBJIXUbz2fxEyvVOvk69DoDbYp18HKimHBxrs/Od8OkCVCx838Z+4vaZPLcpCA
 1cdOHfrTSCosxy2yOc/OurPLu3S6UPc6WYMx3sceBvuMLy0s
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If an external connector like M.2 is connected to the serdev controller
in DT, then the serdev devices may be created dynamically by the connector
driver. So do not return -ENODEV from of_serdev_register_devices() if the
static nodes are not found and the graph node is used.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/tty/serdev/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index bf88b95f7458..e9d044a331b0 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -561,7 +562,13 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 		} else
 			found = true;
 	}
-	if (!found)
+
+	/*
+	 * When the serdev controller is connected to an external connector like
+	 * M.2 in DT, then the serdev devices may be created dynamically by the
+	 * connector driver.
+	 */
+	if (!found && !of_graph_is_present(dev_of_node(&ctrl->dev)))
 		return -ENODEV;
 
 	return 0;

-- 
2.51.0


