Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65193CF209;
	Fri, 17 Jul 2026 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285301; cv=none; b=d/BTxdpM9HOrUMHzwM4A4CVFvNHEb0v+IJc+zizfzVcbfbDCnO2kO1erCKs/GMTQQWhqDFmce+i2s+8l9uFBJQ8jeTfLTUudhqvvByJnOyPpzuw7QfsImF8xPaK/3TZC9a9v0tpZsnAxrDve/bvrNP8IIjCzQgVmEojalcXfQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285301; c=relaxed/simple;
	bh=Ty++MwoNE3KALcCks3FUvWgBo2uPpvSW6K5JdwrwwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJjwqjhzpICdHp+vN7c95WdQZW6TaR0a35MyPbk+AATJoqO+fDcg3PiyY4J5p9kCPo3uFx+9OuN6eIBC3XDZYANqPcuOQosCZD+8teGxzxXs+1GPAvjysTGrpPStyxOIkF85BzbJpFyDCYxyq5l5+TxXunbsj3X8r0ntIDXGLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWPPAUE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWPPAUE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65051F000E9;
	Fri, 17 Jul 2026 10:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784285300;
	bh=h4pzKh/tnRoRedxPzQr3WKj6PjoIY3zSEXj5WZOcq+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YWPPAUE1di30CKh3TYtuByPVMFDO03wnX2/Ishi46KNNYPEJT6dXq1jAnCzTTAn5y
	 qLm5tAk/2hZN+TDUfUWGQQjaNABVOAkv1N+yckx/1FJSCvRmyf6Fn0J/5U9ztnEUIs
	 iQrUf+wD2J5Ju5a0DYzalh/H8miFRA798fyfh21o=
Date: Fri, 17 Jul 2026 12:48:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: leixiang <leixiang@kylinos.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Fix use-after-free in
 pci_p2pdma_add_resource() error path
Message-ID: <2026071700-chitchat-uninsured-0767@gregkh>
References: <20260717095120.51111-1-leixiang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717095120.51111-1-leixiang@kylinos.cn>

On Fri, Jul 17, 2026 at 05:51:17PM +0800, leixiang wrote:
> In pci_p2pdma_add_resource(), a devm action is registered to call
> pci_p2pdma_unmap_mappings() with the 'p2p_pgmap' context. If the subsequent
> call to gen_pool_add_owner() fails, the code jumps to the 'pages_free'
> error path.
> 
> In this error path, 'p2p_pgmap' is explicitly freed via devm_kfree().
> However, the previously registered devm action is never removed. This
> leaves a dangling pointer in the device's devres list. When the device
> is unbound and devres is cleaning up resources, the unmap action will be
> called with the already-freed 'p2p_pgmap', resulting in a use-after-free
> bug.
> 
> Fix this by properly calling devm_remove_action() in the error path before
> freeing 'p2p_pgmap'.
> 
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> Assisted-by: Antigravity:Gemini [tools]
> Signed-off-by: leixiang <leixiang@kylinos.cn>

We need a full name here, not just an email alias.

thanks,

greg k-h
