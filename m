Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4849A3B2FCA;
	Thu,  3 Sep 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425002; cv=none; b=Cr7DfQfjG9YFhlTPu1NHQgF/UICPQ1HdrV1j4vWHxC7ZxJ43iddImLT0of+fvsSY1ZcoAwxBMGOFBkTMRDEhOKaG8r1uKXXtjvsfQUgR9cebAQnYMRhtd9/GFpqHmwsKUvq/IQkNhMczG61pPKDbWhbUsgHfmiGQdzJkgnVN+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425002; c=relaxed/simple;
	bh=VGWcRq02jO61NDjb0fyieujd+ftQf6pVg1icbTXBPgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8BGIg3gyfwir4gqbt73YpSb5ve4h+E9Ln0RbbSF42kDfucJfB889N1IpleJBbdPO4gb15SlgJLXy2WL1sgm2zIcjBSBWlK1irhX3yq3jP9LehJ6Lpze0hEjXsPDM0TVW1op/EMjn+WXKqM1hxHgx3P/0DjuxZXxqRafPe1E2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id D0572CA8;
	Thu, 03 Sep 2026 10:35:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7F098600082C; Thu,  3 Sep 2026 10:35:11 +0200 (CEST)
Date: Thu, 3 Sep 2026 10:35:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Robert Richter <rrichter@amd.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Message-ID: <apkxP_fydVjpULaT@wunner.de>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com>
 <anijY3eTVWSqHLxh@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anijY3eTVWSqHLxh@wunner.de>

Hi Terry,

You've submitted v20 of this series, but the following
questions haven't been addressed yet AFAICS.  I'd be
grateful if you could take a look:

On Sun, Aug 09, 2026 at 05:57:23PM +0200, Lukas Wunner wrote:
> Am I missing something?  Is a scenario ever conceivable where the RCEC
> receives a message with different severity than what is inferred from
> the registers by cxl_rch_get_aer_severity()?
[...]
> These so-called Advisory Non-Fatal Errors set one bit in the Correctable
> Error Status Register (Advisory Non-Fatal Error Status, bit 13) and
> additionally one or more bits in the Uncorrectable Error Status Register
> (see the commit for details).
> 
> cxl_rch_get_aer_severity() is not able to cope with such errors and
> will incorrectly infer that the severity is AER_NONFATAL.
> 
> Now I *think* this is not a problem because Advisory Non-Fatal Errors
> are masked by default and the commit only unmasks them on regular PCI
> devices, not in the RCRB of a CXL device.  Only once bit 13 in the
> Correctable Error Mask Register is cleared in the RCRB will
> cxl_rch_get_aer_severity() fail.  Right?

Thanks,

Lukas
