Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33E3BB135;
	Mon, 17 Aug 2026 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997934; cv=none; b=pDTq5gDIb9nqE0bEKuhsJIzHjG0AxP8kuJw6r4ZkZKlmBhNSNRm3jFZrUPcZrte1TzIh6fh2y4iDuYn+SYIV011xNzD9dp1BLIuRveOBWPd558N/LIzSNJyGo7iM7hQMzJpt+gZx/aTGOAEbCZVmZamO/JOK8AoqNyBfmUR9Pe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997934; c=relaxed/simple;
	bh=cdef0KUa/zkxbOCmirwq4B/W3fBFZv6fH737DhclMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhyrhYqB1+5UII14bNWdCV+VDZiV0k//1eYd9E8ATDGD3yT/O7ddfHz/7TsSCDave2rDttTSRWfENIjBsYIJWn50UGxKN2khWrhhdWpNfEBBxFcZI2DRSeopilHFbxFus5ng3Z1sSG4Nii9ql4SJDVDpNmK0ZNlD07Q9Cu1+kkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tal01Z5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tal01Z5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0187D1F000E9;
	Mon, 17 Aug 2026 20:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786997933;
	bh=f6P90L2EB+g60dvhhfBN81/5nt5Odfd7+1fby0MBBDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tal01Z5MRC279b5XwQr+sF1+ndiX7igRFZMQFWosfJwpVdMiLcYZBRA3G6HMjZ+yh
	 wPDuIeRjZ2DnBI8vF7InU2HOOgEMptkVpsZHU64YrDvQu5tvGhN4DldMv2oE5YkJ48
	 0dG4aze1XekKF/4/Dh+L4YESA93YlJasU//oJ17kgHmNaDLKCfq+XlgOE28GE77Vc0
	 0qrfKWBiBfVE2jQQhmm3gtkKQ5DhJEVfkQqtPTaTDObaJuXg+r6Cz0fju+2/jeYq0c
	 lr0DKmCXz63fQPUqvSTfW4inoqm3noNGmZ6W3U5Vvwq3D1s0UisWmuyDTia0zonCZP
	 mh0VlQuBL0Xow==
Date: Mon, 17 Aug 2026 14:18:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Message-ID: <aoNsq7uGzLfdd2jW@kbusch-mbp>
References: <20260817195110.2077698-1-kbusch@meta.com>
 <20260817200404.BB3121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817200404.BB3121F000E9@smtp.kernel.org>

On Mon, Aug 17, 2026 at 08:04:04PM +0000, sashiko-bot@kernel.org wrote:
> > +pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev,
> > +					      pci_channel_state_t state)
> 
> [Severity: Critical]
> Does the extra pci_channel_state_t argument violate the slot_reset
> callback signature in struct pci_error_handlers?

Yeah, it does, and I messed up with a bad snapshot of the patch. I also
should have labeled this RFC as this isn't a serious suggestion at this
point. The entire vfio kernel-user space interaction for recoverying
from these conditions isn't there.
