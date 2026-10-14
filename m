Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB644E50B1;
	Wed, 14 Oct 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980454; cv=none; b=cGd3P5BmcYT8/8xQ3bs4fyFSuwsQANC8K8p65WqkyjITmguT5gMxwpxdpakklxRRQuiDqHYHRhtGEqgx0twV1I4fN/fdxWVEAvSWaf5xe23HYczXGV2w0J0wxUiuPOERfOcuditGMfwo3J1EU4WZXnDSlVjkpPi58p7RHQDWEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980454; c=relaxed/simple;
	bh=PTvTpnzPm4L3mxYDgVkaKKUh9tP86dI4gIqMxAntg9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lxfG462lM8jgWEeOS8mugwQ6gE8jIC4QGsEqb0sCyL3RBGvNScqi03HOLcoTw7K+gEWGc2Oew+mGKz6tiI5DdeorFdHcCJ5omjVugtySST3xN3urGKZVBQbsAOGhg0r4LEdK1CTixelsQNaxR/v3cRw0ekNTeuksOm6vteSw2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL4HH5x3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL4HH5x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4892E1F00893;
	Wed, 14 Oct 2026 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980452;
	bh=KZ7TceI9IaLYnqpvKw72rUVqXx6i9v8/OoLAMP1Gma0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VL4HH5x3Keb0hwxqwRnPdTMunlpITFYoOIMj3QvRDrM12abORu4Q9lZnMbAX2KlwP
	 CgwJIWq2eqdcnzSp0LKFSOndJimG3fg73KtkvYfvkC1FJLWdO75+UISDtycYeII78O
	 1c8bLscdrkiuul8lLCXmVHoBJGalKFdKLCE1/48/jHU5C0h9OWHCBZCvs7ZGTto6tn
	 45fAt0aADSaL7MvhbGJiUjhr+0hzr2pll3cI0ZP3eaeJJtSvf7su+Y2vaan7SX/Pup
	 GRFaaDlEVyOzv1wMisYUyCt5Tqr6RRo7bYEriSMeivUgTQG8kEoVu/3tkxX8PaJWPV
	 uTqKckvZMwrnQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Linmao Li <lilinmao@kylinos.cn>
Cc: Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>, 
 Tom Joseph <tjoseph@cadence.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260915082826.4135665-1-lilinmao@kylinos.cn>
References: <20260915082826.4135665-1-lilinmao@kylinos.cn>
Subject: Re: [PATCH v2] PCI: cadence: Store the core controller in platform
 drvdata
Message-Id: <179198044335.38040.14093908660365235919.b4-ty@b4>
Date: Wed, 14 Oct 2026 17:50:43 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=338;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=OT2ww0GMyuXQKgPnhBHXg+WsU+RSzq8ZpPrCJ2ga2Ao=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz3OgVGrt4mDT8BW7WoWLWiTHWh5RwJGRZaURT
 9dhhKEaoeyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas9zoAAKCRBVnxHm/pHO
 9f7bB/9chrVcCBZTp1bTthWvyx8axBH0BcFy7Mm852KntXKICpqhne1SuuwqoiMsA3GHlfPJrWr
 jnmr+f9oufiO/AJOTuM/sGtkJ/A9msSn91FdJ7hmKYqhzRMNopoBviJXZdfEDMSvNCpwC0cBwxJ
 bcR1mZG6W9YtTUy/U3TO89CoudUGPJINmEOOi98unLMz7v8uXCWoLd07Z3vqXpHWDymp/+i4jPt
 Xt0l5ErAtLRWeZsdC5d1u7K8/KAgHhgKmrbhRM9Sqiv41v0AH+6GT8hvEaRrM0nxwxVXMsNRIF4
 fUWcU/9YCbdBgNtLY28Gix77sH2UPl5Qto46f7d6tkTlHCP5
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Tue, 15 Sep 2026 16:28:26 +0800, Linmao Li wrote:
> PCI: cadence: Store the core controller in platform drvdata

Applied, thanks!

[1/1] PCI: cadence: Store the core controller in platform drvdata
      commit: eabe6689cd9cae4c39cd7ec188c6f739e8081648

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


