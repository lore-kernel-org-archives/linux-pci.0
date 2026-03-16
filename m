Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F6139D;
	Mon, 16 Mar 2026 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692213; cv=none; b=iOZiSWuLT8N00p3NE3ss+OxCQri9uOZaN8Q9L8OLyX53HXzT8JDPF9UZi9s4oQ1Vf+XqjJpgd6tClfdTTpkdu9fNy5umxQXT+Pb8FF88m+iWUHP7v0FeAaLiU387KftNOAkyuGaaFjjQb4ALyTcH9lphnKkM8NbTOzPqOOmv7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692213; c=relaxed/simple;
	bh=OnCxr/RyvCpaaUk3eSeAxx/ggPZ6xK3QVvjB7vINWaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dophzKvmVmTo0IGPjT59fuFYWakd1BgZRWQINnX3k8E6eCFl2zKsOZa6FUnbwZGXYsc0ys9Ir2gDJ7N+xx18ZCcW1YgTAygUz21/x0jhRO2wTNE4IgfxIkrr4n4ZU22UEFAYvVC36ALZevCB2kqLC6csE8iCQSnBtCtIf8EPXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQGP/TE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQGP/TE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9BBC19421;
	Mon, 16 Mar 2026 20:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692212;
	bh=OnCxr/RyvCpaaUk3eSeAxx/ggPZ6xK3QVvjB7vINWaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bQGP/TE8PVNEWoPCWYPZuo1w1kelqWicUTvpF0gYu/eJgaF2z8Sbii284gtfJF1nL
	 b8NgOGNTjVB6aWgYQMXd91ULDmONCIGADeHPDdZGCClbKVMnh/PLiCg3daTdKFK5Lf
	 noYebeTYixQayP6Zdxmo2wbs4s+gASYr2goeuLu0pSF+8pleiMF9yhd7wTG6h2rUoL
	 SYoeU9zFY8d4vf2Nm8DeAGL5YDWfE7vUCggDvPyhCK4lUOQPeoriPBasM3HMkChcMB
	 xUaKmsorrlfzxgjOzeWWOjO7e4+i6mYVdqR9C4Hg9P11En3XZW9egAzul51+ZZsh0O
	 PNUVnsZghmWgw==
Date: Mon, 16 Mar 2026 15:16:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [REGRESSION 6.14] Some PCI device BARs inacessible
Message-ID: <20260316201651.GA23314@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418102926.690ac42c@foxbook>

[+cc Ilpo, +bcc bugzilla reporters and commenters]

On Fri, Apr 18, 2025 at 10:29:26AM +0200, Michał Pecio wrote:
> Hi,
> 
> This is a heads up that an apparent PCI regression has been reported
> and mistakenly assigned to USB in the kernel bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220016
> 
> Visible symptom is missing USB devices, but the whole controller fails
> to probe, apparently due to devm_request_mem_region() returning NULL,
> see drivers/usb/core/hcd-pci.c and usb_hcd_pci_probe().
> 
> Same systems also show a similar failure with some AHCI controller.
> It seems specific to particular ASUS AMD motherboards.
> 
> Somebody found that disabling CONFIG_PCI_REALLOC_ENABLE_AUTO helps.
> 
> That's all I know, reporters can be reached via bugzilla.

I see some activity in the bugzilla but no resolution.  Ilpo has done
a lot of work in this area since v6.14, though, so I wouldn't be
surprised at all if this has been fixed. 

Would anybody be interested in testing v6.19 or v7.0-rc to see if this
problem still exists?

Bjorn
