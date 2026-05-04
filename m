Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DE30F7FB
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880982; cv=none; b=EC3PubSrXJBKyzdn4FN1nEdvr79NdLV8wc9TAcivqMsjFaVHoAsZMOLu4w80InGYxrVTo/bhZ6wRwpeM//C2yQnUHieygE2k8TkCyFGIXsFTHWq0gCosl2nn6mvZ8pGV2Hb97fSbhkz/xafAC/zGcmccaouOj5LHW79+VsPHzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880982; c=relaxed/simple;
	bh=iyd9zb129Pnm+iwV0/zcRqQV5H+vblJWszUxZPv1rlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyPzyPJDIdk4ua8LLRGPU4rpEYjl5L2PqD9YF3tPlfvC23bP2Bg7xtDpIu5aXg5wHq80v4SLorM00wWo/2wPCcErfFnDHFQUNreIK1Ku+r4m2Ym+y4Vt+qWC6y9I6e64SCEFpISybyo4cJzI/HLXVFoFkYfRwPCHtRat2h3ez4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id D6BC910DDB;
	Mon, 04 May 2026 09:49:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B74046019647; Mon,  4 May 2026 09:49:36 +0200 (CEST)
Date: Mon, 4 May 2026 09:49:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: sashiko-bot@kernel.org
Cc: linux-pci@vger.kernel.org, sashiko@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Message-ID: <afhPkLynt7vS793r@wunner.de>
References: <785c98b50a7a00d0698848c75d51b8f5669ad18f.1777814679.git.lukas@wunner.de>
 <20260503135109.46193C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503135109.46193C2BCB4@smtp.kernel.org>

On Sun, May 03, 2026 at 01:51:08PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] Removing the read-back and retry loop for BAR restoration in
> `pci_restore_state()` introduces a risk of silent regressions for
> hardware resuming from non-FLR resets (such as D3hot to D0 transitions
> or custom driver resets). The commit incorrectly assumes the 60s delay
> from `pci_dev_wait()` covers all usages, but standard PM resume paths
> only delay for 10ms (`PCI_PM_D3_WAIT`) before calling `pci_restore_state()`.
> Historically, hardware that needed slightly longer to accept
> configuration writes relied on the 10x 1ms retry loop to successfully
> restore BARs. By removing both the retry and the read-back verification,
> BAR writes to slow devices will be silently dropped, leaving hardware
> unconfigured and causing MMIO accesses to result in IOMMU faults or
> kernel crashes.

Hallucination alert:

PCI_PM_D3_WAIT does not exist, it was renamed to PCI_PM_D3HOT_WAIT
six years ago by commit 3789af9a13e5, which went into v5.10.

The macro is used in:

pci_pm_resume_noirq()
  pci_pm_default_resume_early()
    pci_pm_power_up_and_verify_state()
      pci_power_up()
        pci_dev_d3_sleep()

However before pci_power_up() calls pci_dev_d3_sleep(), it reads
the PMCSR register and errors out if config space is inaccessible.

Hence when pci_restore_state() is invoked a bit later, config space
can be assumed to be accessible.

sashiko reviews are a mixed bag, I think this one doesn't even reach
junior developer level. :(

Thanks,

Lukas
