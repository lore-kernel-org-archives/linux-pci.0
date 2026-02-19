Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4D28850B;
	Thu, 19 Feb 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528476; cv=none; b=m50kBwtnjbxtZ6InFIfxDg8N7wcgOPSfJoihl3s1deMi3N/2bEIu4rfyVGcwASIzQ2rvqM4kgYUUXQG/TSSf91R/brZ1/QfU9EkMEEhXDeXxKLUAze6lgHmkzc6P6BALKVYc3VgPlQdtHDyHCiClOB48z6+vbaGopy+4tnBA7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528476; c=relaxed/simple;
	bh=0cAl1i0h2ueVVAyItz5sGOq532kLhVcVwznnTI2kvOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmQD5IA+UKfY2jDmU+xPYWERx+nbs18vfGla49xrRP+tsvvMqZijPu6VqRoFXfWSoKFTN8gHG7WiIcCSoSzeIIBVgGJgRvm5fY9Y++6Mg3JgkkEeJ8mU3Cq+cfF9s3mega/6Kp9HLdc28LQr+xywygiNGYJPtcYhMec6YVGx38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X73/PJLE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X73/PJLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE15C4CEF7;
	Thu, 19 Feb 2026 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771528476;
	bh=0cAl1i0h2ueVVAyItz5sGOq532kLhVcVwznnTI2kvOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X73/PJLEKhDfoLjIeVICL6EBCIbMe4MW9hNUW/IWxnEz58L30P3uV3dO2noCciN+9
	 NGdIDDK3tnGAChZl0UzjceS1q6o7EWqH0C6d+Gpt8658pDQKN1BSQLZkpXUFZHxt3M
	 0AycPirdmOy4BqXKPhqYT0vvsodEg6P/+BuTUM25ggVSDi/v3N2e3hqEMEqPM+vwa/
	 5sGpyhp3FrZS9fu+HjnMXiqvmsFO93rvNxHCJ5MQg2Pm3MAPuK50VsmX/93hx/9Q8D
	 PNiI46D+ENNNiRvI+NHb1O723D/wfsmMLq5Az0TVHZinm7vdzcF48yku38pMCKPdYV
	 C+/ERdrrYpTrQ==
Date: Thu, 19 Feb 2026 20:14:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <aZdhFdzVqDLthmiP@fedora>
References: <aZcKVLGNSifE60-P@ryzen>
 <20260219161348.GA3483770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219161348.GA3483770@bhelgaas>

On Thu, Feb 19, 2026 at 10:13:48AM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 19, 2026 at 02:04:20PM +0100, Niklas Cassel wrote:
> > Since there now is a for-linus branch, is there any chance that we could
> > include:
> > https://lore.kernel.org/linux-pci/20260202145407.503348-3-den@valinux.co.jp/
> > 
> > In the for-linus branch?
> 
> The URL you mentioned is for "[PATCH v2 2/2] PCI: dwc: ep: Always
> clear IB maps on BAR update", but here you mention "the above
> *series*".  Do we need both commits of that series?

Yes, sorry that I linked to 2/2 instead of the cover-letter (0/2):
https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/

If possible, I think it would be nice if we could queue both patches in
the series for-linus:
[PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with in-place epf_bar reuse

Even if the first patch mainly avoid pointless execution of code, it also
helped us realize that patch 2/2 was needed in the first place.


Kind regards,
Niklas
