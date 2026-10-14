Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DD1D9A66;
	Wed, 14 Oct 2026 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957802; cv=none; b=tdLv1Yh/SMp2nTQYRoNqO/P10G9Lu0KlRW43eCG3e6/HPAMh7lGsbuPXHj7m8x7xu/TwFEItEasnGno/ffG1Qs9khYLJJ+npW7VuTPX201Qkijg2CP1XSkh1t07fy9JGxR3GRYbWyqDDP2YTEyL0otpm+14EHifiq78AaBdzKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957802; c=relaxed/simple;
	bh=4MTLOAA9ntn7SODjZIkNJoO1rqcau6BHexLg21k5OJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HQktNLDpoqupaYkpIKw/RELdVuY4FOMNbbLArjZp30ShG14j8bT1/VGURSjOkKSF+kFw2Hk6O/fOu/UMOP/ATLpPKkDZssSmiH7dqbJO1omlv+QMa/NBQUUeGhpmADRHD93SRlIrcpg6wbkTYfZ7Koey9kmekmYE6gU1lFxnYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMpGHFpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMpGHFpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008FE1F000FF;
	Wed, 14 Oct 2026 06:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791957800;
	bh=s8MfM1mspDM0nFe3fO8QU0AZxJBshy5OE1RZcD39XyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GMpGHFpHZg8OK40FDa0Ea/Zn2Al8G4/v+g/4I3M4rIX9F26aHpnUQ4P+QHcaHDVx6
	 eFUHBalNtPEpZfeGq1Kzf0sDB/hDWkUj836/Ct3cGRgC5stlFmptYXtkm1rTZnXsfH
	 EeaVwVUQ0Day3PGTkIWI4oWvs6XQ4yGBmrWKDvK8+GtoBkltXXzi2Rf9dJCzl8sJgN
	 vlAsSMcqkI4tlhJ7oq+xGLFkUeNDqx/ChrlWjVyOXqgb3tabr8EerXm/ZKRdZk7qUb
	 JbvZ9t13acfimcVhlFcrjVok7b/iVlYQ50p3hKwaff154u5S8r/ALKfRf8wkMPLeJx
	 32qWTjCjzOcEA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jia Wang <wangjia@ultrarisc.com>, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH v2 0/2] PCI: dwc: Support large BARs on UltraRISC
 DP1000
Message-Id: <179195779048.12828.9922780104352595952.b4-ty@b4>
Date: Wed, 14 Oct 2026 11:33:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=mani@kernel.org;
 h=from:subject:message-id; bh=6MjK7eCitBMibi9JJ/uSN3z9cJrlntuBDQZ04qrMuls=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzxsjXjKyfzsQ5+8R22XSg88fMvhvQxJrgaMGS
 29yZ0gTZMmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas8bIwAKCRBVnxHm/pHO
 9bFPCACYnJ+rs6NlAmWih1CvbVwOlxzQDfuytorFsEaI+zQKSxnPHbqI6Rf8yB2vzyXh52aDMkL
 E4JQzPBGmJKFmLoN45OFRvkecg7cxD7xM6jP66e3pdqfI6GTcOEs33XzECFciVqKH6Q/uXN88H1
 ATF1ij5Cyy6gvNV2hy9QoUMcC0zWYCh16oju93hwK82KXJ40AqAvJga0Wd9sBHChjR3hWnCVf4L
 F801TrVUpxHL2SPFbnK7LU4JmCtm7NEHv2r48nktW7EtLjFrCao1EIijldCTuCiypxwLOov9Mmd
 gMoaa/pxPfxAVW+T67Lba0hStmXSDSizyaWOkXcIe0hSAJlh
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Sat, 05 Sep 2026 10:56:33 +0800, Xincheng Zhang wrote:
> PCI: dwc: Support large BARs on UltraRISC DP1000
> 
> This series lets DWC host drivers skip generic outbound iATU programming
> for host bridge MEM ranges, which is useful for some compute cards' very
> large BAR size demand (>100GB).
> 
> DP1000 has 16 outbound iATU windows, and each window can map up to
> 4GB. This limits its allocatable MEM64 BAR size to 4GB*(16-3)=52GB
> (-3 for CFG, I/O and MEM32).
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU setup
      commit: 35e7ff697f320aa4c0c8cd2f9d0377df307bb34a
[2/2] PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000
      commit: e9ad968d240e0d8313d3aac19bd5ef0dad866da1

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


