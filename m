Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311E2F0C76
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557435; cv=none; b=YLxvuy3HYhiHR9NZANKZR4Bn5TxjKBKz2d71r4j3Qt/ChuFexgKo8BxUD+nWsEb/XZTRYqjyYXILKRQZM9ZU0XDozWgpa+sIUyR6toXd3O8yZya10FqKXoadijQe2uyS7LpVO7PvOZ51RNs6ZKcXTvLZ1yz6FpmfxsbUKGdUOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557435; c=relaxed/simple;
	bh=OMhj9HFljtIwwHJh7FSuYoEToi/s+9/KcIkDHzxBAx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRmkkH2pXLhVQlfRDAdL8TzNyRN0kVfcRJq0hO6wdOoHRA+w5HX/T+Q9btS6VSmGJG7axjUPuPB2iYGqAXBA37HEQ1t1460hu/dC3u7uS9potDZwPvlD0B0BkrUbDyjKjpTg3GRwgQf2zO9sPAwLtKSdtyyduJ27P90TPH2WnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnDtUWKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnDtUWKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9286C116C6;
	Tue, 27 Jan 2026 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769557435;
	bh=OMhj9HFljtIwwHJh7FSuYoEToi/s+9/KcIkDHzxBAx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnDtUWKUjsKZSPW6cCoVZUBCqdwQH1zXSQ2uHfmnpna8BVqnrTloRnLW0gaTjv+sd
	 GbATGPGyMURARYSltUXy16uFdkjBO5fGPjARwIiEl6nam9U1D0JI2wKIPw1FzZ+e73
	 27BTSa6n1+wRPx57Uv5bzXGNU1d2+yFwnmcXl0NoeTRZwokAU3U4LKeKZNYx1IjDfZ
	 iHztcK3YDnto3q79zE29fB7/UdwvZ6MYe6NelX/GDbD2gi+GFLApnr0qFQUnV4ITPq
	 wgY/naCwpzK2LddTKQzTiQWsTDpQ+bsDY6FrIjZ0dw4md1eG2etusc6tIskJpMtB/6
	 sA7J6nxY+JkRg==
Date: Tue, 27 Jan 2026 15:43:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Qinyun Tan <qinyuntan@linux.alibaba.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Xunlei Pang <xlpang@linux.alibaba.com>,
 Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <20260127154353.4c115e36@kernel.org>
In-Reply-To: <20260127230912.GA385193@bhelgaas>
References: <197d75a2-4286-41fb-ab4f-9ad744885bb4@app.fastmail.com>
	<20260127230912.GA385193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 17:09:12 -0600 Bjorn Helgaas wrote:
> > > If this is expected, should the warn message "driver left SR-IOV
> > > enabled after remove" be downgraded to 'info' level?  
> > 
> > It is not important, no one complained about it. People who unbind
> > PF, simply ignore this warning.
> > 
> > BTW, the use case which I presented is for SR-IOV handled by
> > drivers. Maybe VFs created by NVMe are different here and they must
> > be destroyed.  
> 
> If it's to be expected, I do think 'info' would be more appropriate,
> if nothing else as an indication to code readers that nothing is
> wrong.  Or maybe even no message at all.  Or maybe the fact that we
> reset the driver_max_VFs value is of more interest.

FWIW I probably just added that message because most drivers end up
printing something along those lines. Tho, I strongly suspect it's
a mindless copy/paste in majority of the cases. No preference here.
