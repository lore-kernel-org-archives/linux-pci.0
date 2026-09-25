Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F640DFAC;
	Fri, 25 Sep 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363515; cv=none; b=ZWLeUE9lLCn71FVnnJUlOGv0yoD8wIK7G8HDKP4JlHlbhGi/v9jugqwTaezlzCkmSfHCKU2Ia8fpLLBeNT2N0swZNpQbegUHlHiTnsTHvPOd4NuAUjOPXGWpNSjZkW9BCDri5m7X0DFMLgCcr1prOHexuDTBo0WHXChRC4hGClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363515; c=relaxed/simple;
	bh=8sP3axgJR0FECVYa5bsThwY/ns4nKct1TJy6/+PDeWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4k73GsO9df+RoEuAu8duA6M/wwCF003Fh97YTjvcqhDTkDkrBf5dEfUiNpovNhhJWlCHQizXAm/4S7k6D/09lFMrzQAnsGHHa58hyhBktCMYBHWoGulwOsmTtkokSa588EUuf0fJPjSRul8ffvbP3Sdd1Nf+nuNYxKvuIIyhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 42B2E578;
	Fri, 25 Sep 2026 21:11:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1CB75606F526; Fri, 25 Sep 2026 21:11:44 +0200 (CEST)
Date: Fri, 25 Sep 2026 21:11:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Avoid dropping hotplug interrupts due to
 stale HPIE
Message-ID: <arbHcOj2kdT6fPJP@wunner.de>
References: <20260924101929.143806-1-qiyuzhu2@amd.com>
 <20260925114635.192878-1-qiyuzhu2@amd.com>
 <arbCNu_Ozv2j_CEv@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arbCNu_Ozv2j_CEv@wunner.de>

On Fri, Sep 25, 2026 at 08:49:26PM +0200, Lukas Wunner wrote:
> From PCIe r3.3 table 4-6 bit 0:

Sorry, this should have been PCIe *Firmware* r3.3.
