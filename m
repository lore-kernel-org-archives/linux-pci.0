Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7C3C343E;
	Wed, 15 Jul 2026 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101146; cv=none; b=s3E0NyZUxFCJnc8vlmdkiwkAVYzAGLKjfD6taZUbq9Mt01bKqy1HRi4mqCxcumksVAfgTZdCuRmurjJKU4pv8+JivuQUmiqFcqA7ihCxt0UBi8cJQHsdGmDGPLTtv/ngp7o+HtMe4IGSki80xjYfdpwvEttkaQNibXzkEZfG7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101146; c=relaxed/simple;
	bh=CS6mtZVuFmnUSFnKE1JhHGfMKLxjMywlOkMEEzHTPwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t7FGy8gsoSIMIO4r2sCknO5vRdkQjzIsZCH2cQM3zsOU5jd+hW1YVZn8A7j6P/hdPlkMH/sJbjE1N1SzBYPT8iYYJloG8Td9Zcbmay3tYHlrYPaZ85Nfl6KN6/Rr23lKU2BOibYjJa2ZqlSAqycPxBtbSqyeHNn560XPAz3KSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gao6q/uV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gao6q/uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F8D1F000E9;
	Wed, 15 Jul 2026 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784101144;
	bh=1s8dnr/H+2lv3l62SQ2Gt53o+XNvCpu2jy+X2ExQ6Hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Gao6q/uVXwrV5TEJGCI0khpJpB9/TFkFo1ZBpgBhYDuhcfC11h5rmrIr1m9ZtMGUG
	 utCedatmP33etuukEe0awnhL1gdp808/33231mX07UfC0zw3r9UvCawEvlYczovDhG
	 NBxIzyGhBGgqGDWzKxmCeF2puDstt7vfJQ6UQ7gy+2ShC3wcSEjRFf9hrtpC+gktq2
	 4kXA0pSrHBlC7IxfghBMnkywDmJCFS/fwZm/PspH6iesXO0DVzpYqz6OYsV0k/alg/
	 aCJqgMvDK4lKIZ/Or9cNVkuIHFxrtw/K8kMuFhzzGHeEjQjUFP0Hw4RajyaU8ZQfEk
	 9tPfOtUwcYeDw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, mpillai@cadence.com, a-garg7@ti.com, 
 s-vadapalli@ti.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260701073513.1101559-1-18255117159@163.com>
References: <20260701073513.1101559-1-18255117159@163.com>
Subject: Re: [PATCH v8 0/3] PCI: cadence: Add LTSSM debugfs
Message-Id: <178410114155.126778.6712169476306452015.b4-ty@b4>
Date: Wed, 15 Jul 2026 09:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 01 Jul 2026 15:35:09 +0800, Hans Zhang wrote:
> This series adds debugfs support to the Cadence PCIe controller driver,
> allowing users to read the current LTSSM state of the link for debugging
> purposes.
> 
> Patch 1 introduces a new flag 'is_hpa' in the cdns_pcie structure to
> distinguish HPA (High Performance Architecture) IP platforms from LGA
> (Legacy Architecture) IP platforms, as they have different register
> layouts for LTSSM status.
> 
> [...]

Applied, thanks!

[1/3] PCI: cadence: Add HPA architecture flag
      commit: b5672f9463f2ee184730daaa5c43b9b5e8fb9f86
[2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
      commit: ea34744eb0949c7b1e53aea579f5a3e2d2b88d63
[3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
      commit: d70e964dc099821f6c159d8f40aa7be2c62ecfd2

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


