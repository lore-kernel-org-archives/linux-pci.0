Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601888;
	b=dq2yGgtJgjNZ7xSV2bR7qlMygfR+O/7WWF4VCJ9+0vgQCYjK0TFG6CFoj7TQE5hM1smM
	 xRqeAJQYqUctVTB42PnBZUrZpwY698af8P4f6a3ggEBnNPq0uRBI0hDBJxN+rTCLG3a3u
	 OP4QlusgJsuFOj2CwOHTzd5NdAgHSOgmeSyu4t/Q+yQ0ZZORw4/EBVbEp5B3rwiH8Qk2O
	 vfbYkMMjDJ7H8BV8qh7JZbIPP6zx/YnH5+GRZJ9A3rsXge5YazEB2zvxXDUeqTNM8LcgT
	 6h4bOmrg3avBvVa/pIlsfnGb1sT7/5YjBvs+mFL3Q4vOcu44WwsRmN6YKF+HNZ44dJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601888;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C8ddVP38kpSgHlDxU4PJo/sZKlRR5kUy3K1iHjwxOSM=;
	b=lg9ARiSPMle7nzVPN63jcAXq8mncYAiMF8VDggWgATu7lwUZVWdX4dHA4BJWOa8lhN6Q
	 7CtBbxSKJaZEF+GhroCsg6n0uO9Kb6498O+QBxjG8LRkDNI8JEKb8Iytrg0KHpolzBioJ
	 hRsTBMhKjhUacu4cYaQwr3yE9RuL6E7e4iA9QCIintk5G6hlHsHSCJyVgMXUCi/mHd5O3
	 rdy/4hmdBKEYBrnwQ5WB1NB7Rtvkl26kE23psuOuc0ZWw1nqLK4KzV8jV3Qx1qt6BL4jb
	 rpisb9nvDz7hAOnw3EZSGgM7Ry+hrEUvuaom2W1ZwQn/4rilJj8AZ+za2tXig6eOmvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7CFFYvd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BC606A323;
	Wed, 25 Nov 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7CFFYvd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795601887;
	b=Mi5oHcDgyDzi3BdzXWSRoU8nB5UkBJ7V9wSqww654MBiOzb0UvnYKCFSAiiVkGXKJ8rq
	 8Mq4JMHvuPAFK2fgahUmwlDkg+34SVM7+kdYAWgwzL0DZv3LO2B5uNcFjahH/1QEjV8pY
	 QcLxUompgPeM/cNMIW4u2ZrTJjST8UbgJDiOLpu/5cHWY+0mhf5NAk22N5pJukShcTswB
	 +qP9oqb/WFo7kFx8L6wr9mwWQf+9tZARA63Kw/4f00aZtWBoWeQXScGnJAXY1SJmQRDIP
	 olTCqXMV25ZLSFZRjCWDxCUJfepEGJ6CR0vqgMedH+IE63X6I6mg37qh5lONAMHdKqA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795601887;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C8ddVP38kpSgHlDxU4PJo/sZKlRR5kUy3K1iHjwxOSM=;
	b=qcs6Nk7MNcgXncCXf+zZ5p6D95c6HsE3nU0SEYgWASgkoqvT8MAimMwWYjInNhHySj6u
	 OqnGWtrrBsim2gFCLa7AQX+XGplWiJG7nWHun6ASaMoWTDDyi/FW/drOYRnoI2wm+uuMt
	 MxEUwVvXJBZHvUS72Zu/We5MuzEXfLo8bGhR7MhhbY6/TLw7lvrnS7pM0l0Zy/KtH760A
	 RSL6tmV0eKMIec/V09XG5xeSNTlMaLGp9Nm8f2QmjmKhZ9IYswFUX6fH7LbECe3LJ4x5k
	 xdtCSEvFfJ0URu1K+XTli9IcNixKNulakLsUWgZACk/PW4yL5pZPvfqQQ6pZFp+DFAA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFE861F000D2;
	Wed, 25 Nov 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601887;
	bh=C8ddVP38kpSgHlDxU4PJo/sZKlRR5kUy3K1iHjwxOSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A7CFFYvdC7LIEAlVjv03u1WW5Uv6Q24xeaWG8sD54fAzLF3gk1m6aiUwaGjrfohRK
	 g94+n4fI8HGl9nM8t69ThPouyi08l4FwX0TkpWRXDLXsaB2//vNWSgFCQyDAgcWsd6
	 WS1380W/U9Q6sAt9y8TR60g7W6pCt50Xk84YhiSG2pBzvjHQCnOHBMwbpEXsGbDNeg
	 pnw4PDc3OhssW8IbHCQe9wuLZrtN6egjEhwH7INv289LHpP9ABvqsLx8sjqhyJlnqh
	 DiJK0/3a7ZkMpS3RqlwGYv9S1BZqiEx6QbSfXXH/POZteOl2cPfkjPcaxZ2n5GbVaz
	 QmharPDZrWa1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 787284CE06;
	Wed, 25 Nov 2026 10:17:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 25 Nov 2026 11:17:41 +0100
