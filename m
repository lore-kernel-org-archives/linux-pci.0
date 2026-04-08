Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EC238178;
	Wed,  8 Apr 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646008; cv=none; b=tuAlrVWFmIZP8yfe73a/f1UvcprDjc7Ga2+Iz96xiKYUY/7mls/7x2MpIcPzUyrXlCBqYRWbvNBgI+DXohJzzbPR2bqLlZdt3DlXcjB0cgH3Viox88cRO3aSDZSmXPSCOXsLm39leUkS5bImqA8H6Nmys8Xy19bua1478DhS+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646008; c=relaxed/simple;
	bh=NjekC4PWv9Avo4VfEthLxytugfCCYDLjBrPkrO6jh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7eSeHa8pemd0bQC3jmJQtI5R4FBwk65ZGIRBepQUQcSAgKKyergdof0RLV7Vmac0HRhVY0DAwQOhsi4OeXgpa5ER9ALlcnrBdfQneHCwuM4ehpjVs6IvDmMjZjvKKn6aqx9IQv+Q5XEPSixL/N4Wm1KmASwQHfFmEw52VHYj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 6C2BCC19;
	Wed, 08 Apr 2026 12:59:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4004360E3C76; Wed,  8 Apr 2026 12:59:59 +0200 (CEST)
Date: Wed, 8 Apr 2026 12:59:59 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	manivannan.sadhasivam@oss.qualcomm.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Fix NULL pointer access in
 pci_store_saved_state()
Message-ID: <adY1L6R88SLtpZzN@wunner.de>
References: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
 <20260404-fix_pci_access-v1-2-416f32c6f7ec@oss.qualcomm.com>
 <adIXJvrV1VRunFOu@wunner.de>
 <89dda312-92ff-4957-bf67-dd0b60f681b8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89dda312-92ff-4957-bf67-dd0b60f681b8@oss.qualcomm.com>

On Wed, Apr 08, 2026 at 03:16:28PM +0530, Krishna Chaitanya Chundru wrote:
> On 4/5/2026 1:32 PM, Lukas Wunner wrote:
> > On Sat, Apr 04, 2026 at 02:23:00PM +0530, Krishna Chaitanya Chundru wrote:
> > No, please validate values read from config space with
> > PCI_POSSIBLE_ERROR() before using them to access memory at
> > a location that may be out-of-bounds.  Or cache the size on
> > enumeration and avoid re-reading it upon pci_save_state().
> 
> pci_save_state() has many config reading having check for each read
> is not ideal way

The ask is not to guard every config space read with a check,
but only ones which are used to calculate the offset into a
memory allocation.  We only need to prevent out-of-bounds
memory accesses.  We do not need to prevent saving "all ones".

Thanks,

Lukas
