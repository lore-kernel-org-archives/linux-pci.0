Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDA57EDB3;
	Wed, 23 Sep 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196934; cv=none; b=EuYUBedwRjMXhYQtE6GVliW6LaK77Anrxu6ORowr3dTf82OI2RmER1fqJf3TK5BETTQE7LsGAzcROblgJ/eqmUE6S3YNpOvKA39PfReGa0y1wZmJzfhH4s4zahLL6pAR8/8dRwRNniQXbIrkONDN8U7GgqpjDMOktBXMLoqAhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196934; c=relaxed/simple;
	bh=W/CP31dYcptPjaqWxjb1shHhgwb808r3ZczPOdKHUb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OorhtFH/bDyF6DBS1Rg0Ml43K2JkMG47a6BAclX8ZL6Gp9mj7KRYA2P+9UpOL+wEsPKQszn+i+qLZ8fitOznbbspJWJ2rK8APSkLFp9TohWHl2pFubXYVTwH8vOXgPnj6FL1nZLP2MeRtO2H9z5xY0XmmuczSMcHRf3AWHYQ4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLASo/qJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLASo/qJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C521F000FF;
	Wed, 23 Sep 2026 20:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790196919;
	bh=RWDiIZHXz4OWtcQyk7ljlDs0yaLnlXtGq0jqP5Xeia4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=XLASo/qJtXjF8XDJWuDOK6D0MDH4JHCThEx+nIegxAKTKyzY5AcBOojfJOmZtOJSe
	 F2hMnTc410QUXyx+ojyl3CHkahHncOlE9OVGq8yxwc+/IK0SnoPt169a9Yp8XsRVQ9
	 uqsHFDPQWMItATakBKKN4WhIcGDzO1gvqopr1aYblB74dPotRRaGzZKwkeTgGDLquB
	 h8DXOataDDiPFIikvjPRfLndmB1TAaZ3HQaCL7oy/caG+YveB4VfonsJnHFvRtnfKM
	 MjAHSLXmOkYpyG9sr6O6guhRqV9CspF7V0b/Q1RujNMiW+9uOCfTWGGIOpcIBPQl/N
	 AL0hcni8+NsXg==
Date: Wed, 23 Sep 2026 15:55:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Message-ID: <20260923205518.GA1941939@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY7008e4JA35T2wE8TnJnR_r82RCpfSd=aLBmDh5xAQ02A@mail.gmail.com>

On Wed, Sep 23, 2026 at 09:05:15AM +0530, Deepanshu Kartikey wrote:
> On Sun, Aug 9, 2026 at 10:29 AM Deepanshu Kartikey
> <kartikey406@gmail.com> wrote:
> >
> > pci_resource_io() validates that off+count stays within the BAR's
> > range but never checks that the resulting port is aligned to the
> > access size. A pwrite64()/pread64() on a resourceN file with an odd
> > offset and count=2 or count=4 reaches outw()/outl() with a misaligned
> > address. On arm64 this becomes a store/load to a Device-memory
> > mapping (PCI_IOBASE + port), which architecturally requires natural
> > alignment, causing an alignment fault and kernel oops.
> >
> > Reject misaligned accesses before they reach the low-level accessor.
> >
> > Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
> > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5ec0b245a69b..72f0404a34e9 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1175,6 +1175,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
> >         if (port + count - 1 > pci_resource_end(pdev, bar))
> >                 return -EINVAL;
> >
> > +       if (!IS_ALIGNED(port, count))
> > +               return -EINVAL;
> > +
> >         switch (count) {
> >         case 1:
> >                 if (write)
> > --
> > 2.43.0
> >
> Please let me know the status of this patch.

What do you think of the sashiko comments:
https://lore.kernel.org/all/20260809051652.36BA31F000E9@smtp.kernel.org?
