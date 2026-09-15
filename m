Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5A4A5C33;
	Tue, 15 Sep 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483869; cv=none; b=DpgqEIPpKzqZ7cDovdlO2wx4y0taRnZPORaMUbUbietddv+OPEp4egJnOonrpstv0Exr1f6HR15zdyNL9xfBMzpb0LWYZiW7jtjBNIndwofDZqzs6L4rkpRfguiRZy59BHNXj0r+sO4vVMovbxyWArGVOMhv4Fr4m3buGDdXtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483869; c=relaxed/simple;
	bh=P5iYy/QSYWpIBpgNKRP7nBK+8mbBN5jaovZEL295pX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcDTKq5C+SElw+y117NQAMCCxOkhlmBkBZ6vHXC+uabRJ94ttiXLNgZ8jpWV/27xtqMlboT3HB7Bpb8hRmcUxlKsQB5K9GSgtJua/gIZes7eO1WMkzXElMbCyPf+zmbxMg5+l03CKElgNwCvhvWYG9iFTSL09x3EpoVJTwwMLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKG4ADbx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKG4ADbx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789483867; x=1821019867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5iYy/QSYWpIBpgNKRP7nBK+8mbBN5jaovZEL295pX4=;
  b=NKG4ADbxya7fF+3RfHk4VPEfYgWX/pUpuTei1Hy7txdRNgw2/iPFsYav
   9EYSA0vCB/8OWxKWp8d1BrbaUCWyHOFS5EgVXAJo9SguigIpdXRfizein
   PintOYQILj4MkzkfFJtoAspoY1P0VJN1jhMfRVrYvsOUn/A9qk05haUTO
   xS3ns3rwJQWqdB2fvRPch9FWcYpU9jf7qIdAE9rjwkgXs6+1vTO5lMv1W
   o63z5cZsrfBDFYk1Nx2EfyZNt6EZ7oOymeev3WH3qg7v6i7NDbS9F/oki
   q+C5bb1TlYe9pdCHIf2KFc+9ZUghm6hO3pY6TenCMfITRCKOY4nOcif8A
   Q==;
X-CSE-ConnectionGUID: RZPmtIYbQJeJT5VDdVQQ7g==
X-CSE-MsgGUID: wmGuwELvRPS4bdQQxLnCOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88983364"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88983364"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 07:51:06 -0700
X-CSE-ConnectionGUID: Ol/cDn8bTau4gdkva6ZjQQ==
X-CSE-MsgGUID: Vlsrmi9NRxeS/5OiZL/mRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269352551"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 07:51:02 -0700
Date: Tue, 15 Sep 2026 17:51:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Rahul Samana <rahul.samana@oss.qualcomm.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] Bluetooth: btnxpuart: Add auxiliary driver for PCIe
 M.2 modules
Message-ID: <aqlbVNjTUHXlObgy@ashevche-desk.local>
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
 <20260915-pci-m2-bt-rework-v1-2-3c7d9cf9c010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-pci-m2-bt-rework-v1-2-3c7d9cf9c010@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 15, 2026 at 04:24:03PM +0200, Manivannan Sadhasivam via B4 Relay wrote:

> The 88W8987 combo module exposes Bluetooth over UART. Since this module is
> attached over PCIe, it is not described in firmware like devicetree. So it
> is discovered at runtime over PCIe by the power sequencing driver, which
> allocates the UART serdev and creates an auxiliary device carrying that
> transport and the power sequencing target to power up the Bluetooth
> function.
> 
> Add an auxiliary driver that binds to this device. It reuses the serdev
> provided by the producer, brings up the controller through the existing
> UART transport with nxp_register_dev() and drives power through the
> sequencer obtained with pwrseq_get().
> 
> Factor the HCI device setup and teardown shared with the serdev probe into
> helpers so both paths register the same controller.

...

> -static int nxp_serdev_probe(struct serdev_device *serdev)
> +static int nxp_register_dev(struct btnxpuart_dev *nxpdev)
>  {
> +	struct serdev_device *serdev = nxpdev->serdev;

Why not also

	struct device *dev = &serdev->dev;

and use it to make lines even shorter?

...

> -	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
> +	device_property_read_u32(&serdev->dev, "max-speed",
>  				 &nxpdev->secondary_baudrate);

	device_property_read_u32(dev, "max-speed", &nxpdev->secondary_baudrate);

Now exactly a single line (out of 80 characters).

...

> -	device_property_read_u8_array(&nxpdev->serdev->dev,
> +	device_property_read_u8_array(&serdev->dev,
>  				      "local-bd-address",
>  				      (u8 *)&ba, sizeof(ba));

	device_property_read_u8_array(dev, "local-bd-address",
				      (u8 *)&ba, sizeof(ba));

Now two lines instead of three. But ideally this casting should gone and
instead something like ether_addr_copy() to be used. (The latter is out
of scope here, of course.)

...

> +static int nxp_serdev_probe(struct serdev_device *serdev)
> +{
> +	struct btnxpuart_dev *nxpdev;
> +	int err;
> +
> +	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
> +	if (!nxpdev)
> +		return -ENOMEM;

> +	nxpdev->nxp_data = (struct btnxpuart_data *)device_get_match_data(&serdev->dev);

This is bad. The const qualifier is for a reason. Make sure it's kept.
On top the same suggestion as per above, use local 'dev' pointer.

Also Sashiko found a nice issue with the driver data, id est driver_override
mechanism that in some cases may lead to NULL dereferencing. Please, double
check if it's not the case, otherwise check for NULL and return -ENODATA.

> +	nxpdev->serdev = serdev;
> +
> +	nxpdev->pdn = devm_reset_control_get_optional_shared(&serdev->dev, NULL);
> +	if (IS_ERR(nxpdev->pdn))
> +		return PTR_ERR(nxpdev->pdn);
> +
> +	err = devm_regulator_get_enable(&serdev->dev, "vcc");
> +	if (err) {
> +		dev_err(&serdev->dev, "Failed to enable vcc regulator\n");
> +		return err;
> +	}
> +
> +	if (nxp_m2_connector_is_available(&serdev->ctrl->dev)) {
> +		struct pwrseq_desc *pwrseq;
> +
> +		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
> +		if (IS_ERR(pwrseq))
> +			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
> +					     "failed to get pwrseq\n");
> +
> +		nxpdev->pwrseq = pwrseq;
> +		err = pwrseq_enable(pwrseq);
> +		if (err)
> +			goto err_pwrseq_put;
> +	}
> +
> +	err = nxp_register_dev(nxpdev);
> +	if (err)
> +		goto err_pwrseq_put;
> +
> +	return 0;
> +
>  err_pwrseq_put:
>  	if (nxpdev->pwrseq)
>  		pwrseq_put(nxpdev->pwrseq);
>  	return err;
>  }

-- 
With Best Regards,
Andy Shevchenko


