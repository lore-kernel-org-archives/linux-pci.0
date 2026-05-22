Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E721ABAA
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436971; cv=none; b=KrW7BOJFENZTvKeq0qPHeGIWNp3TJ0g5JSG5NROI9oVmtLhY3pCAjSwXUndJGgu+Fz1ij6Ob7oIRtDXCoP9/dME6kd/UB7Im4xF01l6kv2pZalVcBO5pWFdLpfHD5Z+uHtWySWrjrDG1LRn6N6zJJsmruWtjww/kmDIlKzHs9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436971; c=relaxed/simple;
	bh=qhddZx8oRASYTYGI0RlhU+w2W4UOtRk3bcm0fBTTjQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+6t5rN+s905Lhlp2dtwuaPaxOSG3UfVdLjFgHqZtvOW0I2R99CSJkb2eUuQQYRWZVa+8kIfV7QT1oUndFzadz1Yq7R8lY6GxNg2jR+lkZw/eR0ubB/ICzeHBRPdC2H9ZRWxG89xrmp2zPFEbiYIVPeyD/d0nMHUFIkeLgXvaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 6CC2B1062A;
	Fri, 22 May 2026 10:02:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4D3C360A1463; Fri, 22 May 2026 10:02:41 +0200 (CEST)
Date: Fri, 22 May 2026 10:02:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: weipengliang <weipengliang@xiaomi.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI: Avoid unnecessary cpu_hotplug_disable() for
 non-NUMA devices
Message-ID: <ahANoSZXPFUX3HaR@wunner.de>
References: <ahAB2BFymPVFGKaG@wunner.de>
 <20260522075453.473-1-weipengliang@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522075453.473-1-weipengliang@xiaomi.com>

On Fri, May 22, 2026 at 03:54:52PM +0800, weipengliang wrote:
> @@ -392,10 +391,13 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>  	    pci_physfn_is_probed(dev)) {
>  		error = local_pci_probe(&ddi);
> +		dev->is_probed = 0;
> +		return error;
>  	} else {

Hm, looks like these two newly added lines are unnecessary.
Am I missing something?

Thanks,

Lukas
