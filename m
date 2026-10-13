Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFD5208C3
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910764; cv=none; b=YZAoCyd73q2ZrRMX/+HpMztmXk9OAasGalkCy26s2niof8uFC9Ks+ty49ukuBiaEcTDm/3pD97dmnMRO9f5TPnroJ8eK+U/g60kIv8ciINhp+M420Cw15IcKJOMPvxTywSIOFZV8K5D3TYIDavnjZSYk9htHepB3Yk70m6DJCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910764; c=relaxed/simple;
	bh=Em0J4kFPQkpc6DtvJOpGf2IR0VZFxoTRpJ6JXd5k4yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZfPjYxFFtz0YN+TUhHb4cX1rqwIUA/ebV0QRV5df3NjKTi+uFeBqb70Hie4/UX2lRBFUbaDBQseqjBz2jmgYUM/3CMPWIzb8dma5zRrj6DJF3j+B8Z9g6L3MUJfJFGwQsxxH3fI4duEpXGjcbWN1QXNMbmKaomW5OrFOQymfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnY9OryH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnY9OryH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE7E1F0089D
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910762;
	bh=N1+Y8UcbV3j4gztto6Wz9a9MFiofJ01PDbTLcnyXQoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NnY9OryHtHJIel8UNv5f+AGAi81aEBCtoARkeyf0ziaFlyzh4VtDnXtHwi49nICP6
	 NVuN5bMhuwtBOvlEqdxAVdF/CLjEQCrxrPrSXkEvE2sAjQDMa8LcLJhZZqGdM4CnFx
	 GY0L3LlDtpceVmsjbk4Bx9PV4S7tzCi9PmFDIL5DG3iW4wpAzA9r/9HiIT4zBm/m4N
	 8viphVEmp7UMLUMACskdV7NVh6hc8CWYNKJ3CR0CG1ELz6tHKA1Y4FrIwdiwrD10WL
	 hGbAxhlPgA/1Ua7RsqtYfAsqh/F/F9l0hJuf5HH720Ff4o4K1Ux+Z3iUlW0JwJUaUh
	 +gk85jfYy2a7g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso1670204e87.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 09:59:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByZgylnynvqAmSyJvq32tIXr1SsuIYwm+TlJCmBMpZPbsl4BZ80Q5QRyPSp9jLAY2gd24+ST8W0c6Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkFRNEFj2xjbywX8j7od0IywaMi0ZWvm3RlTLd9Po2EJKRwWeR
	Cg//OVsHgEkEOSe3Z0/1+flishwaJS/l6Fc1M0eBXsYrDbggNmlNu/cxKQzy2mAjYE2wE0vBruf
	E50nFUXUcJ+RBoPP4VLp/AxcabvMdrEM=
X-Received: by 2002:a05:6512:304a:b0:5bc:d39d:9b38 with SMTP id
 2adb3069b0e04-5bcde6c4cacmr4486252e87.32.1791910761041; Tue, 13 Oct 2026
 09:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012104645.975190-1-keng-yu.lin@hpe.com> <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
 <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com> <20261013060957.1023448-1-keng-yu.lin@hpe.com>
 <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
 <d11aa70c-4753-4a28-9955-990c45649677@amd.com> <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com>
In-Reply-To: <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 18:57:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com>
X-Gm-Features: AclHuK-kpBBJjgT_J-9UdGMEksfS5T7DW_cr_Uqhmch-I8vSerRUvLqL95_av1o
Message-ID: <CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com, 
	s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com, 
	zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:52=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 13, 2026 at 5:41=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 10/13/26 10:23, Rafael J. Wysocki (Intel) wrote:
> > > On Tue, Oct 13, 2026 at 8:10=E2=80=AFAM Keng-Yu Lin <keng-yu.lin@hpe.=
com> wrote:
> > >>
> > >> Hi Rafael, Mario,
> > >>
> > >> The initial read is not needed to fix the reported D3hot-to-D0
> > >> failure. I added it to avoid extra BAR writes on devices already
> > >> in D0.
> > >>
> > >> pci_power_up() does update current_state, but need_restore is
> > >> calculated before that update. The check includes:
> > >>
> > >>          dev->current_state >=3D PCI_D3hot
> > >>
> > >> For an initially unknown device with PMCSR reporting D0 and
> > >> No_Soft_Reset clear, this still requests a BAR restore. Reading
> > >> the state first avoids that request, although the final
> > >> current_state is D0 either way.
> > >
> > > Fair enough, but if the device is in D0 already, it need not be
> > > powered up, so if you make a point to update the power state upfront,
> > > you may as well skip the power up if the outcome is D0.
> >
> > It actually does need to have all the ACPI calls that happen as part of
> > the D0 transition though like _REG.
>
> Good point.
>
> This basically means that the upfront power state check belongs to the
> logic to determine whether or not to restore the BARs which should be
> part of pci_power_up().
>
> So now the question is, if this upfront power state check is done, is
> it still useful to read PMCSR after calling
> platform_pci_set_power_state() in pci_power_up()?

Or what about using the following sequence:

pci_update_current_state(dev, PCI_UNKNOWN);
if (dev->current_state =3D=3D PCI_D0) {
        /* No need to do a full power-up, just sync-up the platform state. =
*/
        platform_pci_set_power_state(dev, PCI_D0);
} else {
        /* Power up the device and restore BARs if necessary. */
        pci_set_full_power_state(dev, false);
}
pci_update_current_state(dev, PCI_D0);
