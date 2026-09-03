Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF504EA396;
	Thu,  3 Sep 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452461; cv=none; b=gyZMuMidD3j/vU5b9f7MmR8Dr+gSjcKaWbJklvioHLK56HoBtHB6chT1PGWO/6kFGwB3zhvcRSMiharpBz/LtUU1NYjRXgFfrBM208qb19lkaZj1JqrMtfxzUed8hYitb+2lhFvtSFx72Nyl4hTZfn9izMN4T8IU/vumAGK5S2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452461; c=relaxed/simple;
	bh=82oBLQtaAZdfTJ+WwkbrcGdaqBz6bS1zsIPgAJpQdKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8uDQi/W++G8coGE8haI98v9/I3wbwWNcAse2ATGxs7wISHcbHs7WMxxq/xjemzkndrgJNi8NmLZTJ2+75P2/7vfC3dTapxyJyAit1fVkeJapuNOe/bbYtSUJM3PIkO7kp0gVQzY/H0obcOc1Qt4j66CajYaKK2+IHohyWb2wT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfflLE5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfflLE5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BA01F000E9;
	Thu,  3 Sep 2026 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452460;
	bh=cBMjI/btxhScWSFb4l2oCtthKIhGMk3qojhSzMixR60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YfflLE5nF/A21l9dO02u+tw+k5tfpt0xMTGlbNVYzzPrgpHzHzJnCqdY+liNr8wwZ
	 FtMd6+7jgPCeW4nSMG5KerIGmukmPZDp32hJ6400IY744Fifh3qWkuHttY4uI+cOzq
	 zqxMaxF779mDXykmDo4PC9BdueQSw9gd0n2ywGkJe7TQ72YN7nD9SWKlrBz0x9HmZC
	 oadMCxh2erWRFgp1kXbXU60Fxb5bDVPxbkNeKg+NIq25YMs1LweGykZYipVsALDj2z
	 UEpjXsEkut7q0krJf/zNXXf1nR9MTsanQiOt5BFX1t1JIxoqs4YEfLKpK4xRA1F70p
	 nWLf+UCaFGaTA==
Date: Thu, 3 Sep 2026 21:50:56 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v5 0/2] CPM6 Channel Separation Support
Message-ID: <apmeaBVeVVQ0nCMi@vaman>
References: <20260820091025.683506-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820091025.683506-1-devverma@amd.com>

On 20-08-26, 14:40, Devendra K Verma wrote:
> 'Designware Cores PCI Express DM Controller - Reference
> Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
> the channel separation mechanisms. Basically, the HDMA IP allows
> the user to configure the separation between DMA channel
> registers and retrieve it via the VSEC capability mentioned
> above.
> In order to use the VSEC functionality following changes have
> been made:

This does not apply for me, can you please rebase

-- 
~Vinod
