Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44486361DD5;
	Mon, 28 Sep 2026 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565012; cv=none; b=nO+QLbDjT/xjmMs1yrxcLgQeOEkZM1qKewA75Yp9znvu3PWXH4nZLlCep8xKkBasMcNSKZcB1+xJYMT2GFat4iq+RPrr7Qd3qMrhJZbgPhLw8qQzUGBZdwcjkzSG0V17/qRREIKze6Sg1PNsib0EpusYBhM+PNImFK259Rgps9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565012; c=relaxed/simple;
	bh=s4i7bjQS3hTJqcapsRCQwavARHyKb9RyH9bZl2AuNr8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ukYjEfPEJRmvI4roIU3n5A7GusxdhMPsc5dLy5oZcLJxXQrmBLG05o9IdIWdgRU23XO1clfVcNmRpP1fiEHHwpJp0LO0lFm6PWY8JBzXGIoh7IejJTIX1580loETLmaMQm2ADFjVALVwCG/uXgxTuXKdxauMcBYYoCgwKJD24/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5D282Bw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5D282Bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4031F000FF;
	Mon, 28 Sep 2026 03:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790565011;
	bh=572ZApzffR2V5WVZZG923BXMb95uxq8rXlHIXJhmvi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e5D282Bw7e+LCL3BfaBn/xHL5axhjK4+/hI1+KnHpF0fOc4M9VGiMkah8tqedfPPl
	 4VozO5QljckrQqi8d0htX/SoPJlvWkhnhUZYftpsleLPSrpkm19v4PDxW1CzQfvcEI
	 vDlTuAQ30QQ7t83WpGIWk0dgxvid1/E1R01F0+s1m5/lpAf311A+12PDXutGyY3ySF
	 y8/WERcDxVbsK1VAZBfzo4ai8jbwwRtZApBBw0wZwMKn6B589YPSX9y97ceVN87k4O
	 u2invxepd54ZbZSaXlzT5kqIp5XK1U8UbNev8wcVzBZdFcoBOesOvJYB4qAGxkQiLq
	 bdH8j9IeCzd4w==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
 helgaas@kernel.org, heiko@sntech.de, yue.wang@Amlogic.com, 
 Hans Zhang <18255117159@163.com>
Cc: pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, 
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com, 
 martin.blumenstingl@googlemail.com, cassel@kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20260911162537.469018-1-18255117159@163.com>
References: <20260911162537.469018-1-18255117159@163.com>
Subject: Re: [PATCH 0/2] PCI: dwc: Clean up DWC PCIe register macros
Message-Id: <179056500511.302500.18235445992989185257.b4-ty@b4>
Date: Mon, 28 Sep 2026 05:10:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 12 Sep 2026 00:25:35 +0800, Hans Zhang wrote:
> This series cleans up the DWC PCIe controller register macros to better
> match the Synopsys DesignWare PCIe Controller Reference Manual, and
> removes an unused set of iATU unroll register definitions.
> 
> Patch 1 renames various register and field macros, dropping redundant
> PCIE_ prefixes and using documented base names.  Field macros are
> renamed consistently so their register association is clear.  No
> functional change intended.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Align register macros with Synopsys documentation
      commit: f29719b5064c07cec23c928055df302181374df5
[2/2] PCI: dwc: Remove unused PCIE_ATU_UNR_* register definitions
      commit: 4996364a46e738cc455f5fa9b8b09f2f3348bcc9

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


