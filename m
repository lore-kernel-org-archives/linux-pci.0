Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585C5346E4A;
	Thu, 14 May 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794693; cv=none; b=BhNOYw1W1u7T+X5sjFH6yNwHGB7WtQghlbn+PsiH/nRO/vMht/tM63DKiKYuXxMR6J8v/zdUNFFvgBJj6ucDfcZaAQSnFMrYPPRlMJxJ8vbEljU7ft21xb62hs9YnA6aFWfGiksCgHRtIi7Itx4xH9zE5KxzxJhP/XHIxOrWN5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794693; c=relaxed/simple;
	bh=+ToJqHQD+rEElJLal/LDAFQwHkZ0hsRrOg1Da/O/BWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eS9f8UXTN6epUaySYSWLP8KcVgrhaGk74hrHM0/Xu96gmX4JNCC6zXSQVzFuWeEFPiba6FFec4ePPIDtT9jfFVwz1Ng7WzczQy5Nw+NvBsYTFeUJtMKmX3Vuwmjq/RUD87UqFj/8I9XsHCqGqtRCT1YyYE7KiiX8C84PBWi7aAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qadKqpMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qadKqpMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3807C2BCB3;
	Thu, 14 May 2026 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794693;
	bh=+ToJqHQD+rEElJLal/LDAFQwHkZ0hsRrOg1Da/O/BWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qadKqpMJ7C5igbh17379B2UBnXmlTYdpGEicDRtuWOLr7XI0Anhf6B8c6ZOo/Y7Zo
	 FXzPerAJCz8a6lNOvZTowS/hZ3vOv0kK1rrbvKXIrw0RNxaQs/ub5Wegd9W3oepLB+
	 AeYfzFnY4uFu/ZpilNNzLjDsf67rq5iiAni97T7rY3TqbbgbKAKX7ygX3Q9/A/NwFx
	 NXtoDJ3X1Uf/DokJYtI+2TV9NnXkkllGl7z7ibLrqc5RTCSneccivIrUqDoJi7cVgz
	 dTfBIFZNLund5c/IRDjuL8uL4SQCTqhYZUWkU/OGewoQKTrInba7UIqup+4qZ7liva
	 MwOs5/llK/A6A==
Date: Thu, 14 May 2026 16:38:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Message-ID: <20260514213811.GA434353@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514200625.C6877C2BCB3@smtp.kernel.org>

On Thu, May 14, 2026 at 08:06:25PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Ignored return value of `pci_dev_wait()` masks hardware readiness timeouts
> --
> 
> commit 606c3a6294de4df52ee7dc27a7792cef6c8f72c4
> Author: Bjorn Helgaas <helgaas@kernel.org>
> 
> PCI: Wait for device readiness after D3hot -> D0uninitialized transition
> 
> This commit adds a call to pci_dev_wait() after transitioning a device from
> D3hot to D0uninitialized. This ensures the device is ready to accept config
> accesses, especially for devices with No_Soft_Reset == 0.
> 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 8f7cfcc000901..9d0fc9fbb76a0 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> [ ... ]
> > @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
> >  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> >  
> >  	/* Mandatory transition delays; see PCI PM 1.2. */
> > -	if (state == PCI_D3hot)
> > +	if (state == PCI_D3hot) {
> >  		pci_dev_d3_sleep(dev);
> > -	else if (state == PCI_D2)
> > +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> > +			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> > +				     PCIE_RESET_READY_POLL_MS);
> 
> Is it safe to ignore the return value of pci_dev_wait() here?
> 
> If the device times out or disconnects, pci_dev_wait() returns -ENOTTY. By
> ignoring this error, pci_power_up() continues, unconditionally sets
> dev->current_state = PCI_D0, and can return success (1 for need_restore).
> 
> If pci_power_up() returns success, will callers like pci_back_from_sleep()
> execute pci_restore_state() against an unresponsive device, which could
> potentially trigger PCIe Master Aborts, AER events, or system crashes?
> 
> Should pci_power_up() propagate the error from pci_dev_wait() to prevent
> this?

Good point.  I think it should look like this instead:

    if (state == PCI_D3hot) {
            pci_dev_d3_sleep(dev);
            if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
                    ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
                                       PCIE_RESET_READY_POLL_MS);
                    if (ret) {
                            pci_err(dev, "Not ready after soft reset\n");
                            dev->current_state = PCI_D3cold;
                            return -EIO;
                    }
            }
    } else if (state == PCI_D2) {
            udelay(PCI_PM_D2_DELAY);
    }

> > +	} else if (state == PCI_D2) {
> >  		udelay(PCI_PM_D2_DELAY);
> > +	}
> >  
> >  end:
> >  	dev->current_state = PCI_D0;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260514153124.404060-1-bhelgaas@google.com?part=1
