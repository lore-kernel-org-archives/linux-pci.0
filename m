Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844785;
	b=yBC54YBv+5U46SzfonFT4eNpF9qq75K/XJ6SVxC7z90+bFCX3yGKFGU+EQvDj+rnJ2uk
	 0c/9rXDEPnLqA6lG0YQDaYlzb5EAoropE61l3JXUvyc/+Y5Sip4HtX8x9dhCs/tDraZ2l
	 DJJWovpDCuQk5NmJaNaUzQjCWHCTCEFQd/gS9zy5AOO2GQBCXffGzeOY/D9RtNQeM6ES3
	 SKFNAYF93cEKJ5VzNHN4rnSDFzzJGGQ4eUWkzdc59iljkuEGNPJGSi+/zuoNDTFqUPT4T
	 9bvCESF8efRIOKzr5b4b3IqNMPHfgP7S0hXG38scfWb/1/lk9VXcGFmK8qYcNVVgASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
	b=f6RQisuWshCaeSDXHD/ukivU/Ypb1PVly1mZ12HDR7YJDBydKmOmCPtDWL9Vmqv38Vb4
	 XNC9Btlp7N4uuj8FF/ro//iDRe4/9ID+/DcOeVxelgcZwNZYB3c1XvQw0JCwPEBMSabQ1
	 urinN2SU3gJ2snAZ7TRVs6s1Ku5YvBnQil3fsutXIkEnVgl0ADpR50C4VBDc/WEEISSaL
	 0axMcvR5pqeIPF5xmMqS9KikBTImsRo37Rw2hV+fO+TtpHFmcRW7qPBWdlCqHKqW7BFSc
	 MQJ3wke/cjJrV9PHUcRfCwBEQnkePfTOlmAj7zgfRkpK/57ZC+815h+8rIQ0/FWO+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="T4EaFVj/";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A1606A332
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B8A1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=T4EaFVj/
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eb3fea2a9so42080286d6.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794844784; x=1795449584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=T4EaFVj/Db2Oh0QQIN6fEsneaLWasSmYdaomNevHcWQV9XfC0eku9uiWRA8yiTc/gq
         beN2zhlEBUDpPwvlJXNnJXYG7SLeGP2RUl/CIxz8vHb+CRPGvwOGP84P37zc/ASqwdCv
         a2ZImH/j9PEIljcRTrH9YjQx1m9XzvHX9w4v1GGAYhpr16oDLUf0JwGEJPe+tOCosZjE
         d53ULE5uBklWCIuWvycUfx9hIvJ8w6anXEcNacgC3MbLl4k/Apkhq6kLpk0rmKpAkcTv
         Trqjo9GQ8ASe6EH/m27mrq6sK/GeD3Uc4wVkpatMXBaBSojYeEkRpq+DgrGx3awVmJv/
         hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844784; x=1795449584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=vnObx+C5Jp97XjXyE8Gwpyx/55Cu4R03BwASSRuSYDc/Gt2l1BO2CdVhBPa9u9YIQX
         CtTwuG3szLAMr//NcU3jHHEACG6i3zreiQ+wxoithJZMzIrh/eszUlx71Cbt7QKkPov6
         VnSGoXlQ7zcVzsHMEwZIhUOwVh/OjLm1d/s4bLirM3pBS5lyvhDqqtcl+sPfkWmZnXNh
         okq0MLtXiCMZln+ztxJa900ysg8BRJnieDo8vHr3fAZApvnZ1sn31M1QWHBmhU1urzUC
         zXMDvdWHUtgaDYxwh5PoK3nideQpkIHrLA3oSWITylFt2iUZRAOiUDgVdHNyZ7iSdboP
         TE/A==
X-Forwarded-Encrypted: i=1; AL+hErFTBettAJDqtV6HFT1Dvi+7u4o6w6DWn86kpLvioYbVeatBHYU+iaqxY0uCIJu9rv0bnELBb3FHYPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YN1zULV/65TrYGtBZdIm35U/2KOJQbqGSCbNoz7O+IaPHwNcw
	QOZNAmiL+KD6Y1QwScK+0S9G0NTbt9Hyob/vUP2hmji3NzbMGN8SJDtPuYc+NQcXSwM=
X-Gm-Gg: AZFdTZekKRLx9XnwC0z0/hFQlR5ijMbL72L3xgLaOiZdArWdbYwuRNAird+z1hAplIs
	EZccHXih1/C0zKgc1yIN/EqxsDfjcX5DPkrFf2z7g50MvJ8JVGGwUYVi1/tK1EZXjgjoN0XHqX7
	0lOQrVg7+U7b+V9M8wB+lecN8v8bG02YF6Rje1ItAz/thx5LybtLB/uOaiBSspo/7OJTrpmfiYC
	R3vuZiw5j9MkNlINszvWOQPcOGiI7+DoD+v+I3zjwKdamLrWaA0r79+kTIVph8LIaZoei1hjLeH
	Fw8nBmlZvDlCAWFFjrZFGQhJZcA1AkkaNUIzUvRP59oGUMpSYPSW7vKTeE6uAGdYclJy3KI5H9a
	ZUo1K00I30r3ixlFfHaeCoqTOO/ss6d9H8jUXrZWu8WxJxyoef9cTOwb2cv6mvbqFgwiqQYgnq8
	nxaxahIqePSC39Wmt1jL0vYjclSQ2eY+ixRfUx9fCIGZLo7rI5YKzmcAB81jPp7DvCRC1KBnlAY
	Aehz46ZNAoyUNJCAsKERSd3+rwwvuKr8qCQ2cgO4xbYME3Svb9MoXgo08hVnPhwSmDz6IToZ1g7
	KIevtA==
X-Received: by 2002:a05:6214:2467:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91f24209db6mr171122396d6.55.1794844783992;
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm87735096d6.30.2026.11.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSz7O-00000009eOI-3Mx3;
	Mon, 16 Nov 2026 11:59:42 -0400
Date: Mon, 16 Nov 2026 11:59:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116155942.GA2299285@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <yq5aa4n8ydsk.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa4n8ydsk.fsf@kernel.org>

On Mon, Nov 16, 2026 at 09:22:11PM +0530, Aneesh Kumar K.V wrote:
> > Once you turn on TDISP you effectively activate DMA, just like turning
> > on the IOMMU.
> 
> We considered two options for doing this:
> 
> 1. Via the ->accept() callback in pci_tsm_ops.
> 2. Via pci_dma_configure(), based on a combination of device trust and device acceptance.
> 
> If I understand correctly, you are suggesting that we stick with the
> former?

It should still be done in #2, just with nothing to do with device
trust.

You can't run a TDISP run device at all if DMA_ENABLE is not done,
there is no half step here so it has nothing to do with device trust.

Jason
