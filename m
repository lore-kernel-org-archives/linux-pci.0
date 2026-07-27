Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435073DB31F;
	Mon, 27 Jul 2026 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147248; cv=none; b=ioXufXr3x2+yxPBxKbImE/1MSzV4Q4k7Pf2Os+R2LPH+gIX+EHOSfiNPGwQU/r0dVEqkiKYtlWy87JSS5RYll7ESpQmqMFIzfdj9QOMr5XQFgswjmgL7AkQ3e8Bo+k/EZB5WGB8nWsxrqHXSh/iJDFdYVpzSEzAHQj5OHZEUvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147248; c=relaxed/simple;
	bh=u3lRx538ZGJlOhB++fFOkBNICMXv2UUCeZf4sIrKiUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qStsEA4NH153qtRN3ml6jG6+PKLIdICPWmmcKcAbTS2KYgnpkvn3OcxuItXjhpTfVugbEYTllIOjKHc237F3R+Q7X5O40AS7qDRxH3Rqv+7DFGgtciDjvbg+gp6d2mCbqS+ANu63elfzNcAXT5Gkg65LMy+27b415O3XIMAqjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 79B0E36F;
	Mon, 27 Jul 2026 12:13:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6138E60332E5; Mon, 27 Jul 2026 12:13:56 +0200 (CEST)
Date: Mon, 27 Jul 2026 12:13:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, Kees Cook <kees@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs
 show/store callbacks
Message-ID: <amcvZMBxMFB5ild0@wunner.de>
References: <20260727072915.3954329-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727072915.3954329-1-zhaojinming@uniontech.com>

On Mon, Jul 27, 2026 at 03:29:15PM +0800, ZhaoJinming wrote:
> The aspm_attr_show_common(), aspm_attr_store_common(), clkpm_show()
> and clkpm_store() sysfs callbacks call pcie_aspm_get_link() without
> checking the return value. A NULL return would indicate the device is
> not PCIe, has no upstream bridge, or the link state has not been
> initialized.
> 
> While the aspm_ctrl_attrs_are_visible() is_visible callback already
> hides these attributes when link is NULL, add the NULL check for
> defense in depth and consistency with other callers of
> pcie_aspm_get_link() in the same file (__pci_disable_link_state,
> __pci_enable_link_state, pcie_aspm_enabled).

Well, if we don't need the checks because the ->is_visible() callback
already hides the attributes, then we shouldn't add them.

Otherwise it's quite possible that someone else comes along and deletes
the checks again because they're superfluous.  

Thanks,

Lukas
