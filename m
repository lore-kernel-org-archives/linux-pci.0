Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046548;
	b=oMCVftHxwamtXK5mgX29bz9fIyZ4KQeiiaA0wlIQwYwkkNIqPBocyVheV3kY35yyLz5c
	 1lgYPzTOxMRRBf06J5kc/vvXf15g2mcmmDAg3CFAEMFcRIh2ssiNTTyPZ8SrrxQS4i7oA
	 jeLPs5qD1MP8hTvfYP9K+5GD4TzW3LnnvnU3o310UMXQZumKAfmFRe6vqhITroewrp0ON
	 zWTD2mRlb2qwsm8MTZ5zQPiA64QS/OruTkfT+dzY5MuvJ4gx7FnlZq9yJNlYCJU8wDhge
	 Bd9PZN/UZXv4MQjQEJ5w0gv0w081WX14+626NlFvKm+wKdCbiWIxll7TXGSB9PmCm3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046548;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=obN3ZLOu4Y0dfCtGHUV13AmNn4OvcGtbPLV7+uTTzP0=;
	b=ou0F3CBxmxGVPMv+yuTdPGhEqeE1AHIyHcbm8iSw3DlnM66UO3nwIpsIJV79Fi6lVzbY
	 LM7TKe3p/Sb62tkDgk5IhkIFSDhCr5FcaJfPUA761TYbSXq5Yk3Z0RmZC+Xbm8Klv4HP9
	 QN2IcTEdepWQ/cfO8Z4Z2/xF2KkaXM04iUYTMKnNI4F144sGixaeKHNXCL5UFGGIPn+vz
	 QNlAGhUIcgxSe2+8hQf37HoLQMjifOFFD2OtVa8EQqPSkn8F1+8GV1Xe6VBTBm61vDmR4
	 HVrP3fnN39lnZQqfHbvO21B2K5+agnIHY9sesvqgT65agCgnS8gTecljtVD+4c8SA5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+k7UKq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC88606A334;
	Thu, 19 Nov 2026 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+k7UKq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC541F000C4;
	Thu, 19 Nov 2026 00:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046548;
	bh=obN3ZLOu4Y0dfCtGHUV13AmNn4OvcGtbPLV7+uTTzP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=N+k7UKq6Bp3KDlD3glX9M6tljxYdqdtymPyf8VfnHFkjYgi8xKJv5dJoVxI5ck3MV
	 Uv1Vtf4YCVZxxo++EXfYuKfx/sZUu9bJmffWjlVjtrN7OfIXY+F5aBTPGPBJIZ4jxS
	 mHKSXijqxJC8xmUT8dc6KSV0EPhH3M6YKnBjhZ1SzncMeIThfaiIUhvHYUz612LC0Y
	 KPPqeVrxPjR3uw3g1Vpjxaponb9EcC00E+lAWlB9WBAy5w21m9epJwotNuwEm/2vuW
	 a1mkyqWle0JxEDMv+wgqpUbfkiri33BISI9p4Xzwih1EBAJTE483HOTf3/pBvadjEm
	 sDEKNq4kjz4xw==
Date: Wed, 18 Nov 2026 18:02:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH 0/4] AER sysfs fixes
Message-ID: <20261119000227.GA755903@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110215614.3931232-1-yazen.ghannam@amd.com>

On Tue, Nov 10, 2026 at 03:56:10PM -0600, Yazen Ghannam wrote:
> Hi all,
> 
> This series includes fixes for issues reported by Sashiko on the Flit
> logging v1 set and were included in v2 of that set. But I figured it
> might be better to send these separately since these are independent of
> the Flit logging capability feature.
> 
> Thanks,
> Yazen
> 
> Link:
> https://lore.kernel.org/20260918145619.3016889-1-yazen.ghannam@amd.com
> 
> Yazen Ghannam (4):
>   MAINTAINERS: Add the AER sysfs ABI file to PCI SUBSYSTEM
>   PCI/AER: Clamp negative ratelimit burst to zero
>   PCI/AER: Report the ratelimit interval in milliseconds
>   PCI/AER: Hide the "aer" sysfs directory on devices without AER
> 
>  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++------
>  MAINTAINERS                                   |  1 +
>  drivers/pci/pcie/aer.c                        | 22 +++++++++----------
>  3 files changed, 26 insertions(+), 18 deletions(-)

Looks nice, applied to pci/aer for v7.5, thank you!
