Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9B23BCE3
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654677; cv=pass; b=IMFjV0hR1Dzt6p/9lNJdiwGNBN4y9K9/ZcbdqY0m/n4PIwsg4eQWs1ObcEuhx6Bn763K4Rjty4gXssxZY6tS++tmPJ7JrILeAjZzP7rezq42Eoi0qrwqmV/G9NcDlxZIyPa5lJg6KD6tHYenbnQ4s6RRRvm/ThHODqvIp4xSadk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654677; c=relaxed/simple;
	bh=bKdkMIOKWZNneVM2/reuENwleR9x2amx9Y684oqA2m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGBgK777YqPdyeVtRv29mkRePIrmS+/daGCXIoNYvsm0PyWxFmi3hRot0bGLy/+m3X2C1r2d5nRw+zfjraevweslv1HtJYUCxJAH7hZapQtwkldSyru3Q9BizKXwE3353S0b5VEO2gZFTYSxE6DPyIqmLoGphFCCwkFNaseuV8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwsOvsa2; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwsOvsa2"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8ccc7755so3184034c88.0
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 09:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777654673; cv=none;
        d=google.com; s=arc-20240605;
        b=iRvRNQln8yRv/NxbinNFUYuLEkKUa1V6k5XqyspFc7E0K+f9RZ7Ib8TVMWLMLpHZQz
         dC3VfwbnnMYd86bWz0V4u/0vCxU2NjfniEi/dnxkK6bvUSLqfQIkdIB2HGsgKiGLDiXc
         ZbDVWsKs55wf7p35FKS2DVRLITO0x/jiyM6PD9+pt+qzyQ31FDJWMX3s232zpqk87a/p
         BngeWqsByRZa+HJ1OqT7a1GKrq3weiVTZosRkyIcVaXB8qQO2s0QGUrpqlc/ORGAfLIn
         JkWDXy1zf8nP400koeq4nLdgG60AQAss8nrUJX/rTGBp2OQYNy1u4120C2y4cscHShBT
         b+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        fh=7ZNDnQIvA3kNA/YQh0lralirXjiYYkeNosNEcYPlsps=;
        b=RMdOhJbo+RbbuvlV5+X1kNDuAKCIsuEe+hAP11lOj6tOGMPGLcg0jZB+odOZtsrZRU
         sVMa02zv4pIzSFqTzREcUnCUhPhvHL9yj+NJrWx1rLfiZbMkPeaowzWl0EPzDVrvga0N
         SCevCniWbYGFpjcA0jSIBYxilSVmV4nz8O4GO4XFpAYP5f+4ey1rkz2JkJUMFKPlJgcE
         2lFSIHvh9XldZ2ikf5M3/0X3MUWXHHBVkuvnt++kLL18vgjd+CguE+lJSFy9fPK20CbM
         XGFS0k/el+1Uwd+bdyyzLhZkUSV2jZZtBFoJUnTceXxe2xfjvjSXYEZXdXYh0HRwQqOR
         7beg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777654673; x=1778259473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        b=rwsOvsa2I5764eUV9LIYhn+wKeG7zwNhGRcaNuJ1SNAL/bTp+ULAhaA7vcEzUCvmVG
         foDyFl+s0OFroOg9OfYwhGrm7wHYXILuRvj40xwJtqdaTVOD8HIeAucvHeP4FNPSCevW
         6rLIAaaUliyCA+5E3L7nhEpiBWZd0uR8o2SNp+tOC5dNq5xqWRWceVRyYgtyCLkjgDaO
         oNdvk/DF59Kgy2g18XdAOQz3eisALDvtvwE9rQtHqKpE5fkLyvYOAlSsD9uzI3wgMSkX
         c4yczDOG6Fb4fA72VhecPQ+79DyI8VJGe9zNJmPal45b0hvjlyd/EnzG6oHlt3mqds3I
         jjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654673; x=1778259473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G34ikY2DD+u+VVE3dDOd4ruOH6p/Jku1HJ+Euceqccc=;
        b=WwfOrkJQdSfkoIMzhEogIHdF6QbcZS2HiwmNtgdef6DbnM+yeMigNtfTRhUQ13JowH
         d0UGyDPZA9iqa0vEVojSKweM4ApR/teYIIg2KkAX+ynYilcO49oKIEERjqoid1XtEybn
         +6NAChBsbafW55vyoG19jXl7QIeqE36z0KbWsFJXdjaSlPJnCbsbN8LHDS8Ch2Q9nbGC
         onM0Qm4gLIj3fe1PglTfiAjEEiN5n21cvclIjRA5pFEj/vmjkxr3myZoj3bVLZiG2dA9
         eDOWPxq+XCrX6aQRqGYsfFHWOiftlEQBzGamOgT0labmjhAqiXqztouxMAnkbdkzTEXk
         m5lA==
