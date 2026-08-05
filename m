Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B98184524
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900448; cv=none; b=ofQY1Bwacd2Ca2Nd9bhUh8fLvIRP3LcDygL3CGfBJXz3hGbD3p2uLPUk5VDj59M5GY97ke4Yfyc3uktpO8h4c2OjQSYt7blcdw2Ug75WyNycoFDq4YdIf5J7+1KiLfrKyy1O+v12/DkSo+YwvJ39DuqEqK5r6pjUUcTUIBdsHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900448; c=relaxed/simple;
	bh=ro+iN22prWGUFX2ViFmEFgE8JxHDuMYUKRrnqLplzto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyb4FU9Ty1seKVdG9y+UoeVJUS25OEm4aMjL7wyoNond7VMOBbtT40HSj8j7cIz7vQA5n0QDHafwjHH3Gk6xcljQnwaDoxQ4jJW0VDNw29SJcGWM4K4PDZ/YkY4S263+Tz24gg1pZVdn+23uzY6m/LM0T4Y9YARZSBUdDSpX2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny+UuD31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny+UuD31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D031F000E9;
	Wed,  5 Aug 2026 03:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785900447;
	bh=lJuxAvkvVjnJNLXJ8yx7ZltWa64ZRYUBnq8sFCsN5+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ny+UuD31Vve44avE0kjG2AUDdcpfYby4ur20BSXot4zx6JMdm4zu0D6S0tq3TteqJ
	 lP7k5RowZ7n+arlvU3y+WHrqQ/E4r7d+GsrL4ZRnA7mMhzv2HqKUt1udRNzS0JbfLz
	 Jg/g71m39T6xVrRThqUN2JoPBnQbnJgvWDPieMUCEt6IKSB5Jm7SkZ3l3AJso6EDF4
	 qpFKd+mJP1sx/D1DVnCdmKaIfBYWg5fLRe8JGFf7HL9noYbQ8NxTKBa56y0WNQ+Tnx
	 5tzjrdtnq/tS8u4+PEFkxLqjypPs/lAv+UPVb7ma9DPAf6i6Mcuq59VCLn42sdQUfy
	 gfrFYk6zJTJ5w==
Date: Wed, 5 Aug 2026 12:27:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Szymon Durawa <szymon.durawa@linux.intel.com>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: Lin Mohan <linmhwork@outlook.com>, 
	Ali Alaei <ali.alaei.tabatabaei@gmail.com>, Jonathan Derrick <jonathan.derrick@linux.dev>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Message-ID: <20260805031714.GA464895@rocinante>
References: <191EE983-DD30-4B14-9B63-93AA0BF750DB@outlook.com>
 <20260721164231.GA621153@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721164231.GA621153@bhelgaas>

Hello,

Added Szymon and Mariusz here directly, and moved Nirmal from Cc to To,
so he can get this message directly, too.
  
> > I am Lin Mohan, the reporter of
> > https://bugzilla.kernel.org/show_bug.cgi?id=221137.
> > 
> > Since commit 22b47bd49e45 ("PCI: vmd: Handle BUS_RESTRICT_CFG value 3
> > for Arrow Lake-HX") has already been merged, could you please add the
> > following tags in a follow-up fix?
> > 
> > Reported-by: Lin Mohan <linmhwork@outlook.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221137
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221136
> > 
> > This patch fixes the same Mode 3 / Dynamic Bus Offset issue I
> > reported on the 8086:09ab VMD device (Arrow Lake-S).
> 
> Thanks very much for confirming this!
> 
> I added the tags to the commit on pci/controller/vmd.
> 
> I do still question whether that commit includes sufficient support
> for this Mode 3 feature, so I'm hoping Nirmal or someone else from
> Intel will chime in.

There was a series[1] posted not that long time ago, which seemed to have
been also incorporating work around the same thing that this patch aims to
fix, albeit with more details, at the first glance.  The progress on the
series seemed to have stalled, though, sadly.

I am including both authors directly here, alongside Nirmal, hopefully for
some comment and perhaps a review, etc.

1. https://lore.kernel.org/linux-pci/20260625082940.1290740-8-szymon.durawa@linux.intel.com/

Thank you!

	Krzysztof
