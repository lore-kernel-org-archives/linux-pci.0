Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23E41D635;
	Tue,  8 Sep 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856172; cv=none; b=uZk5W63EBdC1YnLBq88Zmte4Bo5WsS4rUGOpU1hrEIClRNTD2ERZKmutmlRIRM52QlmZyzP3XkJ4Yg0w+PFI25goT7hTmZHLfiLfERXkYpuX/LH/1wXfOonZ3cLXHa2CnufFle5kUtchgSFGR2pipe3LVCA0+4H9Bml0PBfGwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856172; c=relaxed/simple;
	bh=Ry4s1GPSc8cKBB0DQdEedSRojAHrulU6/auwMzle9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV00ljJAcscuIxjxPe4Rtp+FmfbsZjyX1uHRsWeNKqhi6mDnCX6ifu7MbQlAFKVQtkNMYFIeZW4hTzN1YJTmr5mOWGxC8kf8amYbAwC0zYXUWba4BeSq28vBLP1qOFOCJJ9BmIueQLdPkjhRF+tBU4tqvCKQF9ODgGieIPsakgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e01FnUV6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e01FnUV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788856171; x=1820392171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ry4s1GPSc8cKBB0DQdEedSRojAHrulU6/auwMzle9BM=;
  b=e01FnUV6KKUNZwZOgQ+jco2gIjlqM9zPeNyXReN7RjOmY71zePk3QyzJ
   rnNgk/rFfmR6e87NX+MQRU0tqPv5qEbCsBSsxgNolglb9LDj1f5/ncow6
   ElufJGtIWdl/5WytUAKA7v1rzkIuipEz3j87pxm5UdCIX+OKym3ODHGc2
   90pLUY8D4KSYm5UP+EKeKb7yA03OOfnYKlCHzwfoxLrn1YoSaWOdmqOOR
   7gQD66rN1S7cJ6ku5y1pFtn0tjAKPW7fPG9GqpKEiDFfLDrEGNiMbRg3x
   ki4sCvTlidBOM4v2ww+qq+70S/jlxAwd8csbn2gm0eLJM2T314ngIz3Fc
   A==;
X-CSE-ConnectionGUID: 2v5Y6J2TQNmtzkKXunj9ZA==
X-CSE-MsgGUID: 1o0/6yYpRbiocM4+LJ2gjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99911075"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99911075"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:29:30 -0700
X-CSE-ConnectionGUID: kQ71qvI/TbKfGtKtXDYu/w==
X-CSE-MsgGUID: k41aV1whTfCrYOJz2zq02Q==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 01:29:25 -0700
Date: Tue, 8 Sep 2026 11:29:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Update after split of
 <linux/mod_devicetable.h>
Message-ID: <ap_HYy2IVZt-0mxN@ashevche-desk.local>
References: <20260908070031.32833-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908070031.32833-1-kmehltretter@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 08, 2026 at 09:00:31AM +0200, Karl Mehltretter wrote:
> From: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> Most structs that were defined in <linux/mod_devicetable.h> before were
> moved to a bus specific header. Follow the movement to get the struct's
> documentation back.
> 
> For the list of device ids in basics.rst use an explicit list of all the
> headers that have kernel-doc annotations and that are not described
> elsewhere (i.e. pci and mei_cl). <linux/device-id/acpi.h> is left out on
> purpose, ACPI_DEVICE_CLASS() is not a device id struct.

Huh?! The device-id/acpi.h provides the ACPI device ID definition.

> Also repair the referencing in the zh_CN translation of pci.rst and
> don't duplicate `struct mei_cl_device_id`.

> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers")
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

...

> Changes since v2
>   https://lore.kernel.org/r/ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org/
> - use the :file: role for the header path in pcmcia/driver.rst (Randy)
> - say in the commit message that <linux/device-id/acpi.h> is left out on
>   purpose (question raised by the Sashiko review)

I am unsatisfied with how the ACPI division was handled in the above mentioned
split. Id est the include/device-id/acpi.h is *the* header that has to be used
for the IDs, not the respective "include all" linux/acpi.h.
Hence the documentation has to allow the use of the device-id/*.h directly in
the drivers (most of the cases for ACPI).

Alternatively the OF ID *and* ACPI ID must be included to the upper lever bus
headers. So, spi.h, i2c.h, platform_device.h and so on has to *always* provide
both.

> - carried Randy's Reviewed-by and Tested-by from v2, the diff changed in
>   one line of markup only
> - Uwe asked me to take over the patch:
>   https://lore.kernel.org/r/apv6yQ1U-HhNglyV@monoceros/
>   It supersedes my PCI-only patch
>   https://lore.kernel.org/r/20260905084916.40196-1-kmehltretter@gmail.com/
> 
> Randy's suggestion to add kernel-doc comments to <linux/mei_cl_bus.h> for
> struct mei_cl_driver and include those instead of the duplicated struct is
> left for a separate patch, it touches a header outside Documentation/.

Uwe, can you fix that?

-- 
With Best Regards,
Andy Shevchenko


