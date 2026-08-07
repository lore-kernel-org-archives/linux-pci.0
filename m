Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D235DA43;
	Fri,  7 Aug 2026 01:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066296; cv=none; b=cltP5nrHZTbSROSnpMzFdWb5fLxWRsyUfgVS7NqBAtZi8jpCvnFxNGVFavO6fWgrlIbw4BtfkYuzZ2R7h98iHxcrldI77KLGulqwzqJg1Acdnhb+IGcsvFwKoDS+pGf7I51LxQGgC6F401odCMDnpv+IasLNH08JrNyXcVMx1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066296; c=relaxed/simple;
	bh=taqgwb4RpaHuorOFuY8dCdXDfQToTYDhk32UGL3iqAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpNpB7h52MfySpv8u6iwRPiZKMsTAj2N2x8Pu6R7jZMtwNzTshR7xHxOhWxKhUzwYtW7wQh47ZZdbz8eg+bkmVDn7FWo4ebG60lMmEn8xsxMg2SMqQhDdgLWRuGuSgJ/sJn06HilQV7OrHvZNMQfAs35VRGOdmDGfWsAgBBHHis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFjNTcxv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFjNTcxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786066292; x=1817602292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taqgwb4RpaHuorOFuY8dCdXDfQToTYDhk32UGL3iqAI=;
  b=DFjNTcxvVjomFmTEnJk01otpy0+GeVuQrj4iuXXNDVww7tpiXGIFT+pZ
   CgUq9ECfOGGpqX34b0bWzefQzwQ3O5vVmLoisYyNvMf5vT2xkrlpqxKHV
   MYW4eJZsfpmdPINATYpy2BNRsjSBiNl+81fmswPwCNMuWw6xfp0xjSTfj
   vZ9ZGlMIaZ0ujvxKBmb956ezfPi23oWgPG69Lvu7WZoNu96owSE0rAnWO
   K7DFQOqga0DKgOB78gaIaUyrLbq2V0NT6yw5LKDNoSKZdvhLy+8z/5tC4
   XyQ0qxayyWynEvTlMc4rofxd470G/nOcqT5FGX3fgGu+oEPUuzVn0YRUP
   Q==;
X-CSE-ConnectionGUID: 6Kr/CIJQQ1OMAbcsWgzUNA==
X-CSE-MsgGUID: NaVxHELORmSgDtKyUTB5cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97266865"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97266865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:31:22 -0700
X-CSE-ConnectionGUID: rtF2mFYSRteG0Dd919mAZg==
X-CSE-MsgGUID: w52SIaqWTLy2EEAJZkJeeQ==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:31:15 -0700
Date: Fri, 7 Aug 2026 04:31:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Darren Hart <dvhart@infradead.org>, Lukas Wunner <lukas@wunner.de>,
	Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 1/2] treewide: Add a flag to detect the Apple T2 chip
Message-ID: <anU1YX6EAHxrNiLP@ashevche-desk.local>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
 <20260727211807.1223-2-atharvatiwarilinuxdev@gmail.com>
 <20260728005847.GBamf-x27vgqj7WG7e@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728005847.GBamf-x27vgqj7WG7e@fat_crate.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 27, 2026 at 05:58:47PM -0700, Borislav Petkov wrote:
> On Mon, Jul 27, 2026 at 05:18:02PM -0400, Atharva Tiwari wrote:
> > Add a flag to detect Apple T2 chips on Intel Macs.
> > Cache the result to avoid repeated checks. That will
> > be used in upcoming patches.

Why don't you use match_string()?

...

> >  bool x86_apple_machine;
> >  EXPORT_SYMBOL(x86_apple_machine);
> >  
> > +bool has_apple_t2_chip;
> > +EXPORT_SYMBOL(has_apple_t2_chip);
> 
> I'm guessing this is parrotting the non-GPL export of x86_apple_machine from
> 
>   630b3aff8a51 ("treewide: Consolidate Apple DMI checks")
> 
> Lemme add those folks and ask why aren't those exports GPL only?

I don't remember the details, but brief grepping shows no impediments (from my
p.o.v.) to make them GPL. Maybe Lukas knows more?

-- 
With Best Regards,
Andy Shevchenko


