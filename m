Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F94428498
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174082; cv=pass; b=uC9rj6aPQ6km1pOI44dW3wlDnzn5vkZw+uYk89Ej0QtkqP75AK/VUhJHSZQ5oLYiJJYvMh4g72qGwVG0scR83r+qJvFvlGMxENeGqxHv1u1BERk3qQh3fJESnMMaFl810xMqi/cieSrxvE0l/o2ECpY6f2jyQmz9zB1lMstuqMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174082; c=relaxed/simple;
	bh=BFAKGAXMoTfNxPRg9rdsHFVakpPjLQ89eZWkvu37Jk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQhllh4r4DnGEU8Pr1ro3wwq+fcu3Txf2ebupglXZ2u65spHbqNgzKT6GVJkSDJZo0P0a8R1WEfkg3V+XJPvtUtGffaMhhwGtrptnRXHlm6Vsaa0ltaWDX8mljTWmZD0hp6RtsQhNtEMmp9X0U2rAWmb3v8rKC/nOhetXN/36E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSzs1T/M; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSzs1T/M"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2308069a91.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 10:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174080; cv=none;
        d=google.com; s=arc-20260327;
        b=gqOiEjzyp9FjbSFmngKC4OS8Ra4/5gKmkmyA4s2CI1+Wx33JCrIRhbgtrXHuAousjz
         r8+HqrDOu89UPowTwuRPN6fMVyRhsP3Bx53qK2eYDxJQ0/8XulWyyuiaaJBxgb6RBZzu
         vN5DVgCQkJH3yu/6WFoGYUgyEDUhDmPDfgz1+QDTa6inKcGvwYrQxIIwyzstXJNNScBQ
         OILA3PNs+xqOt4U/08VeiHP2yTR0bw/N1F2MzYVBXRuHIaKZkx2dmSaSAXNOxoRqoZZq
         i1d4IwzJSLEt5tFkJy11+K4MUgLWXojc0jeSVVJvGNTt/2x3o2VgoauXZMX0cH14KKsF
         QNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=;
        fh=Zz+wGw/oe3uSuo/uIh7pSfIvZ2nZ/4xRJsZZkf2DUh4=;
        b=n8Fummy1O67rxmAQAkkfxAOJtzLFj2GKReoGzJhnE8Ptc1PT2ZkcPrgfZofrsemSGx
         ihikyirlao7tAciU7QiGi8yrO5+y2qusItgcQOkXH2iCK3hXmyAjHYXSsQYDahuOWEpW
         rzsaeY2EhC3deRJosGX5dZ0ms1rYrQb6jdRJEJ0iDYrVqZq26mKzjTQNfXyZuyc0+WpM
         r+UQZcVj55hFC8l3LzYLc87r1SpS6iJIk1JdZOwTt6TodfOm5Ir0168FMWhzOJdjXSQQ
         /w3AN2tIXfFpLUdkXCi9dsRrZ/c4TY/hhGiyJE2ihi8Ti4j4Z5BIIQeumDh4Mq7NyxQu
         djnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785174080; x=1785778880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=;
        b=CSzs1T/MrOG1PhucXEYwHCTzp33LKREOCVS7cNbaXv1uJpw+ZLQuuFnJRCk9/HxVDk
         Q1zm7CJsw7f26LPoEBq9qoM3p8soNbMaD4LbE2ZJkkbqnk5Rc0CYVqZVp55KOBldIirl
         v6bIfpwKIyEBPg4KXUF0v5Hf5ZNnwPxIq3Lvi87tJZkE6PGH2tQjSD+KJbolf3m/LvtI
         03jxtf8ufdwGBo75RzvsskSngs4z5z5kCj1bBUjy+DJEkNMovXC0Wi+Nqv+/kxjS9BeB
         2S4Vsjd8bVXoXZlOJ+UkX3nIjj/xwk8XZ414qr7OgNnwR5q76VCF9NOS2gPZ6ZejhHH9
         9Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174080; x=1785778880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goSDZrkoP4CAKwXn9vTqQBBWqi12AJrVoF+aHToitxQ=;
        b=GF9qtev10kP5XHEzffd9la9G/QyhKRDxE7haiVsr3afLI8P9LuWokf9QFQhCGeJE+b
         wHDDafTmjivjaumm7GKhBD6ITjDIvB6ENo85mulsBp1LfcoWsLqqwBITXKgmx78LfTxT
         X+eelgSTwu6QPHBl56rO2WmHXyAzRLIROI3PlGSnHmncAbXD7e2Dx0LevFqby7ytzyjs
         /WtQbvbaZTGvdmbOj+q/kSVOuWOTmADZQT+Gqoe3gvgBNEC8aAYzaXYndlSVNr7XrA4R
         VSoWMCjDCTKOidW0st/j6LQJ4Z/N5Glcx3BdnXn4IJu6VkI9C1Dtv5XQQUHRmHkz8dhh
         krSA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7LrRGWWYwtoBF38VVynHxeXi+u+T6rx5yfgYE6NFlN7Oo2d4DtTpWd5tBBraAWdvIa4O94Nlg2vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQ20iEa6i+gsR2VBZGEasgUugw7C1OfIjp+W7iC4yy504Owz2
	An4f+3uPeOkbBEY/tPzDaT0nouSGHys4b08sIZc9d2VdsXji8Uabpz6Nf9nTkNkmslE5HTpN8K6
	RyAXPsilDXa/JlCfr1TMgak5n0xM+ihr/gD89iXwi
