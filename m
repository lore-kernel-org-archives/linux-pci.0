Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA82F1FEA
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325504; cv=pass; b=jWKs2GwLE3JvYXPT1KHJCcPugKcWGlvcPFLOTYs73+MBY9w6r1c6qGimhHVN0lJMlcb3H5DzQNTBFgJmeM0t6VbK0DGdwteua+3O5YON4L5pOEwStOzokmAr05LJm7X3H22xYpe9QYE4Lsm/udpR6zsein0YTGdSf0o7/dk3Q6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325504; c=relaxed/simple;
	bh=XxyXGFehDCe0pfONU0BVHIsiW5Y6i0tO8AG04f++XSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5YmzrzpZzx0uelnNqPjXIDXK1oJd4e359H84XOLFO63ANqe25/4cKqMwiStTU6CW+0mLcdy2KWhH6UUJdvo57K4ppu/EL6hEIXOr1YZy2uHD3jGZf2p19P14Gfv1UV1IOATY+ui+JeNvqz6vCFC+7MdLouyxA2f3HOLyADelRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMA/GD85; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMA/GD85"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a402dea4a5so10709594e87.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 14:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777325501; cv=none;
        d=google.com; s=arc-20240605;
        b=gj8EqfpD1yA2Tigr5Y4ZDZYpkxUHDPmgwaCd4w+REhcX8Zw+JzptuTSub/weXsBUHw
         vBZsPLz8T2o6onUtP3EZjtk8E2uhvauggKpUcbJViJ2OuSS9ZzBWN7MQPR15+JX8b0Ud
         rlwqyL9uzcHWCLKPjKlBXtuBFbnLMvM6JNwjqtBCl/o6A+YTkUN1R2NvM0lyLLZsE79N
         xVRXR3nSrD83uuS3wrGGu1ivV5KHdt6xBTodww+/LdDul8lKGMNSVHyNHSS4mR/nsZq0
         zzc+NrRWmmFI3bLoLn8zFqjPqmyAFfWjkwKyQXD6/pLs6o8yKzbrohOMEqVODlL+2UmA
         g8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        fh=9GuFns84QHD8u48iiunQ9u52ELuCt1H2AI0XJjBQHBY=;
        b=hXNJyvJJ1nDH80Ws8zzjlUUjeTVGFMIj1CQ0SFymQiESqUlLW0FLe+t7va90cNqJSl
         0q6GvpuldEN0NLtJBz4SYMvcy4ZogLsDfPQuTo8Rb/woDJjUD9+gMQgaLZN6Ykt4O6nx
         roWiHRPo1rrBrgrF/W0ijUI+FSyLxQLxwCoR4X7ImRPGRNllNIDirQBZCgIEHVBxTc5w
         PLUQjcoIahMqCO13wNe+rIrEzAwPht+apDyt/YUN4OzrmWr4EZrQ3LeuVcKISOq4unKw
         orLArLu0qRjR/daMNdlKOn5Rc6vRs7zfdS0QS1h+N5aUpN4G4a2EtwWOyfZXPS4HOwHH
         Qbjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777325501; x=1777930301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        b=GMA/GD85zEEHmut25/kka0RPb4oHoMoH4eR0YGpu24JrcbVz+UsJiiiJ04vxZXXjLG
         rjo+LSj5O6azoj7oMNvIlC+cY1+oOBZk6Tam0PWDBigUfEOLIEKK68cU9FuNAX6cBn5l
         0PGzLLrVEF1cD7rE09HjIsRsdXPF70qaxCZPuB07uLBI7xZ7Qpg3MUC79t8zCIRYIjVm
         j6o47V1iGBrlKzMBGjHplWZSxAGLzTS3GVMVNMfPEU4Kfjl6m27E2azIiE80KbmKgoE1
         wqnDrY/cz9FVJiBgRNzD/wWmGJcL0zoYMGKpDXN+JBTyzJsdgQENR1U9gK6RvON31CXw
         lwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325501; x=1777930301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fbSZrcbEX7pFS60K+snXC2z4cFQZ67H6ZAP0NTDTDM=;
        b=Qgsx3pfmZ18odz6PUnS+A5KjibULim+ZdNiVCDyAgJvJN8LP6hKBH0ICzU5vsMU6ck
         S2fMh9Atze+YKebTL/IDnVfnHs2DxK5BRMG9Z9ER1gQVYmN81ugFw492yXsGVIqLGcle
         U5smPe8L5t0c+dSzHPvfsN94VuLk08buTOLopk0onSKJqNr9NVK0Arx75mTSRcHlNqKV
         kolSShn18LhXKZ5OCGxvACsh9P4ul+XDz/pmrRUzeZZFNJkg+il395eLK0vNEwF3LRbl
         oWMC8Udsfy7mJxVHmnWVIsnB7NlA+0bBRSu3qtQed4I4Hj8NRNkKjJeRCHxFiehjwa8d
         xx2A==
X-Forwarded-Encrypted: i=1; AFNElJ8HYLPj2LqKP+EME71XJ4NhLyhsaws8lZnRJUneHWV7FcTBjfUbJrQgGFahiiuQL1pf2hBzhb2CskE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Qd1iehWpa5dBPpjyxxTqZv4SaFrEp5GwZuxshYvhvzU1zPTu
	EYrQb60/SCMSGELq57GM4TLqoYgZzAZdglYMHP7pmYn/qBr6SeOAMMlIiyYc4rSaPahvQ1a2j8v
	1kiH9DTns1mihEl7EM3w2hTKCaa6kSbXJm01/kcfx
X-Gm-Gg: AeBDietgV6hiQ7dxYDbQJlBFlNzTCXRldQhkVuL7ah2vqKwwzztCfd/eYIduV7WwIjf
	GjYLcC72+IEjwbnu4OYvzNtLS3LoZF+6nXRI/gEVT2aKEzpd8k46k3Rbt7X8EvBPYhIC1CdKbMW
	AT/Je5Nhu2La/uV9rTwwmthKT3f8QL5UMKKkE+GvMvifHr3lNK9MM6n3mod0Y9uBEvqIzAx8pfA
	VN6qMMiAEsUH0DQf7825Y+n24IDn+B778Xxgj6UzVS0Oj2PlYCZ3pbIaoBE/bF86Ga29bcn0qUG
	Kryi+FaXeTMn5hrARbBlxbnNfv26xQ==
X-Received: by 2002:a05:6512:3c8f:b0:5a4:505:f62f with SMTP id
 2adb3069b0e04-5a746411871mr173644e87.6.1777325500555; Mon, 27 Apr 2026
 14:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-2-dmatlack@google.com> <20260427210529.GA186381@bhelgaas>
In-Reply-To: <20260427210529.GA186381@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Apr 2026 14:31:11 -0700
X-Gm-Features: AVHnY4K95rEzKgWcXKT0jFnCdsBpr0VFFFUI48Oher6g49BqIzQIKoHjNP8bc8M
Message-ID: <CALzav=c=99653vuRa0S6cyAuTfP-PWFpOdopYArihOBLor6eQA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 2:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:

> > +++ b/MAINTAINERS
> > @@ -20555,6 +20555,18 @@ L:   linux-pci@vger.kernel.org
> >  S:   Supported
> >  F:   Documentation/PCI/pci-error-recovery.rst
> >
> > +PCI LIVE UPDATE
> > +M:   Bjorn Helgaas <bhelgaas@google.com>
>
> I don't think I want to be the primary contact here.  I'll see patches
> regardless since they're on linux-pci.

Ack, I will drop this line from v5.
