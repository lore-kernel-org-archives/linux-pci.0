Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BE4E430F
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474136; cv=none; b=blv0qlsYA2MVaPNUwZv+6qfBeU7e28KANYKwUPqO5N+cKRbpR8Kh4FfcET3+sU+5fY+KGMw4/tDHBQBFqeoX9eUn3jov+sLFWdNSIdQgoDDDYhGuzR6GgYDPrtwxdcYNv9reYs/JXd1dRMDhDDBkv/pEHwOG46pM3pb3lDqpjJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474136; c=relaxed/simple;
	bh=gg/wCoeJJkeYRFieCpa1JYJtn2aW+4Wg6mPD5tGmwAM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9DkNO43d+SNozMDxGXOcc5+WsAcRvOynD+69CemCWMPSO1btNOKrlGAvqqQtEeYf3oruZGNfi+rqYWl1f7QOMrwRwc+qf8DXEZR+kHq8QzkXP7rTd0ZLEAJ74ftOWksR7hQb488vMYb9y25lpATH2RZVeKXrUfsdnUAXKKxc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rw87p5Nl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rw87p5Nl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so27220825e9.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791474133; x=1792078933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEL2zNgqtY5R53b/Ga9fAl62FJSzRCZqrvx35PwejXs=;
        b=Rw87p5NlSOfaAHnIYB/bSCE37Sm79XrdvEod7dwprBaOmUO9WC6UPUHX9/9BCPTvnw
         WcVQPznE9QUimJXBs5Vw0dN8IOePkbj6mqwHcd3IiYPIVMZO98vPABetle/OLLam3yHX
         Bk89GUwaSmMxtlykpoi2WoUqaC4MmVLPlIk8LVPRYTjFSM0hZ3od5tCslgHeSeFhZQGA
         pCEhlGh9WDXOk8PIUfATKOJgQ4GExadWAeas+j6/2G/9Ga8y11RWJL4BcUgz4AAZnTwi
         Xq74lDaxYCzp4S2hBljp/MQYOt+quT3wvDAp5H4tr/hAv/7En6DMrnh+L9uTzQ4JZ+t5
         iVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474133; x=1792078933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEL2zNgqtY5R53b/Ga9fAl62FJSzRCZqrvx35PwejXs=;
        b=whMBiVTSrn6nSvgEmLVZu/rgO55qmRHFRUjQRUW5Asbep3Tp7Dc+YYNKenmcjE4qb6
         dn3mSSxuec4xwPS2b7hlsndEBvBaEPoU3fSvTX9DdlmP9yDwR7gMqn93PYS8oEdGb2lN
         Sp3wrQ6NRHZmU7zl2Sr7uveng8WxjspOff8QyttELNu2dC2Qxm+kWYLtksI3lBGMxWRu
         Qxm3KZU08VrmzI9Np9DvzhjHWYbW5ubfq7rxukxO/yQ7f8Wj7zWO3MuAhq36CdzhoQhA
         VtlSnqRkc8XDJoPVauFHE8wRdhXsNsxfTDZFt3cX97ulK/i3tOPsYrtnzvbiN55u5jSu
         kBzg==
X-Forwarded-Encrypted: i=1; AKwUvBwMUz+ZHgOGNkgEdsSXIePL38IPdiwDV4R4PWbPRc/Ikw6/Zi6GiQ7+Jyjxf5v53mbBjTHmUt2HxDc=@vger.kernel.org
X-Gm-Message-State: AFuF++nMEiOAFv/g+6vw3fMpFUDaEW6MgVpElRyzGSkXVTqCV2XDYQvH
	tznnVq/PtTYL1S1glD7aGsmUKTGiTipO4RoV9nFLv3sA3WEbY+xabtyXatpzitBXZds=
X-Gm-Gg: AYBFou2DmmlcscXT03Rtpvv6z6afXFpXWlEQhj1QudJkhE9rQLfCSCgybqY/sWAW8zT
	cer0ZlmtdvWNE35bjxUTgDwD1AghKJExjtgRU8fy+At4xy7wYAx+48I3fqKGM/ScY81B78MCabZ
	pI8hfvMGmy9S3E9Qryq39Kcm4gISpfibxSljca8VYnwq8s9UoP10xh8Nzk9kqPJalYFazJrPllD
	t7YNCksj6oGLEdCbmRDd/WsFPBgMkWFqiFaXDmFRQz4a6ilHtAqQFJ1/a4CD4m6qUJvgK7Eicto
	xmTb96fqd6paxiarawKEarLmDnkUd6/g+0TqZBlk7u10tvES5w9vctBhdYQawN5p6aEggpqpLPe
	5e/40kxK6xUuKxDTzov8fxaB7uY6GNu21o0fRjcIrTu52ymK0HCvGVY5kq7PIKz0md8XHqUaSOY
	nsdwZPP2JoK436fR0WsPKqpn92CfIjyVx3bSZJ1hBHiZ2HVfDw5c1bhrQhvYdw8lCdmo0LA4W2H
	zlGE8oj
