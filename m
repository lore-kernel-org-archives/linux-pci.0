Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5E38C2D4
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317263; cv=none; b=RV5Ah+faL751EYHBeBf1p8Ysn+kXuWeB3zcL7lMxSjC4M5MJwA2d3InCVoLdZHH+oKEh3hYZ1GRdJcRKl+JMDGyPh/7a5IgpVvRBwwxVubOkGW4FmSjv0u7untyiQv4AkJOcgSDzOxWIh1+3vqk3wPyDS6Q7pmWHsDT9pNT63MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317263; c=relaxed/simple;
	bh=32n7+drnmjsHOwmKp37FgDZV8uI0SFCc7HoxHLrBYas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX3FxMR0M8haV9BMb2DanGkEZFh+snHBIWD2/vFIR5eFYaa+LfnzZa4ant9492PznirfezqhX9+Ss3A9G+pWo1SookWouNGh08VDmIvbNGqBETiACNT4acN8roLoqmIuzxcp/HiAnPWNS94APIaGfcuKtpMz5ixw2ZXFGxRqLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=SYU85b/0; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SYU85b/0"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e533aacf2so278277185a.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784317261; x=1784922061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc8aVZtebMWgQf9o/5yCOKG8fzMb7f5xhxINPxPhrtE=;
        b=SYU85b/0hzlz/OKGO4pCzU02jnBe1KGkcOFsOnWdfyxyZap/FbP3jyHpBH/92Bcai2
         4EzZyVOJXkObOybtS9A/t4U+HruzT4EM8cj7nbNh+e3fcQS/oy5S8h/IL//Q2neK+go4
         yISiZ+qMo+JUiY3CEBdcL/7wG4Trr4i12lTDbGnJVb7nN4JoawGXQZ4ouUIDgpupI0+M
         Cc2262GzbBGHjahFmLSm0gfnp5R87zpzcs3xNBBxjiefS0iV2JDkOXmMA6cgx4iFs/zI
         MAD/v4UNm+m+6iy3zFnFPsxw/p5r0saeR3j8Qs2DwXrsB1Lar2KyhZ3wHckeciqvQxI8
         +RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317261; x=1784922061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc8aVZtebMWgQf9o/5yCOKG8fzMb7f5xhxINPxPhrtE=;
        b=Xt4Fa5OGzX5pQAA2fuNHF42rSgi7P/Lasj38dD+avf4mHqJ0+xpXfya1QjDYmiat2t
         vLNVskPuOyT/0W1QfDMQreaSzJplW7lZHcAidLZirUdyLSDL4P7bJMzdx1bAzKDM0g3Z
         QvAYxvf+NxoZRsAUcW1MAq6nXDEsiIjID5Zil1UGgNkDYbNP1w9B8Zxa39PryPxm5n2q
         3ahDrD6eiKz+vY3AzMEcnHWGuEE00f+sLnFppIf0AFWo2xnnegMQMpgwRxV3GEQhNH+5
         OLZfhtBwdqHPz+VaZq1fSkAWRXmdPk21GkmN+Y5m0rk4gsJdtjCkY+XD6c64RIw7eRw/
         LoYw==
X-Forwarded-Encrypted: i=1; AHgh+RqZRJFL5C3/xbki/4HtIasPvyPDe/TXOHERO+FOq3hLPLNq2faMyuAH8wly3wp99Jx6z5/c20Sif7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZ/EVR2ko0hxiw9aoiHskBsidlBPgxzkwTD4UI01OLZ1gWLyx
	h2AjRSOTKxm9UqZ3L28zmXLUWalzSlQQYczDigW0/D+ilGG5zUEmTEe5d/7QAq+v5rg=
X-Gm-Gg: AfdE7cmiN/bV27vYd+W80zQ0Rl8JzOaQ6bpqzriF2rrGyOgdINDu1qarCNKwMjqCjao
	Krtx0osOk9jSC6UJv+yjbRB+T+Lvd7hSMld+3+p2rCxwMV62XjT+Dpu/Thd5ng6Igh3PKAe+Fyo
	7ADrKrTRptkOIqaOuh6/9Y8VfXMt0o7DOTPCMKmbLdmIq+CVdWbTylPsVDC00S1EwpI3270S1aq
	DwbaE3Pe+6JbdEJz8Qso8ccJswA6LpHbYBFFT+yEs9KBoxNiEJLJpCx3OAG99YAYygS1hswtLU8
	FWzkPvI3yKh2mZUC1rcIACo9bW1fzL7IuZqLJLeWB0VW2wtBZHXL5PjabBmhDmqsiExrJgnFjMs
	gsU81eUX0rX0F9mCqIEaEfox+cxVQ0avr8NMuepI+wxvlgD19eAGfOkEHoYyUnhUGtqA0XmIxij
	HK6bKUyBJuiGtUwuU5lE41kfmVyJOA0w==
X-Received: by 2002:a05:620a:a197:20b0:92e:c116:bef7 with SMTP id af79cd13be357-930b4315f1cmr311099685a.84.1784317260004;
        Fri, 17 Jul 2026 12:41:00 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dff03sm230279385a.9.2026.07.17.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:40:59 -0700 (PDT)
Date: Fri, 17 Jul 2026 19:40:58 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <alqE_-OR-rB15Crx@plex>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
 <178431652443.189683.17611165218179620081.b4-review@b4>
 <20260717193055.GD699082@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717193055.GD699082@nvidia.com>

On 07-17 16:30, Jason Gunthorpe wrote:
> On Fri, Jul 17, 2026 at 07:28:44PM +0000, Pasha Tatashin wrote:
> > On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > new file mode 100644
> > > index 000000000000..899758883dd5
> > > --- /dev/null
> > > +++ b/drivers/pci/liveupdate.c
> > > @@ -0,0 +1,155 @@
> > > [ ... skip 50 lines ... ]
> > > +#include <linux/slab.h>
> > > +
> > > +/**
> > > + * struct pci_flb_outgoing - Outgoing PCI FLB object
> > > + * @ser: Pointer to the preserved struct pci_ser.
> > > + * @block_set: The KHO block set holding the outgoing devices.
> > 
> > AFAIK, these should be aligned after column:
> > @ser:       Pointer to ...
> > @block_set: The KHO block ...
> 
> Gosh I hope not, I never do that. The horizontal alignment is such a
> PITA to maintain.

Agreed. I just see that everywhere, so I thought it was the rule. If 
not, that is great; I hate them myself.

> 
> Jason
