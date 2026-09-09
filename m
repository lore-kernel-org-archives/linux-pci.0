Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4126B3845B7;
	Wed,  9 Sep 2026 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936169; cv=none; b=iQEVmqrmM4m/RMXYrBzEPSS0dErQH0mdpdVkjYsHG+tA1lpFIsT6oJ04q1etxVC3FtIyQL3v496MGRt32CZEM40qv67MmGmGEwzBpiFE/QQ1mfMv61htZlQO/p0SfdELYh9iYnhf3vdqP6Ru/p2VbJ5azsIcIrY1be5tOrzrOqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936169; c=relaxed/simple;
	bh=0zHnaPVgYAIlDcasohtjxnsml0RJUyCb/n5Azd+cpCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHNwIsyJHJxOzV8wCatrlkwtqIViH6S026YyxxNW1xDV/QGAhbzBoJhSo5bOVJeERIWF9VYK5ECloM/JBDIVg3XA8c/7yv6zHoE3FPkBSC+DBzPCXuabaQowC5JEPbys3oK2E+7R5CFExpN8jq6Ogl4fRzpCT7U+Mj/8GAsNF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 7345CF4E;
	Wed, 09 Sep 2026 08:42:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4B7AF627236C; Wed,  9 Sep 2026 08:42:37 +0200 (CEST)
Date: Wed, 9 Sep 2026 08:42:37 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Fahmy Hassan <fahmymohammed@gmail.com>
Cc: helgaas@kernel.org, bhelgaas@google.com, scott@spiteful.org,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: pciehp: Check pci_hp_add_bridge() return
 value
Message-ID: <aqD_3ULr3ls4S9IN@wunner.de>
References: <20260909014143.GA123333@bhelgaas>
 <20260909022227.620217-1-fahmymohammed@gmail.com>
 <20260909022227.620217-5-fahmymohammed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909022227.620217-5-fahmymohammed@gmail.com>

On Tue, Sep 08, 2026 at 08:22:25PM -0600, Fahmy Hassan wrote:
> pciehp_configure_device() calls pci_hp_add_bridge() for each bridge on
> the newly added slot without checking its return value.
> pci_hp_add_bridge() already logs an error for one failure path (no
> bus number available for the hot-added bridge), but returns silently
> if the bridge's subordinate bus isn't created after scanning -- that
> path goes completely unreported, and either way the caller currently
> has no way to notice or react to the failure.
> 
> Log an error via the driver's existing ctrl_err() macro when
> pci_hp_add_bridge() fails, identifying the device involved.

The only change here is to log something on error.  That can be done
in pci_hp_add_bridge() itself without having to amend every caller.

However pci_hp_add_bridge() already logs an error for the one failure
case that merits an error message.

The return value is normally evaluated to do something, such as
bailing out or unwinding some earlier actions.  But in this case,
I'm not seeing a need to do that.

So I believe this change isn't necessary, at least as far as pciehp
is concerned.

Thanks,

Lukas
