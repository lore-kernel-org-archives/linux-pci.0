Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD22D23A6;
	Tue,  3 Mar 2026 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566137; cv=none; b=YgC3Q3hqTcfOwmLmgAaLrNDnJW+IPdxe8eLBCwrjGkd+HDImDLLlU95/IVMmkIzlI7ypFkEwfWiAAQdLPF14UNlVA0RZernjt22Yk0Y1ChLiPXk15z0PVPOEHAyP4WfL0z83+3LhcjKZRgvrPeswsiso5qI6NBQ8ZhQNq5/x6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566137; c=relaxed/simple;
	bh=o1E/ObinjdE0YNzNWRx8jFUPrPNn5Xxr486T1nBj8N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYOBs+n+ZhvQKSXLTi/WoBoElOpBxIaffJc6BJUZhGAFtLOXq//v9Qpc7/zZ0/KvwjJVlfpm75EEvF0w0trY3V4fNh5nkLNZ+cfVysquzrIfqu1pl8pxVNh8nwwJlEgiFgPt7OGrcKFRD5mxmroetbHbJufG/eQrq2jhUDoUTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2949620208CA;
	Tue, 03 Mar 2026 20:28:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E88853F490; Tue,  3 Mar 2026 20:28:45 +0100 (CET)
Date: Tue, 3 Mar 2026 20:28:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org, sebott@linux.ibm.com,
	schnelle@linux.ibm.com, bblock@linux.ibm.com, alifm@linux.ibm.com,
	julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <aac2bUCCX3dZcwo0@wunner.de>
References: <20260303080903.28693-1-ionut.nechita@windriver.com>
 <20260303080903.28693-2-ionut.nechita@windriver.com>
 <aacmM9bAPstfDpgY@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacmM9bAPstfDpgY@wunner.de>

On Tue, Mar 03, 2026 at 07:19:31PM +0100, Lukas Wunner wrote:
> Also, I would put this in the existing pci_lock_rescan_remove(),
> i.e. without introducing a new _reentrant variant, because these
> deadlocks exist elsewhere.  They're known to happen on unplug in
> pciehp as well.

Actually, scratch this particular comment.  The deadlock in pciehp
is actually an AB-BA deadlock, not recursive acquisition.
