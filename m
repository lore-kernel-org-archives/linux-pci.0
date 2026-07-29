Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F9043D4E9;
	Wed, 29 Jul 2026 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313350; cv=none; b=hNmRZ8VqbpxXczqtbK5WamXIsQiVlThpV56ql2rfBx4Ms+cQ1oVs4vcSFpXQurAOcgkbJs+tT/v29nzMVSzIA+tgqXc+obPjY/Nz4ws62PyilVdThhWmihLsRlXPx4FYEh7c7ztkRMr3hMonjnvB1xxqoODjPr/03q6t0sXsd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313350; c=relaxed/simple;
	bh=juBu4CMhboKJtMiNF7HMTHPGg+LEbH0xZo8cQPHadv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KA0Ehgr48X7LdgfgCeIIOuxvuUJ4DMlIrXN83nC2PgfvdVuU+lvLah4y0C4HBaLpAqCEr7GwXpMdWz3rEdIkoTRdxhZKjdNXh0r/fuqhnn+A8UsTcR6jWVH/Cs3ZgsMPh1vyMaKeMcxW5lJpVPO9u8BdOXw8DoRBbIS7xrJeo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6527A1F000E9;
	Wed, 29 Jul 2026 08:22:14 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
References: <20260713-b4-clear_abp_0713-v2-0-4f0333a98d4e@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] PCI: qcom: Clear Attention Button Present in
 Slot Capabilities
Message-Id: <178531333402.863208.8046509800827605222.b4-ty@b4>
Date: Wed, 29 Jul 2026 10:22:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 13 Jul 2026 00:42:49 -0700, Qiang Yu wrote:
> Qcom PCIe Root Ports advertise the Attention Button Present (ABP) bit in
> the Slot Capabilities register, but the slots have no attention button.
> This causes pciehp's pcie_enable_notification() to enable the Attention
> Button Pressed interrupt instead of the Presence Detect Changed
> interrupt, so presence detect changes are never reported and surprise
> hot-plug detection does not work.
> 
> [...]

Applied, thanks!

[1/2] PCI: qcom: Rename qcom_pcie_set_slot_nccs() to qcom_pcie_set_slot_cap()
      commit: 9f46f9d696d31d79b39539f05226abef06a7d472
[2/2] PCI: qcom: Clear Attention Button Present in Slot Capabilities
      commit: 7b7f5c32762109be07298e7499a251cbf04c3f06

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


