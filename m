Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23140F8E6
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659956; cv=pass; b=Z2GMxNrUngf9qbT1GTJK1KcOTwLGWl0+GxSnfEJ8hiaUJyIDQP4CQHFE7e8y23b28pOTnlRy5ol3hLidAqSy3MdWBP55U8KdUffMf0UlO13NtB+UcJKOATHkuQC4UryvjnUwLRtiaa49kwSQYWlX3spEBnOexolj2MbosYFS128=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659956; c=relaxed/simple;
	bh=7glQpGGcTAa1D+c5BdpA3vyeZj9yXvwRLKoRKqlblRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzr7kERzpezGHOrY8o+GbC6oQl7nSAeWOan8h4uyKM/RZGP5zVXI3pQdmYcNf1a8xTFg0umd+2AJ8j0px+NWhE8AwSnjUQSuypPcdqmiz7lddDJaVp/7T27cQN+jAtgqBgzQU+CisRci1+eU0perqDBFMjdW5HKcpaxZPRWoSAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0zg40tJ; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0zg40tJ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c726ef332so3485905c88.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 11:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659954; cv=none;
        d=google.com; s=arc-20240605;
        b=KoAGNkTJclSBgxYGdXcYaOABDk2/1fpQKZ0KLcKYGnIuvdKVfbvxJghPZxm1yzXLUH
         Ee4OCk26nKDWWUEZxYmk0LBHecfZlfjICzga3BgWiMvx5jmo+jvLO6WxYrkhPzrY6wwR
         TcaXw85ktL75ECMsjOQNdLK7sZ4JJ+x8AP3F9Q+b9/5/BVCdxwbvCKjlIiSBHBPZrQgm
         RkSlmxoB2Zobt/zNg1JNdmGI6xbvdm2FSLnMgRU7hVV+9zraNceqwswXEM2xJ3Tn63EN
         oBS1YUwiJ8B6lmxxyPjNu23uKwBZJMcPeo0QhXE6VqdKGdWiZzvCHu40To1YKtOMGe1b
         mrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        fh=oLc8cY1WZkNDR0TDd0c7jzJ6nNe/J5amqCf0E+6d4Ug=;
        b=fBbcizsR8CbJAqwYUMntGfaeIOk4bUPBMQCpqWldiUQaP5tB8hYtE74ycAULgwi6YY
         T3XVwN9HRedDs9Vh7jiJhVYep7eoFDcW4WaIZ7PjFS6WNX4wfBMJxi17m/dgtwW4qchb
         Qmj2kQAMWLyGXKV7bSxn5DmdhNqhbPSS6e8LzZApW6MPKq5k2Dsxlp0c2+jOvlSusKkZ
         oooV7pH4aF9fCS8UCyy7DxAmVRgUgAot2W4r4wcyVwK1Qn395oH87b/tXJQIQ9dEvGXc
         bnpKZXv3ITjaF2Ki4yrvcW/J54oNZyTKGNg2ezb8lUr/rXQ12N1ucr3TV+kBlEctTams
         A+cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659954; x=1778264754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        b=Y0zg40tJ/dsI8QnrMT7KX1AP+6jlCpkUHhzn14Y0wrdVewWfc2FexT/2tqeHzFTcvm
         n0m8mUpcPImgPDeczA0UMLqt35VbfItet35/zS2F1XahoNO2IKCsxz4dvplyXekT0HHt
         42hx6GQlfDXv0e5d2vUwNu7MVV8qkPjf2Crm9UdCLYV2jGcast1plervurVM1l1LHADg
         XAPV/43Iyu4bYUOniL21VvTvfcpvpUbmrdcqssm9yXVP3wrApyi460jZ5mEoPFcugvFE
         GBfrpcBfD605DSTERUlo/0yO5mEaPOvABlq9zVsfvH1CoVuEj8S/R4pLMuJ9iGZ1sSza
         g4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659954; x=1778264754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ynp4A/JaH22lvkihT3nPFtsXKnzutYHpfXYULBKQQKo=;
        b=m5OxmzQjwRkKSfS7NuknPSFGmbd6BtjWgO81jGi4bL1zXvO3jdxU+VXURGzEXRWWa+
         fSzdiqVY+jHxCeA70BFyqixy+V6XfyO/9u1sZSltXVsR8IWXUtFMSSlitnaz5+ZWXj7v
         LeVx4sAB/DVa54QatWo4MzTlyFZYookO0Nj8XFRYgyO2mPWjICsoNHfiuB6hA9Y9FQmh
         TZLGrX3wjVqFi1SblXRy7AEgw5edDBGqxl6Js7D2xn4COBTExD4b5LahXeZhH0vCrKve
         7q+yYHTk2mMXoYD7clrog0QW+XVmLB6y79BmfgkZ8WdJaC8+ETnNq8ITU3Eeh2o7nDcB
         VCww==
