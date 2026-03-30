Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E83290A9
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882178; cv=none; b=NLaISYrxaQJhzOJp/ypYk+9Kv4KWZ5GXVYUGzIpUjSmL9EoJNjQ5E+1XqLjWWIJQ1kpKJ2Cec1ancgGEvEMhahg7aG/I/BNEwODLDehD/2j/xcaYHLHMz/oXtkIgX43rSCQi5q8F28sthBdpt/oTpL9mAuIXi6Cgp7Kv3b4CeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882178; c=relaxed/simple;
	bh=vl8O2R6691EXUtiEM6WZdymHuL7V1zcKmzD+/lkOIfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isaSgPhwFASCCMyzIs55JnSP3+icv0rJzkZSztBwE//3nSLnZhUNbhxyVyJtbBvP/5lP6VW39UhfnWQefH8BDWoOAXR6dZXx84dnhwDOU/tz8ltXafSIHSGFczI5UkcStVZls2r/yZwHq1UPHdu5wOEGhtr2RvQ0Z0oTuoN/wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=SODBN7gm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="SODBN7gm"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd7c372929so495429285a.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1774882174; x=1775486974; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CIFnVccMuHwr9dEag2kDinb3ZQcKveHam1hNdbO26w0=;
        b=SODBN7gmmel6D0lC5ChdZmKtzyJIJhFlcWt77C7+vZiR6o2TXmLcQeXzUlgB2Zp5NU
         JnKpYsb4Gn2dvkHXMRpECZQFjS8smHFbY+tgqeOiWuAP8YEzqcaoSgLaU/QkN+xry9yg
         tY0j+DyziyencSCz8/GT70atIEPXe5x1uNVNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882174; x=1775486974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIFnVccMuHwr9dEag2kDinb3ZQcKveHam1hNdbO26w0=;
        b=HLFKdX2THnUWKTIZFx6D1HSFfpfH9wa3pOIoeC41HMH3dHGtKcqc9Zc8Lkf0X2ytFw
         uC5kwiRC4xNUt6auJIzbHyB+9xdMftpTXKWsvCNluRKwVynvKcpFAzmbJ3VWT0l/sqLF
         8NBXqbcpspw1Jru1zixKLd3tL3jaSMVw8oXW3gAWL7dmxvuyrGFoiw29XrbU4QLSUDdG
         DRoJey1bbYVStz25F7feUp5hFIqNpZwJETCuxOZcg9pk4sGXu0Pjx/IY21qxIqK5/xUs
         Upo/QoH1CWkFGUNNxNp7CdI9cbHeTWjippWp8qvwnR3ayayGIPIKUSAZzUyEpd5dFYZl
         igaA==
X-Gm-Message-State: AOJu0YwOK9HOvBKwpg0rTPfA0togHv0kJBdO1PZp7fVZBR6R3g6JuIwP
	NSayFKY/t76MQrWK18NuOS1i5YceHUzK9IZpE4hVWIMwKxaH5/yFwBLlMPpGnNu+5fg6fBfwaD3
	z2jw4wg==
X-Gm-Gg: ATEYQzzfRI3e0LDTml+OXi2a4/D9YKkIk6AUTvYGI7oaWAJiMAtnXv83rYhqu87Z94x
	5zVSabn0Gce8sY8cJr7WEWF/WTmnmScs9EOUH1VAOhPfqsODNzmyA0P4nO8JLY48uSwTBwiZ/ie
	2tgvVsCuMPuHXmovpmzv6hTADl1Ndw5ikEoBnodolmgS4TuSeAJfTb6YuStoGg0Xe8XKkzdOvX3
	xn5KfxkLAYuySEKLQpTdT+2PD+IbSyrbWl8jEpArDBsc4oTn78cHpAjpEYqz3/i2OR8Wj1W1fS0
	uG6VCzaBfJYSHt1ykSicqCbSFzk+bIxBESWg75hCASd0qosTKfCG8cnPFQ1x6KQWh9iKAPwxwyX
	p0dOzqLKsChhj5U6++zoeu68HT1ucukVAwH3Ppx+IyR/nAA9p3itpCDVlqWnizTc4aDkyLfJYGA
	I5uVvzF7G4/PoXsc/S5Yumnp8L5lzC9SbJGg==
