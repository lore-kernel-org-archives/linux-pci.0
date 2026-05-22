Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BA356746;
	Fri, 22 May 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472679; cv=none; b=rJEAqoVU1ax6GePYvDD8FNdTIFHQcNUYFKJQnFpT+Yv0/RgdXMkCycVypzP4fuTCRDzCGUO4s8kOYdLhP1bhhbiGAf4WeQevap/genzt6T0lcIkuLXqXEbeaL7zAVSZk598iAIbDtObfKuUqBXKbcU6bgbm5VZxnj7sUxLikxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472679; c=relaxed/simple;
	bh=BSVMYubwItNP9m6StG+StqgBHWG4YjzggfC9ywv8B7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kLa6Vi5qkgxKnfbwT5ElzyPx6BgnKwKuCstg1uWe8flBQsn3J7TTl2Nh2NA5BpIdj5b5BI8mt5c1WpUeUlFQyR2/z1UFgi3swARtMdcRZhL32sekpUVc9PxKPpZKsH5tRvhSV5l5Tvk4W9f6bGidXKctUtpfxW6t/EQXjxF5x1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy/tOkxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy/tOkxt"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7FC721F000E9;
	Fri, 22 May 2026 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472676;
	bh=cl7ag77t+S0cvQjJcgg6gb4ywEjI5mP2aQ5CGBiSLuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fy/tOkxtNEzFtipEYkXy0WJPOvLF+1NANNImU+vrYJo0+/fyGZ+vpvJ8LCHblqL77
	 QkqYNObKUr7IJScwtKZC0npx4LUgb5unsd0m9mh0Bzsz5gfLh01K8pYrMBU9IZN0zM
	 71duMHpgWfdYsxf3W60NU+4w9hiC50YzolXuyE1R6WPXJFi/ZLc7BBVxkMLBxRWXRk
	 2koPY5R4L//2T6M1ZtQyObKCPmA4Ea4M+MJ954G9fxxx4oJicdrcquVSrkpEeagwIC
	 73wHtabPXch8G9WQVzgkFv2kel272beBXS7cby2anrx+icjctkPUrTDO6eg8zpBfjb
	 zk2yFn0pQtWCg==
Date: Fri, 22 May 2026 12:57:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260522175755.GA231746@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agYRd0xQs0r8OOKA@google.com>

On Thu, May 14, 2026 at 06:16:23PM +0000, David Matlack wrote:
> On 2026-05-14 12:31 AM, sashiko-bot@kernel.org wrote:
> ...

> > >  static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > >  {
> > > -	struct pci_ser *ser = args->obj;
> > > +	struct pci_flb_outgoing *outgoing = args->obj;
> > >  
> > > -	WARN_ON_ONCE(ser->nr_devices);
> > > -	kho_unpreserve_free(ser);
> > > +	WARN_ON_ONCE(outgoing->ser->nr_devices);
> > > +	kho_unpreserve_free(outgoing->ser);
> > > +	kfree(outgoing);
> > 
> > If a driver fails to unpreserve a device before the FLB is torn down, this
> > WARN_ON_ONCE triggers, but the memory is still freed.
> > 
> > Does this leave dev->liveupdate.outgoing pointing to freed memory?
> 
> Yes, if a driver unpreserves a device without notifying the PCI core
> then that would lead to the PCI core having a pointer to freed memory.

Just a curiosity, I guess: How is this possible?  Is the driver
responsible for doing a generic unpreserve and also a PCI unpreserve?
Seems like it should do a single unpreserve, which should internally
take care of whatever PCI/IOMMU/etc unpreserve is needed.

I guess the requirement is explained in "[02/11] PCI: liveupdate:
Track outgoing ...":

  + * ... Drivers must call
  + * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  + * unpreserve() callback to ensure the outgoing struct pci_ser is allocated.

I just don't know what the driver changes will look like.
