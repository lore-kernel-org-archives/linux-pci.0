Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D951BC46
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240783; cv=none; b=gK70a6UZ+GgKNdb9OLfMkWTbfhh9gqNBNvc+rpXo5eAY/msA5aAPcLgBEK4A3NT8f42ZAq2PvaXTBnlFaqdtDGcOyqptCBxnhtRR/6A50n2/Unyb1BQ7aaXoLwSO1tZjIQl/bmaXYPYurZA0bdJOm2aN5GdTLbhpmSPTarY0jkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240783; c=relaxed/simple;
	bh=lbxn/eoSeLJB3TlPCOE5t/PjY4kroPAbdAVQ2jQQw5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh/8mYpT4g7PjX46PA/Iy7MRT0yfZAya8sccvH5sJqivLPva8aEcQ249dysgazGdVRoDH+CwWzQlqj68beuoxEJwefqVJ1/V3VPIwzAxtzkaPHRk7T5OyvxQGVTdxKA4JZZFdei7GMxj8W3VoYSJSurMnExtE0WiqZCerYM0+tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/GOVRbw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/GOVRbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFE7C4CEF7;
	Wed,  4 Feb 2026 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770240783;
	bh=lbxn/eoSeLJB3TlPCOE5t/PjY4kroPAbdAVQ2jQQw5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/GOVRbwzKIEwpT2JuhkhDa92k2zhuNEOEUFsQX5vEOUbykl+6GNpD+aoC6xR0aNe
	 jfqtiOcddLAfO2p59THgdc7DdayRo3djNvOYNohZ0hX5vE8a+hGinhmsjZLF+DBvNu
	 2B4xCR14rw9wyWZwMowPVwObw80ssxvx+EfQXZoTMiMM/wFqGYFV1346U5YII2OFrt
	 HJk7ToVVkh6fK7R9w78XRW5K9VAMSf85rd4GV0za11sGtWNVKrQdWz6zW5Oo0/8c5O
	 Gn4wsDp5167w62ya4KcjU8Hw3/53+rp+s+N3s3YmRI45eegVV4p28zD2h6dxuf8vXk
	 n533gb/nRNOGA==
Date: Wed, 4 Feb 2026 14:33:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: dan.j.williams@intel.com
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, alex@shazbot.org, lukas@wunner.de,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv2 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <aYO7DHyuxXS3ZEZ8@kbusch-mbp>
References: <20260130165953.751063-1-kbusch@meta.com>
 <20260130165953.751063-4-kbusch@meta.com>
 <697d9a0fa0427_1d3310063@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697d9a0fa0427_1d3310063@dwillia2-mobl4.notmuch>

On Fri, Jan 30, 2026 at 09:58:39PM -0800, dan.j.williams@intel.com wrote:
> Should this be:
> 
>     bus = slot ? slot->bus : NULL;
> 
> ?

Yes, you're right.

> Looks like at least pci_reset_bus() could pass a NULL @slot.
> 
> >  	int rc;
> >  
> > -	if (!slot || !pci_slot_resettable(slot))
> > +	if (!slot || (bus && !pci_bus_resettable(bus)))
> 
> With above and something like this:
> 
> @@ -5219,6 +5219,8 @@ static bool pci_bus_resettable(struct pci_bus *bus)
>  {
>         struct pci_dev *dev;
>  
> +       if (!bus)
> +               return false;

Sounds good.

> >  	int rc;
> >  
> >  	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (pci_slot_trylock(slot)) {
> > -		pci_slot_save_and_disable_locked(slot);
> > +	if (pci_bus_trylock(bus)) {
> > +		pci_bus_save_and_disable_locked(bus);
> >  		might_sleep();
> >  		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
> > -		pci_slot_restore_locked(slot);
> > -		pci_slot_unlock(slot);
> > +		pci_bus_restore_locked(bus);
> > +		pci_bus_unlock(bus);
> 
> With at least the @bus initialization fixup above and with or without
> the other suggested cleanups you can add:

Thanks!
