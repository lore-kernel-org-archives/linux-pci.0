Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBA386C15
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582985; cv=none; b=Ar8azmEqnct1Bg607ZtKdvasC8xcQyqYDDiUZxKPzVhoVyo8AlHh4x571+CZg7aOnuEVDcovnYcECTQkCorT0BLCFMnaa64JhUoTlo+8L715QwmnswEWGqkjwltj7KcuQZG/bY5ZgQ7u9vW7Lt5615HU2IrKScLwbh10xewxBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582985; c=relaxed/simple;
	bh=C4k6pp80hnQQsLLDSWMWa+xYXh2iAo+/ZwCtVZ+IPx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSxidsMIzY6wMXA3I38XoUuHuu3PYEM72EVrPCr/n2RE0Ox4kQ3CC8N8Sn2ecxmtUtFV6wmVapfCg3EE7IW1vyYhbMpK0EjtMGWOEeg51RUik8oZ8Gy6vVgorTMqb67okLi5H753JTRhohPsMHf/wzP7/vzDe2Et3DYEmYx5kHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfmAuk+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfmAuk+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955BC2BD00
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778582985;
	bh=C4k6pp80hnQQsLLDSWMWa+xYXh2iAo+/ZwCtVZ+IPx0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pfmAuk+FtPjx6gnE97rP0bq2NvVALLry2WJV5whroEp2kIZyhamjjk8HDzPqD8ImP
	 TS2pOV5ADQt+ULbDtM3g5w5YYYKU1LFUqnvjZ6G/A5LJRpjWZyHDPfYtGhhvEr5+2x
	 fHKN0QKhRcKDXy2RZi1OSsxKxiOZAWOB68JeDpDPYtzYme3i7JGc2vxtI5qbbqGE72
	 3cXq/lv5TAxnSOzc+Wa4oIPcK1CBndv71R3YkNrbb1RH8/cQutv0fdOxk16ibxarYP
	 0LzV1BjM1xLL3rUBLa+Q/oygFFJ3Y+mxnvt133ZNKd55Nkfr8UUubbrcJcq+tC3fQR
	 pcWf+p+NW768A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so5115071e87.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 03:49:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+jApkGSANpvtwuB/D+0WQ72zIxt6yvJSNYW8GpW1CHWIaSjG3ckpkOeAKNe+8j+iIb6rdTlbygxDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04Pl+ymPT9hO0KdM2heysvGsQFxSqM9Hd2H8thl5XfF5qwVRZ
	V0rd2x9il6Bbd9XsqZkzDdnb1PkUP7nUXaU3gepiZfVFXldAFKPU84U7dRa9+Vqg6n4ezMVYdUo
	Tzb5BfDOzH0OjIdTp5C5ZfLgRaVZSxHU=
X-Received: by 2002:a05:6512:203:b0:5a8:8891:ca2d with SMTP id
 2adb3069b0e04-5a88891ca48mr6876042e87.6.1778582983671; Tue, 12 May 2026
 03:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0gU3fjh0czpp+7gC9EfRSwT2dUZQj0hSJR8VNwBLXM4PQ@mail.gmail.com>
 <20260512000112.GA194667@bhelgaas>
In-Reply-To: <20260512000112.GA194667@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 12:49:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hS7fJ3-MEb3fKU7xs7fEOi6CDSj=AfAor02qM=HGpGAA@mail.gmail.com>
X-Gm-Features: AVHnY4KRtcb2f84wLbl1V0OhJkkCljQZZxaIDm0IhrJ2oN6qs7XVUUgTmOYhZDU
Message-ID: <CAJZ5v0hS7fJ3-MEb3fKU7xs7fEOi6CDSj=AfAor02qM=HGpGAA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, sashiko-bot@kernel.org, 
	linux-pci@vger.kernel.org, sashiko@lists.linux.dev, 
	Marco Nenciarini <mnencia@kcore.it>, Michal Winiarski <michal.winiarski@intel.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Eric Chanudet <echanude@redhat.com>, 
	Jean Guyader <jean.guyader@gmail.com>, Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:01=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, May 11, 2026 at 05:24:49PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 8, 2026 at 11:43=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, May 08, 2026 at 02:51:37PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, May 8, 2026 at 2:17=E2=80=AFAM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > > On Tue, May 05, 2026 at 12:43:17PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Mon, May 4, 2026 at 11:17=E2=80=AFPM Bjorn Helgaas <helgaas@=
kernel.org> wrote:
> > ...
>
> > > > >     platform_pci_set_power_state(dev, PCI_D0);
> > > > >
> > > > >     pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > > >     state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> > > > >     if (state =3D=3D PCI_D0)
> > > > >       goto end;
> > > > >
> > > > >     pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > > > >     if (state =3D=3D PCI_D3hot)
> > > > >       pci_dev_d3_sleep(dev);
> > > > >     ...
> > > > >
> > > > >   end:
> > ...
>
> > > OK, so after platform_pci_set_power_state(PCI_D0), the device may be
> > > in D3hot in some cases.  Then there's a D3hot -> D0 transition, and w=
e
> > > do pci_dev_d3_sleep(), but not pci_dev_wait().  Sec 2.3.1 says RRS is
> > > permitted after a D3hot to D0uninitialized, and pci_dev_wait() is wha=
t
> > > waits and retries for the RRS case.
> > >
> > > It looks to me like we need pci_dev_wait() after that transition when
> > > No_Soft_Reset =3D=3D 0, i.e., something like the below.  Do you think=
 this
> > > is unnecessary?
> >
> > Well, let me turn this around: Is there any evidence that it is necessa=
ry?
>
> PCIe r7.0, sec 2.3.1, includes this:
>
>   =E2=97=A6 For Configuration Requests only, if Device Readiness Status i=
s not
>     supported, following reset it is permitted for a Function to
>     terminate the request and indicate that it is temporarily unable
>     to process the Request, but will be able to process the Request in
>     the future - in this case, the Request Retry Status (RRS)
>     Completion Status must be used (see =C2=A7 Section 6.6 ). Valid reset
>     conditions after which a device/Function is permitted to return
>     RRS in response to a Configuration Request are:
>
>     =E2=96=AA Cold, Warm, and Hot Resets
>     =E2=96=AA FLRs
>     =E2=96=AA A reset initiated in response to a D3Hot to D0uninitialized
>       device state transition
>
> When No_Soft_Reset =3D=3D 0, the D3hot->D0 transition is to
> D0uninitialized, so I think the device is allowed to respond with RRS.
>
> For the D3hot->D0 case, pci_power_up() already calls
> pci_dev_d3_sleep(), which waits the 10ms required by sec 5.9, but it
> does not currently account for an RRS response after that.
>
> My argument is that if the device *does* respond with RRS, subsequent
> config reads in callers of pci_power_up() will see invalid ~0 data
> even though the device may become ready in the future.
>
> For example, pci_set_full_power_state() reads PCI_PM_CTRL and may
> incorrectly complain "Refused to change power state from D3hot to D0".

Fair enough.

> > I guess if it is not necessary, there will be no harm, but this is a
> > performance-sensitive code path.
>
> If the device is already Configuration-Ready, pci_dev_wait() will do
> one additional config read, see a valid Vendor/Device ID, and won't
> wait at all.

One extra config read shouldn't make a measurable difference.
