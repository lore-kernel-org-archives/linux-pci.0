Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A53485CC1;
	Wed,  2 Sep 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359068; cv=none; b=Zzv0Qt5Fh0Dtb7sx0QoEdwQDkOXHCfywhoTon4FpsvUzuMvINlixSo4mtWwz3xJX+C68r8PlUyxrk4FhmgzSPb4eJchiuqyJX+DoVwKQfaypizGDGmmeiyfS0KjYJ/rS8cya6QtWDSuENCDBcya4bLC5Uu6wRJHyOe7Le/fc218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359068; c=relaxed/simple;
	bh=aVfBUQPY4X1e2fqKLi0N0v3En3yYCmTEySnhU9zjydE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjbRNqtQ01v4lsv4BlYM3uiolfFn9M3D8ZSksrS96pqPm3LAUj3SXF07D2mVm6qDnD4b2Z+Cphn+gSerJ8Hp4ZRbukkA1jsiAfbZTDf1THZV7Ius7mC2IlWxG7Fn8yO44GzYsmQM/JK5gnyWUif1/QvKtb9eUfo3SK6IZj4xF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E6C1F000E9;
	Wed,  2 Sep 2026 14:24:23 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: thierry.reding@kernel.org, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, Linmao Li <lilinmao@kylinos.cn>
Cc: robh@kernel.org, bhelgaas@google.com, jonathanh@nvidia.com, 
 mmaddireddy@nvidia.com, linux-tegra@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260827093919.2825467-1-lilinmao@kylinos.cn>
References: <20260827093919.2825467-1-lilinmao@kylinos.cn>
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
Message-Id: <178835906327.87213.9567370431840450453.b4-ty@b4>
Date: Wed, 02 Sep 2026 16:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 27 Aug 2026 17:39:19 +0800, Linmao Li wrote:
> The PCI Express Link Capabilities and Link Status registers are at offsets
> 0x0c and 0x12 from the capability header, respectively.  Since the driver
> uses 0x5a for Link Status, Link Capabilities starts at 0x54, not 0x56.
> 
> Reading a 16-bit value at 0x56 returns the upper half of the Link
> Capabilities register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
> 
> [...]

Applied, thanks!

[1/1] PCI: tegra264: Fix Link Capabilities register offset
      commit: ed17593383fe3926950cae250842783630f32697

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


