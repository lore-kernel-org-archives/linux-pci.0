Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B83AFAE4;
	Wed, 26 Aug 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773704; cv=none; b=S+5S0b8Lgj9FtT1OLomMO/fO3ZVipd2nGGzgSSwkbX2e8fbqr8yh7pu1w9XSeCRRYdI1WdbeUQ5AL/+RfmPSAHXDk2ts0oyys0eZ/T7rCUCYMdHmMC0LOx3P/OVa8fe9XNjN2MHa3K4yiAQGmQqm3OMxWV1wijrVSOpKHGIsk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773704; c=relaxed/simple;
	bh=74eB3GEsVqj3DQKZsA7h4bS9Ik66uUQNjOf+t0SJ0w8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=URd5o6ZxI9uYW1ke4UTwoj5/XR6e/stvjC9+CofUvrXYUbmz3vqIhcTGYhXROJUiPNjpBeGI/5q+S7FG4lFU85ZKntegQRK+qkbC5J3lkd50OzzBxfWFRKrTbO4jmKxmkJmS0SFXOlMJXz+hH/HAvyYIxPP6B6CxlnApvjACB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRTO1PEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRTO1PEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC721F000E9;
	Wed, 26 Aug 2026 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773696;
	bh=OewvCC8oO08yq61LfenP9V/BWhvohcjMvW6JsBT8qs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dRTO1PEclw8cMgyeiFgppusSKZw2uEdKHcgsOsslDMsMGxFArM0f7x0KBQvSRYjuW
	 2+O3jfxZLRsE5s02H7BGq7MUiTcDZpC0N+Ks7ObziYjp3rUgSN8zDid0Lx2U03PAEt
	 uww81pn29rC2/3JU0G+TW4OS0cxisV5ImtMmm7KSqICuetBFcDfgQChnc23PLfX2V/
	 sXefEwodDxGMulGNiubMqtwA9UmJHFfgFOE1UrMh9q1Jpse+9bQ4CuEbUTm6cA7B3D
	 sYF1IgmtRq4cFNFiX83KT7L0lh9LcVjOUh+AAhdlOMFkkSgSKxxXUC1ZWlpnG3pUxA
	 WKeEKOeHbQGFQ==
Date: Wed, 26 Aug 2026 14:48:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: lukas@wunner.de, mst@redhat.com, virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, kbusch@kernel.org, stefanha@redhat.com,
	parav@nvidia.com, axboe@kernel.dk, kees@kernel.org,
	ilpo.jarvinen@linux.intel.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH RFC 0/3] pci_hp: fix surprise removal hang during safe
 removal
Message-ID: <20260826194815.GA1552818@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823183458.982699-1-abhinjoses@gmail.com>

On Sun, Aug 23, 2026 at 06:34:52PM +0000, Abhin Parekadan Jose wrote:
> This series is based on top of MST's RFC v5
> (cover.1752094439.git.mst@redhat.com) and tries to address the architectural
> gap identified by Lukas Wunner in that thread.

This is going to get lost because it's buried in the middle of a
virtio thread that's been dormant for a while.  Can this be pulled out
along with any dependencies from Michael's series, so it's purely PCI
and posted separately?  Also please observe the drivers/pci commit log
and subject line conventions.
