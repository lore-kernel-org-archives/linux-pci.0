Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476541C71;
	Mon, 20 Jul 2026 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510230; cv=none; b=RUYpzYuw0cZ6283JfnNcLkcpiaHXSBQcsMxGICwWcanZRT7oiX6+YVsTNFPcfj9CCLBEh+AaA86Jy/fKtGJcRaVPtt692W3K4PVhjprhvz6O6NnITH2oH71h8TK+ElIKnVFO0nMt2IhNBcArWkYNJBJfvN7DFX+ETy5gQxuxWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510230; c=relaxed/simple;
	bh=1mS3J4+PnuFX21mA7SkamVlLa5fNvhCbf2TGsWLkqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5FPIGVJo1wmRq+LR5A53CXH8c0/PHeXzKMf6pk/r+hebUPbzfQs+p1O9qIJxdEA6BQm5fNY/w+Z4fFaLiOMRP+tEFTCqy6zLLauDewt3toeHqqmTkLH+rYd4lF70VXM61+htXNQ++isUw0UUw0ih2A/AyPIoVc+PEeU6laHf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b093a80083d811f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ef8eb170-ae4c-4c48-8a7e-3d2b0567437c,IP:0,U
	RL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:7
X-CID-META: VersionHash:e7bac3a,CLOUDID:a74f54005374268efe0dfdcc99f957f2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b093a80083d811f1aa26b74ffac11d73-20260720
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 955506042; Mon, 20 Jul 2026 09:16:52 +0800
From: Xiang Lei <leixiang@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: axboe@kernel.dk,
	bhelgaas@google.com,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	logang@deltatee.com
Subject: Re: [PATCH] PCI/P2PDMA: Fix use-after-free in pci_p2pdma_add_resource() error path
Date: Mon, 20 Jul 2026 09:16:49 +0800
Message-ID: <20260720011649.23333-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026071700-chitchat-uninsured-0767@gregkh>
References: <2026071700-chitchat-uninsured-0767@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 12:48:12PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 05:51:17PM +0800, leixiang wrote:
> > In pci_p2pdma_add_resource(), a devm action is registered to call
> > pci_p2pdma_unmap_mappings() with the 'p2p_pgmap' context. If the subsequent
> > call to gen_pool_add_owner() fails, the code jumps to the 'pages_free'
> > error path.
> > 
> > In this error path, 'p2p_pgmap' is explicitly freed via devm_kfree().
> > However, the previously registered devm action is never removed. This
> > leaves a dangling pointer in the device's devres list. When the device
> > is unbound and devres is cleaning up resources, the unmap action will be
> > called with the already-freed 'p2p_pgmap', resulting in a use-after-free
> > bug.
> > 
> > Fix this by properly calling devm_remove_action() in the error path before
> > freeing 'p2p_pgmap'.
> > 
> > Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> > Assisted-by: Antigravity:Gemini [tools]
> > Signed-off-by: leixiang <leixiang@kylinos.cn>
> 
> We need a full name here, not just an email alias.

Hi Greg,

Thanks for pointing that out. I have updated my name and will send a v2 patch shortly.

Best regards,
Xiang Lei
