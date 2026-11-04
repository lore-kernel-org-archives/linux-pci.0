Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813484;
	b=Q3Kk0MC8T3FKgOlbB0hulSNi4F3nDIrc5xIPui9p9nwgkjjc9TBhe6rd+iJe5tiRDa9F
	 K4CCsGjHO9zmbmjLOqlkI4Kt/MmtZAibSym33+eIDCLjRSgRsC6B3XqR6BtEhtL+eAfYW
	 MNtomX4AfKMCmO/c8DOAMyjSptUxxlCw6E+GeQx+GkS1wPTHfHbPiC4F2Y+8jjRCMu9Gc
	 +AJm7WhSTuxd6ime8Vs+h7rHd2LSbD0maYWTuhdKLJBpD86WCyhfx1x5TAtOGaI8bv6k/
	 dWYApfkLnwLSn2XeduMNlrdEGhorjfzPd/5c0I8BIDZRb+kxFUvTtyGimR7nqi5rUKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=MZNgt729IcTXFfACw9SEbczNOMEofeBpwyhqGRkdYis=;
	b=Uo33BOkJUFMhTuLh9QbF6vOE24MSV7pgzjz5jCqQXl3BChyrcQ60pbpZgq/il+5ISG7z
	 nNCwy9Pa1bVgQ4y1OuJigWpAITUcIWXMnheSVowBhgH/+1YYyCsUfONUbMtQrha5nRiZI
	 FNJsZsyzS8ZE1keIIyfuyeVFCZ0Q0/a4mR1ZrqahvzaB55EZ5Egm6KHHzOwipERIEPOYz
	 ObSvwXJjUuM+KEKronADV8pIHutnjJSbCNGwcR9L40hKTkoeujsWkVD4Yth3u6CzAC4oY
	 jPZBYMldrIpYR/3j8RpqvbU6pslO8Jp5aWKgcG6sazumkv1Gb1SOFMWNduTrC4EFGpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=D8FgtSN+;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16CA60A5BC4
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 17:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16CA60A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=D8FgtSN+
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso6264086d6.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793813483; x=1794418283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZNgt729IcTXFfACw9SEbczNOMEofeBpwyhqGRkdYis=;
        b=D8FgtSN+VPTCcCpkVLPDg8xKpTFyl48aHxcRKOM3g2M8FopT9nPE5+Fbxwc1pRkGSl
         YeRhtM6+AQaWs+uQNDFcGktN58C8OM12f1ggKhQpY8pW+fZyj8pBH/R2NXoGl08s5kqK
         gJCWBRL3JnbQMlWecmGg4awjFQRb3k+aTE6wrFEZc+/Nw/3IJUvKLbW2noXOd1w1okYo
         IFXW6YOThf7CZxKgbZf53DLw3LkaHqluubQSpq9/S3WDUuJHY13LifC+dd8Tryr8aMYL
         tFxSHwzpRdhNY1TpuHJrNuorO31mKIQ2PTa3pRB7VGk+UftsZYAk6ZynJ+PqgUCo4KHL
         6c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813483; x=1794418283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MZNgt729IcTXFfACw9SEbczNOMEofeBpwyhqGRkdYis=;
        b=blmvLYYbwCyoqRDxRUo/1hN5HIsLTKHy9j4GBxryeneCyOMBD2mPYQV93KeQ9y+OnC
         Hc3m1V7lXrRmLxC53CfsVBAGOkdDpnlpcWPalmG9yM89+jPEesHd5SVDZs/bbFdrpNTX
         7DCkU9FNcafPrjkmhaA3mWJXbGWqjg/qlnhjX60soDZXJygQzIuh9CvCLOGAxN5LuMqr
         EuU3GFF6lx1umqhiVI4H3qykeCEefBEWAR4B2ijxmywqBLh03tJaUpBAExu8dWnMdpRN
         2AfGhhXR+yMo9zee+HrRPt9ycHJcu+gJwm3WFLirX5cRhQQPUB/88C/FdJMcadvXlTBv
         Bvdw==
X-Forwarded-Encrypted: i=1; AKwUvByfs49e0nOcPQ0smAfLAWYrb2xSudii9TCpYIQ3WZzpeX/LjhyU2laAv/T/r/kf043/ghR4geYvVK0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8efRZBBW8/qdiCBTM/Ilj8S48knuzVqOwBQrPp1BjuiRA/XCKW
	+X/lur3RXSi7MuWrcGYPK+FxUs6fsQg1geXK1AWANrIjiloH+/qSw/Sw0GhOY6RCgqQ=
