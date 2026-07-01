Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6063AA1A6;
	Wed,  1 Jul 2026 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887517; cv=none; b=O6dwOGnKUbiWqEo0UZDpKibHFprykdgPN6sMtb9Bpnz2VPQNxZTRIrhlfbXMk8OECdUc8HphoqXAUWLJ7QCah5jbV2ZD0mDg/0E1wt9vgv1l899fHpofKrRx1jhKVyJL44LSsp61rRlRM558h+9NxwilVADQWjEFjQYxeuZGPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887517; c=relaxed/simple;
	bh=RQgvjBRD+p2OAyNLUeyNomzRji5GTNgbkBw2zesexp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3qgM2rL/xb2xAViw5fQ6HPbmf6tG8wl7YXvtMBu1XSHcAEGZ859Nkf7RadYDnSw7oWCysbtkZ8ZBSWZOQLiFJ90Et1araNCVBx2HaTfbEE4/l4itEydwQQf1uekC5zr11kG/MnlmN8gXxfM0G3reoPn38ngq96ld8194jDfSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4goOVL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4goOVL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99791F000E9;
	Wed,  1 Jul 2026 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782887516;
	bh=d3/fteDdeaDUb7HQHKSHZdGzJyvgRky/lNVy7Qw3Av0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n4goOVL30pVwfTB+AWexMrJnCGhUNnc5KRtLRnmVDICyJwmPlpIHlcQUFH6RFYeCU
	 YuFXnd0CV25QivbFTHhG7sjMrhOrrG5YaeknU3tty6U8UGAdODODaoMvzNcSaJrtau
	 c7V1Elg/qE76Hw6OSqhag+/DBxjFsyLywPZznuVKd3V7UM4FbpwJk2p4DnLyKq8Z+e
	 oMZH0r4YPLFPZAzNH+i9DjEXO0QHb76VdoYxkZujq9sgO6FIkBfVhMjSFg7Q6NdbDk
	 ZY1i+FaFVk/48vAgEdIVfEGCmeAcwVE6Y4oUJ53F4qlAN9l6C/JjOWOJ2FeKMtmve0
	 kXpjPHzauO8jQ==
Date: Wed, 1 Jul 2026 08:31:47 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: gowtham <gowtham@ferryfair.com>
Cc: yue.wang@amlogic.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, 
	linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
Message-ID: <5rf4ijh4kagydji7n4nuieunqzbwgk3cg5i5n2srjf4npzrjth@dcqeafnmrs4q>
References: <20260614095626.7afb7c04@slick.ferryfair.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260614095626.7afb7c04@slick.ferryfair.com>

On Sun, Jun 14, 2026 at 09:56:26AM +0530, gowtham wrote:
> The following changes since commit
> bb532bfaf7919c7c98caab81864e9ce2646e11e3:
> 
>   Linux 7.0.11 (2026-06-01 17:54:55 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/GowthamKudupudi/linux.git
>   tags/meson-pcie-warm-reset-linux-7.0.y
> 
> for you to fetch changes up to 852811b11795ee389ea6a953ed0db69b76722469:
> 
>   PCI: meson: Fix PERST# timing by asserting reset before LTSSM enable
>   (2026-06-14 09:41:01 +0530)
> 

Sorry, we don't pull patches from random trees. Please submit the patches to
linux-pci for review.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