X-Gm-Gg: AR+sD10HMMd351oOMeDJFWUsP8OrXLlbmPqsYuXN7fcvBSiE0VBxLecHQxKsNzIiu5U
	A8EMmq5vYGgk7op1GqEPbYI8T3y0kl9RGirbyI8h/8d8W3OIMn+GpGaZHPPLkUp/xQg1w2ec1lb
	ZWM1qGo7/gCu9m4yN4vyI1BvzFnUE7xBWBXPKXgrkPxq8n6lZys6YfZno7gNZIB3fNyiWUru9gN
	uFRPyrBg3DQiCfIVi/oRUH0BTKaSv7SuscwZQ0lCMO3svJ2O+Aiu+NEl8jF2mNsu/U7cXqJosld
	DV1gr00J68qVNSUHscWNpyR0s5sIDzTIhuLcuwniZotH
X-Received: by 2002:a17:90b:3c8e:b0:38e:69ae:7148 with SMTP id
 98e67ed59e1d1-38f2960cb21mr8640703a91.24.1785174079933; Mon, 27 Jul 2026
 10:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-2-dmatlack@google.com> <20260723222106.GA867236@bhelgaas>
In-Reply-To: <20260723222106.GA867236@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 10:40:52 -0700
X-Gm-Features: AUfX_myC2ShwJmehW74tz8H5rliP_ZZpqbkoGqNrvu-bKZjNzGADgRSnjM8EYT8
Message-ID: <CALzav=cRhFW+zNX6xCnhjJXXDHgyhOxuoX26FG2Ve8+wMccypg@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > it to participate in the preservation of PCI devices across Live Update=
.
> > Essentially, this commit enables the PCI core to allocate a struct
> > (struct pci_ser) and preserve it across a Live Update whenever at least
> > one device is preserved.
> > ...
>
> > +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
>
> Is KBUILD_BASENAME buying us something important here?  Just from
> code-reading perspective, it's more work because without some digging
> I don't know what it will end up looking like in a dmesg log.
>
> > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > +{
> > +     struct pci_flb_outgoing *outgoing =3D args->obj;
> > +
> > +     WARN_ON(outgoing->ser->nr_devices);
> > +     kho_block_set_destroy(&outgoing->block_set);
> > +     kho_unpreserve_free(outgoing->ser);
> > +     kfree(outgoing);
> > +     pr_debug("Unpreserved struct pci_ser\n");
>
> If this pr_debug() is useful, maybe it should include an address and
> there should be a corresponding pr_debug() on the preserve side so we
> could find things in a crashdump?
>
> > +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> > +{
> > +     pr_debug("Registering file handler \"%s\"\n", fh->compatible);
>
> Is fh->compatible enough to identify a driver?

Not necessarily. VFIO could theoretically have one file handler that
handles all the vfio-pci variant drivers. But I suspect we'll end up
with 1 fh per driver in practice.

Are you thinking about how we can ensure devices are bound to
compatible drivers after Live Update?

BTW, thank you for feedback on the rest of the series. I am addressing
all your comments in v8.
