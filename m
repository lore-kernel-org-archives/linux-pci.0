Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451593A7820
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954923; cv=pass; b=kJVYTNp/ETj8Gvx3la5sD60QcUvTaC7L1OoS4PXjnyAn3JzO5p0xVAyXr+D0+acvQ0b0hP7O6IqwhKsePL2neoFjBsDAzakdi3A7boCQsyrr+zwqiDEp3qnDVo5qJtNA96B4CepoJ04eqQCOE1MfN8G12eDWxQbVKEiO1q59KaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954923; c=relaxed/simple;
	bh=DW1NTiE5pLHpCUpqDij/x58cnQih+jbjh5U1eBS3LkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/EzV5Na4jM/xm2hNfJZORnzgqApVK2gRwRlC38daT4Nxtq5uqlOQBkfE66WmbSLmCl4uMPVUiBcoiflEWuOtPBUxSjdpazKijtvhczpsmd/8taJ/PhhvMFtR/cNDOz74pP9DG51GSGMIRln4iyIunOUyWQ1RYbRA+1DfBbdpvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LM1l/EHh; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LM1l/EHh"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-948d0d5d4d0so3673382241.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 09:42:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954921; cv=none;
        d=google.com; s=arc-20240605;
        b=BhlpymYBhm+n6L8z2bJIn1+qeP7CDUxxDQqTqTzMxP9rWqFppnfZAsUMlrFbgfghUa
         LjEmFcwBLM6LUf/AbdRg/g5TzLvbYx1Y5KCA5X3XwoctZkR1+AtmwqQYXqtyiPy1EChA
         a9qXI/2jCy9/KK+cF810Iupuwqs30x1yBXhN1Z14jA/BckNL4DDk8kLnYnFcPCD3tuuQ
         u6FxZVtLatmvuO5XMpOrcPDOjHcqczFUn50Zd5GcgSvx025lbX3dmuAV+Lsf86Uov9ym
         pgruzxF36qPkrAlhuii9lEJbRiu+aFyKt58Vur4JAEuTJhLCPOcA50OsKWaVqlX7GBmk
         xBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DW1NTiE5pLHpCUpqDij/x58cnQih+jbjh5U1eBS3LkU=;
        fh=PWFDgpONo0F9I4e8EgS7fL3S+4KaoSi2j93+uCm8M8Y=;
        b=Qk1nvmXMOnHOuJDshzi3moTjLfQJ4UmNl5/5ia6ZhuC8pquKe7LtUYnhJsjlr7Ejn3
         CutHsxQRJ+EZeSEYAwPt0I/hxNtBOZQJ4ma8Vhn0zvRiCVFMTK4K0rL2mG5IVO2JTtju
         Cu1trHEvLzy6kULtJtLHT/8kAspkyAmT6Avzpwh1RBGpOfNfjf1r0BqbEx9FvEfxbOUv
         tlN8pHtqjRXXvj3qbsQ1UmhuiORV821Y3JlZJRtg/YoeVtJGppetzYWKoY43Hbpl/cOR
         4npc6Fm66QVes1emRK77K1uxPDB88J212A0s+o3vj8NJnPUTCTIcVt31FOZifhnJM/Ht
         NCVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771954921; x=1772559721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW1NTiE5pLHpCUpqDij/x58cnQih+jbjh5U1eBS3LkU=;
        b=LM1l/EHhj55rICpk97AjGzEoKZTCkOvw67MrPggEkElFvHHXo6aYksA1Tv8PixAW2c
         kcDP9TJwKCLtrrpUtdYOpt/4+SCeK7McC+hnJKvRET2oll9zwrFJWNx0rpQN0LqzGapv
         IZsW5fkmpWt24fIPqTYPoMOyIieqDARO+ucmbRzeudwdVC+zW6osbb+YaexnAsAqObOG
         TYILgbVXQ81uv91gEdLTvcPb67oYVm9LMuIA60DX2c2rmF3tht+6AA2dzC1Ai9ndej8d
         X/eOBKW9m0WTNJZ2+vWItjgFen30EE+aNmV/3o9rK8cGdJGRghNtSwZdQaAsPxJfb25E
         5nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954921; x=1772559721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DW1NTiE5pLHpCUpqDij/x58cnQih+jbjh5U1eBS3LkU=;
        b=NNdlgr6VcOwsRa4Z1IuIQ4V9qIKOFjHLm6efyx3xN66xjeA7z2i6MIdT78sr9hV7ew
         dy83u4bnRrnnTR4kBudNaR1cFoeOguspPN9vZevq+W7niGtgo3/3Wcr81Eus0kRCsZP6
         G/BXb1vPrikBTvJ9jW1Nq88zpveAHo4CeLAYkhQz0GbEKy2h2bCeKoYI7YQq1aHdC7m6
         5uECRHIk+okKcrQRLw0visAPHtMAgSYuGOEfu8IqqdcGZNz4/13UfUKqO4jtVngdHijV
         J6Qzu/j01+xhU2YCnRFBpubeH9apwWzmO3a5C40Ake7nuQv3Lhh8N3hVVsIeEyG602NZ
         FWdg==
