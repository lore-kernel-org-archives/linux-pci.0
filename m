Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBF33374F
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652154; cv=none; b=kCHjR9juRavsQ9GHZTooLAHSChyFWmxq7HS9TP/EJonEWs7/lOrQ4HuHyh1ZaxUGk47TuuwVL5U+zHDy9MJ+Ghtl1huSC8wo/eEhQ2a7Fj6zmdN9JoOA8NQZ2ds6YexNoukNvbrWppA4eukt9ukXqj8NcRXbH9gVvaTBd/Nm9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652154; c=relaxed/simple;
	bh=GIfGUuIU3pl2cgxwAJGa0+OOUyyDOpmxsESRPNmCKAE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yq/aBx7VvVcGz4uN+6S1cLY/g3xGmvDPxOMNu/FYQonfkVREqYKXjfq0uY0/Lt72AGObLL6XWcZI62hun2mBhk7CW78PssxvH654JyC0A/KM0s4yp4iK9QL6qwj+cNLh/QaKh8Kuh1szdE6ILow2Ab8QDZIutduwGxo5mGH4hRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Asn22bNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Asn22bNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007951F000E9;
	Tue, 21 Jul 2026 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784652153;
	bh=1tuetcqW7dzuDB3i06URqN3k17bRRDhE4VNhGkDKEd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Asn22bNFuvM58d4tSVRyMdJx6NB1cFbe7RmLXALpg5qmqlicem+yRYb5ifhex9Qgv
	 xUfiZ+6Pq1/o3uD6MiDnhnihZCxnkSwYNHngCgqjyvZrEq4lbwYdT0AVgoYBYUqKv/
	 lWkCQqqY0mBHR69eQAKxgni/hboJH5Y0DCdNI6uSoAHcOA/go/5PZCxpp4a6XJyL0Y
	 KWJTU0JSYb0n7gxepwVkSw639QS6kurjLp3h74UUuw9xAGeNGcITkMXnK8IYqXpvk/
	 RtrPBBFpUGZsC50TxeYeFpZE8IRrU3/ab4kDtny1DQxTG9Ss//qebfHDbZXyVg8Lg8
	 4cOTbLkuKxmVw==
Date: Tue, 21 Jul 2026 11:42:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lin Mohan <linmhwork@outlook.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Ali Alaei <ali.alaei.tabatabaei@gmail.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Message-ID: <20260721164231.GA621153@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191EE983-DD30-4B14-9B63-93AA0BF750DB@outlook.com>

On Tue, Jul 21, 2026 at 12:47:07PM +0000, Lin Mohan wrote:
> Hi Bjorn,
> 
> I am Lin Mohan, the reporter of
> https://bugzilla.kernel.org/show_bug.cgi?id=221137.
> 
> Since commit 22b47bd49e45 ("PCI: vmd: Handle BUS_RESTRICT_CFG value 3
> for Arrow Lake-HX") has already been merged, could you please add the
> following tags in a follow-up fix?
> 
> Reported-by: Lin Mohan <linmhwork@outlook.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221137
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221136
> 
> This patch fixes the same Mode 3 / Dynamic Bus Offset issue I
> reported on the 8086:09ab VMD device (Arrow Lake-S).

Thanks very much for confirming this!

I added the tags to the commit on pci/controller/vmd.

I do still question whether that commit includes sufficient support
for this Mode 3 feature, so I'm hoping Nirmal or someone else from
Intel will chime in.
