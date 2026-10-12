Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36ED472F93;
	Mon, 12 Oct 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799930; cv=none; b=Oyh2eQ8l5TJzTzLCiJiEpjyrekMmrVzx/mtsYLhOqyoP9kEVCWECDcj9C97E8+XtyFz/clgDkihYnnHBch6EJaIPLbgIKiOmCVtUfdap1GewSi0pSjGyZ3+BrD0Trk9ibrOftuMMbtxLesKJbNvcuDSeixrRe6h1XUD3mvi1uTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799930; c=relaxed/simple;
	bh=MtT+iP3cKBw24ZFL3MLI6cV8yBFqbIdjvWW6CIqA4sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYtmfctX0rFipzNI6IQan7Nr8oAWVwAgvzeuNNS8CToUKHHu0XLAAVy8gCD90fbEN2gaYjVGOc2xPY6Et3VIxL0uCkjOFweVtiYlc2kyA/FkRA0dV+6kByKVKqinlcnf53Nce9/cPHK4LN9eLCKUFvK06ltH1fKiqxA1mWEYZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 11F9D10F63;
	Mon, 12 Oct 2026 12:11:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E32A8600E1CF; Mon, 12 Oct 2026 12:11:56 +0200 (CEST)
Date: Mon, 12 Oct 2026 12:11:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>, Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v3 2/2] PCI: Don't treat ~0 as ready in pci_dev_wait()
 with RRS SV
Message-ID: <asyybNwDFi7hNpZN@wunner.de>
References: <20261011190145.23621-1-gruhlke@mailbox.org>
 <20261011190145.23621-3-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011190145.23621-3-gruhlke@mailbox.org>

On Sun, Oct 11, 2026 at 09:01:45PM +0200, Alexander Gruhlke wrote:
> @@ -1235,8 +1237,12 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  
>  		if (root && root->config_rrs_sv) {
>  			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> -			if (!pci_bus_rrs_vendor_id(id))
> -				break;
> +			if (!pci_bus_rrs_vendor_id(id)) {
> +				if (PCI_POSSIBLE_ERROR(id) && dev->is_virtfn)
> +					pci_read_config_dword(dev, PCI_COMMAND, &id);
> +				if (!PCI_POSSIBLE_ERROR(id))
> +					break;
> +			}
>  		} else {
>  			pci_read_config_dword(dev, PCI_COMMAND, &id);
>  			if (!PCI_POSSIBLE_ERROR(id))

Lean and clean, thank you.  The additional pci_read_config_dword()
exceeds 80 chars, but I guess Bjorn can fix that up when applying
if he dislikes it.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