X-Received: by 2002:a05:600c:45d5:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4a188de9ea4mr25538755e9.5.1791474132743;
        Thu, 08 Oct 2026 08:42:12 -0700 (PDT)
Received: from localhost ([195.94.150.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db650fd9asm239323f8f.15.2026.10.08.08.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:42:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 8 Oct 2026 17:45:58 +0200
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, lizhi.hou@amd.com, herve.codina@bootlin.com,
	andrea.porta@suse.com, daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
Message-ID: <ase6toUhGn0XD0v9@apocalypse>
References: <20260924222444.1351466-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924222444.1351466-1-elder@riscstar.com>

Hi Alex,

On 17:24 Thu 24 Sep     , Alex Elder wrote:
> A PCI endpoint bus is a devicetree construct that allows a PCI
> endpoint (function) to have sub-devices defined that are accessible
> in an SoC via the PCI endpoint's BARs.  Such a bus is represented as
> a devicetree sub-node for a PCI function having the name "pci-ep-bus".
> There can be one or more pci-ep-bus nodes.
> 
> A PCI function with a pci-ep-bus devicetree node must also define
> "#address-cells", "#size-cells", and "ranges" properties, to specify
> how endpoint bus addresses are translated to the PCI parent bus.
> 
> An endpoint bus address has three cells; the first indicates which of
> the function's BARs the address is associated with, and the other two
> specify a 64-bit (2 cell) offset within the BAR's region.
> 
> BAR base addresses are determined dynamically by the PCI enumeration
> process, so generally it's not possible to include them in a static
> devicetree file.  When this addressing scheme was introduced, this
> was not a problem because the devicetree content was generated
> dynamically--after booting--based on the information (including BAR
> addresses) available following PCI enumeration.
> 
> It is possible (and in some cases, necessary) to define the devicetree
> nodes that represent PCI devices ahead of time, in a statically-defined
> devicetree file.  In order to support the PCI endpoint bus model in this
> case it is necessary to dynamically update the static devicetree so that
> the BAR base addresses assigned during enumeration are reflected in the
> endpoint's "ranges" property.
> 
> This series implements that dynamic update, leveraging the same code
> used to create the "ranges" property when PCI_DYNAMIC_OF_NODES is
> enabled.  The first patch makes an argument to of_pci_get_addr_flags()
> optional.  The second patch separates the code that dynamically builds
> the property value into a helper function, and the last arranges for a
> statically-defined devicetree node for a PCI endpoint to have its
> "ranges" property updated (if it includes a "pci-ep-bus" sub-node)..
> 
> 					-Alex
> 
> Note: this series is built upon these patches:
>   https://lore.kernel.org/lkml/20260924150222.1179235-5-elder@riscstar.com/
> 
> The entire series (based on v7.3-rc4 and including those prerequisites)
> is available here:
>   https://github.com/riscstar/linux/tree/outgoing/dynamic_ranges-v3
> 
> Between version 2 and version 3:
> - The ranges property for a PCI endpoint with an existing devicetree node
>   is only updated if its ranges property has an empty value (i.e., it is
>   "ranges;", or is not defined)
> 
> Version 2 is available here:
>   https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/
> 
> Between version 1 and version 2:
> - Included the first patch (which was previously posted in a different
>   series)
> - Modified the last patch so the ranges property is updated only for
>   PCI endpoints having at least one "pci-ep-bus" node
> - Rebased on v7.3-rc2 (and the prerequisite series)
> 
> Version 1 is available here:
>   https://lore.kernel.org/lkml/20260813220717.1394644-1-elder@riscstar.com/
> 
> 
> Alex Elder (3):
>   PCI: of: make a flags argument optional
>   PCI: of: introduce of_pci_build_prop_ranges()
>   PCI: of: introduce of_pci_update_endpoint_node_ranges()
> 
>  drivers/pci/of.c          |  94 +++++++++++++++++++++++---
>  drivers/pci/of_property.c | 137 +++++++++++++++++++++++++-------------
>  drivers/pci/pci.h         |   1 +
>  3 files changed, 178 insertions(+), 54 deletions(-)
> 
> 
> base-commit: 6ba8359b84d69a07d508693551ed3f661d838e9f
> -- 
> 2.53.0
>

After a quick test, it seems that it's not working out of the
box on my RPi5. Let me investigate a bit to see what's wrong.

Many thanks,
Andrea
