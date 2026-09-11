Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA74AA572
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151525; cv=none; b=gXG2fr+N0axn9rudtBolHeklG5wyUyTH/xq04hqa1jxMBl1ApYqHaJVjEGimx80kryjnHpVOO1Xlv7Usg2gaeVBAQrXHBrMZuxzYyfvSiVlmsPTRPxuSrOloOXWI7lBv4EFzk+o2bm6Tj262bicnGcgJxeRhkKUp9ViSkD43Qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151525; c=relaxed/simple;
	bh=6cBl9YoGoA83gQlWtx1nBAyvkveypxIuXeuy2M875mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i37ypDZWIO3A7Ozr98+h5nYB50PLCY8zFfQ41hSZTo3WG+IV17qo8KAP2OJKiSkX3Off6f/QVAeW2qmgwnnWRdPLjd64VyycMI/V4tsPi1v2Yg+CdLcUuCzqJBLIUyAT7MmEuYHAWe33MZa+ZCOfyEWQ5qxiIkVtzjDo1Wi4HsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5GBk6fF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5GBk6fF"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so1140900a12.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789151523; x=1789756323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=647PeDACYFGwHy56KY6C8DNyZ6c/Uo5FYVw3HHMYVSA=;
        b=f5GBk6fFr3x/guSHAcYDCje1xOw8IeDCzr0jwB0gNRXooXc8AScK3IlipaXWBvY17A
         u30QvjIR8bmn8kxKXzOVsW+LA3S504JLCcllVu6g1/Xjx62Grn2rOFEMgAl3CVV/U5YZ
         krbfMFF2GPgse8Ow0F4d5/rtJek2P+piaVLfe022/b8y2RjntNhy8pL+1C0+FWmoLZmU
         83lbsx5duoScL3EheD8YdZy7o1inCnO0+7bdp8X6wRPAFdTdYOLBkK+ob5zSnPuwh266
         ftpeqqme7OF7orvSF36+Ee95q0jZp8s5wQVT5SnRZww9b/dYatFdrYR4iOAgOCiQMdG7
         ye5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151523; x=1789756323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=647PeDACYFGwHy56KY6C8DNyZ6c/Uo5FYVw3HHMYVSA=;
        b=UYeaJHpKzvcjmt757MzQyilLqXgD3AcrYP5R2fmp4Iw6bUKrj1sXS7Bgeln9COCVYX
         vV1LlwXDKTBjnnn6jpZqsDnVJISef+GpOly0PjW0ufxxn9vzbzp36KC1WgocKxLsf+nS
         tkY6wf4WH1Eijvr9TgHXi4SZmdi/JWpifA4w1vWCZjqkeGsLTqqj5UbOyytqzbusSqmF
         x4uYux5tBFBJEi+/qNl/ijb8S7HUDN6t+jiH6OlZqVYPN1v1Ygsp01EO1dHjzKz01vTW
         4wZ1o/4KVGJwtgCwbcZQH7t9IR9vxMkMmT9BvUfcWfzqftKdgDA5SBKseiX2WYaxNBuv
         /wzw==
X-Forwarded-Encrypted: i=1; AKwUvByZ/n0I8NRO++MpdzXE5cdskLpvFTNvdMElQQTnQljAiETF0f196lD+6nOJNqP4Ac3xoa8d8g06vh4=@vger.kernel.org
X-Gm-Message-State: AFuF++l92PPUj2BLQcajBSOY1SE4/639w1ZMhwqAkFtDv5CB6hW53UO5
	WKCLxf98r4w45NCC9B6Pda0ccfNnO7b2INT3VBZ/8qFuzSX9irbbyJqCeo5BtCCDdQ==
X-Gm-Gg: AYBFou2X+Wql/X+p9E430O1f1OZRBZS0C0XeFv561r6cY/PUgRyl7/F7G457KLtJZfo
	kTASOI2hlMUxcLU41aFDeCBZPOo3mwOUHs+nRtmK9UYwaqB3jaokyqqWaC4+SvgLCU34Zj6IIEs
	ZGpRIhP6Hr5BEns64GA9DNTfsCWVPA1Td4sbRXP63S4ssw24XvbQ2ibWhPdwpRbzxaNUu/pEV1K
	LHLS0R4HloSx4MLs/gqN1bUT40sR/QRRO71vALV4aQPxy4sHPzG65fnOQbCPDrr4kv+j/cEmtj6
	DQyUVnB/MfRFDswORnENh0ZIRvpjs8sH6xH74eYFPXHa5rgBeYTV3Bf1mdkFLwbeJ6ZgfKsqqBC
	mEwkVPklEIHV6IsOMSxKjECHnuVaWaO/8J9e8+iq6mwoltXkr0lYkFpue5XJ6Srh+J3HQp7Ms+k
	32ut0tCnaEj0binLbZj7ggq2LGNBjrfMq4d2J8xmqZP4J+xa1/zuqMgEKVotdnsoacKfS6bqDxu
	V+wWfc/r+XjOO8X876d3R1BiobVzFsTTUaZIURgfR5cnhqVrlk=
X-Received: by 2002:a05:6a20:4308:b0:3c4:3767:adb2 with SMTP id adf61e73a8af0-3daed46ab05mr10698355637.1.1789151522711;
        Fri, 11 Sep 2026 11:32:02 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c657156bsm1621771a12.21.2026.09.11.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 11:32:01 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:31:51 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 08/12] PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Message-ID: <aqRJF8OME7hn7CJr@google.com>
References: <20260728221007.2098560-9-dmatlack@google.com>
 <20260910235149.GA364189@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910235149.GA364189@bhelgaas>

On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:

> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 77b17b13ee61..22001bdf4c97 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/aer.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/suspend.h>
> > +
> > +#include "liveupdate.h"
> >  #include "pci.h"
> >  
> >  DEFINE_MUTEX(pci_slot_mutex);
> > @@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
> >  	bool enable_acs = false;
> >  	int pos;
> >  
> > +	if (!pci_liveupdate_enable_adopted_acs_controls(dev))
> > +		return;
> 
> Ugh.  The asymmetry between pci_save_state(), which does nothing
> ACS-related, and pci_restore_state(), which enables it, is sort of
> sketchy to begin with.
> 
> The command-line parsing in this path feels like kind of a wart (not
> that you're touching it).
> 
> It just seems like this path is already hard to analyze, and
> liveupdate is making it harder.
> 
> If we could save/restore the ACS state around the reset, wouldn't that
> solve this without any liveupdate specials here?

Yeah that would simplify the liveupdate support greatly. Let me work on
that for v9.
