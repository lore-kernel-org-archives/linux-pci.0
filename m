Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766834677D;
	Tue,  5 May 2026 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997127; cv=none; b=ajQ+y95PM/sA+XtqFFX1dnL6tlA3bBGnaHjkZ8XomRz+fh2BQ9N0+TKudfyCFHJ7FgDZhitKVtQzeDlUAuxck3G88MiTuaw3f5cnByiB4Vjp7mUe7OBZdf+aar9CyaZ2o2QmDYZcnj/blQoxvCh5OTZo3Qk15ma7M7v81nzQXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997127; c=relaxed/simple;
	bh=VpZ227TdDqhfe1MHjIUQzix13+/qEQ7J1ckhZEsPg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PkxmgQDzQxwpF2USLtb4lOzeubAzt8xudilvCzaSq8/uGcP0ionbREClOAuTCRQrV3UeQASKWr5t7Rg1j8CO63/6fYNtVPhKNROKlMyruiHHgs7bspuQXtDvF7jPRGOobnMsfjbPjuXh/4UlnIf7TpLmVXmS6sE6hswWbVq/gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8p7C6p9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8p7C6p9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C456C2BCB4;
	Tue,  5 May 2026 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997127;
	bh=VpZ227TdDqhfe1MHjIUQzix13+/qEQ7J1ckhZEsPg8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c8p7C6p9JUqbSYAynL3OManCvAs5sJSr9BiPAkGJp+FbszJ6TxXv6uTa0OCYjKJZI
	 riQx3+9s+brdCf6Qis/PsO3akU1Nsxj9ODlndB9OHcb5ZweQrqyftgf72XGrfgtYU1
	 xk/K0OErhficH6/JaDSzZaV3S8Rzy+nPUDYowExJxRuy0eSH2IxSlVzfsCWwx95uMg
	 863vhqEDRamB8uKT+pAeBfusFJbkfRIsRZnwv8p8mVjrwbdNMLKWpG6XxX40d9s83F
	 8yEIInS14pTkbK2Ja2tydVAP807VZbhdGUe0dXA2gv+RywsfeWlz8wiHLGUnl4z0bA
	 lFKdcaK4bj78A==
Date: Tue, 5 May 2026 11:05:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Message-ID: <20260505160525.GA733339@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504225246.480921-1-mario.limonciello@amd.com>

On Mon, May 04, 2026 at 05:52:46PM -0500, Mario Limonciello wrote:
> When comparing lspci output between Windows and Linux for hotplugged
> Thunderbolt 5 eGPU devices, Windows enables ASPM L1 but Linux doesn't:
> 
>   Windows: LnkCtl: ASPM L1 Enabled
>   Linux:   LnkCtl: ASPM Disabled
> 
> This difference in ASPM configuration can cause behavioral differences
> between the two operating systems for the same hardware.

A tangent, not a comment on the patch itself, but what sort of
behavioral differences are these?  If ASPM is working correctly, the
only differences *should* be in power consumption and performance.
