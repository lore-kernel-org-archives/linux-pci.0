Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A258345734
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827571; cv=none; b=a8zQnnq0ldK5PU7/wWpy5WoG2SNpRlQM/Bwu1EIBIaN5ZjUjpydJ3EOjX5p+WR9l1rOHSGHIe+WqjrOzKQL1YQd3zvoRfs6x/LxL3KtQ52Xe3M4lFyRFDSAU8rGI8CI9WJItaKFOuhYOLSZ1HuwuQ2q2CZmnkbPMyd1wDroMMUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827571; c=relaxed/simple;
	bh=PMWtXQ5cmgbjtLUXyGFJOXGJAgGMVKrspd+4+NPPee4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mv9jqk7bxC0bJdvcuCo/qvcx0VeBL0da3eoIiTv2juEZSGcK8dnObHRhGeY1LbgY/9YGTmEcJKixEe4KCjcvIQiL4GqrPk+JipWCsG/nEadLA8JuvTRQ6oRm6yTnIutkjKE+SVOlhRrd7S5RunY0JeYv071QbS0Ro/rsizGIzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-826c49b7628so1901362b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Feb 2026 22:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771827569; x=1772432369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z+tryQVOqPweIIFA1mPTB/Be9SSgz16ZuB1krdG7iU=;
        b=v0SfcMZr/iSW0/XfD2jWA1529F0a1kZByNVMNUMxuSx9f2xitt+g6nNVF0gDn9Oa8m
         sFiezmoGdfoAICtJdT4IYa1z4aotOiftKNkPKtKAw68hnXr9RlntVuQQbjFA9zhdbrj5
         3nBnnHmSZLO5KJVjy4uB6GC3YqbiZMJ5j0MiWY02STxPxlMxEqr1HuqVkxb1BFzrcYPC
         ecYI9IoeDOK+Nwnoji76XvFeW//3hC7mR7mlMxzhJTAFtcznWzNWGBvsmpDeN4ngmDIc
         wDxFkkGJgt9alMrelH8rxF2hiTkmof1hBOWARypeHQp2une01tVHQsasluR1OUyedqi1
         2Izg==
X-Gm-Message-State: AOJu0YzOOCcncJLMYO2E2n4qZ6OKs1mewyY9tJn+y3D/BV3xy1cEG24n
	qSQgmiEL7th7+l+3/xCFwlECbaGkBXN/RNhyx49ClHcr60f//SxLjUj/
X-Gm-Gg: ATEYQzwejK+NKI8kKJsLx1YR+9/lRDooef6gjfS2gpHTdSZO+7W8KDZ1qV18P/55fbQ
	4ywrrRgTWKHOigJ9aGGYTIeBXinJwdc8RQX1obsT9z+aNvMQVDhTIQXvU+ZRSZV4sZjw4WksQQ/
	qlBwIfxDw3jddqYOo7+eEMj5xsMBVzSnsHp4HcoDNqGso/J5pcPmXO+7bdp6G0JMVagDtSYIkXU
	zg8T6xnYFUS4NlfD7I49MhYwgOMlHEYyBi1prM6bQOQTLhwy05yCW/EcAFoNyfSUPQGocZmKftH
	Ee8qhz+O4DfEZtHLxAXgQftDeBdQvNjrNoV7CDnpjt/w9lZ3K5QedTTexAadQ0xzdvFbwFPi10h
	9Ettc0dX9YZOrwAr1Xc35ZqP+92VzgFUWuHfaqp3UpdUyjr8XACYoBRGEC6jYyJt5/EhkqNxXBI
	6faz92FMkk30vLdi+5tRZiF4azjDfSLSjvyRLGRTE=
X-Received: by 2002:a05:6a00:114e:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-826daa947famr5619343b3a.49.1771827568745;
        Sun, 22 Feb 2026 22:19:28 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641b4dsm6762957b3a.11.2026.02.22.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:19:28 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [RESEND PATCH v1] PCI: replace msleep to save waiting time
Date: Mon, 23 Feb 2026 14:19:19 +0800
Message-Id: <20260223061919.1408000-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pcie_wait_for_link_status, using msleep(1) to wait for link status
change.
But msleep(1) can sleep for nearly 5ms.

ftrace shows:
 0)               |                pcie_wait_for_link_status() {
 0)   0.500 us    |                  pcie_capability_read_word();
 0)   0.580 us    |                  pcie_capability_read_word();
 0) * 10292.26 us |                }

 after changing to usleep_range.
 ftrace shows:

 0)               |                pcie_wait_for_link_status() {
 0)   0.320 us    |                  pcie_capability_read_word();
 0)   0.480 us    |                  pcie_capability_read_word();
 0) # 2483.980 us |                }

 So fix this by using usleep_range.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..68532e248e51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4519,7 +4519,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
-		msleep(1);
+		usleep_range(1000, 1100);
 	} while (time_before(jiffies, end_jiffies));
 
 	return -ETIMEDOUT;
-- 
2.25.1

