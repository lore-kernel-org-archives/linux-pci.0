Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E519C54E;
	Mon, 20 Apr 2026 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718156; cv=none; b=a6qvUFvs4bEmZHbuL0K6RSWqwupG+MaQ3OVQeoAy6lfnyMAFADck81paodFQmEr6IQeL7dR+y2skzsBgJCTYYBooFpmWNIlc8Tj5imzQLszc4t4U2pFcxfef6uaBzXO8zb8B0qIX9sw9DFM0oUCw0on6uy7wMOYqvNv54vvyz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718156; c=relaxed/simple;
	bh=BJ8ETRCkjFk05mCQgMXRwxFn1FURg0WZX+lXBX3zkxo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f4v1PmK1UNjf/sv4QScFu/pF5WhOOgQIC+kHA8/nHZW3hdbeDVElkv7fCxH+nTyHXdMsPwtIQ2r8SVxHYndM+hLdW1RvnSfNSYAqBQeN8mLai7S2VJMqYhCQs9TU7c/NgTAmLUicNuZljGusAxvHyBDzJsb3VIjhY6qRtwGzQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I18zC+fR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I18zC+fR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6725BC19425;
	Mon, 20 Apr 2026 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776718156;
	bh=BJ8ETRCkjFk05mCQgMXRwxFn1FURg0WZX+lXBX3zkxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I18zC+fRDQLO7ho+L8/FKaP1A/3fjIfQJThI2m6aLx1InirpH6RQbLXCf27UnN6X1
	 Aboe0CptmgfoOwaaSfQmIl7kZvRIujOMFbNOzEhPZPKjSx3IspxAEv7FRQSRqhV/gd
	 8btdr69IeFYf2RL9+WpO1n1TvpSnrnyxfWMbJHyg9DX+cO3Eesr4iWzTYZCz2ybFl5
	 sY9F3R9LJKiFMl9XzT/qB2ONHLuumXdEFWH53LfL7vE9S4z7tfUddnFhuT4hjorxgq
	 9hzXBnxgxjbVYTxqdCLTa37VIYoO3bSbA58MJQft9yjSvnxhlZyY9ECXJ9Ucy+IDfS
	 3wEzMF1WLH+Qw==
Date: Mon, 20 Apr 2026 15:49:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: qcom: Indicate broken L1ss exit during resume
 from system suspend
Message-ID: <20260420204915.GA231862@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zv3tl2cvlhpmwe5ikcszdneft4bjebqibrl6onbg7457vtzmmc@clh7nzgpeext>

On Sat, Apr 18, 2026 at 11:09:11AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 17, 2026 at 05:26:15PM -0500, Bjorn Helgaas wrote:
> ...

> > Does L1.2 have to meet the advertised L1 Exit Latency?  I assume
> > maybe it does because I don't see an exception for L1.x or any
> > exit latencies advertised in the L1 PM Substates Capability.
> 
> As per my understanding, 'L1 Exit Latency' only covers ASPM L1
> state, not L1ss.  Because, 'L1 Exit Latency' field exists even
> before L1 PM Substates got introduced in r3.1. So it doesn't cover
> L1.2 exit latency.
> 
> > Regardless, I'd be kind of surprised if *any* system could meet an
> > L1.2 exit latency from a system suspend situation where PHY power
> > is removed.  On ACPI systems, the OS doesn't know how to remove
> > PHY power, so I don't think that situation can happen unless
> > firmware is involved in the suspend.
> 
> Yes, you are right. Even for systems turning off the PHY completely,
> they should have some mechanism to detect the CLKREQ# assert and
> turn ON the PHY within the expected time.

What would the expected time be?

> On our Qcom platforms, we do have some co-processors handling this
> even before the OS wakesup.  But support for that co-processor is
> currently not available in upstream and we don't know when it is
> going to be added. Until then, we only have one option to not put
> the link to L1ss during suspend and keep the devices into D3Cold to
> achieve the SoC low power state.
> 
> > Maybe that's part of why pm_suspend_via_firmware() exists.  What
> > if native host drivers just called pm_set_suspend_via_firmware()?
> > After all, if they support suspend, they're doing things that are
> > done by firmware on other systems.
> 
> No, that would be inappropriate. pm_set_suspend_via_firmware() is
> supposed to be called only when the firmware is invoked at the end
> of suspend. If OS handles everything and not the firmware, there is
> no need to invoke this API.

This is part of my issue with the "pm_suspend_via_firmware()" name --
it doesn't really matter whether the code is in the OS or in the
firmware.  What matters is what the code *does* or is *allowed* to do.
The native host bridge drivers do things that are done by firmware on
ACPI systems, so the "via_firmware" part is not as clear as it once
was.
