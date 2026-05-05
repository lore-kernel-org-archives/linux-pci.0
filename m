Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A6481A8A
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994726; cv=pass; b=h0X5+K7Cqo0Yw2QrYcvEkpZWCe7w0CpbdFgGgF6k7MDuMCEH2dQM+TCH1DjaLpzjEcOPBSAHnnY/NXXLgAR973fB0PxejddkzEqrKrnbVDsIxyhxiEcb0lkMAdZPtohjMTDDVzIp/Z9kVosPHe/tIlqhxX5jDbTpAO0cxdFXDqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994726; c=relaxed/simple;
	bh=lGg2abmeK2X7Qd78vLYSKP0TideB4JdenQcUnDGZRJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqJZOunj4MBh5Kfmab7HSltqX3mfGbZtMJDSkXb8exP+87UWFqTuNztfVzNBpPk6GcSnizUEcyi/9iTBiIYFoQBRHh510oXhgxNWdtPAITtslU+tirwLHAv+YqKB5DdWUNbmUy0uOAdCIm8IbNY5d6yjbpak96eROvGRmstzQe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuGrre6X; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuGrre6X"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38def541b0bso52248541fa.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 08:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777994723; cv=none;
        d=google.com; s=arc-20240605;
        b=X86f+MLC4HouKTtlu17eJJ6LSJH9JKGPcXk2gk610x2zzaOfPj4FKhQHYR617R/+KU
         htqVlV2zbHqd+AcE5gt4DG9F4k96Frm5TAS4pdMayufUzDkNp3d2hWjrqj2uT4Nat9kQ
         OnVvaDPAOlWniLBXSrnd7cbMWA43s6MM+S9BtN5m4mAn0Dkrjm57gWvCZSQ92AGPaFiP
         kxZsSe3S2HC1Z92pjVbp0mV0DJYyuBFW/AIaZ4majMWtxekQh6L3nVPT8rvuJzDL9TmW
         z5S+86h5kQqiZCyXb0eixVljvLr35OwzLKV/1mBR7h4vKdTigUhCWrhqH8yCq+Zhsl/2
         CNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=LFA23XaRUYTvjaED/Oey0IjLZr5jn1jKfrl93jCACf8=;
        fh=83ioabFBVQHELsaQ9bw1+SFPkjLPVZ/gKY99TJBZnyA=;
        b=fPkcLuhnpMbpVRsk1E70FvL2n7Z2IGj/W4XTqzPRkG7TXSe64beSPF8emHqvS55YZm
         LW9PIqcKSBNls2VhFtqzbQs+5t4TSdYvcvWMRURFWOM7ziHhCrBEABzG4utqwqUcOvxD
         M3AEh3P6Fas0wuYA2TJXbViP7gqOUpTsi7jc+sUQvL8jvI1di4TsF9d860wIhtO2d4If
         TF5ENHLs3srUa5nrJFunE40mf67AOxiJBg970oOdlgkjhlFkgUEDN0mR922nUQC4a7VP
         JeeO8/CMYxeME5lsCDO0EpXKzVzi5t0QtCqhq4HVyR/KW+/D3zMyHRmxRQsM6Hn7VBwR
         iY3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777994723; x=1778599523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFA23XaRUYTvjaED/Oey0IjLZr5jn1jKfrl93jCACf8=;
        b=RuGrre6XCib72q/BQC27n0fzzgEy8is8kuAozd6FkZ4q7R+TLNfcNhax+GBoOu31iu
         yzsfABT4Mbu9JDwoevybyNkXDvIrH6EQYYakGlYkkz7eq30tiH/AM68yHVFgzaB5F8Dp
         +3xReQopXSoH766llx9/VyWuqGRGkDWGJVFCIYg4AzgBjqA+hlpwTHi3/RprDIzpiFNs
         mpgxMGMo9e+kSPOgd2k2sWxszAky0GAPzBAvhWI6t874vOiuxoR/cJ3KNuh9uBhfV4TS
         GKSFxvtbUeQl8G3f01i38ocJ7GJNgQ20N4hoYBED9UO3zaJLcIwBhbTPkR1j18N53dfa
         5hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777994723; x=1778599523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFA23XaRUYTvjaED/Oey0IjLZr5jn1jKfrl93jCACf8=;
        b=H8JLqcnM8vziU1wUMNHiTnaJFOwW/HKp3YQ4e7vOBqQ1oeYPS88LVEwWKtX5kp1H4D
         QNnm7gudva+q2A1Ra4r9GpMbv5hRFJzQnJFpo/s7s44fdlbcbVWDACxt0en1HUUmWDvr
         G7EOVIHdmFmPh9wVjfexGS2RDVY+WgTR0MCg9U7Pj8xqS+1j1AdiuKFJSW1KeMGApGTm
         jtW0vxD3r1IZee8OAT3UHvvctvCJCWYa7xRP6g5FQU0RuvbDRcbdZPXyn2+ZNHt8QzEG
         VPKg3lqiCfSAhoO+m9F3r0ySfdfeKPW6YtjdSPNx9BL85sWxDou/d/EKT9BnSLe+JYc1
         +wuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8l9wxhKPzuJ0L53q3/GKuuuT0OYqI1pj+u83vhP6GLn7fxmYOz4yv9TJBHv8w8nuIhq1wO42Ewx8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+o7xRgc9ycwnJvsea9pgLdhBr9emHliZPEumO2S2NJDC8t5VL
	o5km3bJ4lCNf0cXEGFLT7wzCQULwO45RMI4eYXLnmBw3JyIpd1hznqWkRqZ5mc8eVNqsjcQ4A1z
	dvP4wNSNp383WNe4buZ1Fm/VZDcU1L7Q=
