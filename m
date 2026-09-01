Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9E3BBA18;
	Tue,  1 Sep 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271814; cv=none; b=B1d6L46Mj1aPQXcBtebtVtSth/4gtwfV1KTy7Z/rlv7WZBo5WnbKifmi+nfEpV5kIlerVwJiVeUzjj81Yp4MZO3oFFuZxzN3rWrSjv3iE5s3ggqT7NokblSCVui0cg6ugdLRrq0XuILIi7b9YFviZP31uP0uFr6AcLr2JiuMozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271814; c=relaxed/simple;
	bh=MfdUhg03s77mCsDzUBghqFdfkJ86benl3+hsn5TwC+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F9Z5UuZ4bGjV9ed/jwPe4NGgCrjs03dYgeL0tFiJu4avdQ/c6nQ/PDdsMNsq3INws3C54r20KCT1cjI9Sdlza1Tfk4TobKOhjOpOCSuJoMUNvmQJaJTQWnicWfDmIqdkKFgSWjuM+06ucjN4o6Z/JFsd5UJQnczbNo8h5gM7wkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873051F000E9;
	Tue,  1 Sep 2026 14:10:07 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 mani@kernel.org, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, mpillai@cadence.com, a-garg7@ti.com, 
 s-vadapalli@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260820232305.80596-1-18255117159@163.com>
References: <20260820232305.80596-1-18255117159@163.com>
Subject: Re: [PATCH] PCI: cadence: Fix enum type mismatch warning in LTSSM
 debugfs
Message-Id: <178827180719.63280.3912893890195814644.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:10:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 21 Aug 2026 07:23:05 +0800, Hans Zhang wrote:
> Fix Clang -Wenum-compare-conditional warning by using a single u32
> variable to hold the LTSSM status value, replacing two separate enum
> variables of different types.

Applied, thanks!

[1/1] PCI: cadence: Fix enum type mismatch warning in LTSSM debugfs
      commit: ce8034bb9c5c50f9f5c305856aff5d1c3efe3a30

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


