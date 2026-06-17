Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F03783B0
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734063; cv=pass; b=A7GkkxiwGiGP326BwXsoUutssZDIU0zKtmiLdeg3wnMk1aLrQQ98hjVU/vmh5Cw59RU1Uj4Po2LOktpdF3feiWhc1rj7xEgUtFAfnrDl4gETnp/UoRkbko8j6DUdYf73qXCdbbd6WOAhVteWDR/JATtu9cKC444yVB4C8qPDD+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734063; c=relaxed/simple;
	bh=dpAk0VAQdmltDmwyDqcpJc1YZ9ddSOslmAa2U6BjQvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2I/3UIkOvIDbf4FRw8C5RDYyIHIJhmHgiFpg4jfzIh869XTUlzCGnETR9eCeUUm3xyrNWgCzChZ5twvHizZ469q7D3tU931AjWegMTwbSJOG5WxGWRI2hP0u2OY/brU6eC21QFWNO3ZuoAHultVMoE9Kgtsbhx3xKp4mLkFB5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p47Xbk2q; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p47Xbk2q"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1390f75d8bbso685633c88.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 15:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781734061; cv=none;
        d=google.com; s=arc-20240605;
        b=KFM3H7LSqyWOn9+kjA8f+kkSKMc06hVO+FyI2OVK3flIlKjwZex5q3QWTtGGOAg5ne
         9/m3q8N5UAsnBCLgYSV85a72qPmnvNCVS7hqOifZSZNdAb2EWT57virbvl2CowaCF5PB
         1/gIkqpbJRLw2JqB8CYzozOK9xaztL2F4XVKQJ8uz2sgXSyitrXVM6nyJ/9hb5EEh9Ul
         qqvXQSZ2FqLUOZ+KkBCmWlbX9NmyPfESmiNGPUOSIvX5uU8D+3D4QG/M6xFmPWm6LorC
         rF4+YV5m31oAAmFaWOlYdmEXMnnf6m10xMowQ70dLb8og897SoYi7dW5pdv8Notckclx
         qRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=;
        fh=4KAah4FsWsFEIOtUEfYiR0E17vH4tOurz8Z4yO+HFeY=;
        b=T1Y2qW6bzOycdIf5MR8MVev2Kg8VN5eoxz26YGRBr//hj8Cb2ct1LMERDm6oDoZXbo
         uUkvkAO2iMBMWp81DrQyg+4XmOSRKtioiZpNBIpbmkjDIC+SAn7LVeSLDAxvNFvpOwYc
         fYFhz1KTpYPuRBTUiKHGUX+f7rBpnhR1InNbJURIu2eOmOxTOTQb/1G+LzR/8Xdhl22n
         +gr3IZb7fbjq9+VEyFd+EcsEHcITu1BJe3xfpFhGfFUrBux4LXzQ1UXi8cQVIZhTOHw1
         trLTpVe46GTFbcj9+54WTKYP6Emw7afsyicoLxQPhYYhdHPMa+F5mrBHqUL1yWZPaNnE
         JEbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781734061; x=1782338861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=;
        b=p47Xbk2qdEKP71XwL0AY+6LOQv9sWWMUSls9YNgeRkjHSjBa+v/g3QuF8NXjt2Lzc/
         VHNErdQLsBfOeznG7geRMkQma6OhvGGLF1pamPgBe+DsENdnZgDV95ycFiL/Ymm/CiUs
         Bqph4+Th0BZbydlVJ5laBjYkSDC5aCJxXPYtLYlUL4osq+RysnLVdV98Q0ZMRoJ9Ns5C
         js4V02JxSIXeItYEUABSJNtQTOQ2KXtU6wQhaEXxIeiUr+zyefSPfg7AZTRSjtH4ETCW
         XMxka1O87DCUSu+qJY9ZU5lgdhowAh8SJ15gDt01BhRa7k5h7yYyx4Ta8v1nNDND1Gyd
         BE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781734061; x=1782338861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dxvS3kwOW4bWC0xsZqNZINpijY+mWNOP8Io4oLdd84w=;
        b=rmVcrG/9hsh3r/BVAuPONMCIrIhFyio8CTkgKnCIWuDqpCK8tIIiK0cSoreJ2aPRoy
         aN6of/lP4ljGot3/lqf8ezYnE3S5rBbL2NvUGMwqFRAvDlhf5cqj5qltqpSHqx4RYIRv
         GuhPF1cKoh2fKDi/aY3npC7Dv9QjvAWWS12UusQD/H8XEfBxMPWXyY61Z7s2m1zS2hY6
         +PI1y1LymoR9L1hpgx+VQXl2mIrtoWucdx5HOOg5aqET24jzPM4ht2gj8B/kmne5y3j3
         l2Msfg8gLOYVYqY6hmCbzJIGXBDl4URnqGG5NRn24Q2wHVJ89JPAr0saMA6sKkmN+UOL
         XdIA==
