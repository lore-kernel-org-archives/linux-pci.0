Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525494F053F
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583518; cv=pass; b=YHg9lRwqJEX6C3kS+3VegGtCTrLUaHc3uFgUt7q5Ky4zde9OyeZut4D/LWoK8/13kD8lzYO+/2gLijj7FfTbOfhGpNKOKn4RC0eBQota45Vej4oHmqVksRL+OPyzLHIQuPLvSQ7oFfFGuz9yc5PjDSkZDNoZqAmbXt3Ctgld5YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583518; c=relaxed/simple;
	bh=MlkmGTEOgKGE4phfBBPqWxp9/hOjpHqb2bxTI3f37rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5KBbE+O1YUVk+mQmSfgoBnbypWv1EtBzPqIVjPz9J9roMetFmp/O60YuhpMuisgQZYnD05Er4gzUlUEumFvslNKXNwHm9viJqfyru8nfl2d1cCV+AX61QdpetGoUfl0ymBN52RFSs9GL0HDLqM5++AYgh6Mwib/zICUScvb/ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIySt+0V; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIySt+0V"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso8049066b.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 11:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789583505; cv=none;
        d=google.com; s=arc-20260327;
        b=m3elYVVnSuDx/BF1pz3Q/nNBkaZXbZz2XIz2gASSL/UmuhxY9qnnLoXFVISW5BfW7+
         2QiyF9iFL+Bg1Q2IIC53HO5web5F0M3aL6vrxEsOVvoV8mEq6R/33dXzyRTI9RdKduWF
         6v2hbYe1E+e0zP3ebZR4lh/MpysA3Rk8jEdJxX5arWM7XYOhcaCiP3NoPKIhAETiPUU+
         /9kIY/BPSZwsqGRuG78TJxuMjNtVeF8gW6eSqTNJkEyKGPL/L27pupaXxYrZF7JTka+o
         oTH8hPxOSMmsQLs+DPpAOxQPSHGCdR3r4pO5eb2OwTIHi1KZnjqs6eUHaYg+2lvHXeEt
         4B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=;
        fh=uGhVFdaNW9WjlK/48HNssURKj8izP51yIKeEb/c4lvY=;
        b=f7u0AhWfpJtSmR8IfpTOAovPWO3kcMbmrdTss8kUuRMzyw9RoW3Gx3qKM9eDFTR4Qq
         wjMKv7UqCg84wgYBngygxdA4iJMRRRvuOjNgOTrRzT7nL5RJ5NjNICAtjcipAPvMkZPW
         4VjvNHdwz/8/8lEGNC57wjtALrWxnLkg6/RisCIGLlBXeehX9Ffxm5L/AC9qaja48fiv
         0bMqXeVCKc+S9Y1cOgR6Lc43jlSBNUo5+k2q+dhCFLRorbi26oa7ctKV7B/BE0CBtQeb
         K1SdsdTY1/AQxaDrCpwk+K/W45mareFC/aZzBEvsk7SDMqmyCyDRcvDcOSpSmnqOmgLm
         /ERA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789583505; x=1790188305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=;
        b=SIySt+0VUjNfcqHk6oZyXDCHy67nKrwVRB+2th8R9olPcfWBta9s1SfZ1Ppq+wRgNI
         7uQJw0Aqlk52eoxPWZyvSCj8f8tN6u04+CXqmKhBxzKQILrK38fWig4j333wbyfyV4yp
         CMC31HR7o7+gxdYTveZM0CD0KWWUH+7wZafnuT7ZOBzawO2zpOVXXCkYtbL+vYlnJRvH
         ovEyOdIsY4g1Uelp0/QzuyJrp00svWB3pdKHIaIIh1fPg8/oEdvqRkY3J91VJBws1Oc1
         N2MSYgT7QW8i6efnSSefNpxyobRpAULoDPJR5tby3UHvQLioSPjbsjzuibmG3gqo4WrV
         ODnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583505; x=1790188305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2N3q/7Juy2glVDKTIb/78eRKEUlwWWYByVLZXDb0dM=;
        b=aHHN5guHUYNh9jyzRS2aB3m4NaVYKRqvC4OIp+yxZ59xJqP80KbqOSuHG9ilVZjvYf
         tO+vd0Uc7V9qc/Cn/cujVahprp2wVnxTfuYzZsSqdGyJ5p/ltplRZUdHYcbkYHQZyfhS
         fwoVeC0ugEqO3+99crQ7XQLL9s0oc50NYQdzcrDcLdnlT7buqNIU+VWOTUqzzZWuTRWz
         JYIS8yl//pOylKuaMnElIoP5UjW1lll2Zo84xmtq031u8EzQt9XKGaAnAVFeFCPuhPkE
         volAnbsi+j2wI8MyONHOnjR58wjYZfxjgsh2Q2cLGYVjDmJ0+hIWCVUQssjd2cbd1S1s
         0THg==
