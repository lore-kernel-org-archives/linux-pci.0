Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530912DEA89;
	Thu, 10 Sep 2026 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052386; cv=none; b=TpoNEwwnJCBMbE/5rciS+5sKwyyz8tSkzmTZeI/Ipld5KcM/PkBObLG4JNbpHJKMy3hFHmr2FkdHS6fZjV1A3aQRYqe3JdqS9qzmxCNOkFqIG9a93kqh7rnSph1LzV0pvt/XeVq7ZtTjWSKv8jooMz+S/TcuW2zql/pcb9JHomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052386; c=relaxed/simple;
	bh=YCb0fkJVBj+EKyz9u62mRZSYumgbp1OXvyY+PAlScvU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=inNLJItkryf32ukfif+05q6eJeur8Zawc7W/k3i4doyZxmf/Z8n0bTQdx3gUmuK2tRcf9511gbpMjct5IgDRyBtIAYGml3+gxh/aFWsnnxe9mMVu16MGKpTnMDiIxZp8YMIm9azX8Iqgwy8h5BcPLkrDCv52h6WDMp5LpMK7+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E1F1F000FF;
	Thu, 10 Sep 2026 14:59:40 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260901063238.631166-1-den@valinux.co.jp>
References: <20260901063238.631166-1-den@valinux.co.jp>
Subject: Re: [PATCH v6 0/2] PCI: endpoint: pci-epf-*ntb: Harden vNTB
 resource management
Message-Id: <178905238036.17545.4959829394659337102.b4-ty@b4>
Date: Thu, 10 Sep 2026 16:59:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 01 Sep 2026 15:32:36 +0900, Koichiro Den wrote:
> This is a follow-up to v5:
> 
>   https://lore.kernel.org/r/20260226084142.2226875-1-den@valinux.co.jp/
> 
> Patches 1-3 from v5 were applied. This v6 addresses the remaining
> lifetime issue. Mani, sorry for the delay.
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: pci-epf-vntb: Serialize virtual PCI bus scan
      commit: 84c3520c9e8c14b09a5cf645cc4fa7c6d9d61127
[2/2] PCI: endpoint: pci-epf-vntb: Manage virtual NTB and PCI bus lifetime
      commit: e26ff299ac09405fbe3a2525b060d32988fad17c

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


