Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059D320CD1
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858112; cv=pass; b=F+3a+TyBfN0lYnvdLdnczsSonD4BJLkQ5/zOJ+ilUJBBOx2lwFos3EESAuztLSBfp84f+V7WLxoVEg5+sQ+rl3zR7Fl23pIZv1ztnbFxlxvt9/7hgxOILDLGrgoXyIXZwXKJ6Ez3ko2gFd3eF7MXHn0PnM/OHb40ySdr8tFJZxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858112; c=relaxed/simple;
	bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V70R7dBUOpUwcST7PsBKSsT3oJfJWhp6WDRPN2zrbE0+LlV+bqfHjN6GZwvpA+rKVox4GXW9oW8472RDbvDwKqoEMk2fWXtGznxFavYTz5SdMV+VOu2NwyNlyrXS52tZ9kNavi3lr33aX28FTBFwA4KaWGBS7jDkjqm3byuR3w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9WuzwHb; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9WuzwHb"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-139f1dfc9faso5304272c88.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782858111; cv=none;
        d=google.com; s=arc-20260327;
        b=mLAImm/m8pKObStQ2UbX4/zM9V+awwhR0j49CWCtkyu8naa2Mqgx6FVq6WngGnHT69
         2Jn2p4zO6IZBfgffjYTFL2qesiW0Fpy7tfW9Y0WGlKyjh8BECtbTxWEP/DxaFV4H7D6r
         kA8B8IueL3D7vIfIVHC6ko//iyVj18ivRv+TcWg3hHptkDP0dDbU9o3XBcQboPjbnlOu
         Yzx9kXdwgG0yj3CL551bulH0F1ZW58Fy/Az/9yuu+tDAgR1uhdmy61TXbBnfArjjM4UN
         JwLf6i/rvb/MiqZE1BqMUabfCQnPuOXqmCXsc81GMySzPFHz+ANBzDbubO1t9tCOOhN5
         zoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
        fh=+U7WjubhWTXOEO6OeXQXX7sOx1nmMhEhZOOTUy9ooGw=;
        b=gx3E4L4xnYGaibUmv8JbFj3iWeqjmSs67uUfMj7mPbQdSMlrsgKNGGXNDU4mOTZiRA
         a5wl0zywvLxABoMW2hV5YJqqqj3zQGMe+SCV/YTBBtS7aw5hN9G12efAm5+LPQtWC/0u
         nwCXUnT/0tJZ98bhwMxlriUg1Pv+ucVx/UMJ2tuqWPUYOSEdedpEPFEFYGJa+n7vR1x8
         e4tVLfCH5Gecbf1K+jrsJmdR1OmokuQ802/OPsOESQApmOaXeJN3pKbzmWryqdC6B7kR
         Tp5Hju2ztHpTsNUj0DePH0O0WSxHpzp/msYjw4ucY5sC23KVuR76bS4+VJFe1JEfI0qS
         kPcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858111; x=1783462911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
        b=B9WuzwHbaigQyM1oU0Z7GSraufv3HeZOr/QIAwzQkrrT3V5/MUv1/kl/SB9w2vG347
         /L+sF5wU1VT+LS1ZmXHhVAjX5/KkN1qwDKIlNhSsPg0vz6uwEWIWeJ8dr+xm6tvIqpcO
         L142kxDDlLQ3g9eMCRDgEzU+FJgyXK+vEcpF9P5/SGuNqY85f3JULLbCTGpEEavIWo+o
         v7ovR2UdNNmPWdFjy5YbzwG3Qh1EC6hJ3+vkhqWRosXL5ST6ZbTPfoYY0C2WYMH6aw7C
         VU44FFbeUKUFVxsLpHba80xb1FgZwqnTruJE8YDLo7ytL1duo0jBDKOPc6wYx7ycUF0l
         9rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858111; x=1783462911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DR0tH2IO3fN80hPp68tJnACbZx0ZviQ8SFdx1MtberI=;
        b=TXASL0v8bY6D6tZzFclSE5/O/LTfaotMaJMz6ikGcKXTk7AjhExCkwOHf5MV/twYzM
         WULn81eVAsnjlZKwMcSjFrqH9TTN2N61fEEmvTk2JthGV1efatb3023lSElI2ZOW66t6
         dBZl1AIg5qNS5Xe7AlqpiMcjn4Xp1JuTr5GGnwKNJPg692RrQSbz1Gi0ioFh2Zz7ZRmw
         4wYn+6np6kCIUB1G/75Ec6adnOR2e+51MBKa0hSRklS9vEuXSLFM6LF1uuM5+blm9e6/
         e7O+NlJ7Tk3WkQXMENJKCl3JPs6cetvmBnrdiejsNHYfYqMRzwyirC2OZ47z6ya/9LAp
         FjfA==
