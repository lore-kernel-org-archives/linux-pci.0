Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAA37883C
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982814; cv=pass; b=ik7baTSyYd3BzkD+1HvdXR6wXmury0FHBNkQSd9sp2wl3n+zffjoyIptZUNgrkn0bGnhaBGDEF2+MxrfHEvdz8w0AVjQxbg5QRfovuTs/pBSN/g5NNqoAekJu7C7YLGAXwqqcUeN9E74lH0MIpTkj2DfEolorYRhmGhuBUt9oYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982814; c=relaxed/simple;
	bh=PKvYRiI21Kgg1XWi2vNRkTbtRMKlopRPCopKtkbsm+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pswSZ4dNtR46aaxtcNAS3Ybt3dBqFYZjb+ro2x8RCrQl97G8NCNZ0dn4GwVLxSYvCRJr+Ykbrdbsl8tVuk1cozpROMKlzYOdNhBh0n6tpH3+vdOI4zzx2VErcjdPBO9lXxTlasGZ6Li9c2VwOvVecXQvGwKEUtrSmdCO4iWFXwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEw3vykZ; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEw3vykZ"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38c551f2497so55158421fa.2
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 11:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774982812; cv=none;
        d=google.com; s=arc-20240605;
        b=j/v/Wv0JccR2qR/TAtFGXA/gEkVL9M48vb+KU1Sr6pBf0NEJEHJNWZ9otBKjQ2dUqN
         I8WnMQdRfFnwCdo2fRlu3VOwonlu6lfIpwfcpraVWZn5KAta6TrkxLhk3J3JcRsXSoRp
         XP/cF023rq6Q7hNzedYR68RfG69rXwWsfUu5TXyymY49gvXEhQmVkx+S3fAIAF5mIjCD
         azHm2wKooRQXF/goeg0OotM5bronq/QZrsvaVn05kmOEohAJDbY0Jkqv/03s37iCfuTb
         WXhQgv69+532kCroyAaSykDR8IgBDbGG9L0UwR4xArn5IYxEqCNFG6UQkOOLOQVWwq7t
         buog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLipUJuY+nsANkrQTTUf9WJ7NcT3iseNOdTzo946RNQ=;
        fh=V7/4uvjzrjBUIhYsbQexsbaX0/VDH41FH4YxPc6uiZI=;
        b=Eu55MFheq4YoS4QIjeztRN4P7vxc/q1v46eAcHXTBBZqdCDrUElH+yR9krUY8y7/f5
         ZgUTPt4aE5kNzok1kdAei44eNICz4O4vQp6JxoC+8jvs8cqT8YDIYeNa6YHPGfSwiaR4
         m8QaiaZDUbpbbwY550h7803ijv7JIHfOgCLR1frbrM9RSiGJtwTFzlNUse5pGG6oB4rN
         eLrpP697mO7X9GCgQlauWiO547nBsYLGhIo67zAancH+DHOPGb5CXwxwwEXKMVwE1Pfr
         31KyKu9VaTQprzoZ7APjRm1cdEsmKNjo2Hnn+6J0g5b7+QWSOiXg63A4Vi+y6KwbC/Sm
         /BLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774982812; x=1775587612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLipUJuY+nsANkrQTTUf9WJ7NcT3iseNOdTzo946RNQ=;
        b=KEw3vykZvZxmqZRWQ0BXsjn2R4Tbs3vYh/AoiV6t0ZLTJlP+ikyLKBDJJ/dNzpYKZh
         CD9bFWGBwa9OJlUSSwJJ8kkUSiFpPhaKRQ6PpRwzzi4aT1+hxiHbGWBnPZ73cpe3prI0
         SxSkl1JO+P62ILG3GY7fvNvZxZqJ0HSmE0p/HZQetk5COxIO/4WcmPL2KJTXFH7n5XWc
         KilSUgv9zZiz9TDeNdjLGZk+wYJgOdtjrtcZw3tUjE2Z238S5sNtFdAr97gJyMcX/jVe
         jiCMihnYZkfvHOo/Wjfppr10VjX2kNJpsgpFG693BBmSKPs0QJ8PKkKwuIHwWa0RnOkJ
         QUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774982812; x=1775587612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLipUJuY+nsANkrQTTUf9WJ7NcT3iseNOdTzo946RNQ=;
        b=N5zQQCtS77JvPn+aNrGMObf2A+1GgX5VrXDILKg+pFgwLjyeffCdMcnMHne5jQwF6r
         XY3yYlYTns1FYZpSENjIKw13+jqZD1EA9Xqi9W3IQpPmf8QJmY06HGlOt1l9ved6Ksei
         wM73eHRcsdC/gBi1z127CLnB/3wqwfNs8ThDB4R+DUNsmQ/5vumszf7rVI6AshN69lUu
         d2rrmCm7/dRHvxzpcX26AKb+56Z/5I5C65G0tfkhfcKONchMvopXlz0LZ0H8sY0t8T0k
         rfobUFmxaE56e7bMkT7ZKo/KliQi77q4h4KOJh+xIIjT7s7DJUi6ykak+sGx2wpRrIC6
         Qd8A==
