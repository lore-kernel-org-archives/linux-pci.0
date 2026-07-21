Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC173911CF;
	Tue, 21 Jul 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667609; cv=none; b=o/2WKzn7RVhMxIXJIrxV/klrQidLlg+/GzKKWxdi7IVHL5xUmghhWw4kAKkZdNmiGTj0fMAG01DgMVjeYmPoKQZuiiT2NpOHgOt6l5eoFZC/78Rhv6gUptZeKEnhIhrzK2zHjH3nM5TtZq8EcWaNbX8DxYoYBJiNOauKFjnzxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667609; c=relaxed/simple;
	bh=7EuNsmN0glXHc5iuPu+6uXwjrXoN5R87UXkbXi2faXI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIKE9f4j7PhyAQNcLrVJui+/EbMZkgfAmsEjq0dRXOseJn1IbtzCHChaRbA2HH0Hd8R/7sxqSWWdW9DORZQPTuzXwVJSubTmYvvRSLTosYtNKxn/kiOXkabFUfAeUW65E8JMFP19UD6Oc7WObjqXnwmc/4Yz9U68ukR86RqbboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0owwJyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0owwJyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54AA1F00A3A;
	Tue, 21 Jul 2026 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667608;
	bh=5U/QQQOWYBzApQkm1JASPniKTOmSJjGJW9W90lyYY4k=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=b0owwJyzAJX6nZhjsa/t1pJkdPje6SOAlRzX5uPRAAdPnDOYBZjfGagDiXc7x2kEk
	 l0T4FEVUTUN5lctFlOv57yA2S3O5hmJ5kvzDHPplGPh9MrWTMoW6g6nxL6E7MMZMzh
	 cTx2km7kjQjRuS2OxjVj+MJmBl7t2y8WGkG5wd0Tn5fgkzKafB2gJW+va1lQymQ+b+
	 jOG7po6p1xD84Mlcl/ckB2GDv/W7PgRNE8QGBOdG+7AiqPQjZE6daqZD3gx5szpUU+
	 wo8i370f2z92cgl+aam3MjU8lILMEcCt//4bVaS7NVL14UL3/hz+nDCUk8op/Cj/N8
	 /zGTVse5DDIUQ==
Date: Wed, 22 Jul 2026 06:00:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Linux PCI <linux-pci@vger.kernel.org>, 
	Linux IOMMU <iommu@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, =?utf-8?B?SsO2cmc=?= Roedel <joro@8bytes.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: The VFIO/IOMMU/PCI MC at LPC 2026
Message-ID: <20260721204559.GA3638633@rocinante>
References: <20260706123705.GB3821042@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706123705.GB3821042@rocinante>

Hello everyone!

A quick reminder...

[...]
> Two dates are worth keeping in mind:
> 
>   - 10th of July: submit a topic by this date to become eligible to
>     pre-register for the conference.
> 
>   - 7th of August, 23:59 UTC: the Call for Proposals closes.  This is the
>     final deadline, shared by all micro-conferences.

We are slowly approaching the two weeks mark before the deadline for the
Call for Proposals (CfP), which will close soon on August 7th.

Thus, if you have a talk in mind, then don't forget to submit your proposal
in time.  Also, don't hesitate even if you only have a draft, as refinements
and updates can be made later.

And, as usual, keep an eye on the main Linux Plumbers Conference web page
for more future announcements.  The conference page is at:

  https://lpc.events/

Thank you!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
