Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477565;
	b=R90wfYr5xLxot6xlblQ2FV4Y74DQIdA5QMC+M21IHZDGGM3P2F9tFmhL8uzwyqzjNpG8
	 vUs9w6UN883wu+TbnbVq/TiE7PwodrAdVlK0KUTPWyPHDx4F8EShyB1uibfhq4BigSO0r
	 QKJkNvLbOPVgD76T33JdYUl0GP13eQk1Cu/JW7eTf18RvKXmilBf0QLqIuvNq9UP+cyFh
	 D8LpDo4meyp4tKnJAGOjTGT7e5NVTgbxA6dx/SUyExaK3D0mYsn9jGP94cSSQ6lqBsSq2
	 deM9liMW5Lrlpz+10epT5LO2j9m9CYokc158Ih87v9k4L5kMg0EnHURiPYbWUKAumIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477565;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gj/FQ6r8Dxu9yDYtzLhdIqLF4PlZPZjX4h9LsmiDR0Y=;
	b=YII1Mqw60hX3f48ZOKxUcwc3VlJrAYxSkzkhSmgeEwztEu9Yj6si68CCMJhsVMBE9AVM
	 hkh2gEocTArqhPB6EE8/udkdfj3OZFLhdRuI3AoKXdaMUYM32AmrUw9z3aKPT5cGnPStv
	 kAdV+4banrBZUnrDQCq4TH0LY67POsZ6fUXI32HV5TxJjk2Xb00GUSNYDqlxWOxzDwBr/
	 Nqz6FOy3JTsVJnj3TTIMOuA5SubhKqSR24bUKtYUt2BYB87lxZhL5Yf/TfLjwZW5r0vQq
	 BGYD9w4Wy1bIsLQ0AvNdE2GFnWMPcI3YZB4KJFIxTOsKpwokjOTCdlxtGrrBAbiQR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdvnHvAj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D225606A322;
	Mon, 23 Nov 2026 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdvnHvAj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B68A1F000C4;
	Mon, 23 Nov 2026 23:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477564;
	bh=gj/FQ6r8Dxu9yDYtzLhdIqLF4PlZPZjX4h9LsmiDR0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OdvnHvAjDlDVgBI2tr/wDpHXxOevLi9l4FWtCF5CNCM6LN7n4YtrWYLa1JvMfcmju
	 +uN/YYARI2h//b5OwGb8EEcVhMfvGnbg7VO/YAU1PIZRrgLk5gro/r6UBqg5RVYD67
	 TeyxrxtmlBt3/jScPfXNfJAr1QK5/BUu8W5Ionwo5Xa4EqiVDbO6C+sVmp5RkgsaRg
	 ylYGEH+z6gbAcsOvchirdPA6glq1wa+o/8wB+j8RjBIiDneI6ew3GWpUgshfyxTm/v
	 nxW99RgosKnAGkOJmgvBPVlfVgzMrk/I+LptzAgFoQ620+PeXPysnHgzH/J2W/4NR/
	 /YosIe7VhLRWw==
Date: Mon, 23 Nov 2026 17:46:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 4/4] PCI/AER: Hide the "aer" sysfs directory on devices
 without AER
Message-ID: <20261123234603.GA1123067@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awMs4CwlPT2vsDV2@wunner.de>

On Sun, Nov 22, 2026 at 06:56:48PM +0100, Lukas Wunner wrote:
> On Fri, Nov 20, 2026 at 07:31:25PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 10, 2026 at 03:56:14PM -0600, Yazen Ghannam wrote:
> > > aer_attr_group is a named group, so sysfs creates an "aer" directory for
> > > every PCI device. aer_attrs_are_visible() hides the attributes when the
> > > device has no aer_info.
> > > 
> > > But this doesn't apply to the entire "aer" group. So devices without AER
> > > end up having an empty "aer" directory.
> > 
> > This applies specifically to the ratelimit-related things in the "aer"
> > directory, right?
> 
> Yes.
> 
> > If so I might amend this commit log to mention
> > that, since Lukas's subsequent "PCI/AER: Enable baseline capability
> > error reporting" enables aer_dev_correctable, aer_dev_fatal, etc even
> > for non-AER PCIe devices.
> 
> With that subsequent patch, the "aer" subdirectory with the ratelimiting
> knobs appears below every PCIe device (unless allocation of aer_info fails
> due to high memory pressure), but not e.g. below Conventional PCI devices.

Are the ratelimit knobs useful for devices other than Root Ports and
RCiEPs with an AER Capability?  That's the only place we get
interrupts, isn't it?  I guess DPC also?

> > At least they're internal so they're easier to change than
> > "aer_dev_correctable" etc, which are even more unfortunate now.
> 
> Baseline capability error reporting depends on presence of an AER-capable
> Root Port, hence is still in a sense AER-related.

Oh, right, thanks!
