Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E3370D61;
	Thu,  3 Sep 2026 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415111; cv=none; b=ZOxlj/n7OzmWv5SgF4YWMmW0G0wRUbjjBBC15WXLUolbDkiGwXrnjz7BO6Vwk7cuS6vsml6aIv4lp4T1+WRxntojh/XROyaSjP7j8+YKGWqN9qaVTBOoo4Th5+BLuVEnBa2GQEmP+g5T4hiR7Vd5jK/TaeSWkr8SQO3TNOjSjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415111; c=relaxed/simple;
	bh=jl5IC6lDrbzDmcKJDv9j9+slGlkT1xX0S6xkAk3WvHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J4vJ5wpoE/bYiD0Qcee3mODxLD3BXOcKpEjyW58X0psoGxV3u1rbXviDk5rl7izgTOAWw9WPyDN4glpBEXjrSmsN31RtJq0fHXKHXGsMjMFhMMKbRkDcdVtDVf6EXuZ1n1zvNg1GtWW4EKUaOI2MjpEeMATdJcfVl4osnQqZ5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0C11F000E9;
	Thu,  3 Sep 2026 05:58:25 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Niklas Cassel <cassel@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260728172306.2751813-1-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
Subject: Re: [PATCH 0/3] PCI: endpoint: Support vNTB as a non-first EPF
Message-Id: <178841510582.110830.12282680445235619300.b4-ty@b4>
Date: Thu, 03 Sep 2026 07:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 29 Jul 2026 02:23:03 +0900, Koichiro Den wrote:
> This series allows a vNTB endpoint function to be instantiated as PF1+.
> 
> vntb_epf_mw_set_trans() programs the memory-window BAR with hardcoded
> function numbers (0, 0), so binding the EPF to any other function
> programs the wrong one. Patch 1 resolves it.
> 
> The platform-MSI doorbell path can currently populate messages only for
> the first EPF attached to the EPC. Supporting multiple EPFs in that path
> requires separate work. This series leaves it unchanged and lets a
> non-first EPF use the embedded doorbell instead.
> 
> [...]

Applied, thanks!

[1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when BAR programming
      commit: afe2aa9dc93d904730bab63f5ccb514a318e6464
[2/3] PCI: endpoint: pci-ep-msi: Make embedded doorbell IRQ exclusive
      commit: 52c73e3cecd0603346e176da1d04a0c4d3c98f1b
[3/3] PCI: endpoint: pci-ep-msi: Let non-first EPFs use embedded doorbells
      commit: 68fcdf30a1582574fe67e0b02488f8ba0d4d1242

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


