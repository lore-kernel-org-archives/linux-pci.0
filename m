Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC563BB135;
	Wed, 22 Jul 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705252; cv=none; b=t/ZNTkvFoJDIcNhL8l17CTy3aPFQOIhzn0MA5dY7VeHEHsejYvGceJPJUXpnXmJwrBnrbJYmUmJuyJts9jfRwYhxNmLmjojfJ6yrZTsuXNk5UIx8KDCOfBJQHRXxMQM6m6ONqN7yhK0Xj7tL411dKGisOcQWph67mzYyXqBpUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705252; c=relaxed/simple;
	bh=RM3yY+hNZwjByjajtNHQeAh/l80MJM2w5CpXJ2JgT4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ma/jzEdfyGdKRrhWo/B/cGZ2977ZQb7Rs4LIggcn9GWF/q55oNO1jxJ0s5/NtSxmN8Cf33xvMIqZPWsKZPPcANblmo2X8pROusLNp/ScjEj/a6PYwiayAnP1WjaVASmFTq2Pp/T6E3s4chYiIC+QPP20Q+mjSp5iI+V6zICuieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15191F000E9;
	Wed, 22 Jul 2026 07:27:27 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, Takuma Fujiwara <t-fujiwara1@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 mani@kernel.org, vigneshr@ti.com, s-vadapalli@ti.com, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260721155743.3347659-1-t-fujiwara1@ti.com>
References: <20260721155743.3347659-1-t-fujiwara1@ti.com>
Subject: Re: [PATCH] PCI: j721e: Fix incorrect max_lanes for J7200
Message-Id: <178470524754.131560.2267100744380104820.b4-ty@b4>
Date: Wed, 22 Jul 2026 09:27:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 21 Jul 2026 10:57:43 -0500, Takuma Fujiwara wrote:
> The PCIe Controller in the J7200 SoC supports a 4-lane configuration.
> However, j7200_pcie_rc_data and j7200_pcie_ep_data incorrectly set
> .max_lanes = 2, limiting operation to fewer lanes than the hardware
> supports.
> 
> Set .max_lanes = 4 for both j7200_pcie_rc_data and j7200_pcie_ep_data to
> match the hardware capability.
> 
> [...]

Applied, thanks!

[1/1] PCI: j721e: Fix incorrect max_lanes for J7200
      commit: 7147a7bfce47acd48c3738130bf0bd692bfd80de

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


