Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C091EB5F8;
	Sun, 22 Feb 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771765626; cv=none; b=sLkawoWB/WInsfeC4ahGUxpuv9imHiUcgolz6cQ43e4r6gjf4IKOAGw3tjgm8qFpDg1xL0J+Lxbz6BsRnydSbNRaGGR4VQ+t6q7ATarWb0TuTgEGmEZgRqpeeps4bXbSuvlgpaa8PZXbs/kSQ953mqLeFyaVOTNJlXE7YSirSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771765626; c=relaxed/simple;
	bh=IB0vTf1ok/9bz8OTUdwo2iavt6xyOws666hF9uOTCKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2+llR51VK6XLcMOWUjSM+j6JHnhc6NDZEX/VZ5EECazIQHQJcSqacdBrIHk9a/R2fGWlIjA0/izlHw2jCarpvcKHp7x4rPCBa3d3G7FlWA7tVxtek5vKwGzKHakV7QgsLKSS8LmJZquljjrcBNdBgZpJShTatT7trlmqb6dqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 666F1203064F;
	Sun, 22 Feb 2026 14:06:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 557734C89A; Sun, 22 Feb 2026 14:06:56 +0100 (CET)
Date: Sun, 22 Feb 2026 14:06:56 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, cassel@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 3/4] PCI/DOE: Add DOE mailbox support for endpoint
 functions
Message-ID: <aZr_cD9LIQgvywri@wunner.de>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-4-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213123603.420941-4-a-garg7@ti.com>

On Fri, Feb 13, 2026 at 06:06:02PM +0530, Aksh Garg wrote:
> Add the DOE support for PCIe endpoint devices, enabling endpoint
> functions to process the DOE requests from the host. The implementation
> provides framework APIs for controller drivers to register mailboxes,
> protocol handler registration for different DOE data object types, and
> request processing with workqueues ensuring sequential handling per
> mailbox. The Discovery protocol is handled internally by the DOE core.

This looks like it is largely a duplication of drivers/pci/doe.c,
including the asynchronous request support that was originally added
but was never needed and so was clearly a mistake.

I'm wondering why the async suport is needed in the endpoint case?
Why can't this (only) be synchronous?

Thanks,

Lukas
