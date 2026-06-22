Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7028B4FD;
	Mon, 22 Jun 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148381; cv=none; b=lceeaDlUqcOJ/RxVjjpxWC1kChOaOg5d5rfJomQ2pdsM8KapJ7wPcmlcOAhdWw/iklZtuMub25WM3VOup/XnLWeUx+FuTNUat7nLsr6nbEKYZN9IE87+9Z+xlxR8cFUyjlmBR6ovtkqdQvtcteSVAaehYrKZdlqxhvlsYwduHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148381; c=relaxed/simple;
	bh=4Vzov/euiZAy5o3XxIZy2yxlTi/J80ubOPRtm1V4DLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QSXBiE7WdRSSQemkjioXWoa+w5xJ6TUE6jKNrwkya2wPf02GKd/hVRxITFE+5QGN8trh/2EVX4NpWXIeCke/rWQ27bMZlETofTPYsN1xuePr5wuBvfYZfepRca6DD5XYxOwgmtBgihxFWotcW2UJPd6Gur0Aayv/MjUp4XJtYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAva85/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAva85/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DEC1F000E9;
	Mon, 22 Jun 2026 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148380;
	bh=EvAi2RJUZxbViIB5cagLnCm3XOGhwgkjuO1fCsubtiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NAva85/uXgZtmpqR0M4AOunEABKi7IxSMcB9ZJW9V3fMSQtRS9BGZOozfyuBd6kP9
	 y//J08xUqlC/JbkHnLzjRNLHGmONDTFxcpjQKyOBVGe0lr1Pgdco1jPgeyYRqsGVcz
	 1uqkTLBoSEeTz70+oH4SBdrIGdt0LrlrYoHm6WtjfrPa9duRYS5a1qn4mtLKseDJk+
	 qPRoJsfMOu6c/R0utY6dYjls9tEok3k7tu6O7R9eOMN7j+NnN0QbcFSlDi9R1du9Z1
	 v7lCR2hLXCYuqPIcwyLn+ExKC2/bZEK+a57MRH/khrU7aeY30J6/ebUya3k5fj0imx
	 VLSOHHA8tIAgg==
Date: Mon, 22 Jun 2026 12:12:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, a-garg7@ti.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] PCI: controller: Add missing rescan lock around root
 bus removal
Message-ID: <20260622171259.GA677910@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a9a0f9-b331-48d8-be86-64471b9ea4fb@163.com>

On Fri, Jun 19, 2026 at 11:20:33PM +0800, Hans Zhang wrote:
> On 6/19/26 00:59, Bjorn Helgaas wrote:
> > On Fri, May 22, 2026 at 12:18:13AM +0800, Hans Zhang wrote:
> > > Several PCIe host controller drivers call pci_stop_root_bus() and
> > > pci_remove_root_bus() without holding the global PCI rescan lock
> > > (pci_rescan_remove_global_lock). This can cause race conditions with
> > > concurrent PCI rescan or hotplug operations triggered via sysfs,
> > > potentially leading to use-after-free or system crashes.
> ...

> > Thanks for this work.  I amended the commit logs of the eight applied
> > patches so they're all the same (since all the patches do exactly the
> > same thing) and so they all mention the reason for the change.
> > 
> > There are only four callers of pci_stop_root_bus() and
> > pci_remove_root_bus() that would not be able to use a trivial helper
> > function that does the lock/stop/remove/unlock internally:
> > 
> >    zpci_bus_release
> >    acpi_pci_root_remove
> >    hv_pci_remove
> >    vmd_remove
> > 
> > It would be nice to analyze those to see if they could use the same
> > pattern, which could be done inside a helper function that would avoid
> > the possibility of adding the same bug elsewhere.
> 
> Thank you for reviewing the series and for the constructive suggestion
> regarding the common helper function.
> 
> I fully agree that introducing a helper (e.g., pci_remove_root_bus_safe())
> to encapsulate the lock/unlock logic is a cleaner and more maintainable
> approach, and it would help prevent similar issues in the future.
> 
> Since we are now in the merge window, I would prefer to hold off on this
> further refactoring until the next cycle to avoid introducing any
> unnecessary risks or conflicts at this late stage.

Definitely.  This series is already merged, so this is just potential
future work.  I'm not sure I would even add such a helper unless those
last four cases (zpci, acpi, etc) could also use it.  Having two
patterns would be only a marginal benefit.
