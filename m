Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253482E040D;
	Tue, 27 Jan 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507278; cv=none; b=Y+dfH2TuYoLDFTdFhQPChIKBObytLg2PlM0aSiK0yAe0AS5MAI183ZSNrAriMH6jXxclcUhrGTix2TbsQcW4qpQcKjH9X57DYxlHTwUg1xbn+HwrqyP6KgC5ypCgOwT2biFH0vEAUmnWbytNKCwSFpYO0z/d7RXuHr0s/G8NgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507278; c=relaxed/simple;
	bh=TQl+XUnTjtRtOXjHCbKd3JXbhimpuS3lMlbUrcmWca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQCCILqOQ5i9Mby/bAyQKrdSXYQqRdZysTtEf37k1TsGK9Wog/uSLJ1Gkr9oPGTLWLLSkh5mqvaq09yxVJCjlW8TMUaVCi1waxfzRO3zPJaj2L//LlAUeJOoCPBk19a9I4Kybvq/+f6lvF//L7uuHgBm0orTlRQcaF/kUhjAnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubfpjJ7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubfpjJ7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB7AC116C6;
	Tue, 27 Jan 2026 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769507277;
	bh=TQl+XUnTjtRtOXjHCbKd3JXbhimpuS3lMlbUrcmWca0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubfpjJ7huxAWOL/vZ6373Nhr9wG0Ti6fd1/zGOuCcOdYlZ0LBlnJRjr3KWcfoShmm
	 TBMjslzWysN1Zoo8pwa+xlbVDJdy8SDR10hkRFDwAJV2pg1hKoe5+cV5uYk+p7kKad
	 lASJLOAbxf3rlxaRokoF+6ZMU4tHGMHGsqJvp9dFhmnY1lND+QkZk/omtE3i/k1b6i
	 kgN8JEA9YE+4zHm4OeCXyadhbDC0wil8uUuNfsdAoAHSgqjYwqKQ+7uK5UTKO+wp50
	 efZSIc5SF+t0dF1nskPoAWa4V78qN9/8FitAN1NTiPVZuo9MqOMa+2EhDLMFfRnRgq
	 aJ1mWUXRJYqJA==
Date: Tue, 27 Jan 2026 10:47:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Frank.Li@nxp.com,
	dlemoal@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <aXiJyDUSj68MLQaa@fedora>
References: <20260123180747.827357-2-cassel@kernel.org>
 <23lxq2hvynxqmothnkhjtarpklin3prv7tvjlvy3xjnzpn5kdj@ks2qay2tgzc2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23lxq2hvynxqmothnkhjtarpklin3prv7tvjlvy3xjnzpn5kdj@ks2qay2tgzc2>

On Tue, Jan 27, 2026 at 12:44:13PM +0900, Koichiro Den wrote:
> On Fri, Jan 23, 2026 at 07:07:48PM +0100, Niklas Cassel wrote:
> > Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
> > restricted to run pci-epf-test with the hardcoded BAR size values defined
> > in pci-epf-test.c.
> > 
> > This code is shamelessly more or less copy pasted from pci-epf-vntb.c
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> This is useful, thanks!
> I've used this patch as a dependency for my series [1], and it works fine.
> 
> Tested-by: Koichiro Den <den@valinux.co.jp>
> 
> [1] https://lore.kernel.org/linux-pci/20260124145012.2794108-1-den@valinux.co.jp/


Thank you for testing!

Just to clarify:
Your series is currently not depending on this patch, and neither do I think
that it should.

There will be a trivial conflict when PCI maintainers will try to merge them.

But the solution is to use your new values:

-static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
+static size_t bar_size[] = { 131072, 131072, 131072, 131072, 131072, 1048576 };


With my new variable name (default_bar_size):

-static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
+/* default BAR sizes, can be overridden by the user using configfs */
+static size_t default_bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };


So AFAICT, it should a one line conflict resolution.

Since it is so trivial, it would be nice if the PCI maintainers could
handle that when applying, but I guess in worst case, one of us will
need to respin.


Kind regards,
Niklas
