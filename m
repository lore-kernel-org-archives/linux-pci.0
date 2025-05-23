Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EB266592
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978407; cv=none; b=RoKycD5OUe1Pe+kq6Ynla0YNJf4SspadI+fcDsNuNLeoHF+vROJ3qn2XV+Cej4VLUBcaM7QX6NWTkFMkv9K8f+cTlcOM/6+gXXXt2dmpGrpw30GuBDusrdirdhYGlQ6xzDXqCsoqoNT/Sco8xJyZia2ggxk/FjOWBxEB1YkAw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978407; c=relaxed/simple;
	bh=hkk4AcOB/KhpZav2O6ZyQ88Z7OPmTg0Vsw2AsC/N2Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXSN6DEHpGNK3id8J8rFiDkNxYNknuM6kxkJtX293AJRvKAL+vpUQ6PYwGW3cBmhr0WW7cnxynMkj8mU3nxT2Rp2vXwn9cIG8c7LfrIzapsecbP6koRLSieH10RBp4np6A5C9uXNkYIixzz2Wi8voKDmwDmJ9Hz94SfyjjYH/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 806E1200918A;
	Fri, 23 May 2025 07:33:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6D8744E74F; Fri, 23 May 2025 07:33:16 +0200 (CEST)
Date: Fri, 23 May 2025 07:33:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <aDAInK0F0Qh7QTiw@wunner.de>
References: <aC9OrPAfpzB_A4K2@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC9OrPAfpzB_A4K2@ryzen>

On Thu, May 22, 2025 at 06:19:56PM +0200, Niklas Cassel wrote:
> As you know the reset_slot() callback patches were merged recently.
> 
> Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
> reset_slot() callback has been invoked. The issue is reproduced when MPS
> configuration is set to performance, but might be applicable for other
> MPS configurations as well. The problem appears to be that reset_slot()
> feature does not respect/restore the MPS configuration.

The Device Control register (and thus the MPS setting) is saved via:

  pci_save_state()
    pci_save_pcie_state()

So either you're missing a call to pci_restore_state() after reset,
or you're missing a call to pci_save_state() after changing MPS,
or MPS is somehow overwritten after pci_restore_state().
Which one is it?

Thanks,

Lukas
