Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386B38D
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783216395; cv=none; b=MiKrcvr58Am63vfDZLw5JM9obpzJrdYRZlTwfIfDiGZR1T/Ktgyb9FRfPWpWJzFXNMxFYQ0vlfjTmftNkdq1XEsu0Ft+JJBh/VLOPjzqVSW+hc+kWAXKAEcBHqY6VndqtfXaQPVDiz+pYl+hQI7Ya6xZbylHIRyodY+fGncjBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783216395; c=relaxed/simple;
	bh=2HWg0oST1IiXTqUM6qiNbG9g7AItoDJP2s+ptaWWz10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoxsgaTIr6V5ObLBQzNuAtez6f/7rPtpAQ3l8BgsWo8VA9molc/DDbGZl6kobtybr48pfFkfNbC8AxRjpGRaGm4D00tjdHLabHDHJALIhuQoJEQTHuAms/vxK75hKrRdr7JqUTHVwaQB89wTJh+HTgZV7XKqWOO/tzg430nX7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agEPGyaN; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agEPGyaN"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1459961b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Jul 2026 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783216394; x=1783821194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mmBarBS2P3KqburN5n4cfJE0l/iJod9d0iroSCl5SmE=;
        b=agEPGyaNFX6bJlwJvZUyxO81YiVwSbF9T1/D0KY/8Z3ytuRhtAIIytRNNhtXzQO0wf
         t50DxY+5HcZd8fbpDXH6gegfVsgTxO9tcfTikz4r4ES7IoVGBAH2ng348lX4/dEKhcJP
         awmj5Z5IKnqYEPBpeDazFhySHLilq0zZwRkZwDDAC/jdFfdW2XG91biCMo6BnG59qJlf
         6m2Juxkvtv6X12Y3cjpHMekGXi+bBg5i8q+3xUeYif31rcboQnxn0KxyVaoNj914HH2d
         vOaLku3HBxxkaCFYK+fFGuoeUvgrB2Qp1+qnh57iuN2cPLCiukpbOfCX7eLsTkMbPSFS
         Dr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783216394; x=1783821194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmBarBS2P3KqburN5n4cfJE0l/iJod9d0iroSCl5SmE=;
        b=DAH87xoqElVRuAuFNN83g/7Cp9LJGCr4yablfamnhf7uKHtIHlaV4Vh1Lg1HF7VE/3
         T5n2oC0k8m1cvf44mIofpkqDTG2DvFdjiLmfHFHq46J88ltPaC/AoHZQtkdSJgkj+ah1
         asS4itHMF7wgFC+3viwrMZR2IexpNqVeGyT86Oih7iYM5C9Hno0DuIvNcJeDixH/Ble9
         +KWym/vcaAdF88cRB0hNoiaAZ4EZTJSy1jBFdrXQderRRtWMdgDiBwEPjXbJjJTg9yT0
         arCUjYRUUtsjioyu4UJIhndt0QUj0d6BP1Om9S+78N8J8M+lwDCXnJJeIVIp6YdSy3MR
         OyRg==
X-Forwarded-Encrypted: i=1; AHgh+RoP4CBxAsMB1Mwjt3R1Hq46rC0NnqgVXy8NHhiT5/uFcQSZp8s5F7QU1nEIfy456Y+vxLHewmXQ+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqaXctzDaolWaIqyZSGndfbU8Pn3/+fVd4nHZ0wbAWNLCreqVh
	cJy9NiIsFEX3fMsE6iMIeDDgXkt595hYXLcYO/qogihIm/Yod3WbNQeH
X-Gm-Gg: AfdE7ck52H/W0HL8QyqD9SohCbU54vaBZsuV8dBk6/cODuAkvK/GWwCh9GRb/7/D/ko
	UvFS6+MwLD3IJvF3SKSgQlRCt8kYcdXtZ0gzjt/WXEr62Ig7WIUsdfbrJShZIb2WnkUowMkqfjP
	DcRE47pDNG3f69l9HsHMRjtAfJFVIR5SXvNGaD0Op769NVCQe1wSMBn9knoze4hy3tRdDO9PCr/
	1Ol0oGY/0Gk+wjc+yJCs94UPeWf2jWuvh8h+x1bQFo5Eud7LwTmJBNw6034nu8ffx8Pq4leP32m
	VMqySELypsSavfFWvUoF5IID9t8bhfF9qmF9ln6TwtUteLI6yG+A7QJVpFIXuseVQDpM/AINIe7
	otOsMw+up6Zs0RVr8AQEguHQwje8cGMEl+T423Q9wdDDK+tr/0jxqL+bJS0j9Xjcy
X-Received: by 2002:a05:6a00:94c6:b0:847:9223:9726 with SMTP id d2e1a72fcca58-847e186de64mr8695417b3a.18.1783216393864;
        Sat, 04 Jul 2026 18:53:13 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bb2753sm1790716b3a.23.2026.07.04.18.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 18:53:13 -0700 (PDT)