X-Forwarded-Encrypted: i=1; AFNElJ9nIETjfAEof2Hh8QlBgpbeNtpgRebgihZqVnHESX6xFm/S5wuSv4VXOKtvUhY3tuyDeLiBoFpt1ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF14H9Ck23XW3RpPmD3E2AxvBu0on4ghvvSMyIoCmzzw2h6/cY
	j5pEE1ia+vMn+VJfEksH9KJkiyIZ75w3FwFIUYbLIVpybgMAdVsWGJCQV1wPC6wUpCz6HfduwwQ
	4J2bwMWXufjNM4CUhkzbASAyLdy7EviAlBUrlgLU4
X-Gm-Gg: AeBDievMt77oiQJW0AGjhUxzNz+RwZzCBA4GRBR4OUNaQAdT9nYITwY+28HOPqis6Gl
	BlBFQVW0PWik4Kf6c4BYrGN783Evtb6Lv5Qoh5Z3zj++gs53ySUtvlOlblxTqZt2wusFMxRprsc
	iLtd3FZplVGKBSrd7toNN7ZDyi5aX6qnnHGwjqwZrDQPVJAzcJdcNwrZe6fNWJRywQ+EYota4oQ
	8aow36ReTgqld3RuS2vhHGoE4QIVNyx9gOvAOf7WpzoXWrgayZ9QxG2ylZhr0af5ekG0J5W7lkA
	zAaa8EE7KR3Y7Yho3Q2jmNTyx5hbAg==
X-Received: by 2002:a05:7022:ebcc:b0:12b:ec15:69d3 with SMTP id
 a92af1059eb24-12dfd7d88femr150449c88.19.1777659953185; Fri, 01 May 2026
 11:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com> <afPGYp145FbrvURR@google.com> <afTgOXpUNWMapPAS@google.com>
In-Reply-To: <afTgOXpUNWMapPAS@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 11:25:26 -0700
X-Gm-Features: AVHnY4LHOeLRxPaffc9oaSUdxPiYe323BsN3VXy59mO0tVvOtZ5BkXLT2WRxf9Q
Message-ID: <CALzav=cJLA3-gK=Ljfqf=YCPML60F=hM_teB67M_3PNCZE4T9w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 11:17=E2=80=AFAM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Thu, Apr 30, 2026 at 09:15:14PM +0000, David Matlack wrote:
> >On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
> >> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> >
> >> > +  for (i =3D 0; i < ser->max_nr_devices; i++) {
> >> > +          /*
> >> > +           * Start searching at index ser->nr_devices. This should =
result
> >> > +           * in a constant time search under expected conditions (d=
evices
> >> > +           * are not getting unpreserved).
> >> > +           */
> >> > +          int index =3D (ser->nr_devices + i) % ser->max_nr_devices=
;
> >> > +          struct pci_dev_ser *dev_ser =3D &ser->devices[index];
> >>
> >> nit: Maybe we can move this logic in a separate function as down the r=
oad
> >> when we expand this to add VFs and Hotpluggable devices, this might
> >> change significantly? It's good if it is self-contained.
> >
> >Did you mean to leave this comment on pci_flb_preserve() where it
> >decides how many devices to allocate room for?
>
> I was talking about this one, as I think depending on the scheme we take
> this might change significantly. Just a nit, you can ignore it.

It would depend on if userspace is doing a lot of unpreserving as
well... I'll see what I can do in v5.

> >
> >> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pc=
i_dev *dev)
> >> > +{
> >> > +  return dev->liveupdate_outgoing;
> >> > +}
> >>
> >> Is this expected to be called under the outgoing lock?
> >
> >For now this API is only used during shutdown, at which point userspace
> >should have already been stopped so drivers should not be changing the
> >preservation status of an outgoing device. So I don't think this needs
> >to be under the outgoing lock, but it would be nice to have some more
> >explicit synchronization.
>
> Ok that makes sense. I have similar cases in my series, but maybe we can
> add kdoc regarding these stating in which context this is expected to be
> used?

Yes will do. I'll add some documentation and also restrict it to avoid
misuse (move to internal pci.h, return a bool instead of pointer, and
use READ_ONCE()).
