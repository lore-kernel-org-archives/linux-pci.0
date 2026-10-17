Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90438736E;
	Sat, 17 Oct 2026 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213438; cv=none; b=sWunLrkiWknUV4ltgerxo1rpsf67mIetHXbemJzruDa2srf/V1iRqsfG2A0mM2GH6iCETd+XI8Dl4oedoorezTDQwdJ44cSJTaHEVAHEmaLscBr3o0ewXdt2sXQUMIx3hczGffACGOHuPZg4/oGEOjiBPhsnflNIagVGJO815tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213438; c=relaxed/simple;
	bh=+YWHAC5gYUDZCtOECncdNt6z5YOh2Ori4eqA/lsBvQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X+xUfWEKb5gtyKsZGzNsUO6gfJ6Y664Ma3T3lDxhKJjL464lEi81vbFmd76nuRFUKSYAplxnekz++8yX3/EO8+Pp3imTuTqAp9ovOth0rYN3iHlIaiQrtaROg2mkIQ9ZNrscRqlPuP4J9pQb7AoHPuxEndr5mv4tAa2G1vtg/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6IPBrRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6IPBrRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8311F000C5;
	Sat, 17 Oct 2026 05:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792213437;
	bh=lGAhQj4Vef2YXXX8wm8HKYGp/8FgcLBQIUB7nrHlyJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=V6IPBrRKtbvOWFwg6ChweTRbinNCB2qPF787hjUtZwP+1B5NMR6GjLF5Br2SSLymX
	 NNmzctZ8cioC/0DjP6qDnskkxGEljnxS8xNLfzHOVtb3fzY4t9V2BOjzv/c9Gxc/gF
	 nUrzCBjgWnphtTnhOk4guwHAlMWIUJ8gUDv7EwSI42PYx9BKpXp4MvMt3Z0+dqDTvb
	 7/b6kopvSo3dhuWoQI4qhOunAESJl+StdNZBbOHRw301fw+96JiaYjvNGSZTIjE7o0
	 8D4GFl6BKUuHcSpi8JKQePA9sHQ1z3jPW5jfmUGsKwYWIhBWvaQ+YgKP4fN4yajdFV
	 F7rAZehajZB3A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, 
 LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 robh@kernel.org
In-Reply-To: <305ef70ecadb4db9aa42c66607240aba@thalesgroup.com>
References: <305ef70ecadb4db9aa42c66607240aba@thalesgroup.com>
Subject: Re: [PATCH] PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig
 help
Message-Id: <179221341677.2165.2177875431608248516.b4-ty@b4>
Date: Sat, 17 Oct 2026 10:33:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=347;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=NXwGK0gn7gOAiiajD6a0Nu1PXD7v5pzh8JGfZiistJg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0wG4HtX+dlOMO3g0Nary1c8Jih9+Q15aekb+3
 jOJzqISBoeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatMBuAAKCRBVnxHm/pHO
 9Y6iB/9SBHurvDQlT8ouXAcQ1nzWHqFPL+8i6XTINGrWHDnSlyD9Uo7ySfmen5WmAVvDPHXx1YM
 o6jSYyRyRBKrnnw8EtLMvbKi5BcZ4lnAHgAhjKxfzmuLBcBr1BUmbiKy1f39j4EbK4T46xECWaZ
 QnhVN56qs1tEx3eKjrUPD//LXcelJ4rzhPAiP3CeXx2Uk8VSgLfFQRcnA/dw8Yet7E2ARr81l1y
 YMYcVGNKV3bw852pi32Xn631xyq9TvE+Q+bNVWwn2FDrNPjFvunNjYkMGT5vhD53ALCYiTGfn4v
 ZE6yni/ljzigSoqPMz6OnRHSb+3/HeYPMcgYPet6xNKo8Jfu
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Fri, 02 Oct 2026 08:07:07 +0000, LECOINTRE Philippe wrote:
> PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig help

Applied, thanks!

[1/1] PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig help
      commit: 440b83f5b733ac4e6f6e3f0706bd718879859d9d

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