X-Received: by 2002:a05:620a:708d:b0:8cd:9a1d:4fb with SMTP id af79cd13be357-8d01c5dff66mr1583239185a.10.1774882173892;
        Mon, 30 Mar 2026 07:49:33 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02803f1b6sm631056885a.22.2026.03.30.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:49:33 -0700 (PDT)
Message-ID: <c0b1932ca75fc5eebb3aad97b76f88a9607875e3.camel@ieee.org>
Subject: Re: ReBAR over Thunderbolt
From: Cristian Cocos <cristi@ieee.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 30 Mar 2026 10:49:32 -0400
In-Reply-To: <2f6838fa-dd7f-848d-4788-8b04a23b5753@linux.intel.com>
References: <a177e7cf1e638c874a7b2e9e68027094bca68041.camel@ieee.org>
	  <9cfa81e1-373c-cfdf-89a1-5d7c169f3577@linux.intel.com>
	 <46877507be26e594e42ccf8aa9daaac2656dbd1d.camel@ieee.org>
	 <2f6838fa-dd7f-848d-4788-8b04a23b5753@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-30 at 16:23 +0300, Ilpo J=C3=A4rvinen wrote:
> > [=C2=A0 292.204936] pcieport 0000:02:00.0: bridge window [mem
> > 0x6000000000-
> > 0x60f04fffff 64bit pref]: was not released (still contains assigned
> > resources)
> > [=C2=A0 292.204937] pcieport 0000:00:07.0: bridge window [mem
> > 0x6000000000-
> > 0x60ffffffff 64bit pref]: was not released (still contains assigned
> > resources)
>=20
> These 2 lines indicate where the reason likely lies. BAR resize
> attempted to release these windows but there are some sibling
> resources that prevent the resize from succeeding. I cannot see what
> those resources are from these excerpts.
>=20
> Basically, the resize walks upwards in the PCI hierarchy and tries to
> free any bridge window it encounters in order to allow them to be
> sized freely (enlarged). The device whose BAR is being resized has
> its resources released prior to the resize commencing, but any other
> device under any of those bridge windows are not and they pin their
> bridge windows in-place (it won't be possible to release them in the
> general case as some of those devices may be in use at this point).
>=20
> It may be possible to workaround this problem by manually removing
> the sibling devices that pin the relevant bridge windows, performing
> resize through sysfs manually, and then rescanning (but with GPUs it
> may be problematic if it's the primary GPU).

Thank you. Your suggestion does indeed work! The resize succeeds after
removing the three empty TB downstream ports that were pinning the
bridge windows. The BAR went from 256 MB to 16 GB. However, it appears
that the re-probe after rebinding hits an amdgpu driver bug: Failed to
create device file mem_info_preempt_used (EEXIST from stale sysfs),
which cascades to sw_init of IP block <gmc_v12_0> failed -17 =E2=86=92 NULL
deref in amdgpu_discovery_fini.

Be that as it may, I do see a workaround happening via a udev rule or
systemd service that removes the three empty ports immediately after TB
hotplug and before amdgpu binds. However, I can't help but feel that it
is the kernel that should handle this sort of situations without any
user side involvement. The problem (and please take this as a
suggestion) seems to be that the kernel's PCI resource allocator
speculatively assigns those three empty (see topology excerpt below)
ports large prefetchable bridge windows "just in case" a device appears
behind them later. That's what eats up the 4 GB root port window. If
the allocator didn't hand out speculative windows to empty ports =E2=80=94 =
or,
even better, if it checked ReBAR capabilities on the one port that does
have a device and gave it priority =E2=80=94 the resize would work without
removing anything.

Laptop (Raptor Lake-P SoC)
  =E2=94=94=E2=94=80 00:07.0  Integrated TB4 root port          =E2=86=90 l=
aptop
       =E2=94=94=E2=94=80 02:00.0  8086:5786 Switch Upstream     =E2=86=90 =
Razer Core X V2
            =E2=94=9C=E2=94=80 03:00.0  Switch Downstream =E2=86=92 GPU pat=
h (04=E2=86=9205=E2=86=9206:00.0)
            =E2=94=9C=E2=94=80 03:01.0  Switch Downstream =E2=86=92 empty
            =E2=94=9C=E2=94=80 03:02.0  Switch Downstream =E2=86=92 empty
            =E2=94=94=E2=94=80 03:03.0  Switch Downstream =E2=86=92 empty

Again, please take this suggestion for what it's worth (i.e. my $.02),
and many thanks for your attention to this matter.

Cristian
