Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D52AD2B;
	Wed, 25 Feb 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025816; cv=none; b=jq6+wi1G8yjvCIMtZ/eNjstW+ac6wlPKIDTjUt/DbAoV5FlgBy/lbq61tCiTwlz80VjZS5HAohTp0Mai2mdAoHjtopxrDh7WB8ANFX8UBYUuy8Kf/jgc3vQJ38EoSbp3RtMw0VwTBslorzSSYQoVMR7396ADv4N5ac/jwKq2gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025816; c=relaxed/simple;
	bh=KkOUu0ANk24DAYYKqHkiIDfF/KjppTLb2F+CqIPjC30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCx8iPxHEmYkqdBQeheeGDgRDdDPAxeYPgBE/pfOUhki03PMBiJc+5JTfF1ATrGSPKlA1ikBx3HFn8eIJMAcjxtbyO304c5fIl5qnOs7kRlL37s7lAIDeBwMZP4+4i894sM30voCRoWJQLyQGaLp+rCp1WIV8z0/YfUsXskRFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e88X1oXq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e88X1oXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C58C19423;
	Wed, 25 Feb 2026 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025816;
	bh=KkOUu0ANk24DAYYKqHkiIDfF/KjppTLb2F+CqIPjC30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e88X1oXq2uRLqdG82vcpQTTAorh/0GbjqkO6G3Vcau2WGDMGC8k+X2s6nEpao6BuZ
	 WOeKyTNYT9BpiYLR/mkmhw3m2XLpW5AwuhxlP+Y3VjyDB4mhWZJjKBKMx/1bX+Ux+t
	 zR+EhgIGMkDvLksminfkc0HfAqK9G5iInIrpuHqiyybFktNsZLSiopvdeh9pKne4Jm
	 pPXUyCEAbvg2qrkN8FxO9cjET7fkg2eKVFkK8w30oH96h1q5zPcTmpWBy9ay8+fh3w
	 GKNucZW7XYTqsrz1I1mhRb4z3kLZnMU1ypid5l8gCdKu6ucyFwvOJ0dFyY1N9zZfFS
	 tdEDdYegPeiRg==
Date: Wed, 25 Feb 2026 14:23:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build
 time
Message-ID: <aZ731NM0TgqvwOlo@ryzen>
References: <20200928194651.5393-2-james.quinlan@broadcom.com>
 <20260220221106.GA3552425@bhelgaas>
 <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>

On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
> On Fri, Feb 20, 2026 at 5:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > > The Kconfig is modified so that the pcie_bus_config setting can be done at
> > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > > pci_bus_config setting may still be overridden by the bootline param.

Hello Jim,

Could you perhaps test this series:
https://lore.kernel.org/linux-pci/20251127170908.14850-1-18255117159@163.com/


Since the series above only defaults by setting MPS to MPSS for the
Root Port (and no other devices), for kernels with PCIE_BUS_SAFE=y
pcie_bus_configure_settings() will still be called for each downstream
device, so it should not affect your CM product.

But, it would be nice if you could test the series anyway, just to
verify.


Kind regards,
Niklas
