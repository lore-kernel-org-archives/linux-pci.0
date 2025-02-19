Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F925A334;
	Wed, 19 Feb 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006006; cv=none; b=n143+QAHwLFYvJTZie9EEV+pKqW8i/0LOl6SHMwKQDOo0EJHNMUXG3Num0Ku47fcED9rym2c25NbzBlN9vcbYzFmKXOUQtsN8Hnd62qEJDu8FVc95UEXehYZzglfm6axtPFK4tvqIJP7uffPJNGY19RnKLwhslrx8knp9XlYBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006006; c=relaxed/simple;
	bh=ycjVKUq0Z/JzO3KFCBtaeWyRj0ZFaYt/UYqgHgQIqQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IiyQeVpQfmAz4nCkMLnRqibH9TqsjDDP0pop/UScrCtR1iWNKrB1D+yDcuTu2X8J/l23pWWSPh70SxI/HGtgjZFqaXNHpt3DtpBh89JU0S5lSUyZyWkrFs9PCzjIzKPIquMKOBAt2KnBbrqrdXk6XrMS20qOZT+7G0QyX+8G0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtFBri/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtFBri/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236C6C4CED1;
	Wed, 19 Feb 2025 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740006006;
	bh=ycjVKUq0Z/JzO3KFCBtaeWyRj0ZFaYt/UYqgHgQIqQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZtFBri/4A0glWn5U+INtzQH/E0QqdqJyOB50h3NrGzv9vuluIEFYbA31+fxDoXBnO
	 +0PlwNTe+iYXaY7Yao6IQIMNYU3vICTYT8ZX9XRoVAODhOAq0M+QJHd30YnhAoW6kE
	 moUOEoVqihsND3H6jZ5uJun4tWudm75pXQ5Qd1WXFY5npLl810ovG9YSFXNUVyPszD
	 nzQwx2w/eBI/pZwTeGQtVRdIx+i0cgezapTEnJuowfgE62gAuISqZCJegTakhpeLCb
	 3oHdyjZat6m6UYxzVp33DJesmf7Pv3gmXB8//98EpdSAJacjqhfnc5b5sGxQ6Xi+Jn
	 kLbJhUmHiKfPg==
Date: Wed, 19 Feb 2025 17:00:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: shpchp: Debug & logging cleanup
Message-ID: <20250219230004.GA248230@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218224602.GA198344@bhelgaas>

On Tue, Feb 18, 2025 at 04:46:02PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 17, 2025 at 11:55:48AM +0200, Ilpo Järvinen wrote:
> > Hi all,
> > 
> > This series cleans up debug/logging in shpchp driver.
> > 
> > The series is an update for the only remaining patch in the pci_printk()
> > removal series. To avoid breaking build, pci_printk() itself will only
> > be removed in the next kernel release because both AER and shpchp used
> > it and are in different topic branches.
> > 
> > v2:
> > - Split removal of logging wrappers and module parameter removal to
> >   own patches
> > - Explain how dynamic debugging can be enabled
> > 
> > Ilpo Järvinen (2):
> >   PCI: shpchp: Remove unused logging wrappers
> >   PCI: shpchp: Remove "shpchp_debug" module parameter
> > 
> >  drivers/pci/hotplug/shpchp.h      | 18 +-----------------
> >  drivers/pci/hotplug/shpchp_core.c |  3 ---
> >  2 files changed, 1 insertion(+), 20 deletions(-)
> 
> Applied to pci/hotplug for v6.15, thanks, Ilpo!

And I added the previous patches:

  7d5f1e615e69 ("PCI: shpchp: Remove logging from module init/exit functions")
  499982200892 ("PCI: shpchp: Change dbg() -> ctrl_dbg()")

that you mentioned that I forgot to include here, which should fix the
build failure.
