Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280625;
	b=oxYq2OYKfVJox8F1eNs7yGZKIGbd3c7bxFtgDq4sEkxrC4/XcUEiiM+Y+pBtdPUVBVvt
	 W90h9bYKMfGRFdo14YTO6C0hQ76ZZqLE2lUlga5V86PUo47Z5M+nZbriRGS6O8CbIr3u+
	 nnElu7rBtyL7VPM0CIO6mane9BBUKh8zif2heaUi5o2MOtnMm5ypA2VvXELMUrEVJZNHK
	 Z0uoKHvJwP7zx3OEaEdGJt1QCAsUXd/L9jVoKoLaSfxughMRezmd17nhr/yCUdbc5CG9U
	 4p9iU9ZgsB4jo3h5R8vkTQ+s20TJTedt6gjn2QHGTAlUHxv0izqwKnakIcA8gojY9Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280625;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Mb2nUQU4M00SSUzZJSeoQpnNXAraCq7x3LdAKS30Euw=;
	b=av59mA0JFVoyz4HJOq9OYY+bqom6HCJpdGpiVJZgY+AAAAPVDwFOBscIb2eE9diepS8a
	 838mm8Qv1AJ5Ew7hqXjfDP08UFl5ExS2cKSlAhmM755PQbQ8sFnI93jLjEkU1AMzcega6
	 I+P/CSQSOQqFPMkAYQI6/W7WEU+yng1qLG1kRzE4F5mquQXMfMaeL/nl9G6o74heCvQEa
	 rpQqU7kMzF8FNOkada1v+mxwpETZCFwUIYkuux5HVTxkEX/osFBJflMCLDKoUROsZnXWa
	 2Ob+h0uRQla21ncH85NoA+sTZKMIRLVybaHkb40iHT2q74gjkm7C+1c0AnHdWhQsHdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=moKhVdIW;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67996606A326;
	Thu, 29 Oct 2026 13:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67996606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=moKhVdIW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280624; x=1824816624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XiB/P3z67uNi54hQwr+HoGceAi4KeJ58DpxovBSc0bg=;
  b=moKhVdIWHTlYBTM27yPpptcYvWfZxeoV5vQDl8tROPJHxcy1XOyrsLiH
   UEC0pOG8yTIBOxOxX+8Sx3MfPvthNhhSVbg7hmXMLdY75L0ynvudB2qUB
   xwDw8dlq+JFqmrEH1vF2p5uZ15A+7QpDyhHdm3QkceUndx7CjaFFhUM69
   MGYS36fDRAR2PqPL1vCXsKjhaE/atqXAWFvoXUpwofjuL2spLHNDxelfM
   4s5Iqm0+JQ+1YT0Rz6kf+pLQU6USwnYQL+Zb3tysqKRg5FvDcKhZdVdhv
   IUM8pJpk+riQyMmNtQTeyuROg0DxK1r+WJdKbdMqvpLe47T3qLyVJqwQX
   A==;
X-CSE-ConnectionGUID: X1a7bbI8SnWe9Ef4aSkLOQ==
X-CSE-MsgGUID: CjMqrJc6RY20tCJkecc5HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1915313"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1915313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:30:23 -0700
X-CSE-ConnectionGUID: pazyI6DLSZO+QuLDn2CgVg==
X-CSE-MsgGUID: Eiw0OS5rRee86K4uWKSdfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5273644"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:30:12 -0700
Date: Thu, 29 Oct 2026 15:30:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	mfd@lists.linux.dev, platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] watchdog: add driver for apple smc
Message-ID: <auNKYRpfqrtKa50O@ashevche-desk.local>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
 <20261029085504.3547-4-atharvatiwarilinuxdev@gmail.com>
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
In-Reply-To: <20261029085504.3547-4-atharvatiwarilinuxdev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 04:52:00AM -0400, Atharva Tiwari wrote:
> Add a watchdog driver for the SMC on Intel Macs. It can
> reset the machine if the system stops responding. It works
> on both newer and older SMC versions.

...

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1810,6 +1810,17 @@ config SIEMENS_SIMATIC_IPC_WDT
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called simatic-ipc-wdt.
>  
> +config MACSMC_WDT
> +	tristate "Apple SMC Watchdog"
> +	depends on X86 && MACSMC_ACPI
> +	select WATCHDOG_CORE
> +	help
> +	  This driver adds support for Watchdogs in Intel macs Using
> +	  Apple SMC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called macsmc_wdt.
> +
>  # M68K Architecture
>  
>  config M54xx_WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 9ac406677..f142a5d8d 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -158,7 +158,7 @@ obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>  obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
>  obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
> -
> +obj-$(CONFIG_MACSMC_WDT) += macsmc_wdt.o
>  # M68K Architecture
>  obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o

In moth files the entries seems misplaced to me. Also, why did you touch
the blank line?

...

> +struct macsmc_wdt {
> +	struct apple_smc *smc;
> +	bool has_oswd; /* Newer version of watchdogs in macsmc */
> +	struct watchdog_device wdd;
> +};

Try with `pahole`.

...

> +	.probe = macsmc_wdt_probe,
> +	.driver = {
> +		.name = "macsmc-wdt"

Always add a comma to non-terminator entries in the initializers
(yes, there are some exceptions, but it's not the case here).

> +	},

-- 
With Best Regards,
Andy Shevchenko