X-Forwarded-Encrypted: i=1; AJvYcCXdmS9UE6oXlPrUcQUJZVaPeQ1NBUGGtGkNPozZ2lOyb8lDzKN6FJd5JqINUyzJ5mgCGF1hGl6qO0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwb6JtBLpkMQsbdjvEZ5/bUzwYa8g51IDylItCGDfCSc/ez36w
	J/ZDfNkZt25i0+VlzewCaxIGMYXbXw59QEab36Q2HYlNfJqIiVbSkUBFwD9BuX8hpNkRfP9QtPK
	88QzgOwBjUYoYPnIVHqVGX/jWbSU7nFKb3zyRnqZw
X-Gm-Gg: ATEYQzyssdtWtAlGtjK0TRmB1CwVQoAdYoFJNL/PmZqFpoa1mpU8qYoz+NT5MM6U3k2
	ep11wBJwtby78kbzdUFzShUBncTpICY8qmDogEL/dHDniul51OIQMU9cTaCo1omiL55hzeEXtCG
	uZmsPaqnwpQ/sQd2UyEzlLqw+4OLGL24II4zfq2DNv8Oipew7JGwoD5QxyOS4WxnH0MpFVcWzRu
	FZtSA8X+OLUESrRd+TO42I3acSX21CezF4xMDUaBPR1KQlpxUcyS2epZ5jEuw9TtRAjkAJpkjVL
	Mdt6ACA=
X-Received: by 2002:a05:6102:26d1:b0:5ee:a083:7935 with SMTP id
 ada2fe7eead31-5feb2e9274bmr7102274137.1.1771954920767; Tue, 24 Feb 2026
 09:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223184017.688212-1-dmatlack@google.com> <aZy6cge_a9a7O03g@smile.fi.intel.com>
 <CALzav=f+p3bcq78dunjEqTOhRHxr8WhTxojYNwJOdYH49p0_Hw@mail.gmail.com> <aZ3fCdkCIAW-Q4-k@smile.fi.intel.com>
In-Reply-To: <aZ3fCdkCIAW-Q4-k@smile.fi.intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 09:41:30 -0800
X-Gm-Features: AaiRm50-MfmnHisnhDMnmwtgeBm9Y6NH0tu9rkRL4ArWmCkZxsPtje6gGP9Ali4
Message-ID: <CALzav=eCZf_N=J9pfO8=-8k9TvCbT7m-=ByCL2jZYni=Kaeopw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable ATS via quirk before notifying IOMMU drivers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 9:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 24, 2026 at 09:19:05AM -0800, David Matlack wrote:
> > On Mon, Feb 23, 2026 at 12:37=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 23, 2026 at 06:40:16PM +0000, David Matlack wrote:
>
> > > > Fix this by disabling ATS via quirk during "early" fixups instead o=
f
> > > > "final" fixups.
> > >
> > > Hmm... Sounds to me like a premature disablement, but I leave it the =
experts.
> >
> > What do you mean by "premature disablement"?
>
> On early stage instead of final stage.

Is your concern that applying the quirk at early stage won't be
effective because ATS will be enabled after early fixups are applied?
To prevent that the patch adds a no_ats bit that blocks ATS enablement
after early fixups.

If not that, I guess I am wondering what is your concern from a
functional level.

> > > What I think about the case, that IOMMU should be probably fixed to a=
void such
> > > situation for all level of quirks. Can it be feasible?
> >
> > What do you mean by the "IOMMU should be fixed"? Are you saying the
> > IOMMU should be prepared to handle quirks disabling features on
> > devices after the IOMMU driver is notified about a device?
>
> Something like this, yes. At least the commit message is unclear why
> "This fixes at least one bug in the Intel IOMMU driver..." not in IOMMU
> driver code.

Gotcha. It felt wrong to have the IOMMU driver be notified about a
device with ATS enabled and then have ATS later disabled. It seem like
it would add complexity to the IOMMU drivers to handle such a case,
and would be much simpler to have ATS in its final state when the
IOMMU driver is notified about the device being created.

But maybe Lu Baolu and David Woodhouse (Intel IOMMU maintainers) can
comment if they prefer to handle this in the Intel IOMMU driver.