Date: Sun, 5 Jul 2026 09:52:40 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: sashiko-reviews@lists.linux.dev, Inochi Amaoto <inochiama@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <akm4VHY-BRikbF2v@inochi.infowork>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-7-inochiama@gmail.com>
 <20260703022058.1FD001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703022058.1FD001F000E9@smtp.kernel.org>

On Fri, Jul 03, 2026 at 02:20:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Unclocked MMIO access during probe triggers a synchronous bus abort.
> - [High] Incorrect `.deinit` callback for K3 prevents PERST# assertion on teardown.
> - [High] AXI cache coherency initialization is bypassed when MSIs are disabled.
> - [Medium] Misleading comment and potential missing initialization for Root Complex mode.
> --
> 
> commit 93fac4ee5b6c6ef1d779cae9b2ff5efed7a8fb39
> Author: Inochi Amaoto <inochiama@gmail.com>
> 
> PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support
> 
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> DesignWare PCIe IP with extra link and reset control. Unlike
> the PCIe controller on K1, this controller supports external MSI
> interrupt controller and can use multiple PHYs at the same time.
> 
> Add driver to support PCIe controller on Spacemit K3 PCIe.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > index 31aac056b68ed..680acc93f5395 100644
> > --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> > +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> [ ... ]
> > @@ -340,6 +354,109 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
> >  	return ret;
> >  }
> >  
> > +static int k3_pcie_init(struct dw_pcie_rp *pp)
> > +{
> [ ... ]
> > +	/*
> > +	 * Put the controller in root complex mode, and indicate that
> > +	 * Vaux (3.3v) is present.
> > +	 */
> > +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> > +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
> 
> [Severity: Medium]
> Will this omit initializing the controller into root complex mode?
> 

Yes

> Unlike k1_pcie_init(), this code block only drives the PERST# reset pins and
> seems to skip setting DEVICE_TYPE_RC.
> 

> > +
> > +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> [ ... ]
> > +static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	u32 val;
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +
> > +	val = dw_pcie_readl_dbi(pci, COHERENCY_CONTROL_3_OFF);
> > +	val = u32_replace_bits(val, K3_CACHE_MSTR_AWCACHE_BEHAVIOR,
> > +			       K3_CACHE_MSTR_AWCACHE_MODE);
> > +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, val);
> > +
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +
> > +	return 0;
> > +}
> 
> [Severity: High]
> Does this code miss initializing AXI cache coherency when MSIs are disabled?
> 

No

> Since k3_pcie_msi_host_init() is only called if pci_msi_enabled() is true,
> booting with pci=nomsi would skip this callback, silently skipping general
> cache coherency initialization for the controller.
> 

The PCIe controller is broken as it does not support INTx in this driver.

> > +
> > +static const struct dw_pcie_host_ops k3_pcie_host_ops = {
> > +	.init		= k3_pcie_init,
> > +	.deinit		= k1_pcie_deinit,
> 
> [Severity: High]
> Can reusing k1_pcie_deinit() prevent PERST# assertion on teardown?
> 
> During initialization, k3_pcie_init() bypasses the K1 mechanism by setting
> PCIE_IGNORE_PERSTN in PCIE_CONTROL_LOGIC. Since k1_pcie_deinit() attempts to
> toggle PCIE_RC_PERST, won't the K3 hardware ignore it?
> 

The K3 has handled this properly. You should treat the K3 and K1
 totally differently.

> > +	.msi_init	= k3_pcie_msi_host_init,
> > +};
> > +
> > +static const struct dw_pcie_ops k3_pcie_ops = {
> > +	.link_up	= k1_pcie_link_up,
> > +	.start_link	= k1_pcie_start_link,
> > +	.stop_link	= k1_pcie_stop_link,
> > +};
> > +
> > +static void k3_pcie_clear_irq_status(struct k1_pcie *k1,
> > +				     u32 *status0, u32 *status1, u32 *status2)
> > +{
> > +	*status0 = readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> > +	*status1 = readl_relaxed(k1->link + INTR_STATUS);
> > +	*status2 = readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
> 
> [Severity: High]
> Could this read unclocked MMIO memory and trigger a synchronous bus abort?
> 

No, it is possible to access.

> In k1_pcie_probe(), data->parse_port() is called before dw_pcie_host_init():
> 
> k1_pcie_probe() {
>     ...
>     ret = data->parse_port(k1);
>     ...
>     ret = dw_pcie_host_init(&k1->pci.pp);
> }
> 
> This means k3_pcie_parse_port() and k3_pcie_clear_irq_status() are executed
> before the required hardware clocks are enabled, accessing hardware registers
> while their backing clocks are gated.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260703020003.485436-1-inochiama@gmail.com?part=6