Subject: [PATCH 1/4] thermal/of: Add thermal_zone_get_zone_by_node() API
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
Message-Id: <20261125-glymur-thermal-fix-v1-1-b93a9feae156@oss.qualcomm.com>
References: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
In-Reply-To: <20261125-glymur-thermal-fix-v1-0-b93a9feae156@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=5k4BZ2Ul4s1/TwVfhXlkb5ymb3YEzOmcYly7NzusMwk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBrXN8u8ZRLWNBFP4jw+2gD9HawI4nmGTJbgqY
 CxNRmHYXOuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawa1zQAKCRBVnxHm/pHO
 9WFCB/9mmUu/B7ciK+Msk45jcGrCF0JgSFpXipyfDaWN8v8q21uXAhXH8wqe6hRfLUcRgbp/TTP
 YEWv4vT+qRMs1A3TwV5hf7+h5UQ5L1F/E6zey9l9gsFE/Y/rox8MRkC6k+oDVqVajiNaewEQXkC
 5IrojZYtt5oa/ZN4BViWSe9uJcNKLIR/PKsR1lxd/m5eZTUJcQLJO8yH0wGOQkLuCMS2Jtj/hrt
 fe35TS0SMQYNus95gqsRdnJg05oEjjuTIpVp4oCz4CLPBRXt/Rbgu+UWPK6gbmbK3un73VpoYNZ
 TtMg1as8xc5Gspm/PAI+RovSpPsViwSp5ZxbwzZ+k/CkKXYS
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
Content-Transfer-Encoding: 7bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add an API to allow the drivers to get a registered thermal zone from OF
node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/thermal/thermal_of.c | 21 +++++++++++++++++++++
 include/linux/thermal.h      |  8 ++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9e96fb1b033e..e38f67c19c8e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -530,6 +530,27 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
 
+/**
+ * thermal_zone_get_zone_by_node() - get a registered zone from its OF node
+ * @np: device tree node of the thermal zone
+ *
+ * Thermal zones described in the device tree are registered using the name
+ * of their device tree node, so resolve @np to its registered thermal zone
+ * by that name.
+ *
+ * Return: a valid thermal zone on success, an ERR_PTR otherwise (-EINVAL for
+ * an invalid argument, -ENODEV if no zone matches @np and -EEXIST if the name
+ * is not unique).
+ */
+struct thermal_zone_device *thermal_zone_get_zone_by_node(struct device_node *np)
+{
+	if (!np)
+		return ERR_PTR(-EINVAL);
+
+	return thermal_zone_get_zone_by_name(np->name);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
+
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 306ad17aed89..c5278d1ff0ef 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -216,6 +216,8 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      struct device_node *np,
 					      const char *type, void *devdata,
 					      const struct thermal_cooling_device_ops *ops);
+
+struct thermal_zone_device *thermal_zone_get_zone_by_node(struct device_node *np);
 #else
 
 static inline
@@ -254,6 +256,12 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct thermal_zone_device *
+thermal_zone_get_zone_by_node(struct device_node *np)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,

-- 
2.43.0


