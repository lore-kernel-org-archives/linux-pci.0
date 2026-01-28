Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D843366825
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613113; cv=none; b=T9eaqHiKsFFUmxd60NcfqsWuRTOVw6f2AhBvNzx73Jx7gf2g8Ary4wZF0MnkPtqKUrkySaFGq83efWBEX89rgS84MjMZ5fuJ16J9Px07Sb6g1LFgXr/eLK1fYhOiu8l6RBz9ii/HOPl+sI0u/1yVypK+kES2WaUc7NG2QQ5Af90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613113; c=relaxed/simple;
	bh=Q5yChAoBT7gdJYaJaosYnuqVt0qMv7TL96+/+MDdOaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvCm9PZGed9hV7Q7xvE3HPDiw3795iFUlTxWkgJidsYvGoGRDBTtWXJ9Yw28eQmK9A5OMbBfM+4cWwWgl6P8pozbQPVVExHtPUtPrkmt9Jv52N5ZhAdyzqH46dbmc1IJj6QkrAxy6Dm8HBvofrDxwD5A+iLjq+XXu5T33B52aRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7j3mwoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7j3mwoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933B5C4CEF1;
	Wed, 28 Jan 2026 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613112;
	bh=Q5yChAoBT7gdJYaJaosYnuqVt0qMv7TL96+/+MDdOaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7j3mwojj3mjzfy4ZrgIv+8Lw21NjcGYH5iz3rDyRvaQv6qC0e35SDPZzIGZZm6u4
	 0W/brQA4lB3ro4ECc2PEqcuJPnjsTgbWg8DpAj9Ssipo83SwfuyjWSAxssrb6eBSQV
	 CppsHJK3OijzB2QHzeoKN4iHu0oO7Uqff23M15xix56MRlTfAgSH/Al4a+C5WYVzvw
	 cz0FIwGS0yxD9HWYCZxkriM7HWPnRySASQP4hrsk2hmS89sPPTG5eY6DpeM1RPRozS
	 bz0mKwLlTMoYBZ5MKe6pIqdX1KMh2Pew3qszq98cMjrzwmk4fc5R+6Ei9uXpyVedtF
	 ZKAlZ8X3sCskg==
Date: Wed, 28 Jan 2026 08:11:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex@shazbot.org,
	Lukas Wunner <lukas@wunner.de>, helgaas@kernel.org
Subject: Re: [PATCH 1/2] pci: fix slot trylock error handling
Message-ID: <aXonNmD1dJ3D5_80@kbusch-mbp>
References: <20260116184150.3013258-1-kbusch@meta.com>
 <aXji6yYImTyT26Wm@kbusch-mbp>
 <0637bc5b-afe5-80f0-8d80-7e6d1e2eea15@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0637bc5b-afe5-80f0-8d80-7e6d1e2eea15@linux.intel.com>

On Wed, Jan 28, 2026 at 11:16:06AM +0200, Ilpo Järvinen wrote:
> On Tue, 27 Jan 2026, Keith Busch wrote:
> 
> > On Fri, Jan 16, 2026 at 10:41:49AM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The device lock isn't held if pci_bus_trylock() fails, so the code had
> > > been attempting to improperly unlock it.
> > > 
> > > Fixes: a4e772898f8bf2 ("PCI: Add missing bridge lock to pci_bus_lock()")
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > Ping?
> 
> There's the older patch from Jinhui for the same thing:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20251212145528.2555-1-guojinhui.liam@bytedance.com/

Okay, let's go with that one then. But patch 2 from this series is still
needed.
