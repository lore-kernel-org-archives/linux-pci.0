Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85354515735;
	Mon, 31 Aug 2026 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183804; cv=none; b=Us/yK6CFhEgqQrA/+2n8MKLZHWvNrPGGZCtffM+aCRQ3SoDEG7f+p3ZCTsRtp/hSZG5pst2WpV+NrQ4/gghY7P3ExXqzQOvr3Kbxv4wg/1WFES6pk1Mb1KqG8aenJRN+WDFCzvAZgSsh3ObPZKf6nI8ZWhvPTXDoXrc+d8T4Ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183804; c=relaxed/simple;
	bh=kiWxoJyxqsHtkyjZPQGr98gl60TGYQNddOIbMzUcbpc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QLbirfpurTFq4w3i+ZCmHopuAdyUx4wSbUyzNw9M0fZh+MfwRJXWMxZeT76i9xq3sK5jfVMo6HEqKKAH6vgOnt3WdcFNwfhideX8xVYaz8EvwRk39fdtNtwfkyPOEN2wlhN75+/vSxwWtjMACiBuZsBKAbQ7sp2SQuFrtOVVZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D391F00ACA;
	Mon, 31 Aug 2026 13:43:16 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, mani@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, michal.simek@amd.com, 
 bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
In-Reply-To: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
References: <20260818153755.3801111-1-sai.krishna.musham@amd.com>
Subject: Re: [PATCH v10 0/2] Add support for PCIe RP PERST#
Message-Id: <178818379652.36213.15715295014803112988.b4-ty@b4>
Date: Mon, 31 Aug 2026 15:43:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Tue, 18 Aug 2026 21:07:53 +0530, Sai Krishna Musham wrote:
> Add support for PCIe Root Port PERST# signal handling
> in the Xilinx CPM PCIe driver and update the corresponding
> Versal CPM device tree bindings to describe the reset and
> PERST# resources.
> 
> Sai Krishna Musham (2):
>   dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
>   PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST# and reset support
      commit: 23a2ecf60eb60d3b110957ea1d50ab590b4fdf77
[2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST# signal
      commit: b428bc9a1532e6f2616242ce8425fa271331726b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


