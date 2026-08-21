Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91B42E43E;
	Fri, 21 Aug 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330562; cv=none; b=kHT9HDboqRwZlz+l4QSb6Wk+Q8vfTCOSmX/vc3wrQVpsqQBd0GoYeIkSeli5yvg9IE45E1HDHEM7ZoBrvLzKebahbW96kByAofmSGOWJBDs14lboSNzx8PyveVBxcz1UZyKGMEjRPjUAk9iGuRL5E/XITRNpEdQKsSUM+5l4akQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330562; c=relaxed/simple;
	bh=dEYjYTHnZ3nvTVMVhjxUBAlkXruEKvkyFiw4KoYV1K4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NQ0I/6GY+jxyolVSDQEFQHzzLnUR3xzJYPSkXjEEwarGqxkWgn/XM8ui8uR60N9mfH7q03GOynpayW8a41lMkL8OTS475nMHtmjue190navSBJatc3xyax2ZJkH+lUAxAa1BuYh3mKOh74aO6gadCiFuz/u/Sx+cBoXxD36I0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLVwgJ6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLVwgJ6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667F51F01558;
	Fri, 21 Aug 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787330560;
	bh=+KMV7bp0Qmyuzak5vOlwAPPaxnv4/oTolCg/yrscfHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=KLVwgJ6DceWmekouwTxRerRxnH29oYkGjPsdSymjYlRcoeFdVjLjofbvM6cnxw5U8
	 UkMQmMGkHP7qCaBS2zamCsP7IQ6JgCcxsuMYWlKu6hGRnMA7DL63uk0QlzQVlnUh5W
	 QSaQSTMG6Ecc0slI3ISB3RZgaEowgdXtjhv7dW7RV506ooXMh79aqw0atrl5FculXR
	 ne53kEpuCKwbk0IslVvr38wNfHS+qrRZzG6zMdO9IKacsHym60ZskbQWRYTQjVpfCl
	 rbLrZqd1XfBfS8hb8jdBq0BLMkenhMwITOl4G2GzokMdXUjmchQztbafsK5k2whIjx
	 z5JlekrELBUNA==
Date: Fri, 21 Aug 2026 11:42:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Message-ID: <20260821164239.GA975848@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY4KGiDs3CGYs22aGF0H2LZEzD6Vkjf-yAjr+xTkpZQrmg@mail.gmail.com>

On Fri, Aug 21, 2026 at 07:16:32AM +0530, Deepanshu Kartikey wrote:
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
> 
> Gentle Reminder. Please let me know the status of this patch

We're in the middle of the merge window, so won't be adding new
material until after v7.3-rc1 (probably Aug 31).
