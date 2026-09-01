Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E02BEC4E;
	Tue,  1 Sep 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266132; cv=none; b=IGlqK9LFkOA18a/ZpzM/wMdkgouYY17JEQoJ0BwiLcK9xEKCw69OIMGTHnclrUx2V1re4+6m3/TfJSkGY2nHl37jv8OJTsH73pGuUCedr4g8Dhh91Cnl6rrwOB4mJQq3bQN/BYwGTY1INi/s2u2DJ6eq1vQa4zM/x1TSYI6wqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266132; c=relaxed/simple;
	bh=yFYT+bqTTwweJnkbICBzdfNK4ESeSCd97FLzpwSLmUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G7OFQCyIBeX4A0JUXs5l1d9Ds8wdMGw7eOmrvWFgkMFAj9vAe2H3666lANCQecIXt61BKVYIa9kDypGNTio6EyxHrVebyMt1lFYjMkPSTMJYmCVqPFx7Nb/EMCgq0XlcazLmsJAxVKCJxsI46NXs/aDHRyTnh67BDM1XRma64QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7801F000E9;
	Tue,  1 Sep 2026 12:35:27 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
References: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-Id: <178826612782.58092.15490835074765422013.b4-ty@b4>
Date: Tue, 01 Sep 2026 14:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 19 Aug 2026 23:36:54 -0700, Qiang Yu wrote:
> After a PCIe link goes down, software may still access the BAR (MMIO)
> space or configuration space of devices behind that link before recovery
> has run. As the link is down, these accesses never complete, resulting in
> a storm of Completion Timeout AERs.
> 
> Use the controller's ECAM blocker to drop these accesses to the PCIe
> address space as soon as the link-down interrupt fires, so that Completion
> Timeout AERs are reduced. The blocked range covers the entire address
> space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
> register space remains accessible regardless.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Block accesses to downstream devices on link down
      commit: 86624b718f94517b26f96c1d7beb7632e5562afd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


