Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48246BB5B
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777069; cv=none; b=IpTu62sloKOkRqcsvAppExWJROiDopPhxwUI/vAFWT+66UGAgpgcTxAOxxtB7EgUBIrJJm3OZRyUOQoRCqMimGJhIEh/eiTGSchuomYF/W4+y5x7ndjSgs/iaEpw8z9LZDIU8gXB7IUh0tCweRpR05Iec3S7IWM8SYGd6NqC74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777069; c=relaxed/simple;
	bh=8MfeOgszJIrV7b6AmYu2w4ZJcTS2+CKtI0TeuWASxcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dLYMyc6bagvSUFOsYwOa/zr/mzxJeCFWR20qqa3kL+2QywHIqrA3kPa3ULY1YCzJTmt4kGkhCzbq/7Ko8uvwwF/eZxnJJdbFIw5H7bigmZrsy88FS3ckN8oCGyiX3giSQMBHXZao7pOa3aruVvlqMhPGCevl4qQB+x3KTj1ra6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC2E1F000E9;
	Mon,  3 Aug 2026 17:11:05 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730133123.1420413-4-cassel@kernel.org>
References: <20260730133123.1420413-4-cassel@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix unmap potentially unmapping
 the wrong iATU
Message-Id: <178577706526.30464.16618048467480127143.b4-ty@b4>
Date: Mon, 03 Aug 2026 19:11:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 30 Jul 2026 15:31:24 +0200, Niklas Cassel wrote:
> Here comes some fixes for MSI/MSI-X unmap problems in the DWC driver
> reported by Sashiko.
> 
> Changes since v1:
> -Added patch 1/2.
> -Added a flush in patch 2/2.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: ep: Flush the cached MSI address before unmap
      commit: 1b01d725d8b42450b86a857bab3c46856c740166
[2/2] PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU
      commit: 9de09b807a1942d179ac5dbcb4982b5301dcc8fd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


