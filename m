Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D33243DA50
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082193; cv=pass; b=dq4ZCfRFoDtnRognqaOek47pLasH7I9X9REcohibwRf7ILYv5UORHL1gVXUmIQqG2AUqZqa1+eQ9MP2yz6ECBXfmE51ZURxkEyIuWhqD3T5J8pDvJ4RewpJBj2ywvMTW3VXwcvDsfXd1XTIA6X0YypJuCbpd4rI5p9SBoY+I+lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082193; c=relaxed/simple;
	bh=Q1Hbn8A5ixxsCYzm5kvN36Nd0MTAUla5jdeLPZM2QAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqmwXAF3SYLFL9+1su+ByI9Qa7T+3LJetI2xpcaNSaflbO6VwsH87DjMnkGwTiCRyMkBq5tu2qIZ5i5LP1FTmh/wYYPdJpKoS6dUofH23IKJtb67e7ExQyAz2Z/TN+1W+BQJSAJrx3KPOVIV+KtdfT+Htwkjd5ef2FNJQ1XUM6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=hCxO0nuA; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="hCxO0nuA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49ff680331aso26089275e9.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 09:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792082175; cv=none;
        d=google.com; s=arc-20260327;
        b=rQ1fDvzSO5scFb1Kw6L2Lc8koKnTsiVF8sZLZEFO6mrUFAgaFBoRxhGL4QHMSy5G2Z
         4bv3w7412eesl8hfNEnMf5yaGDX+NdTblDS0EJ622V47hgt0NuyzIP7BeKUgyw31FpIr
         vHNjQebsIH5yySs5BYZPYJImzmSylK2fwBhGifI2WQQDWe5+B3E8kg1pTbNrz7jiN2As
         R6kE2Az28vDXNiPFx4Aw4WqdjOiHePv22nfOLXqavr2D0iE+jRg8YuOsRnjvbSFBhsz+
         m4n+t5yCFNSfNh20cqdD2zPKLVrNHtzJuO22hcICsQSKuxTLKUWNzrR3YdzUVOKB+JgG
         qiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZTsnGl93T9ATaDuHMEnI+XuoV61t91q+RIl87Urhds=;
        fh=ZCehqzGG3M4rg2HlwRo1DCcU88knolQvez+Op1YmqHo=;
        b=ZwneJkQPhZX693YynshjHcypIvOtnRWx2aBfOCRbNiN341Hjod8804yBRfZqQxqGFh
         Za/nFQAefPcQjOBGYqkwYxPWBwteO5v1QfZYZOMOdOUhnaHu90/jgPDufBEBx7ZvhNma
         oLlJ7e47etG8RVAXk4UuH3LQlphCaVTRbSyRmu1EDt4yZcXQ8y6G5buXGO6MonwmkhC1
         wRbphKL9gVQIkkodugTb2Gt5q7KLdqTfX1tdck4tTMr1HPLZIyxmFowTKzGcHnQDjB5+
         4l8lVDfNxm5Af4N5DHIgE+Vd/PBnYsECJZd11KPxE6vnkTclZ5s3x/8g9XPPujFc40h9
         fq6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792082175; x=1792686975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZTsnGl93T9ATaDuHMEnI+XuoV61t91q+RIl87Urhds=;
        b=hCxO0nuA/h9+fXdy7YdWXZk1zj3kB89t+5VcPf2MOgn4vcnWUsKOE5CF9/vTsm9BTr
         y2OcY2vEGENhuXym0537aFsxbJU/rv6KUx3uTq4Pyo2t6IPK8JKvVEqsO8p072fQ6OXY
         kX9rCRYmfUmMWvR039MNitzhRxXwoxT5xcrzlcMK/52kwDTuAgxzpjEks8j8cCn0QHon
         5kfRAKrtmRkC2XjBP5c758wTP2gsskKTDfL/ZDTr3h05lCES/Zpkal13guzd6j8otd6M
         2HCMXD3vA8ynBFX7/mzb9z3Lc9b3WZPbnYLh14uRg3y6dkKLENCyWqO9sp/Goo+VEdgU
         sdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082175; x=1792686975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZTsnGl93T9ATaDuHMEnI+XuoV61t91q+RIl87Urhds=;
        b=hU2Gtesol3hGAuedE0H12f1CzZOQtZWabXQyBVQgC/XDGEUpWurGAse2JtR+Cggo2e
         /lgJk30djMC1ZjmGZFmeAY2nLBtvyw/B+FFXuSza3ukAZSBB6aLePdKkrTeLaok8wvWa
         NuKnPn7T6E5FP465R5sKI0mY5rvS+/HM+62VzwhfsGeBPDok83rC6LtYlAQRc4Qmbaii
         28KEXkfKF28pLeuuBDiRvNgjHqb0063E1AcP4vrxSpuMKEdm33GVvj/WzUXTatkQZoa1
         L5S2AOgjHxUNWtD04x4Vt92PWGwL8W+52O4eFGSf/Nqxol7v8G4zUfE1ZqGapc58XqX/
         NwFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPRXTboVtYf2EQIs+8cFmCSZmswBOdWU9h1u19NoaV1OrehazGCl7E+QbgzFs2u0DAZUoU4tGnGxs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZb+0l/HSU0l+h/+Q7aoI/C8SjAbaDp3szBPKSTGQ8AKZhf8Tw
	C/cWpv1dw5W2FGn2RASH+a2jnc0zVQTO29IxMPKxLshhCB+NwPLi2ZnAagO91tE91Gf4YOqRBH/
	K3io7EQ7nz1VU6AkIiz7b9HSoF1e+SUVsDcrDycDsTQ==
