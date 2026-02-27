Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25629B204
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170548; cv=none; b=cRb4jYK8WHMVLZ8LYHYQShqz2GcSvdA3rQvefw78pEyYqaDL/wZSNMh8NB+sa+F0HxZ+gXP1Fx0DwrZoLbDDIIiMV7FPvyosmG1KBsLoTkAsicupaNvMbs8BYaXACDlOrM8Y+bqxYaskM3aCN6+PzWMbetbLg4nmbAGRzolIlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170548; c=relaxed/simple;
	bh=6F3W35vU/J16kpZ9vXP91agnuRRh6iZ2Kw1OizQw1Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DNBT2cw0zI7JEvguZ/cpnY+2NKG/GFhmPlS53GDi93qURfb1EE9nspUPHAQ0PdVXyF0QGWtWk+KcmTrMBf4pqva0gpF6CXMD4of0w8K3CJtZAxq+QnhARdk+FfKzNSgFwZnv9UBtzpdJ/ZuTnIA21cwQssYkHXfqp8AabQloi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZb8nZy+; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZb8nZy+"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a84f2bf7bso1840581e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 21:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772170546; x=1772775346; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPTGvYA/GKdj9wqcQAjT8fmJEQ+pcQdfunMA1ORun7I=;
        b=nZb8nZy+F8l7JbmK5Dpw74DARUe4euk5pm+grODvGomFQH08ZU+4zCmjqtdyigwogZ
         zv/3RFJY/ACr3uykkHqBDpy4XZvDD81ZDLNmbIICP0W0vpnJ5wjy+OIW+/1iJ2x/6Qpv
         j4joMZHrW+Z7SI0svcUR+nbZa9Iu9auqXmlx2d+GbzzeY7rtaCuwS8Nq1AbohAYhisX+
         AM5KrNYBP+9L8Z4kP8+HnQ+Rk1tTkaSEQP9j4ZxmU9cPtgpWQx8pKbDJEOF/cnNRFmg5
         yXEGwAm6TiSKbwLx4xT4KVHJrX0YMkZQZP4u3ZrSl/knsq6wnK/tIM1rYisl1PMcGPyU
         kikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772170546; x=1772775346;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPTGvYA/GKdj9wqcQAjT8fmJEQ+pcQdfunMA1ORun7I=;
        b=NCJQjMn4x97B4CR4I+8MNG7a61Y9sxmlEVMMrkBlenGUhoYYUEEbzDgYI8b07TEX2Y
         27aRIsHmW7ldOHhX4RnAbX/MZpNLj+HCzuOIKVy3hN+PAhvZ/k3FbqDSAzg0QuzHz0a+
         kbXZNzsYfmKkn7z8++ahqpN4VxKcJytUtzA4bw0fr+mZtZ2WMUKpebPWpUe53rtgz3Zn
         kTcSmOnCMMOwUXNQti9hPo835TviSVCnvbpbd+/CsjtItML0f20nLVaeR9iYZ5wQCrmV
         zZ31PjcxlCKUyESlXM0o3ickvuHUNwo6Z9eYTFrH7z9dWshoD2RYKiwh2vIEtv33fW15
         Zrmg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Bx34hu/nes9MErO4COkBuGZzrSSaVQhMWfHTfKcDObpspIWqeroevyKmArZzFA7JoK0onLsbfp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIVHzylcNgqZ5fTgroekRUGoZ2wiQXIlBXsARwCobnwIieg9X
	rJkbC67iegh0QULxRPX88wDIKABqXUUGJo8eK8oJ/QlrhSQ3FHj9KzMx
X-Gm-Gg: ATEYQzxcve6vvvfGdcrOw6im0wGxyd2YZmnZeb8MnKceTe1zqxb8TjpXbLO84I66SQm
	in9Csc6LaXXirDY7AzFgDdLbbno/1ciP5FD6RXOoABzbMUGwB2i0hZ0DKEmReloxz399DOK+BxW
	1eLUbsvHJQknFDdifob4inbOHF/7VC6GwlixytWz3T2kW22YVTMJ8mxHWAhobTOnX9ucKP5+TKt
	H7BkNkWDaD5a9EcEvILNHu7cP43tg06S0Y8jc7QMwPNHfog+aELSFkWtMv3l3DFYJT2pJyZQ86q
	MTpg/o+JRWXcMiP/v4fwC6Y2dJrzKcnZm4GIrJmYDcSQ6/qEGD+K8VqLwKmdBdqyM5HjmBI3YYr
	VhnA4nkGwJDyCfAiveicJP916xZ2GeayLzvcnOHyrMMMj3IAILm7Bto9+GAcxoQY7X1XSxAv5s5
	y5+KDH0Tnc9w==
X-Received: by 2002:a05:6122:4219:b0:566:2fc9:6c89 with SMTP id 71dfb90a1353d-56aa0a890a1mr1063240e0c.10.1772170546147;
        Thu, 26 Feb 2026 21:35:46 -0800 (PST)
Received: from geday ([2804:7f2:800b:feb1::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a9204b91esm5028673e0c.11.2026.02.26.21.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:35:44 -0800 (PST)
Date: Fri, 27 Feb 2026 02:35:31 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
Message-ID: <cover.1772169998.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dragan Simic already had warned me of potential issues with 5.0 GT/s
speed operation in Rockchip PCIe. However, in recent interactions
with Shawn Lin from Rockchip it came to my attention there's grave
danger in the unknown errata regarding 5.0 GT/s operational speed
of their PCIe core.

Drop all code related to 5.0 GT/s operational speed from this driver.

Endpoint Mode driver was not tested. There's a bit of redundancy in the
commit messages but it's the best I could do to ensure people will
actually understand why perfectly working code is being dropped.

---

Changes in v4:
- Incorporate suggestion by Bjorn and refined by Dragan to drop the
  "catastrophic" code
- Link to v3: https://lore.kernel.org/linux-rockchip/cover.1772057799.git.geraldogabriel@gmail.com/T/

Changes in v3:
- Clarify warning message even though Rockchip won't disclose details
- Drop DT changes as they were applied as subset by Heiko
- Link to v2: https://lore.kernel.org/all/cover.1763415705.git.geraldogabriel@gmail.com/T/

Changes in v2:
- hard limit to 2.5 GT/s, not just warn
- add Reported-by: and Reviewed-by: Dragan Simic
- remove redundant declaration of max-link-speed from helios64 dts
- fix Link: of helios64 patch
- simplify RC mode comment
- Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/T/


---

Geraldo Nascimento (4):
  PCI: rockchip: drop 2.5 GT/s defines
  PCI: rockchip: drive at 2.5 GT/s only and error out other speeds
  PCI: rockchip-host: do not attempt 5.0 GT/s retraining
  PCI: rockchip-ep: do not attempt 5.0 GT/s retraining

 drivers/pci/controller/pcie-rockchip-ep.c   | 13 -------------
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 drivers/pci/controller/pcie-rockchip.c      | 13 +++++--------
 drivers/pci/controller/pcie-rockchip.h      |  3 ---
 4 files changed, 5 insertions(+), 44 deletions(-)

-- 
2.52.0

