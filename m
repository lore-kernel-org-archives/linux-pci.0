Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F23537FF;
	Thu, 11 Jun 2026 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159427; cv=none; b=UcpY5Okd+aOyhEo97HrYfQqJi0BfOAWXh0Nph8ryCOSHkPWr04ShdJBtDWjDntJKzhP+ok0+6kOl6A3kk5ndfZQOmJSFM9KX/VGedFbpZWm4XQukf7Rr6elhJV26fjYLTCwf27FSeXxsWsgBr037AVZrLybpEdp1lx+KI4cff3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159427; c=relaxed/simple;
	bh=Qin7AmylYBHMatUlL2WeyObb4kwcfsiyxzoYvrLofws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyh3wntcOoWFe/mL+TwIL2ltw41WFOadA1aJnaUMNvSzW2NItv1WBspFUgwZxBube3kUaJFOJMJFammluZx2N4J0U/Na+RI9MJWwnt1RVysoctYlid5iWo2c+iOIxuaPpUG4ybVIRfQr8sUsr6WFvXGwhlFgcx7qhnzUJ1eIL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASukD95u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASukD95u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BC11F00893;
	Thu, 11 Jun 2026 06:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781159426;
	bh=Wd+byHBtYHSZdGGsBdy6n7QYm7gzRXImaoOcpxvi45g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ASukD95uTzFQBBEm0r/FjUg+3E2HjL60voOzB2GtaPS7H+WiZyr2GJypzdIfenDdz
	 qi0ekOGmQyVqmuExbGIAVNDIYYR+NagPCaP4myJOoyE99TeL4P1GS5trzYBEn4bUWz
	 6wXBZeZ/cXuMLlMNJPQf46Da5jmc9Im9ZBRJD4r2DWIF8wfs7DfDGDlQ+8rihv5gv2
	 XxD/y8Pj+4zX6mHrqHL/fCFxK8VENVQ+LvRhCeOcKTD/sJsH7xRQCUnQuaCiQ0DwIf
	 Zx8J7xpWGTdBkYIkBuJ1EdbkmHgSqdkrepZ+4dbneTHMtFyKtAIsjl09KtB7QhQxSI
	 YQArurZe7UPJA==
Date: Thu, 11 Jun 2026 08:30:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/9] PCI: vmd: Protect root bus removal with rescan lock
Message-ID: <xj42mezfer3jxlku3rg244skqpbxrf5dn47txnippxxsgan6mq@qhtmpolifzyv>
References: <20260521161822.132996-9-18255117159@163.com>
 <20260521212024.8689D1F000E9@smtp.kernel.org>
 <r5vwd573ydynlrrax5iy6jt25dc2yiqkvlciqy366zsxxu4d7f@hyvqgsdj4ulw>
 <7e46fd05-b190-42ed-8e5e-78c8a0a6bc20@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e46fd05-b190-42ed-8e5e-78c8a0a6bc20@163.com>

On Thu, Jun 11, 2026 at 12:42:52PM +0800, Hans Zhang wrote:
> 
> 
> On 6/11/26 01:28, Manivannan Sadhasivam wrote:
> > On Thu, May 21, 2026 at 09:20:24PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > 
> > > New issues:
> > > - [High] Acquiring `pci_rescan_remove_lock` in `vmd_remove()` introduces self-deadlocks and AB-BA lock inversions.
> > > 
> > > Pre-existing issues:
> > > - [High] SRCU structures are destroyed in `vmd_remove()` while their corresponding interrupt handlers are still registered and active, leading to a Use-After-Free in interrupt context.
> > > --
> > > 
> > > commit 8d5d06b67e6b02d2cc99f2151e90ba61c0d16662
> > > Author: Hans Zhang <18255117159@163.com>
> > > 
> > > PCI: vmd: Protect root bus removal with rescan lock
> > > 
> > > This commit acquires the pci_rescan_remove_global_lock while stopping
> > > and removing the VMD root bus in vmd_remove(). This is intended to
> > > prevent races with concurrent PCI rescan operations.
> > > 
> > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > > index d4ae250d4bc6d..9565567026cf0 100644
> > > > --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -1056,9 +1056,11 @@ static void vmd_remove(struct pci_dev *dev)
> > > >   {
> > > >   	struct vmd_dev *vmd = pci_get_drvdata(dev);
> > > > +	pci_lock_rescan_remove();
> > > 
> > > [Severity: High]
> > > Can acquiring pci_rescan_remove_lock here cause self-deadlocks or AB-BA lock
> > > inversions?
> > > 
> > > When a VMD device is removed via PCI hotplug or sysfs remove node, the PCI
> > > core calls pci_stop_and_remove_bus_device_locked(), which acquires
> > > pci_rescan_remove_lock and eventually triggers vmd_remove(). Because
> > > pci_rescan_remove_lock is a non-recursive mutex, won't attempting to acquire
> > > it again immediately self-deadlock?
> > > 
> > > Also, when unbound via sysfs, the core holds device_lock and calls
> > > vmd_remove(), which then waits for pci_rescan_remove_lock. Since normal PCI
> > > rescans acquire pci_rescan_remove_lock first, then attempt to acquire
> > > device_lock, does this create an AB-BA lock inversion?
> > > 
> > 
> > This is a valid concern. Since VMD is registered as a PCI driver, removing the
> > VMD device through sysfs will trigger vmd_remove() callback and it will result
> > in deadlock. The AB-BA lock inversion is also valid.
> > 
> 
> Hi Mani,
> 
> Thank you for your reply. I checked it and found that this is indeed the
> registered PCI driver. This patch will be dropped from this series. I wonder
> if you have any further comments or opinions regarding the remaining
> patches. Do I need to send the next version?
> 

I will skip this patch and apply the rest.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
