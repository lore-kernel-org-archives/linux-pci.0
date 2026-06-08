Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0F32F76D
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918399; cv=none; b=Q54A/hNM8qNFxq1hqwYLy2WaIdJS2+8rbYFXmE5uGq+9xAzVvDlCl/ENR8N3Sd6s6SFypDIHkRSlJgKD7FtqPQ7WwVseYmKXkeMsRAZXdzNupOypwsg6GbIYOfWasmmEtw2dcUyM9F3hwjDNDG1ffRay5doKqK5qLoxxvHkT/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918399; c=relaxed/simple;
	bh=eHyGunCkEOCT/+vgrLK+pZ8fYBfJ59/R1TOD7yr0PNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4UWSylPMYZz48lC3jdGLiGMcEp4gSxB3bbU1DKrw1MNTcSqtbG+m4aGdhCsJFeGyBR59zQLXN+/JT9hZYAjFquqOfQXINuFeWOEw39rWFYaulN3+PpES4YWN0i7PHgcpPJMWGLmmelmgUjzDV3s+ueR2JYFjkgXkuyLWPWRyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRHtpz+i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRHtpz+i"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0b1a48855so368985ad.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780918397; x=1781523197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AClK5b2UGJLL9HjNCJk/rNNqh+8+sTLcKYFLOrhzbk=;
        b=HRHtpz+iT7e8oEEhWle0XNZ6kadxAoQOUYX+a0adQBWGWSHavLa6QOEJjqMaQT2akw
         XU4x/Eep9A9YIZqKQDf0DTKExiNnynaTRvFzoryvEN5axBsImSWSpqjNNOjXamz3PBTf
         ikPFf7lcyJWrA9+5EePXsfolsC+S39c1m1Br/kQFzGERMZ8LGCQHp/TDTQcnGidVHCer
         Y5jE8mLR2jFZP0u4nFZEf1aG2kjyyEilhTEGHp66jRtwih8ffQtENlglWdSguvx+ymXJ
         J1IDYUgQeXPksKkAMD5qm2uR/FOgXptEMP3xTPIGP60u5FV4dzgauV4TGaT+zMJteXpg
         TyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918397; x=1781523197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AClK5b2UGJLL9HjNCJk/rNNqh+8+sTLcKYFLOrhzbk=;
        b=drMYemnK0XvVX1kxVomjcdPdbjoTpUgjUaY5LoV0RRC38OXkdsBo/iwhwP3uMcs86v
         JFOZp/R81SiF39+Ftt8LqQD7yhu1Z0iHGtROU/YvS0MWvN9ARsF0jq9igDwdH3FIpvep
         f4dAdGuXd7yl/HHasTuO+VFRu3qdt5G30e5Tg9Ce8ajy5qkyAfI6CZ8KIzMHKA3AFh0l
         ilYoeJwCo94S5GeBkuPEy2N35IxdXlSlI5WU0FXTBpEpfcMRDtdB+QpXCrjQhVeLi9/D
         ZaqvEPEmGEiskOty92aeQrNQbYOGSBNWqwjEiIbo9IsHtTJU67VY+MgBeHa9AhBRSG6l
         RyyA==
X-Forwarded-Encrypted: i=1; AFNElJ+hWG53eWdR79yeBlHUHJoHnRjXOGJzs2js8ethUGTpLSQ/Z4z77ioSPY9Qm/NT7n95MURDsfQZOAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLQn/tyEItao/hY5f6ceQMXhLFHokOkbR2ytDNFyQd9TrSrSY
	P+2aCU7iA7O6yYlKYAivf00knK1WebzSoz2kkOsIoXXnETEt41gWa+kW0ctLkY9Z0Q==
X-Gm-Gg: Acq92OEppVQHhYuXvFg5ZyqFVJVyCXm9+xbhqxIeggDhd5fBC76DcpTxDBLkhAA0Lyd
	B6HS2fycKzdsrjc8oQ/PTcgskBkGRnxPkkQ0Rtlo+ww3XQdeOagaysCiA2rwqrfQxtu5RuYBBzB
	QT78ow7rRB18KkjBIpBtW6oUfDMgXlBuMIrlsJhTM0Smun7AMUFuY/4bMKSH8GfWkI1SLeP0sB6
	TMrh6swTwGmW507qRpmjakqMJVsrynjVi/jiko1ZYKkr64HMlsOZ1hM+24aiooi0MT+jY/OoDIt
	lu5Q6lSRTj0Pn+4KcKKCx6BjgnPj2zAezQKw+GGtEwaAqe/pIkpsSge71VMAGRO1KJsO8/2aksH
	HHrzNAl7FrdNWJD3t8Mfigzfn2zJFSTTaJRZzfV/m1ndxMhBX67CDkS3kkPDK/7QzraEqbYMmF6
	eQDeeT0P801bA9pPskvh6cyMgSEcXn+B4d0xM8AhiJBAxRqPq960b7cqR6L+JLDzZuZGmXa38=
X-Received: by 2002:a17:903:2349:b0:2bd:3c1b:3073 with SMTP id d9443c01a7336-2c1ebea9c71mr4318635ad.16.1780918396547;
        Mon, 08 Jun 2026 04:33:16 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm182143405ad.31.2026.06.08.04.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:33:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:33:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
Message-ID: <aiaoc6Y6qeF_5Wn9@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-10-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-10-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:07PM +0000, David Matlack wrote:
> Inherit the ARI Forwarding Enable on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci.c        |  8 +++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a93b7ef065f2..701276ef6cfb 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,6 +128,10 @@
>   *    way after Live Update and ensures that IOMMU groups do not change. Note
>   *    that a device will use its inherited ACS flags for the lifetime of its
>   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> + *
> + *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
> + *    preserved devices to ensure that all preserved devices on the bridge's
> + *    secondary bus are addressable after the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -756,6 +760,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> +{
> +	u16 val;
> +
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->liveupdate.incoming)
> +		return -EINVAL;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);

Again, I might be thinking out loud here, but since these are
hot-pluggable devices, with some FW / SW running on them, I'm a little
worried while assuming the HW registers can be trusted across a kexec.

Say, if the bridge experiences a reset (e.g. link drop etc) during the
kexec blackout, the PCI_EXP_DEVCTL2 register could revert to its default
state, meaning the ARI bit will be 0.

In that scenario, pci_liveupdate_configure_ari() will read 0, set
bridge->ari_enabled = false, and bypass the pci_configure_ari() logic
as well, permanently leaving ARI disabled on the bridge. Any preserved
downstream devices with function numbers > 7 will instantly become
unaddressable, breaking the Live Update. Even if that's desired it gets
hard to identify why the Liveupdate broke.

Should ari_enabled be serialized with bridge's pci_ser to ensure we
correctly restore / match it in case HW changed it during the kexec?

> +	dev->ari_enabled = !!(val & PCI_EXP_DEVCTL2_ARI);
> +	return 0;
> +}
> +

[...]

Thanks,
Praan
