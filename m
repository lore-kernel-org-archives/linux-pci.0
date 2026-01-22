Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC953242A5;
	Thu, 22 Jan 2026 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071991; cv=none; b=rUv/RJ9tVcKqqYCXthQnzewNiD6W/p8Qs4V7XPKHn7mzr9SdNgC3vm85V5vP6mcrdstiZL3UgHVhELSk1D/7qJkyCkijIpZQK2m1PLd6R/XKE1Acp9v0ysMMnEG9JxUMuP98XzXOyaSh5EjWj8QAt3XPxyRrlxbI4X3Hhu/vmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071991; c=relaxed/simple;
	bh=8GXZ78y8CHLxVWaGUwAMSCcpjd9/2XbwpJa6NRVR70k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq3dALbwoJCDoKckoSzY4Hp1+uwKAaW0CimvSEEjz0Zg4mmG4fTkVoM43qfOZ/puwAcelN5J5IfvPIgJgIaXhac3+JaFcbHveaz2kzk7MVBz5iQG6hFYXXdGJ7WdAVCjKkfyQmPAXY7HOR/V4BCklEXnMcnYHdCaMMz2cE4RgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hP9b5Cx1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hP9b5Cx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769071989; x=1800607989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8GXZ78y8CHLxVWaGUwAMSCcpjd9/2XbwpJa6NRVR70k=;
  b=hP9b5Cx1Ur53efTptkYhkwKUAMqKXqlnj8JO3jzNJOw4a3zebVnRiuVT
   olxDK3j37eNhexS0TYN7qM19Q6FREHydE8G/7b7rf+dETsRkq+PoRam/R
   bO4FpKRFIs1cLyWobOCQePOo0ld+nRcslUtxR6uJSrOU64CwInJTFvzFX
   jzNT0qRzrchERV/dLGHDQsjZ3C3ZSDYod5oz6sYbY/KV4WDIkKL07MfmV
   i425q8wwqohS3hrC2OUQVulIUN6tO3AEeNfN5UDGOJF8t6sA6/oHotIus
   QIE1bqbBZkpvdBV2uL1n8T78yXsk2izoOt+ugrZaEZU0KYB1C61Ov8A5H
   Q==;
X-CSE-ConnectionGUID: 60SKLjmwTP+ttGwZ4NKQuA==
X-CSE-MsgGUID: 9Zj7jEq5ToiuZMRqfCLZ6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87886668"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="87886668"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:53:06 -0800
X-CSE-ConnectionGUID: 2Ox0rrcrTtWxqhipEQyCNQ==
X-CSE-MsgGUID: jXg7yxJ6Sq6lbQEsmhpcVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211131120"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:52:58 -0800
Date: Thu, 22 Jan 2026 10:52:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 00/14] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Message-ID: <aXHlaMQ1mpi4Tu-f@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <aWSq_7_5kkQIv9Hc@smile.fi.intel.com>
 <aWSuYd8zqCxZ9DYE@smile.fi.intel.com>
 <20260114134004.11023a7e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114134004.11023a7e@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 01:40:04PM +0100, Herve Codina wrote:
> On Mon, 12 Jan 2026 10:18:41 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > +Cc: Herve (btw, any news on LAN966x support?)
> 
> Related to LAN966x support, I am still stucked on issues related to
> fw_devlink and DT overlays [1].

Thank you for the update and your reply here!

> [1] https://lore.kernel.org/all/20260112154731.6540453b@bootlin.com/

-- 
With Best Regards,
Andy Shevchenko