X-Forwarded-Encrypted: i=1; AFNElJ+9GQVXBstF1tkOQPs7YUqYzZzUwio+V9bjV3exgCBzWaCGmaBSrcpzY4eybAPrybAXKjtELCV+Mlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPpbJyuv6jg0bNhieRUCzvkW+iyefSK5KdLLcYzlzXWoOJmY5
	YXmYFX2uNgKtZUspAuZnNqC+xwy0lHfUWlcI1rxQi7NlAQESjThYWRXkCV829dcNmsXP7/zjEgL
	vgYDvGt0Z74KvhMTa1CwbtYWUhWYHpM14OPXVnNI8
X-Gm-Gg: Acq92OGiZKRkmsLENhnc6QDDOsK8MjjuwiWvmGcktr1eegyLPtBfZIDeu2HS/3yS5WC
	+HTQ2q46aoWlLRwOiad6WXsPQjPw4+NQsESSduBSPxB7oghHqmrHqySjH6UUhKYewxgp89S/Q8E
	oEN7pitcu8AMFMOcJg9FS/WcohgB62NxzoYz0b1UiXRyuNiddLVGElDCc1FfGF4eDynOjQDigFY
	UmvzEGU3J9XCV2srjBcA3BBCufYVR+bcQdQzRx/VifiMDKJYQ6h8nClegyOibj9H2OYnY8/vG3Y
	U3pmUBU=
X-Received: by 2002:a05:7022:68a2:b0:130:6c8f:5a87 with SMTP id
 a92af1059eb24-1398f676be1mr2746710c88.13.1781734060068; Wed, 17 Jun 2026
 15:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-4-dmatlack@google.com>
 <178144432039.1257322.9644414453415904478.b4-review@b4> <ajBgj_aSuzMZG47e@google.com>
In-Reply-To: <ajBgj_aSuzMZG47e@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 17 Jun 2026 15:07:13 -0700
X-Gm-Features: AVVi8CfIvfIjd2Q6o3VPNKmTcz60wFd9tOmavE8DEafzVsI6S2ukw3P-Cv2hKdA
Message-ID: <CALzav=cGZs6sUcGFu854fTdH_rKTMBF0NK=+jKE-yE+N64XBPg@mail.gmail.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 1:29=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
> On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
> > On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com>=
 wrote:

> > > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void=
)
> > > +{
> > > +   struct pci_flb_incoming *incoming =3D NULL;
> > > +   int ret;
> >
> > Maybe make the error return static, and avoid another search through co=
mpatible
> > FLBs if it failed before?
>
> Good idea, will do.

Actually I'm not so sure this should be handled her. I would have to
create a statically allocated variable to cache the result, like you
said, and I would also have to invalidate it during FLB finish to
avoid use-after-free. That defeats one of the main benefits of FLB
which is that we don't have to manage global variables.

Can this be handled by LUO instead?
