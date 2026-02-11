Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF924AEE2;
	Wed, 11 Feb 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795456; cv=none; b=gfsfIFY+yfOpoyl5OhyqNxQAWd+ycJ1oscv/R6PtcVfvpdXPt6d0gEY//3aDbaFbs36+NvEZgLBiafvNJDFOmpJfsVlxDWvIsdU+y83dzabG06QUy3RtFUQJ3M061R+0kU7raTxfI5t+KXeu575P3wioATtaPVMlzAkuV0PWBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795456; c=relaxed/simple;
	bh=boz5zmopdv8v7Osoc5rQX42KCmOBWIYFY2AF5qVy4CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebvp7AOKpPJX+Zqa0eD2kH6YlVZZR80PI8gv9z1ZgeebkulrPhoilcCvhHtQ/aRvWA7liKCyTufJoWy12niTc6FQP6vrdYXyCH+bjmwR1sgOvWnrrIkclB79/AUceEn03gQt4l/dictWj3Z0XRw3OEdtB0oNjQ0Atkw5KOGxsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oNRyjsvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faWtmvce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNRyjsvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faWtmvce"
Date: Wed, 11 Feb 2026 08:37:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770795453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+84hggVUCa/k6XVBCkVyTeANdeVxfQ9yn3EvsWf9NVI=;
	b=oNRyjsvuFrLZjv0s1cZqjdf2eaVi6TMxG2BRR5WkLnCxzz8/9e8aZuMxTsyUCzxNOVm5Zk
	s//MQxiIId1jIw98WGyIo013G34ktIhXMvsrnVe9kgQL6yxqKFgbVmePZFbMq1Dpy/V+vN
	lpMKw4XVH+mWSlq+0FXmdX8brBdCsHFmLSxZjy4sLrHLhLpflTsqcjGQKQ+jdTDF4YfOMq
	sACS3aJuwvrby7U04oGkodsotveQDdHc95UkKtupbvy2999cW46UNMfCX2zzJj0FnzDqlo
	mFDM/Aqodg4+LqsRKAjD77mcbc01rYuwYVwCNVPypZV76oW2nq+h4hzuBdqm8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770795453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+84hggVUCa/k6XVBCkVyTeANdeVxfQ9yn3EvsWf9NVI=;
	b=faWtmvceQpNC8U/NJZy3gO96I+H+Xl7v3pgkcqBiGg7Dn8wgvLkzbD3Eh7+yKwU5kuSLqr
	07Ktteei//PqQmBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH] PCI/IOV: Fix recursive locking deadlock on
 pci_rescan_remove_lock
Message-ID: <20260211073732.DN2yupeZ@linutronix.de>
References: <20260209075706.16367-2-ionut.nechita@windriver.com>
 <20260209082553.1pnF4lr0@linutronix.de>
 <2b6a844619892ecaa11031705808667e0886d8b2.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b6a844619892ecaa11031705808667e0886d8b2.camel@linux.ibm.com>

On 2026-02-09 11:12:36 [+0100], Niklas Schnelle wrote:
> Agree, this looks related to the deadlock I later found with that
> commit and that lead to this revert+new fix that has now been queued
> for the v6.20/v7.00 here:
> 
> https://lore.kernel.org/linux-pci/20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com/

So this particular problem is solved then.

> That said I do find this approach interesting. Benjamin and I are
> actually still looking into a related problem with not taking the
> rescan/remove lock as part of vfio-pci tear down and there this
> approach could work better than just moving the locking up into the
> sysfs handler. So far we haven't found a good place to take the lock in
> that path that doesn't suffer from the recursive locking in other
> paths. On the other hand conditionally taking a mutex is always a
> little ugly in my opinion.

If you could split the calling chain and have one side "I need the lock"
and the other one "I don't need the lock" that would be nicer than this.

> Thanks,
> Niklas

Sebastian
