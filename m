Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80173B52FA
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398547; cv=none; b=gH20GytNkQ/yz0meez1wXd2fpFgQlM5kF/Ufp+wv8U+np9ZeBODOJpyZgBuQtMPnttTePx05ffjNltfya6AEaDzYeoWhNQe4oGdOgMvCKR099c04k3IvEFe1P5prfgIFtmy4K6Vmr7nb3zQ7fA7woYjiDaS6fFatjiK2WkEQq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398547; c=relaxed/simple;
	bh=RH179ROmT40NIjt7hhQGVUyCMnBudHUIR7OXCEbrLNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLt7EigNhBLLg9LI4xwzjKIoSKh7zBcUBBaL9cTFt6jb/yj2KhgbbpEjlRsE4ftdNWKnvbyvGjhp9gUCXbaMHmAaYv14UL6fywiWnxtbEjkaF9jv2ogSjvij1heU7I7s+TAQN5dWUlwXiRM4HImOwy3ZEqsTWMQh4CnUUVIuU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKnqNNd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKnqNNd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F71EC19423;
	Fri,  6 Feb 2026 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770398547;
	bh=RH179ROmT40NIjt7hhQGVUyCMnBudHUIR7OXCEbrLNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKnqNNd7llusJ81VMn4U/VfrMNoHSk3u+obntxUtHNlbdLfucHLsiVHx+9XeMs644
	 Cexvzgcdbila5C3oLeO536CTA5KZxXxG5vNBuM33fUzkf9KKe+OqpxpPV//SjdJAku
	 viVqimADE/GwPgZ7LmoPNhpQejMFiuleJzOOgx/YPRM72P07ZIrVdN+lFdiVknt3p+
	 vi6xl383A30NBqk1G5zb7WY2R92xzrhkg9ufjToJHVAM0AF/7fwiVADQV/dmfzBAVa
	 2wop4mIl1UevO/GhiBIBSZm924MR43pnVcmrgDVjwvKpsMxqF722gMXoSbh7aJsC2i
	 JIiDrm8EVe3aA==
Date: Fri, 6 Feb 2026 10:22:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org, alex@shazbot.org,
	lukas@wunner.de, dan.j.williams@intel.com,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv3 1/4] pci: rename __pci_bus_reset and __pci_slot_reset
Message-ID: <aYYjUdrRqz_6orgJ@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205212533.1512153-2-kbusch@meta.com>

On Thu, Feb 05, 2026 at 01:25:30PM -0800, Keith Busch wrote:
> -int __pci_reset_bus(struct pci_bus *bus)
> +static int pci_try_reset_bus(struct pci_bus *bus)

Just fyi, I'm aware this patch should have updated the usage for this
symbold in pci-sysfs.c and pci.h as well to avoid the linking error. I
missed the error because patch 4 gets everything fixed up again.
