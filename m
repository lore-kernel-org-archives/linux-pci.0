Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61615221F26
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993264; cv=none; b=ZOzZX/86Rzs/pFh7g7C4ZZ6OWqSlkvbXxG7vgbmB8NKDS52RTRRJRVXJfWselJJU0AIkSpXhIlFGXf9Df63cM1RXnTaytL1b2Cfk1e2SWiMWa0fepkCE50RVg/W5NuBszYO+K19qjcF4zve53+w+2FOPbGpQ8bKG8WbCg9Z9hYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993264; c=relaxed/simple;
	bh=K9fRr+UlLUJE9ZHHdyz5ACa1vAiOPMIZQW8NFNX00Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPF7ji5H8ozkt+zEbbkPgW0NzOVxlP15dgkmafUMg5s/y6+SoDxy1euSSdFYRUYpAT6dXcMsqTqC2VD2ydbDi0TU7zQSbyarHPjuNFi9yjz592capmVxOgZMAuU8wdaXIIEG7hYS7Gdr3VKySL0bsW3U16XgRJ2VZfxvjvre0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH7a/veF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH7a/veF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4442C116C6;
	Fri, 13 Feb 2026 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770993264;
	bh=K9fRr+UlLUJE9ZHHdyz5ACa1vAiOPMIZQW8NFNX00Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DH7a/veFVyjmKYWWuH35pHpluGBwgGOTqX2qPhC9uNujly7U2rO3b2VrE4QdMi+Ct
	 7+pSdESV+KwGJYBxIkNm/vkGRNk12IutRcPIBojT4oZp5xtdHK5g6XzcI8v85dFAEV
	 KWizI+xeSvVxPZSAljl/nvpNj6FwtYCDBa8+7BSVQdRDoqNMoCW6iqt3XPhA6IzOfx
	 kTb80HzVSODyYGKYRCEIpTZ56fB5FBfidAQwSnzVtSINnOSAD7Ghk4m6X0P93xFW8K
	 DqsGHTIImKHT560d1EZW6XrjFD90yxtr4VVFYZfprXUZI/mERCc86p37vQMJ8swt7M
	 AewTdi7ugIEcg==
Date: Fri, 13 Feb 2026 07:34:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, alex@shazbot.org, dan.j.williams@intel.com,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCHv4 3/3] pci: make reset_subordinate hotplug safe
Message-ID: <aY82bXoCR43jQplq@kbusch-mbp>
References: <20260212224112.1913980-1-kbusch@meta.com>
 <20260212224112.1913980-4-kbusch@meta.com>
 <04516225-9967-fd1e-c756-6963719aa08d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04516225-9967-fd1e-c756-6963719aa08d@linux.intel.com>

On Fri, Feb 13, 2026 at 09:32:32AM +0200, Ilpo Järvinen wrote:
> On Thu, 12 Feb 2026, Keith Busch wrote:
> >  int pci_bus_error_reset(struct pci_dev *bridge)
> >  {
> > -	struct pci_bus *bus = bridge->subordinate;
> > -	struct pci_slot *slot;
> > -
> > -	if (!bus)
> > -		return -ENOTTY;
> > -
> > -	mutex_lock(&pci_slot_mutex);
> > -	if (list_empty(&bus->slots))
> > -		goto bus_reset;
> > -
> > -	list_for_each_entry(slot, &bus->slots, list)
> > -		if (pci_probe_reset_slot(slot))
> > -			goto bus_reset;
> > -
> > -	list_for_each_entry(slot, &bus->slots, list)
> > -		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
> > -			goto bus_reset;
> > -
> > -	mutex_unlock(&pci_slot_mutex);
> > -	return 0;
> > -bus_reset:
> > -	mutex_unlock(&pci_slot_mutex);
> > -	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
> > +	return pci_reset_bridge(bridge, PCI_RESET_NO_RESTORE);
> >  }
> 
> I think this should be moved down below pci_reset_bridge() and the forward 
> declaration of pci_reset_bridge() removed.

Yes, thanks for the suggestion. A cleaner end result for sure.