X-Forwarded-Encrypted: i=1; AFNElJ/72u4FxfMt7CJbqHdDbBN0kW28o8P3nz2lvpsAsBhAvyaKstF+FFJH+2R3QKYfWyq6zHsgflMIAAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmxj0T3EjQ41UZ9pIH0s5//AvT6X0GS6AGfHUPHel4JQAAjfgy
	K9Dpy0Mhj08W36NQio3MOpxeQgp5KtK8zqhfal595YZCp1lDKt4Q7o6cYNuABhsoPo/HibRq5cc
	prvh4YQJeCpqSyvy8+dmLxu0zwG81T9XuW5NtDR+9
X-Gm-Gg: AfdE7cn6PrZM0LpWo97ViNcF0EbYo60+2ussIwEBI3gpgUqrH989ZAfpyWvfe0yQamF
	d0wM4Bj9N4QTJ+1dmDFVanZPqzWSK7O1xVrTtDNjz+k9/OgFij2CYpTeI06g9W76l/Bvx0z6ajK
	mFVXl6KGQr/9UdpmPgWAewU7roWR81NiHMfXfOD+HHAfng/CHOXMof5fNPw6ZfpQxqvDF27ipu/
	qozQPmuwd/eTJloFUZJoS4Y3K8Y2X9GFYYuDVwnlavj4Gn7MVdZSg1K5+8diD0y++bml6hD
X-Received: by 2002:a05:7022:923:b0:139:ed5d:5c9f with SMTP id
 a92af1059eb24-13b2a1c08bamr3407677c88.40.1782858109859; Tue, 30 Jun 2026
 15:21:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com> <aiaeOVomxQZhoM3K@google.com>
 <20260608181640.GO1962447@nvidia.com> <aigtS3UDdhUGp3m0@google.com> <aigyn66-xQ_9JBW6@google.com>
In-Reply-To: <aigyn66-xQ_9JBW6@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 30 Jun 2026 15:21:22 -0700
X-Gm-Features: AVVi8CdGaAQOsRR3GiQD5WoDqKgNzoVt-sa6rd2Hjmz3ldGohaSjMHvZ8NY85tg
Message-ID: <CALzav=d-JD6ZbUNEbRMQwnvOhCBJ3ruodr3wbHM=1WA++MCKCw@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 8:35=E2=80=AFAM Pranjal Shrivastava <praan@google.co=
m> wrote:
>
> On Tue, Jun 09, 2026 at 03:12:11PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Jun 08, 2026 at 03:16:40PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jun 08, 2026 at 10:49:29AM +0000, Pranjal Shrivastava wrote:
> > >
> > > > My point was that a FW exploit can meddle with the bitfields of the
> > > > ACS_CTRL to spoof and mis-report the ACS flags.
> > >
> > > Devices can also ignore the ACS flags. I don't think this is an area
> > > where we should be worrying about devices being actively hostile.
> >
> > I'm wondering what happens if we preserve IOMMU groups across a kexec,
> > but a switch's ACS capability is dropped or the ACS_RR bit gets cleared=
?
> > The incoming kernel assumes that it's the same ACS cap from the old one
> >
> > Now, the incoming kernel restores the groups assuming they're still
> > isolated, but the hardware no longer enforces it, silently allowing DMA=
s
> > & breaking isolation?
>
> Again, to clarify, I'm aware that we aren't preserving IOMMU groups,
> the incoming kernel has to rebuild the groups. My concern is that if the
> ACS_RR bit is cleared during the kexec window, the produced grouping woul=
d
> be different than the old kernel. What happens if two devices on the
> same bridge were assigned to 2 different VMs?

In this patch the kernel reads PCI_ACS_CTRL after kexec to determine
the bridge's state and uses that information going forward. We don't
assume that if ACS_RR was set on the previous kernel then it is still
set now.

So if ACS_RR were cleared during kexec somehow, the new kernel would
see that and place those devices into the same group. Someitme after
that (I'm a little fuzzy on the iommufd restore path during Live
Update) the kernel would try and fail to restore the 2 devices into
separate domains because they are in the same group and thus the 2
different VMs would fail to come up.

Of course maybe ACS_RR can somehow get cleared after the kernel reads
it, but at that point the issue has nothing to do with Live Update.

So that's what would happen if ACS_RR ever got cleared during kexec
and seems reasonable to me?
