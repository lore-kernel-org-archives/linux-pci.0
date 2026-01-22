Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AE3EBF31;
	Thu, 22 Jan 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099426; cv=none; b=iN89DMNx3TXUSmJywmwFYu3jJ/Jo/aFWM/CKZQAawxuFo8S394Ba/8w/o3XTLFHCC6Sf9GQA/JNBYKgFz3UJ35LxmHNljxOVLMDqoVv5dp7v3AyY/4qUGuli9DwUz/PT2Z1+u80DrCrt6Vrq6VsvZ/bJQQTueUc4MvnakR8wnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099426; c=relaxed/simple;
	bh=FlqUzzF6VmK5cuGb5I6+FSD7in2BIPlszxlu745NWVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C+vEtRWhYRKcQaTkzHBT/efe2EpvnkGzIK2z6NUx5hxxHLZmQwyXAHAD4wIYTIp47upZT7jr2nTb4MNglcNZhIAXkVAXIsNArNb5ejBv9Z7FjJZshBSem6hk8D24AgnhiNYEzxt1NPHTOLkZgkMQqEzBm+714vaKwN1KgZY9BWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aml+XEF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aml+XEF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8297BC116C6;
	Thu, 22 Jan 2026 16:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769099424;
	bh=FlqUzzF6VmK5cuGb5I6+FSD7in2BIPlszxlu745NWVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aml+XEF4Va6WDFoXbp/XPYMKOCnnnwT7aRfxnfNZwHg4iB/smW3WGxynVKnr8N5fh
	 B0uS0DYxnQdZkQGRAtP1GQ/I6nll7QP1uGgHxaXb6C1LObgXBm8FN/qsdzbVAKvxVX
	 cFzviZQ/tczXsA8nK+2jYr5Kund9j+L2U3HJAZcEkkujWFQGtlWaLpQdNy6zu+jk+h
	 MMbbZ5b9wKIaP9cFN/CRW0B8DMtsVJ1RhdQJ+YiLQWkknu9jUTz6/ZyKAh0WKJk0+E
	 mU+RjHRmSU2a0BoRsPzSdIAdzkIUiaDx6u5u/z7cv33Xw5gchF2cbsxSeLc9simtmL
	 dwMJVdv79z+xQ==
Date: Thu, 22 Jan 2026 10:30:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Fix BAR resize rollback path overwriting ret
Message-ID: <20260122163023.GA1251597@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd05361e-39a2-b8f4-d30a-38ce96799982@linux.intel.com>

On Thu, Jan 22, 2026 at 12:07:40PM +0200, Ilpo Järvinen wrote:
> On Wed, 21 Jan 2026, Ilpo Järvinen wrote:
> 
> > The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize
> > rollback path") added BAR rollback to
> > pci_do_resource_release_and_resize() in case of resize failure.
> > 
> > On the rollback, pci_claim_resource() is called which can fail and the
> > code is prepared for that possibility. pci_claim_resource()'s return
> > value, however, overwrites the original value of ret so
> > pci_claim_resource() will return incorrect value in the end (as
> 
> Hi Bjorn,
> 
> I noticed this should have been:
> 
> "pci_do_resource_release_and_resize() will return incorrect value in the 
> end ..."
> 
> (used a wrong function name).
> 
> Could you please adjust the commit message in your tree if it's not too 
> late yet?

Updated, thanks!
