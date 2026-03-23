Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A46394466
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263928; cv=none; b=PQJCifO48DDkvuWgHTAHE05LV2O60zZsDFYea+0EklMptn34N0DrQbZby3g2zcdD9qMk1qXQmjd5746AXav1Sagfc7hhjqrIPBsb6TQKfR8qYnHRIzooRMLmL5z/Y2a1Vu5qGCkvuBIrB9EvgEMLy3+hfvDqb2pYa2Olk+qwtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263928; c=relaxed/simple;
	bh=dKKs0G/Wa3KBfAb/TZIyIIQz+VdKNwuAztiiDQx4WYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p0EBU1D4QErs1KpaYpHL+nr9JN6/noidNwPM/4e+usgg5KmtVK35qDJkcit9xQji4JiHDx7TsAAitME2t829Wosf/U82rRsjNIj9DTKBxARAuE66yruhbF4U+68/lyCIXeixYYW3WZrCRjo9kRYzBub0eOFDwRpKyeeGQ/GpKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffvxxWY9; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffvxxWY9"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1034404a12.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774263926; x=1774868726; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjDPWCi+UxS6zX6zYKH/Qn9Bf2hHL2LIeyIwDf04qlA=;
        b=ffvxxWY930WyhDuZU7ZQo+CbWS33+0onCu5HjvI7LtV17UzvkouRIgmJ1ZTWm/p+MX
         aJcH9nPVxvEAz5ma67H9KcDRu3TpwKks6JRfR7XsDw55tKry8rot0Pz3WHh/AFZfsnqC
         Hxd+cOo51yJBEHmDGiRMbP/PDlanfT7CeKW+Knrr4zxge+BQuZ9zkJzDOva369U+LBZl
         n1FY7g9BWTGztrhDNp2LXTUk3l9ReTuO1vwjcX2Spxm2naGq5Dz7G5K+KI/ImiybTD+3
         5To0n1SWoTzgMhLaBB/YBrLTZbdrHuEqqbcauVZ9m2jPi4rKtq43Elzqz01IpnDu+qVe
         VRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774263926; x=1774868726;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjDPWCi+UxS6zX6zYKH/Qn9Bf2hHL2LIeyIwDf04qlA=;
        b=pPoiv0UDSGJCsqQP14VdNANKF9RTMwzIF/AwxDWBPoSZp0FPdKEbCPGGYH0vqxPC5v
         jJOAe4C7ZlC+IZNU/ECq62lfGqETN4WKvGm4UaSi+mycGyGNDhyn99m4p6KcjEW6w1up
         eN+Y6LV9cnMR2cur5q0JZKb8587XnMg1+4+JfT1+baBAlpEOKkSewDYq0PSkQ97i94Jg
         Ztpfl1hbN7bsocoVt+cWRhaXZr5HMp3o+iZ0x3B6q315a37oRCMfSiisPRXPHfdkHCgR
         /5BO6wA6/yoKkvswk+upX/1hL3rjC4S09gwPvuCmXTVbIt15Z9+ZLuFdRp/jZd6SAQ9v
         7TZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6b2F2nXSbEF8uRebBqRMmXTNaId+2zsI6ZPgimBDl3fkR0NjaySI0+wVrz+Y/9nxsj+KMJzHgbAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN72PAnAZnJ3q1rPwihwNKyzUCpt7A08cgTcDOnYQ/ReQ3G5db
	m+ido6+VUsf9AOa9/qKvoUi9560LboZ2AQsibS4bqv6k62hzIn6IgOYBGtm5kFqKXELGpg==
X-Gm-Gg: ATEYQzw8kvDuh5B9aN0kfyaMECMGe2HOC7Oq0TYplV+yqrWq0Oyt+3eFoqqvaBHaYy0
	zMDGL1lrDlaKlPowb2GMV8WZQpfKMmKhqwoMXu10Ds4BAQ/BPRQJ5v4ip1MS9zPVP+VsMai/zRI
	Dd/Cx4cCMXE6y7NZLJaBGClF166J3dURyf8aohoXTIzhR1FH+eaxmX3xwEX73aMF0lOGN6UF1EB
	2+LZnHblmmC/PmqoBohb+9BnXnt5rEx1RhufmkbjIvXkPGIGJxKa1ZMKWVoOrh56oSmQLYN9guT
	mgm/omNjQNebNMMf+ezQEPllfYQ0AJxTm/obSwfD4DNjsz+flmdDv9c4N+M8M2P7ClyX24yDTTZ
	1V2QJ2X1a60JINQr3ym7rFqG3SgjXQRdQ8MFn/BFtlynMDr2fJIcYv8VVUt90l5U3wkDouwo+2X
	3ifIq/x9/XWwfj4AVth6ewoohc2o7+2GT9u1Bs
X-Received: by 2002:a05:6a20:a12b:b0:398:b619:b624 with SMTP id adf61e73a8af0-39bcea63274mr10869998637.29.1774263925537;
        Mon, 23 Mar 2026 04:05:25 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c744560683bsm7576673a12.30.2026.03.23.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:05:25 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Mar 2026 19:05:22 +0800
Subject: [PATCH] PCI/pwrctrl: Fix device node leak in
 pci_pwrctrl_is_required()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHEewWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNj3YLy5JKiHN20VAsTgxRzY2MTE2MloOKCotS0zAqwQdGxtbUAISm
 t51gAAAA=
X-Change-ID: 20260323-pwctrl-fe840d733443
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774263924; l=1158;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=dKKs0G/Wa3KBfAb/TZIyIIQz+VdKNwuAztiiDQx4WYY=;
 b=tKDL6KmyltfmBlY0kMXjM7oHz+dIX6zkAsMMU57BxYyZTdRQxaPcxh/CKwywSlea+5lz+ZnuK
 vSMtD4tzFQdBNKJuWNEUsl6vyYlz+XumZ0H8waOYmhDHVh5vwBl7yTa
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The for_each_endpoint_of_node() macro requires calling of_node_put() on
the endpoint node when breaking out of the loop early.

Add of_node_put(endpoint) before the early return to properly release
the reference.

Fixes: cf3287fb2c1f ("PCI/pwrctrl: Ensure that remote endpoint node parent has supply requirement")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/pwrctrl/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 7754baed67f2..97cff5b8ca88 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -299,8 +299,10 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
 			struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
 			if (remote) {
-				if (of_pci_supply_present(remote))
+				if (of_pci_supply_present(remote)) {
+					of_node_put(endpoint);
 					return true;
+				}
 			}
 		}
 	}

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260323-pwctrl-fe840d733443

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

