Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028F184
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363018; cv=none; b=sT3tRyF2M5z75nmOYIIciHRh6sZ0XQlhtwlH7oDcVcvEzBo8CVMvpt1gr+Akhn4AQ5B1sVKJhXktIsFPOWbHy10N8DiHXRTZxR99Q7L7TActQLvRYlXcCMWzmWTzRDqGfP76ZuVQp/3a+tTAcEFLni3xzhthMgjl+yok+qFztHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363018; c=relaxed/simple;
	bh=PV205EdY6zaLM0MPwS4BXnwTMygyAtxNa3iYvoDoias=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWovGxVJHGiKK/byAecbLoqyfvexbyQXFex9IAtf2/7OqSmB7b9IWhUV9/HfAda2s337pg8yF498rT9RCkZqmqQk/8leq7w25XMcEqhWXEIlm3JsXb387/w6ujnTzquyRmLtuiLDsh/CZmSmwllfkVVmg8+t+VfhZCE0ssNT7zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ/FRUOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ/FRUOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BA1F000E9;
	Sat, 13 Jun 2026 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781363017;
	bh=s/5RjcdMYKP0QufW4FCM6ahQkZ4XyDwPcYbL1QW7OqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZQ/FRUOB1BNuTk+90ixeyqaCcZQcWvxpAv7WXxKx+eZ2vA6a55uqk76lx3pkGKtvq
	 vrjIsNgCXmv8/fXi+5eT54G+yp095wdT46dfwcHv+UoJPz4InC9n2GZuITEcq5boGV
	 pdRAyR/CGakDqyFZIqdq4LSQ5+QEIMhBDFpA53QP9p2QurGQzefu2bMq3yczJUHoB4
	 VBdBS+dksAsG8SPiJlvA1wnsN0UdcplOHffYX3EXLJNNlJTw43dbX4oEPaLuh/J6Nv
	 qIUsWLB0UlFR/VI1MBvNTwBet6fe8SUTpl5K5ftiy216e2K+yeR8R6Tt7kI183Z/d2
	 aGuyDKsE1ZC2w==
Date: Sun, 14 Jun 2026 00:03:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Use kstrtobool() to parse the ROM attribute
 input
Message-ID: <20260613150147.GA3086320@rocinante>
References: <20260612182448.552406-1-kwilczynski@kernel.org>
 <20260612212254.GA659826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612212254.GA659826@bhelgaas>

Hello,

> > Thus, parse the input with kstrtobool(), which handles common boolean
> > inputs such as "0", "1", "n", "y" or "off", "on", with or without a
> > trailing newline, so both of the above disable access, and update the
> > now stale comment.
> > 
> > As a side effect, input that does not parse as a boolean is rejected
> > with -EINVAL rather than enabling access.  The documented "0" and "1"
> > continue to work as before, and rejecting malformed input brings the
> > attribute in line with how sysfs attributes typically handle it.
[...]
> 
> Applied to pci/sysfs for v7.2, thanks!

Thank you!

I will follow-up with a series that updates other sysfs objects we have
accordingly with this preferred API over some of the hand-rolled ones we
currently have.

All the best,

	Krzysztof