X-Gm-Gg: AeBDieteM5e+a3eaQHxCuEax8T4mWxC+rk/4uqJ4DdZ0Mc2UX16VRvVpQl2pICmlFoi
	zkjpPnVja6HGkDUSpe336QR+9iGrvRF9KAuvsMzniJxqP4utWAWOTYtH44Rmr+ykCKUZJaYXvVn
	qWutU0hv176p06RZRl1ZQGZix/y0nNMYbUWRJecCxzv86tTxayXnER1WOLlmv9Fzx2hrKWiy/Fc
	0ywQTu8BRUfGCzHhwRM0D1sXr+1KWtJwSZSDXC+jashfAkC+sdRpKAUNBd3Spq1KzTwJAZRWF8l
	DJDh6L/xv9Pem2kLo0bKzNqhsZ0A3LWF4/Am5HLcQCJvKEYZ+JL1RF5fMD8K/QEpJHM7jLEKB3I
	nz6Uwo8kdFc7gkZ0=
X-Received: by 2002:a2e:b8d6:0:b0:38a:6537:6f51 with SMTP id
 38308e7fff4ca-393b492c293mr16805791fa.5.1777994722861; Tue, 05 May 2026
 08:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414081730.3864372-1-rkannoth@marvell.com>
 <20260504224955.GA669929@bhelgaas> <MN0PR18MB5847809DF7EB9A3ECA4A4159D33E2@MN0PR18MB5847.namprd18.prod.outlook.com>
In-Reply-To: <MN0PR18MB5847809DF7EB9A3ECA4A4159D33E2@MN0PR18MB5847.namprd18.prod.outlook.com>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Tue, 5 May 2026 10:25:11 -0500
X-Gm-Features: AVHnY4K-DyAHKMwAD4q2TyCQMOsJNwWJaGHim2wRQ-H-SZM8qBkBVZjAEwGD_qs
Message-ID: <CABhMZUW5Y3g86_ki8MfcqX9Qj63TxqQR=m74c8sBm-puZGEvUg@mail.gmail.com>
Subject: Re: Re: [PATCH v2] PCI: host-common: Request bus reassignment when
 not probe-only
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"will@kernel.org" <will@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "vidyas@nvidia.com" <vidyas@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:49=E2=80=AFPM Ratheesh Kannoth <rkannoth@marvell.c=
om> wrote:
>
> ZjQcmQRYFpfptBannerEnd
>
> On Tue, Apr 14, 2026 at 01:47:30PM +0530, Ratheesh Kannoth wrote:
>
> > pci_host_common_init() is used by several generic ECAM host drivers.
>
> > After PCI core changes around pci_flags and preserve_config, these host=
s
>
> > no longer opted into full bus number reassignment the way they did
>
> > before.
>
> >
>
> > When PCI_PROBE_ONLY is not set, add PCI_REASSIGN_ALL_BUS so
>
> > pci_scan_bridge_extend() takes the reassignment path: bus numbers can b=
e
>
> > assigned from firmware EA data (e.g. pci_ea_fixed_busnrs()). Skip the
>
> > flag in probe-only mode so existing assignments are not overridden.
>
> >
>
> > CC: Bjorn Helgaas <helgaas@kernel.org>
>
> > CC: Vidya Sagar <vidyas@nvidia.com>
>
> > CC: Manivannan Sadhasivam <mani@kernel.org>
>
> > Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
>
> > Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kerne=
l.org_netdev_adcXzcz2wWJFw4d7-40rkannoth-2DOptiPlex-2D7090_&d=3DDwIBAg&c=3D=
nKjWec2b6R0mOyPaz7xtfQ&r=3DaekcsyBCH00_LewrEDcQBzsRw8KCpUR0vZb_auTHk4M&m=3D=
01Ocq--c6MApFtcfadw2NVeNuCaGZBUwjA3VpG_9uhWaoPultvNor45uL_Eiijk8&s=3Db9P4fx=
av0nsyokGf8a2Tm_XrNqunGO4YOS6RJ29_iuk&e=3D
>
> > Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>
>
>
> > Was there a bug report associated with this?
>
> Please find Bug https://bugzilla.kernel.org/show_bug.cgi?id=3D221219 repo=
rted by me.

I don't have access to that bug report.  If there's nothing secret in
it, can you make it public?

I assume this is the same issue you mentioned at
https://lore.kernel.org/all/abkqm_LCd9zAM8cW@rkannoth-OptiPlex-7090/?

Your email response was HTML, so the mailing lists rejected it, which
is why your response doesn't appear here:
https://lore.kernel.org/all/20260414081730.3864372-1-rkannoth@marvell.com/t=
/#u

If you can send plain-text emails, that will work better in the Linux
ecosystem.  More details at
https://people.kernel.org/tglx/notes-about-netiquette

Bjorn