X-Forwarded-Encrypted: i=1; AFNElJ9staORd6Grzb9RJqsMjj8FBDzySrQz9u/e/pS/YKBITpw9qh0plHyP2y2TuBAyDKanvwfUs8y2JDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Oeh6XOaGmOcK9sCPLvJ5XbnWxWROMbObIbXqskKs5euIv3iQ
	gJ/mctziD3PsS2L/I66etIlNeP/rAAaNNlpitRYMSZnMzSvNMBSUsCtwg7sBx3I7qeQox6hPoge
	BXZUM0Cd38axIw1hxAcsgct0QQnCB4ZKidWiVr94p
X-Gm-Gg: AeBDieviLnxAq6GkMC3ipGGyW9dPcrbFbUIK+Z0h+fJuCWcWD+M9bpsRhF3AZpC7nko
	8WCy2KQd3Y8R290IR4xUtwQhih2O9/eGVB7iSBZsCWKY3NDsJZgbPiDSyqmzhiHxEK6RM6f+TK1
	BGQFwYjiRVBXcpEHcfjUDAtLD+NVEKzp4o+YhxMqleyKFCn5ZWzxXHs+M9XqYSmZ5AJOiGaDdF3
	ETlvSsD1fdZVfcULCiBxQ3EckERInfdy0hSoQ4JIp2pmW2JJ8MB5CUbbUQKYxBEMeGacyoTLNfx
	vPfsg4rAee6t6njf4f7JaLwv6QOsGw==
X-Received: by 2002:a05:7022:6187:b0:12d:b2e9:b20f with SMTP id
 a92af1059eb24-12dfd821474mr32517c88.21.1777654672480; Fri, 01 May 2026
 09:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afFHC6C1Qbwio4pH@google.com> <20260430210642.GA439800@bhelgaas>
In-Reply-To: <20260430210642.GA439800@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 May 2026 09:57:25 -0700
X-Gm-Features: AVHnY4KFLnH4p2pRBeiWD3uz1DZ5zLD14tslYZKT6G5Ma2DKmFI_8zfdZMWusuU
Message-ID: <CALzav=exRqf3XZWDwUx-OXp8TgzpmQ-iUTixpT4SVRk8nxctrQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	iommu@lists.linux.dev, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 2:06=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> On Tue, Apr 28, 2026 at 11:47:23PM +0000, David Matlack wrote:
> > On 2026-04-28 05:50 PM, Pasha Tatashin wrote:

> > > This is the way we agreed to handle kexec changes: Baoquan He is the
> > > maintainer, and without his Reviewed-by tag, we won't take changes to
> > > kexec. This is the approach we follow with MM for KHO changes to
> > > memblock and memfd preservation, as well as the upcoming
> > > hugetlb/guestmemfd preservation.
> > >
> > > This is also the approach we should continue using when adding LUO
> > > support to other components like PCI, VFIO, IOMMU, and KVM. It keeps
> > > life easier for the core component maintainers and ensures we do not
> > > regress LU by staging everything in the same tree and sending LU merg=
e
> > > requests from a single tree.
> >
> > Ok it sounds like we are aligned on keeping drivers/pci/liveupdate.c,
> > include/linux/kho/abi/pci.h, and Documentation/PCI/liveupdate.rst in th=
e
> > PCI LIVE UPDATE entry and not duplicating them in the LIVE UPDATE entry=
.
> >
> > I think the only open question is what tree to use for the PCI LIVE
> > UPDATE entry, PCI tree or Live Update tree. You are proposing the Live
> > Update tree.
> >
> > Bjorn are you ok with that approach?
>
> Yes, I think that makes sense, at least to start.  In early days, it
> would probably be a headache to coordinate LU things across multiple
> trees.

Sounds good. I will swap the trees in v5. Thanks all.
