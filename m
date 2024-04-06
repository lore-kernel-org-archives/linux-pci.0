Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84C6FC11
	for <linux-pci@vger.kernel.org>; Sat,  6 Apr 2024 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370259; cv=none; b=SzBpslzlUVvuhdjCTqQ0O7kDNRCnPRJA7bEAkWAT97A3JP1d3TM3++EiworiyaHU0UhMEhDaJQ1XYwaDFSo3Zats0IDLV3QzS70C1qxkU49HnKuyN5obg/cat2p2mJ5wiweuAC3PtpEVTYyLJmAwmHnTJlhu3feTwW6G2nMFEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370259; c=relaxed/simple;
	bh=O/oYGCpys+p4k2m392pM9Jf+j6kQABZopOyXap50o/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE85vjcNc0/PTc7HJEsUcbxoRaC6Yf3XXb+9Z0zlD252ZmLUQe/PjQ09Gz9vRON4c3PlljpENh6LMg3gJqdpSDtk2izBVUJ4a64b1HEHK4oLsWGWgbaAdxKpHTD8xZ1oNU3kZ4er/cOVxmmJgYaegiEgHVUd+87Y7vC1+K1n1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l03H6WeQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l03H6WeQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0878b76f3so23474905ad.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Apr 2024 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712370257; x=1712975057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pq/VQw1K21UdvFVFnFBaugAbX3P/hy61YkUH63t4pa4=;
        b=l03H6WeQyfQEQuW4I66v9OmpqOqy7jsOAJdP1R1NSiCDCamSSFONhGicOm0G8yf4gH
         lb39Z3Dd0gTGo12G+8wx7d8wiK7RLP9p/8oaqYBXArJeYoSBluYRFZa2m4u5jf96oxJZ
         Ew6nZm9+HcQlHy0/ygcAHfYwVc6HshS/jVgW4Z5cEOaKDtVFekbxTlmZiZUkVf3PmEsA
         t5aM8SWMlLahu3sxtHRffZvU7lepoxJTKR1bMQpG1IHVPjxJ0jxSfXD5KCXEVcD5Bc7+
         Tj0tO++c3US+YKb3e/LaIMQGagWTCZqsCSgNUVyGOJjwVcesFy7Ow9hYCSDU1CaJoBQB
         S4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712370257; x=1712975057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq/VQw1K21UdvFVFnFBaugAbX3P/hy61YkUH63t4pa4=;
        b=sCUiGCYXevwiHCS8TEdlt8GcSDe9hGhnGjSXStOIgvFF3tw4VXl04MndteVvBXLvNz
         WWcG+BdzIcvb/NHRIELkrZque9708PAKm6K6npDIAsBazynPfWr6Kyt1x+UjRXF6qGum
         LDSyDTAWUIh1soKLAtakwSVkf6jzdyDfKtyObcaEdXSwSd1qqZhfWrAN35bM02LLS1ff
         NgkQFqoh8T/pPxP5KAOOz/87QPObRzxrEEyixBfLOmKhmcatTahLcjfL7i3K6NQhQmVP
         pnuAhE6YgZCVHSYn+LWIot1Tlvum6AcwP3uiJi2Ao4uGKQ/enSHaeYP4uQfSkB8awM3F
         oqIA==
X-Forwarded-Encrypted: i=1; AJvYcCX32Xa6fZ3Ls1WEsaNraxaO5jnH67KT8xsU3b+QwLYYwXFP70sFFSGzAcBte8R4l5iGmmo5nFrvuO2aEv0w7xRoG9JwCFwQTX6T
X-Gm-Message-State: AOJu0YwPDLAMUIZgnUhbdTGc+6YSyIRiGmNGBobWiMHN6nmc5g6uy9ii
	LLM5Y8QN75w2VuVw3tPSsf+wi7pPQctx95+LnnkOpfhmzdG8bVBsL20T3laenA==
X-Google-Smtp-Source: AGHT+IEgNaVAOfzYGlvkSkg/SYdGzGiP1BhiL86m2ABCHbC1gS9d+egXHvLJDX9RU0ddiMGGrDkArw==
X-Received: by 2002:a17:903:11c3:b0:1e0:b60f:5de3 with SMTP id q3-20020a17090311c300b001e0b60f5de3mr4113658plh.7.1712370256805;
        Fri, 05 Apr 2024 19:24:16 -0700 (PDT)
Received: from thinkpad ([103.28.246.231])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001dc01efaec2sm2357603pln.168.2024.04.05.19.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 19:24:16 -0700 (PDT)
Date: Sat, 6 Apr 2024 07:54:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 06/18] PCI: endpoint: test: Implement link_down event
 operation
Message-ID: <20240406022409.GA2678@thinkpad>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-7-dlemoal@kernel.org>
 <20240403074823.GE25309@thinkpad>
 <Zg//LiMg0Wh7LfT8@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg//LiMg0Wh7LfT8@x1-carbon>

On Fri, Apr 05, 2024 at 03:39:58PM +0200, Niklas Cassel wrote:
> On Wed, Apr 03, 2024 at 01:18:23PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Mar 30, 2024 at 01:19:16PM +0900, Damien Le Moal wrote:
> > > Implement the link_down event operation to stop the command execution
> > > delayed work when the endpoint controller notifies a link down event.
> > > 
> > > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > This patch is already part of another series I posted [1] and under review. So
> > this can be dropped.
> > 
> > - Mani
> > 
> > [1] https://lore.kernel.org/linux-pci/20240401-pci-epf-rework-v2-9-970dbe90b99d@linaro.org/
> 
> Mani, your patch does not use _sync(),
> so I don't think that we can simply drop this patch.
> 

Agree, I was planning to update it in my next version anyway.

- Mani

> 
> Kind regards,
> Niklas
> 
> > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index ab40c3182677..e6d4e1747c9f 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -824,9 +824,19 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
> > >  	return 0;
> > >  }
> > >  
> > > +static int pci_epf_test_link_down(struct pci_epf *epf)
> > > +{
> > > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > > +
> > > +	cancel_delayed_work_sync(&epf_test->cmd_handler);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > >  	.core_init = pci_epf_test_core_init,
> > >  	.link_up = pci_epf_test_link_up,
> > > +	.link_down = pci_epf_test_link_down,
> > >  };
> > >  
> > >  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> > > -- 
> > > 2.44.0
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
