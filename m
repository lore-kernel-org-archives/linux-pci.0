Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE534DB56
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773591; cv=none; b=jclepZomefNKQnfzuBlKJldsNPvw35bdiFMWwEz7bKuoHiVcGBD9XG9ydHTkV61EuXS7JVkkcK0ZEhmywHE4/+dACACQs3mMphE0Lv0iZP6yxD9YFpvHIiuCWKmEIflSFbNiEdAIQawy0TjC+JCU2MUatnJM6EH7T3T89vd8Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773591; c=relaxed/simple;
	bh=N9dHyfS/85cVGB/Mfgo3lFlgHZ3Wm6bzxAQN1yO4YFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYG+VtPsQaOf4H8CGfKzwUfoeHJrOAFzd0dnsqg9fLDERG+01vCsFTKcmKCw0uGJD3Nr9o33lJOoazQ7Ow7xZvVwKCrEVKiYkujgpz0K1EJQKAR03XL/qQCtnKepnSeQXWjtWO9oe6z9lyrc2JkpmbK5TiwqmlTvWaZR7YQ/NQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id D9D38363;
	Thu, 18 Jun 2026 11:06:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C213160A01DA; Thu, 18 Jun 2026 11:06:18 +0200 (CEST)
Date: Thu, 18 Jun 2026 11:06:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mani@kernel.org,
	Mitran Karthikeyan <kmitran@axiado.com>
Subject: Re: [PATCH] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE
 entry
Message-ID: <ajO1Cqy13B2xCEfO@wunner.de>
References: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>

On Thu, Jun 18, 2026 at 10:08:11AM +0200, Manivannan Sadhasivam wrote:
> Karthikeyan's Mobiveil email address is now bouncing and there is no sign
> of him [1] willing to carry out maintainership duties for this driver. So
> drop him from the MAINTAINERS entry for MOBIVEIL PCIE.

Thanks for doing this.

> +++ b/MAINTAINERS
> @@ -20438,7 +20438,6 @@ F:	include/linux/switchtec.h
>  F:	include/uapi/linux/switchtec_ioctl.h
>  
>  PCI DRIVER FOR MOBIVEIL PCIE IP
> -M:	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
>  M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported

Maybe also update .mailmap to point the bouncing address
to kmitran@axiado.com ?