X-Gm-Gg: AYBFou0RfuHHdvgDE9RiJW9UTeHbB8NalVetXeOMzk4Yjcl2XKb+MlNA+j87JUowKug
	D7TPJiW2SPF3V8pitR5EHGGoGQtLXiSTaXIoba+5i5bVh1iVXj6smGNDYMWYfmFqeIL1q841hbI
	Z7zYvtrTR7WyXvkww2yGLDo9vDqi7Yg3YZrHYP22WmsgrZpeomdonff1zp5JqsjIJx2lU0ujM2/
	iM+/0f0x1cQ+zQWUnBTCXYMlIzPJdkmAtCXA9goBTwkMwViPPimV84889NFxwiMqAAHEHFEKZTp
	9wyyT1LLpwWh/EyO40cRKmyfsmsFCkrA0KNHCPdDy4qnt/L6xABnTsB5tQfVguvneelHe2JDjek
	tTrYuJc+o/urmNq4L3Fpxxy3+upR5Jl4raeKkJkkQ+KRBMaG73EW66Q1PYwsVXxb++pccHysxjV
	xvPmwXyp1BUszljmzcRPp/BUd7zXmUNTRBgB5bEwediwpGgx9OhD68NAfM6ZinfFa0uzYkkApGK
	QIBHLfQz4mT9yUtkOmOBreVykoj0718LgUZeVdK1bOFN1yrBsQVXGkr2bicui4yvMRRN5fCHpJJ
	G1jhoTkYjoUovr+ANNXia5R+gkmODfbO8sIzjoECIjR9pk87WHHlKuvb4S4OSmvpq4dK35K4ANz
	lbJWFFbw/PZjTlMXxeyAdwXil2SysITM=
X-Received: by 2002:a05:6214:dcf:b0:91b:b0ca:9f8 with SMTP id 6a1803df08f44-91ca4b9078cmr280697936d6.26.1793813482741;
        Wed, 04 Nov 2026 09:31:22 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e8e4b81b3sm8014236d6.24.2026.11.04.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:31:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOepV-0000000GrRW-2eNY;
	Wed, 04 Nov 2026 13:31:21 -0400
Date: Wed, 4 Nov 2026 13:31:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukasz Laguna <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, michal.winiarski@intel.com, djbw@kernel.org,
	brett.creeley@amd.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vipin Sharma <vipinsh@google.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 04/13] PCI/IOV: Allow VF drivers to handle resets
Message-ID: <20261104173121.GW3889730@ziepe.ca>
References: <20261027160446.858300-5-lukasz.laguna@intel.com>
 <20261027200006.GA474913@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027200006.GA474913@bhelgaas>

On Tue, Oct 27, 2026 at 03:00:06PM -0500, Bjorn Helgaas wrote:
> [+cc others interested in VF reset]
> 
> On Tue, Oct 27, 2026 at 05:04:37PM +0100, Lukasz Laguna wrote:
> > From: Michał Winiarski <michal.winiarski@intel.com>
> > 
> > While the kernel representation of VF device (think struct device) is
> > preserved across PF FLR, and the PF IOV state (among other PCI CFG
> > state) is saved and restored across reset, the actual VF state is lost,
> > as from PCI perspective, VF didn't exist in the time between PF FLR and
> > PF IOV state restore.
> > 
> > Save / restore all subordinate VFs config state, and notify their
> > drivers using .reset_prepare() / .reset_done() to make sure that both
> > architected and unarchitected state can be preserved across FLR.
> > 
> > VFs are disabled only after the PF driver's .reset_prepare() and their
> > state is restored before PF driver's .reset_done(), so they can still
> > communicate with the PF while it handles the reset.
> > 
> > This also fixes VFs handling during bus and slot reset. Previously, VFs
> > were handled like any other device found while walking bus->devices.
> > Since that walk is top-down, the .reset_prepare() was triggered on PF
> > before it was triggered on the VFs. Moreover, the walk recurses only
> > through dev->subordinate, so it never reaches VFs on an SR-IOV virtual
> > bus, as such a bus has no bridge. Those VFs were reset without being
> > locked, without driver notification and without config space
> > save/restore. Now, the bus walk skips VFs and they are locked, saved
> > and restored together with their PF.
> > 
> > As part of this, pci_reset_function_locked() now requires PF callers to
> > hold the device locks for all enabled VFs as well.
> > 
> > Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> > Co-developed-by: Lukasz Laguna <lukasz.laguna@intel.com>
> > Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
> 
> 
> > @@ -5340,6 +5402,10 @@ void pci_init_reset_methods(struct pci_dev *dev)
> >   * from __pci_reset_function_locked() in that it saves and restores device state
> >   * over the reset and takes the PCI device lock.
> >   *
> > + * If @dev is a PF with VFs enabled, the VFs are locked as well, their drivers
> > + * are notified via reset_prepare() and reset_done(), and their state is saved
> > + * and restored over the reset.
> > + *
> >   * Returns 0 if the device function was successfully reset or negative if the
> >   * device doesn't support resetting a single function.
> >   */
> > @@ -5360,11 +5426,13 @@ int pci_reset_function(struct pci_dev *dev)
> >  		pci_dev_lock(bridge);
> >  
> >  	pci_dev_lock(dev);
> > +	pci_dev_lock_vfs(dev);
> >  	pci_dev_save_and_disable(dev);
> >  
> >  	rc = __pci_reset_function_locked(dev);
> 
> Today we can call pci_reset_function() on a VF, can't we?  I assume it
> will do an FLR on just that VF? 

Yes and yes, that needs to keep working. VFIO relies on it.

Jason
