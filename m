Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3C3803C5;
	Sat, 10 Oct 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657415; cv=none; b=mnhpn9mZreGxF/vdNoNOFnLSTW0jvGH/wvYlG7tuU5XSXsdaz0Vl2IUMyQAcssBzMWjxMhdzS+74LdPElzyshqmAXfc1EO9by3QZTcusLTPrvUsmyRdFBriVR8/gI0Ed2PMkA4bRvI8Ij+HtiaVB6K/e9IoqGxANlsA+Mj/A++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657415; c=relaxed/simple;
	bh=SQA7JC6qgtMszrjqWsrD0o07K3D1QUJ9x/ZHfKBd6yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcxIJfLybi9gMFDvM+Sl0WfqZG/X/laNATTfSe8JSyxrDc0sTaSQeTevPTtzikSGI7Ew2pUgoHIOVflFHzWuV7ZTKG2SVOqWxyRVopmIU7kIVfq6VMRhVtpZJWkA5Bw1kD8haKjHXA8P0wcAYaN4pO75F8m/eYtnIdsQBBSKoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id C5AF8D5C;
	Sat, 10 Oct 2026 20:36:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 877A260E0055; Sat, 10 Oct 2026 20:36:38 +0200 (CEST)
Date: Sat, 10 Oct 2026 20:36:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Gruhlke <gruhlke@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: Don't treat ~0 as ready in pci_dev_wait() with
 RRS SV
Message-ID: <asqFthqcsDkUU6Sg@wunner.de>
References: <20261010160529.27974-1-gruhlke@mailbox.org>
 <20261010160529.27974-2-gruhlke@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010160529.27974-2-gruhlke@mailbox.org>

On Sat, Oct 10, 2026 at 06:05:28PM +0200, Alexander Gruhlke wrote:
> With RRS Software Visibility, pci_dev_wait() considers a device ready as
> soon as reading the Vendor ID doesn't return the RRS value.  Some devices
> don't respond with RRS while they aren't ready, so the read returns ~0
> and pci_dev_wait() stops waiting too early.  This was seen with Intel
> [8086:0a54] and Samsung [144d:a80c] NVMe SSDs.

If I understand the spec correctly (PCIe r7.1 sec 2.3.2), enabling
RRS Software Visibility at the Root Port doesn't mean that every
failed device access has to return 0x0001.

Rather, that value is only returned if the device sent an RRS Completion
to the Root Complex.

It seems support for RRS Completions in Endpoints is optional because the
"Implementation Note: Request Retry Status for Configuration Requests"
at the end of PCIe r7.1 sec 2.3.1 says devices are "permitted" to send
RRS Completions.  That's a spec term used if something is optional.
The device may send such Completions, but it doesn't have to.

Also, the device may not be accessible at all, in which case it's sending
no Completion to the Root Complex.

> @@ -1215,7 +1215,8 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	 * If the device is below a Root Port with Configuration RRS
>  	 * Software Visibility enabled, reading the Vendor ID returns a
>  	 * special data value if the device responded with RRS.  Read the
> -	 * Vendor ID until we get non-RRS status.
> +	 * Vendor ID until we get non-RRS status, then the Command register
> +	 * as below.
>  	 *

The code comment should be rephrased such that "returns" is replaced
with "may return" because of the optionality of RRS Completions.

> @@ -1235,8 +1236,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  
>  		if (root && root->config_rrs_sv) {
>  			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> -			if (!pci_bus_rrs_vendor_id(id))
> -				break;
> +			if (!pci_bus_rrs_vendor_id(id)) {
> +				pci_read_config_dword(dev, PCI_COMMAND, &id);
> +				if (!PCI_POSSIBLE_ERROR(id))
> +					break;
> +			}

I think it's sufficient if you just change the if-condition like this:

-			if (!pci_bus_rrs_vendor_id(id))
+			if (!pci_bus_rrs_vendor_id(id) &&
+			    !PCI_POSSIBLE_ERROR(id)) {

I don't see the need for the extra read of the Command register
you're performing.

Thanks,

Lukas