X-Gm-Gg: AYBFou1psvAtgId9H5KiG4JNOeBz201pbrNI+F5t9/pf+duXg19Z/UwzYrtv4vjI4nt
	lzA02XIQK/8wj8MZmcbKjZEhGH1qoZs6dSAv7acPVYf808WJzc/UiB5X5BZ9VmIUmji516RUrPk
	xOLDNCdyUV0OLLbMtCzScnoZIyhob6dLYtb3n/7F0yEH1U3XBnXbipSGjYUW8EYUux8RCCVOqbc
	1iFZBawJwZNPNJE08VKOogSCLSejDxOxXV04VTkz6o0i73OwLMR9B2F8G8il0RdxbVK6+85bKpA
	YN7xxFd9fhWdShx2hGQFxUwtPyjDlCR5cquawGuJLz/vcdc6pautQSq//wZigayRqsZ87/5MQ9w
	h2cmizyKCqiH3Y78P+J1d1llsJGQ3Dp+FJiYuzT+9pKfWfA==
X-Received: by 2002:a05:600c:3144:b0:4a0:2423:946 with SMTP id
 5b1f17b1804b1-4a18e48d362mr391589485e9.15.1792082175349; Thu, 15 Oct 2026
 09:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014190815.23455-1-artem@trailofbits.com> <atBnuPOa68f21L6C@debian>
 <2026101501-willed-gracious-cc62@gregkh>
In-Reply-To: <2026101501-willed-gracious-cc62@gregkh>
From: Artem Dinaburg <artem@trailofbits.com>
Date: Thu, 15 Oct 2026 12:35:37 -0400
X-Gm-Features: AclHuK8y_jc3VDzcJv00TFRcnHd-VT4h5bEOUBoAM87IHLQfMWP-617JGGgKnqY
Message-ID: <CAP3zxaDs7Te1utQu4Pi8j5fSkJx1PbxCS1N0jXqjcO8x6jQ6zQ@mail.gmail.com>
Subject: Re: [6.12.y] Please apply one upstream fix
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, stable@vger.kernel.org, dlemoal@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, frank.li@kernel.org, 
	bhelgaas@google.com, sashal@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani and Greg,

You're right, sorry. We haven't hit this and don't have the hardware.

I was preparing a 6.6.y backport of 934e9d137d93 ("PCI: endpoint:
pci-epf-test: Fix double free that causes kernel to oops").

I had planned to send this commit ahead of it, but upon further inspection
that is unnecessary because 6.12.y already carries the double-free
fix without it.

Please drop this request. I apologize for my mistake.

Thanks,
Artem Dinaburg

On Thu, Oct 15, 2026 at 5:55=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Oct 15, 2026 at 11:13:42AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 14, 2026 at 03:08:15PM -0400, Artem Dinaburg wrote:
> > > Hi,
> > >
> > > Please consider applying the following upstream commit to 6.12.y. It
> > > applies cleanly to 6.12.112 and is already in 6.18.y and 7.2.y.
> > >
> >
> > Please explain why you want this commit to be backported to stable kern=
els.
>
> Yeah, this is odd, it's a test function?  Artem, how are you hitting
> this and why is it needed in older kernels?  Can't you just update to a
> newer one if you have this hardware and want to test the endpoint
> hardware?
>
> thanks,
>
> greg k-h