X-Forwarded-Encrypted: i=1; AKwUvBwWXtbnsTPUZMpJmY7RzYmWwlatk6PKquXEHEp1OMi8jfKBnndv/oGb7RLaXXfYK3NXLuKmNWwijHA=@vger.kernel.org
X-Gm-Message-State: AFuF++mfk5sd9nWdayXydswxSFtFirsICvW8J4LzGYjcVr/KhuHsDFCs
	tnx2sQ5jRJnSuWNevxLZKF0OBGXa5V/PQw2Q5wTLtq9eGPZpGVF4gFCsB+ljz3HZJ8mc/CEnj6H
	m4VGrpAojLwi0KA9XE259lKxyfots3NYPYzDL9fzG
X-Gm-Gg: AYBFou1t3jjHqYHAbTSOPgOFSP3f6FKIz1z9iIM2x7GLcNpd73UAFaxxxCLQDa0Z0+C
	NBXuRh8zxi55YwUUUQPxjQqfJt++5uzqzhLMCuoicUftjXx4DPOG0x8AD3edIIhWPPVzbm+/Y0I
	GNR5SAuONYRzmOpQc9Nqns0xIppqsyHDzfkF1r6Xg2VJLpXohRFlTFFc9FbT5swXj7II4hwYXMD
	brJ6fp0JIZ46X1p90iFwHLIcM87ZOIIDRXvZCItqX1cbH9vrqCGlOSaWLWipXHgUTBJrgFROgpz
	hsEf69ljLFaRiRMRSpTM8pCbbNWHW608gwSoVBWnuq8PeyaO9oe9etVf2jZhjhT/l77QDUMHU+I
	x8lMFIpsk9DM=
X-Received: by 2002:a17:907:7287:b0:c26:1649:47af with SMTP id
 a640c23a62f3a-c29e5308ae2mr282051266b.37.1789583504840; Wed, 16 Sep 2026
 11:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com> <20260728221007.2098560-4-dmatlack@google.com>
 <e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev> <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
 <2vxzcxud6ol3.fsf@kernel.org>
In-Reply-To: <2vxzcxud6ol3.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 16 Sep 2026 11:31:17 -0700
X-Gm-Features: AcwNN1Xd8nWTyJ5g1jf7rTHS0mmvfUGKUHwbATk6Q8e84nhTP92-8_DCKmvtasY
Message-ID: <CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Wed, Sep 16 2026, David Matlack wrote:
>
> > On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.de=
v> wrote:
> >> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
> >
> >> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that=
 the
> >> > domain and bdf can be guaranteed to fit in an unsigned long and be u=
sed
> >> > as the xarray key.
> >
> >> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> >> > index 3781e2b5f095..8af20f558086 100644
> >> > --- a/drivers/pci/Kconfig
> >> > +++ b/drivers/pci/Kconfig
> >> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
> >> >
> >> >   config PCI_LIVEUPDATE
> >> >       bool "PCI Live Update Support"
> >> > -     depends on PCI && LIVEUPDATE
> >> > +     depends on PCI && LIVEUPDATE && 64BIT
> >>
> >> One question about adding 64BIT to the dependency:
> >>
> >> As I understand it, enabling CONFIG_64BIT essentially means that we ar=
e
> >> building a 64-bit kernel, and a 32-bit architecture cannot normally
> >> enable CONFIG_64BIT.
> >>
> >> If that is the case, would depends on 64BIT be necessary here? Or is P=
CI
> >> Live Update already inherently restricted to 64-bit architectures by t=
he
> >> existing LIVEUPDATE/architecture configuration, so that this dependenc=
y
> >> would be redundant?
> >>
> >> If this problem has already discussed, I am very sorry about this.
> >
> > The necessity is that the PCI core needs to store more than 32-bits in
> > the unsigned long xarray key (see the snippet above). The dependency
> > on CONFIG_64BIT ensures that unsigned long is big enough. We could
> > probably remove the dependency but I would rather wait until someone
> > with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
> > before putting any effort into it.
>
> KHO or live update themselves don't support 32-bit platforms and there
> are no plans to do so either. So I don't think you even need to have a
> dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures define
> ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
> inherit the dependency.
>
> If you'd like to be extra safe, then probably you should add a
> dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that can
> be a separate patch independent from this series.

It should be in both places then. PCI_LIVEUPDATE explicitly requires
64BIT for its own use of unsigned long, so it should have an explicit
dependency. If KEXEC_HANDOVER requires 64-bit for its own specific
purposes, then it should have an explicit Kconfig dependency as well.
That way if and when someone wants to add 32-bit support we know
exactly which configs need to add support.
