Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750849F109;
	Wed,  2 Sep 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357153; cv=none; b=deVq7Zk83F/RXG2ViEMOPQZ8EGCoQxSr/gEdkw2Y93Ato26/69pwc9EA+jv3Qww2T3sjQlHZuoZ7OinInF2VLGrGPZegqTvMXd84qZyK9MM4Dt9pYw5JfLH+FJM6dk8mUomnuE7whHbBgS0sLg9mRPqjEk9L2ApvsOHn0WiQYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357153; c=relaxed/simple;
	bh=xAmuuR6oWlCmf6ZZd9eFeL/SkNkacccKj71p0/Jm9vE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjPPFT/b7gbKdoPVnosXkO/6Egy0b5NsnaQex7gMIcBNUN4Mo7XlxcpejHfYiRiBNE33HiMSLRTXiVlQhBGxqnw5G7oTgTkHBjU/NOjyR5Hy4n4yxn2taWRlxVVm/hmdqcd8F90ti1hIHGCg2pKWOxJuXGo9Ef+mKvIgJUWfa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEA1F00A3A;
	Wed,  2 Sep 2026 13:52:27 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sekhar Nori <nsekhar@ti.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
Subject: Re: [PATCH 0/3] PCI: dra7xx: fix resource leaks in probe error
 paths
Message-Id: <178835714722.82225.11480476424664369256.b4-ty@b4>
Date: Wed, 02 Sep 2026 15:52:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 22 Aug 2026 23:07:46 +0800, Felix Gu wrote:
> 


Applied, thanks!

[1/3] PCI: dra7xx: Fix clock enable leak on probe failure
      commit: 06c32f3b16ce892f6a64a60be630408fbae84912
[2/3] PCI: dra7xx: Fix device link leak when devm_phy_get() fails
      commit: 2b9a036b568c94921af376f87dd394a325da7a02
[3/3] PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails
      commit: bdfdf654b4b2762b5ae48325d6dd8e0f3529cab3

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


