Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397441C72;
	Thu, 30 Jul 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429885; cv=none; b=ToNie9TqPkqanGxATsLmiRSAVppDULTjvZkKF3If2Jz107UYIru36wSvk1iEs6CNUNLiotOPoma+0o8xNfICAdpHzd6eDZM/HG7rwleVBqz+N0nuiNjyVt16In2btnASf9egCMqHxSQlxQyEhDgfwFl8xGiJ683Xz3B2obRwnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429885; c=relaxed/simple;
	bh=o0o/oLjC2RXVibXc/h8Mh8bdrIYqtUHgAGNdx95nnDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PAvNTdLMOHA0F+eT/LOb6Tnf8QbE99DgS+R/HzucBRTKgmjuWNR6oAV5hytwEHj+E1oneJFtPIIQnmPO83wSheuNlpzOqTZ2uVkZDY7LgHXjmggzwa/tWDtLei5C6HLLetTQ7ESgSx4fFKS8now0qOqMEEfvgDNcnHzeSwNdRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820931F000E9;
	Thu, 30 Jul 2026 16:44:37 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 mani@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Brian Norris <briannorris@chromium.org>, 
 Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/5] PCI: Add support for resetting the Root Ports
 in a platform specific way
Message-Id: <178542987704.1025433.15649163299546579647.b4-ty@b4>
Date: Thu, 30 Jul 2026 18:44:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 29 Jul 2026 10:22:26 +0530, Manivannan Sadhasivam wrote:
> Currently, in the event of AER/DPC, PCI core will try to reset the slot (Root
> Port) and its subordinate devices by invoking bridge control reset and FLR. But
> in some cases like AER Fatal error, it might be necessary to reset the Root
> Ports using the PCI host bridge drivers in a platform specific way (as indicated
> by the TODO in the pcie_do_recovery() function in drivers/pci/pcie/err.c).
> Otherwise, the PCI link won't be recovered successfully.
> 
> [...]

Applied, thanks!

[1/5] PCI: dwc: ep: Clear MSI iATU mapping in dw_pcie_ep_cleanup()
      commit: 36637958726a4bbc630c0848eb3eb07cbfae89c2
[2/5] PCI/ERR: Add support for resetting the Root Ports in a platform specific way
      commit: e3e7dabe25e7be701c2a27a425ea71b17e238394
[3/5] PCI: host-common: Add link down handling for Root Ports
      commit: a36da2a2940a5c23a0a2e0c24966da637ca513fa
[4/5] PCI: qcom: Add support for resetting the Root Port due to link down event
      commit: 6b14d8bdba854e0031b4dbadf2d9cf5b98f95601
[5/5] misc: pci_endpoint_test: Add AER error handlers
      commit: 2e7d10af1cd05b26056a09032770db5c47bd54cd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


