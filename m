Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480536C0C3;
	Fri, 30 Jan 2026 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774365; cv=none; b=rU/htftN/BeEcdmPFvtRvgsZ03Kj+bfDQ2SAFhLDWLcKSaKF1nATIKB6aAWGjsReY0O68jrnBwFZEVBYecfQWMWAEbF+XKufW6WO5cDILfsRn7UPm9J2VGV7XOiArjz15PGHB1hCGiOQzxA9qfmxX0scIDp1YR7dUf1TWJ36rVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774365; c=relaxed/simple;
	bh=mv//+LQHpYnTql/DlwE7POaf3nMf3WtCG43uuVdRW3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPgnBRxd0kilmKvV2NsRlst8pnP3NtIiaLUVDSOgGtbgXqm3BDcQ4BhOYdXsOAU6Z24h+HueptboIEtGPXT46DlnIc5HfmHLEfcqlpSPqZ+FDVmtE6gyM4kkk0sBToLqEHzLWkYChNCYaCfYHfEk2sSt2Upjffz7e4sy8Pq+0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 85CA72007FB1;
	Fri, 30 Jan 2026 12:59:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 75DB71BDD9; Fri, 30 Jan 2026 12:59:14 +0100 (CET)
Date: Fri, 30 Jan 2026 12:59:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, mahesh@linux.ibm.com,
	oohall@gmail.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH] PCI: dpc: Increase pciehp waiting time for DPC recovery
Message-ID: <aXydEn_lAbNROQKy@wunner.de>
References: <20260123202140.GA84703@bhelgaas>
 <3af9f754-d282-485c-a3f2-49a230bfe143@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af9f754-d282-485c-a3f2-49a230bfe143@zhaoxin.com>

On Wed, Jan 28, 2026 at 06:07:51PM +0800, LeoLiu-oc wrote:
> Without this patch, PCIE devices may not be usable and could even cause
> more serious errors, such as a kernel panic. For example, the following
> log is encountered in hardware testing:
> 
> list_del corruption, ffff8881418b79e8->next is LIST_POISON1
> (dead000000000100)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:56!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> ...
> Kernel panic - not syncing: Fatal exception

This should not happen.  Which kernel version are you using?

There used to be a use-after-free on concurrent DPC and hot-removal.
It was fixed by 11a1f4bc4736, which went into v6.11 and was subsequently
ported all the way back to v5.10-stable.

I suspect you may be using a kernel which lacks that fix.

Thanks,

Lukas
