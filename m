Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF230C600;
	Thu, 22 Jan 2026 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107923; cv=none; b=vCl+5JhIrUDrJLX/Ms3m77u46/+XaT9tWrckwvtQUfr/oGc/JhkFlBE7HLiY/y/Rqr1rZP0gJTS3Pzn1uc9CLIZjDFO6xC0QNBrEtt7e+Y3CZt/wWxssWokSFkPBcuOONHxvD+dpTzVapX2vDOckFzF+YpL/yuVhwGRAdUOnhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107923; c=relaxed/simple;
	bh=RrffOs2rTZB+6jkR/cZCuQqV+IRZXKH7wumLr6JBqaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrs8QxOEJTFTWKAho+LfSapBMB34Qg1zrrv6mxxO7mW2EUq0tRg5EB0SSlQp0JfaOgIf2eI5ujjfN6qK7IMGce4gwY6TWuO5LFjjV+BtsJFx8zjIN9F7fUnRDIBKtClTZfzvh8Z/aKerxGfIqj3vkBfIwuOk2zeAbCruUXvuJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id ACD8B2C0665F;
	Thu, 22 Jan 2026 19:51:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 964722D8F9; Thu, 22 Jan 2026 19:51:49 +0100 (CET)
Date: Thu, 22 Jan 2026 19:51:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 09/34] PCI/AER: Export
 pci_aer_unmask_internal_errors()
Message-ID: <aXJxxYrIoOMKIl7W@wunner.de>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-10-terry.bowman@amd.com>
 <696ee3e34f2d9_875d1004f@dwillia2-mobl4.notmuch>
 <aXH8gMf3zcaw8FF4@wunner.de>
 <697254e4efe61_3095100a3@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697254e4efe61_3095100a3@dwillia2-mobl4.notmuch>

On Thu, Jan 22, 2026 at 08:48:36AM -0800, dan.j.williams@intel.com wrote:
> Lukas Wunner wrote:
> > As said, the "xe" driver needs to unmask Internal Errors and could
> > take advantage of this helper, so I'd call opening this up for PCI
> > drivers if not a goal then at least a "desirable side effect". ;)
> > 
> > https://lore.kernel.org/all/aR1_M_i3yIygd8v-@wunner.de/
> 
> I missed that earlier. How did xe manage to be the only device in the history
> of Linux that needs internal errors unmasked?
> 
> What happens if Linux says "no, that error model has never been supported and
> it creates in ongoing mental / maintenance load of internal errors do not
> matter for PCIe, only CXL, (except xe)."

Every spec-defined feature is fair game to be used by drivers and
denying them support would seem unreasonable.

> > >     -+EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
> > >       
> > >     ++/*
> > >     ++ * Internal errors are too device-specific to enable generally, however for CXL
> > >     ++ * their behavior is standardized for conveying CXL protocol errors.
> > >     ++ */
> > >     ++EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
> > >     ++
> > 
> > This change will require touching aer.c every time a driver
> > (such as xe) has the need to unmask Internal Errors.
> > Not sure if that's such a good idea...
> 
> The xe driver can always come back and change this to plain
> EXPORT_SYMBOL_GPL() once the clear the hurdle above of,
> "please reconsider your error model to not require this
> never needed before feature of AER".

Of course, but it may annoy Bjorn that he'll have to deal with
an amendment of this macro for each individual driver that needs it,
or at least for the *next* driver that needs it.

Thanks,

Lukas
