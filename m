Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421527;
	b=JsaPoNhz3V+Luwqkt7xB4qTNqI1Hjc1C4D0JnumPZw6nVgR+EqNMO4rKl+oGGTJ+n7pE
	 1AKK/A7J3p6rmOPVZOcFNM8Bgkk9KqK7SM8bEosA+m3Y/1ZGNikDnO62667gx3sApUIUq
	 OIhJndF+n1AX9jDER4ateXxRjriudwtqw+tf0wW+kx4faQeEE3xVD3h7IVeiZrBFFiepJ
	 7HeBo9PM32d9K4nhhG7C8curaEa/CliMyB/O/mBOcAXrPNBwv8LojXxF+QOJBgKgl04n1
	 tpqyCg04AfM/6o0FaOC5uGJvALdbLOharc50oAklsczaOabSVptBRv+bQU4gC3ycIsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421527;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=XLAuBIKfob1J9x8C36vMT2lkZXWcEt7KCOMBh++G9ao=;
	b=YYZ9Zctb1IURgiktgCgwfZtZpoiFe85g+vim96KOiUI55QGDdXxo3bd51YBq8JjRY/43
	 jfa+5hp0+jREvYhtGRudJygDrb67ZgqYaLgoIEUCpSUWcVw1wp46JfyUkuOSGAO8XQsNS
	 87bGRhi746LI4zIyhwBVsWuPMG5WZLJDarELa7Av2DSg3sPNfh56RAKf2WAJCayeiaNeX
	 UIYTGhhSaOQoK2oQSTGIPeiEX/tsLyUiHeE3CTzOI2JYexOesa6R8svSrky5y5TElIrmF
	 63Vx8cHkg+qaWevmvNzNO7E8baX2UnzpOjwckzon3zLM3+GK7kRSwXvHWsQBAj0yCaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lj+HJn7x;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D68606A31E;
	Mon, 23 Nov 2026 08:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D68606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lj+HJn7x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795421527; x=1826957527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LGu03Ma0njqi8IqJpARzmb5dwjfkGt3tjqz+4ZsTuTY=;
  b=lj+HJn7xK42Z0wJxxAACrD677uxSnjrireFdx1lzl1GOKpvLSq3YwBRw
   qTVV8N8RMSQZMj906Xk1cNwK1kun/+CzlwEF2YN7xmfGK/7zrkml+blWG
   dpQ9YsbsChNOroL6irrYooKuMtVqYc+BuNciKGfqnJNtpI2Gka3GBL3Jr
   q4kBHEyFjYASOCq93U+Bp+A713Afka5r2otHqrMvQohACz9iEbsYe69cP
   3i8wo0lH1IOqJ6aBk8SXYgrxWzjwa3f8qKx2CyZh0oTStgHIP6xUPhBWR
   +fmpzcVd95svtHHexYHqdkX8VZgDJpEU2ogEWvoaeI5S2NrCTzBkH1X3E
   g==;
X-CSE-ConnectionGUID: J2HIPAxcTeyV8+gIf+IQ8Q==
X-CSE-MsgGUID: OljOch8RTQ2HYghyuTYmGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4269490"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4269490"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:12:06 -0800
X-CSE-ConnectionGUID: w+m0IF5cTVObRiwBOKziKQ==
X-CSE-MsgGUID: c2HtbD4/TJmYgKEZbA0l2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11652541"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:12:04 -0800
Date: Mon, 23 Nov 2026 10:12:01 +0200
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Habil Eren =?iso-8859-1?Q?T=FCrker?= <habilerenturker@hotmail.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/4] x86/quirks: Use pci_power_eq() in
 apple_airport_reset()
Message-ID: <awP1Uc-zyiawX3Dw@ashevche-desk.local>
References: <av8uhCdgJ9hX4eLT@ashevche-desk.local>
 <20261121113835.43201-1-habilerenturker@hotmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261121113835.43201-1-habilerenturker@hotmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 21, 2026 at 11:38:35AM +0000, Habil Eren Türker wrote:
> Hi Andy,
> 
> Thanks for the suggestion.
> 
> I have considered using `pci_power_t_update()` helper in the code.
> However, there aren't many places in the code where this function could
> be used (there is only one place that is suitable).

It's one place in _your_ code, but have you checked if there are other
potential users elsewhere in the kernel?

> Therefore, I believe it's better not to include it.

-- 
With Best Regards,
Andy Shevchenko


