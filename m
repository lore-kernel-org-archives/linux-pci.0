Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAA3E171E
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700342; cv=none; b=hjvGWylCKYfYzCRkVYWPIjq0+QluzY7rG7xto+BMxPIqoa9D0gHarglqh24wrAQdrdwBwyyryrDZmUc1s8Ce8XcAyANuGbdRVn99GwshZylKZuZQSnS3T7PUsKverugMxL+H744qnwy+t2GFRAFjYPUeImeUt35aI7kQZVx3s/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700342; c=relaxed/simple;
	bh=+1EKumLLM0yydrlYEykW9gU3C+PSS2ko0hjEWumo2ps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctLulPS6HNA0R4qTuU9mDBjideG0K2RLb0zTwGxzrxAOvV9NfPN+cOOerYjEfqQ7ObWSO5zFxrvBrQSyexgELm+Lz0VSl92sZVKPZba3O/oUzSae5T7uR8XEmrZFurqrB9lJ+/OBqHf5ro3wu/fL3h931BbT6fJF5uop6NZwtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPEDi0fm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPEDi0fm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso4506265e9.3
        for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 23:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700339; x=1792305139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHnv3RyK6B3mY8+dpKdxgwL8T80d95Zy3h96qwK+OUY=;
        b=lPEDi0fmBg4tcRhhpmmP2WyFme9JwgkjoXg+UZTrtNtagxW6PqJrf+qEr23Jk3dJU+
         mGWY4OCXVOfVenjEDZ+Vl4ioCxeNEoFUtR1jTFeRdHS4z9SIkI1vVSe3R/ScOQm+fWVG
         gQbvFg+jmN7YdDzncNxU3d/ILkVyfDnVTi8hurOdHgqWfny+89DPVdoecFsK5EMB7Nb1
         GzzOKVwDB/hun7qlIw1bu+UOSpuIo7IHwZug0d39P2AR8BO+hxOa/9cvqZFdubpspDgB
         BxVmnk8iYvGxqmPDd0D7lUJYODUDF6VOZLql0ukGyrZfAWLqXVmpszHzuJJ8+qB96Z94
         NL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700339; x=1792305139;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHnv3RyK6B3mY8+dpKdxgwL8T80d95Zy3h96qwK+OUY=;
        b=E5UysSzHwpHNi8bxeQdmib7kb5g5OCYdiKqPIjorHidE5FQU7DDXKcp1Hwa8jLAtji
         mwlNH9K8apgTEfORvpRJEKt1ZnVbaIsneKmIcCnI6Q5FOLfAGPokG95VXucnwxS1GSwu
         0Pqf0dR0v71zkIGAINsiESghsT47s85eKtE4P1XZ1Nyr760MP7I6P3UYHDTvpFjZCXYN
         pEBo1qgtdXeVkjZKteZihhkmBM19D9YkRrhzELqnsplkMx2VgN0d/cXPIZPmIItWQphh
         BVYcoSYTcBM/uV+ouv/AUMeyEf6IqRf4CHx78gzXAlyvX4W+6QxBILpVQcLfIJMQiM58
         7/Dw==
X-Forwarded-Encrypted: i=1; AKwUvByLoTpW/ugpvSvISjBWwFDurtWVEWheez6PU3YECeHY4KEBT791sbBWS7JSfvb8ccj47r7bsynTUTM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIutR0dqBcSAtc4tYRyew3e+yI9vRCQWeMyrvQvjyuVATNSX1Db
	7+auqYdguHELuuGWbNCeypQk7ey7yCiTLaPBqv7w5BjI40V7DUpymcfJ
X-Gm-Gg: AYBFou3WppwAVKyCz27rax7iBlvXC/wcLNq7hcCNiMu54RBHfx/ZQzXGhkBqKITJnDT
	bYkHAChpXkWHVf8XwZqoBln1XvVAdT+qUDVJiSI5VLrO6zOT3cfsY005CbxI9thb+oiT2jNrLl3
	xMHSCdz6bpcj4f6doWmxoGNplOhwHCWMBSBs6djrA1N0fdND8r4htbLQm4zgdLp9Req+18+AO1a
	jw5TRmjs6rW8kwoay0FeF1M/qBEKUmzMipG0dMXGbwxaIFqRFQQj2ofSAinmoNeek0xfeU9mh6E
	uIIGnVUiVv8IQ8VyFdSx0hxCNtO0lW0YodSevu2+yzv2IXjz0oCBV2Vvc7Hz1cnCw9WaLoQ0YzM
	B0Ms7MvLQzSNT5x1A9vIplR4Cso++V1ibg2uWzQbS4D5qHAB/WZhKLoMjL+V5XJr0vvYd7hNVmP
	aARMX5UPvIYwgzqkT5oAuKwp/LvXTaU1LhYPVfnfhVg9RHsaBXQD+BQL3imh2srxLZX9Zag4wlD
	angEeu6bw==
X-Received: by 2002:a05:600c:3f0c:b0:4a0:1723:2d8e with SMTP id 5b1f17b1804b1-4a18e44691emr129270315e9.2.1791700338567;
        Sat, 10 Oct 2026 23:32:18 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a197c465b4sm58340845e9.3.2026.10.10.23.32.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Oct 2026 23:32:18 -0700 (PDT)
Date: Sun, 11 Oct 2026 08:32:13 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 bhelgaas@google.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Babu Moger
 <babu.moger@oracle.com>, Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3] usb: xhci-pci: Add TUSB73x0 definitions
Message-ID: <20261011083213.1486acaa.michal.pecio@gmail.com>
In-Reply-To: <20261009125154.266435-1-festevam@gmail.com>
References: <20261009125154.266435-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 09:51:54 -0300, Fabio Estevam wrote:
> Instead of hard-coding the TUSB73X0 PCI ID, USB_CTRL register address
> and the PWRON_POLARITY, introduce definitions for them to make the code
> easier to read.
> 
> No functional change.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v2:
> - Move the TUSB73x0 PCI device ID to the shared PCI ID header and use it
>   in pci-quirks.c too, as suggested by Sashiko.
> 
> Changes since v1:
> - None. Only sent it as a standalone patch instead of part
>   of a series.
> 
>  drivers/usb/host/pci-quirks.c | 3 ++-
>  drivers/usb/host/xhci-pci.c   | 9 +++++++--
>  include/linux/pci_ids.h       | 1 +
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index ba158d63bb8b..f670e7aab984 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -1189,7 +1189,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  	val = readl(base + ext_cap_offset);
>  
>  	/* Auto handoff never worked for these devices. Force it and continue */
> -	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
> +	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
> +	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||

You mentioned working with TUSB7340 before. Was there any board
firmware involved which made use of this chip before the OS?

I'm looking for someone who can tell whether this line should be
touched at all or deleted. It was added by c289d0eff3d5a, which
is very suspicious - it mentions "cards" (like in "PCIe expansion
cards") and adds two IDs in one go. I feel it could be a BIOS bug
affecting all cards and no problem with those chips.

[Adding the author in case he remembers what happened there.]

For example, can a PCIe card raise SMI interrupts? AFAIK it can't.
But if a BIOS thinks otherwise, and enables "SMI on OS ownership
request", it will never learn about our request, so the handoff
times out and falls into the "forced" branch. Or the BIOS may not
rely on this but poll the card, and then "forget" about polling.

Regards,
Michal