X-Forwarded-Encrypted: i=1; AJvYcCVsWEmATPPYN1FfW6SX0meIs4Fbd8awmXbM5tJk059SUY4Zlb6hWGCrScdcsP7tHCdeaFKugvNDB5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoxRxaCgZFLvb17y1eJB/aIvxzyeAdrdXMHVPCgUmq4IIVj8r
	Z2GPiaTC3u/oOO6CZYQRx+uIgnzXVuQZXOvIl8qSaXx2cde+6Yl9mCA/s4WJhKQmlTdkVGkmPFk
	hlSqjQGJBJGpaN+RLGckXAnd4gcLapgABlclN4oce
X-Gm-Gg: ATEYQzzoUKUzPANrwfShvuxHYdgHHwEZEZhNeVwgb+WIyYyoSkQnyfHD2k2GBRbL/S4
	gsurI0nvCNtnFx5GC96i0rBNVAsYibt8m0nNOJfXgu6C/FL8w2QUeUuLfzojKLv0O6n+QT+ZrRC
	lFMqYthK1+wPJtgu1+hHK7rWmp8aEcdtzEB10aFDcxVGtYESMqa5i0P2VJ8Ye786EqNkw/EHHqZ
	OQVBIAHgzE8qz54MFqYbnngnX7MB662nPI1IHWxkS/2zVzQ3KQeWXlgIet4Rzo85+U21j2RvLKX
	+pgOShbg
X-Received: by 2002:a05:651c:54c:b0:38a:5584:ce7a with SMTP id
 38308e7fff4ca-38cc3047cb2mr1368151fa.20.1774982811110; Tue, 31 Mar 2026
 11:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALzav=c7CuJmRjW0-KVk013r4pZZ_CsRtApn0rw9py9cTE-K+w@mail.gmail.com>
 <20260331183852.GA150014@bhelgaas>
In-Reply-To: <20260331183852.GA150014@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Tue, 31 Mar 2026 11:46:22 -0700
X-Gm-Features: AQROBzC0EBAlqKaSnpTquwvLoKQUxRKjGJDOmkcgunFdKFnMtY2SWL8zQLLGWHA
Message-ID: <CALzav=daA0ut2FE-Y07WtYoj45afVte=kh=SNegQ=wGyD+tWvQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU drivers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:38=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Tue, Mar 31, 2026 at 09:01:53AM -0700, David Matlack wrote:
> > On Fri, Mar 27, 2026 at 2:17=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> >
> > >  /* AMD Raven platform iGPU */
> > > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest=
_no_ats);
> > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest=
_no_ats);
> >
> > Sashiko found a bug here that would leave ATS enabled on this device:
> >
> >   https://sashiko.dev/#/patchset/20260327211649.3816010-1-dmatlack%40go=
ogle.com?patch=3D12646
>
> Do you want to update the patch to use DECLARE_PCI_FIXUP_HEADER
> instead of DECLARE_PCI_FIXUP_EARLY, as Sashiko suggested?
>
> I don't know the IOMMU init ordering with respect to PCI enumeration,
> but header fixups are run in pci_device_add() before it calls
> device_add().

Yes I would like to work on another version. I have 3 things I want to
investigate/fix:

 * Fix the bug Sashiko found with early vs. header fixups.
 * Investigate whether no_ats be a u8 instead of unsigned int to avoid
increasing sizeof(struct pci_dev).
 * Investigate Boalu's finding. Maybe this issue is specific to VF
creation, and changing the order of calls there would be a better
solution.
