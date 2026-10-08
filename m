Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC423A564
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489128; cv=pass; b=mCkpM9SQQkH1FCMVSFllsmEVb98khd4bqOC+TUCaAHMBNq6oNn+G1Uwm6E+AMwlRG32+7NLHbDKA4x63bG8byY92tg/tmj4J36xCOLqa281k9s5YB2X6rE4ZYRByIM99XIJavqOdSjzYXNixZ1ho/TwXDfUeZNYlEQP1YEbqCKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489128; c=relaxed/simple;
	bh=lMy0S5ANzwD+2QzmOS/TWSb9iQJ3PpBX7ot+juVBF0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAi/WdmRcBlVEWkdXf+acT6nRfka8DcrqCkAw7UVt04ib8s+IaAOL76Mok3QyledjEfPbNm10unTd2VRk7M8UlZuy7J4b0tK02PfnXkQQasGUhm80Ikv4hfpoaO1Rq+4482aImmMPndTVy+nJIVvcD5eQJzVibSfq/RcFp5oDSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdg1j1B4; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdg1j1B4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso2601155a12.1
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 12:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791489125; cv=none;
        d=google.com; s=arc-20260327;
        b=JtnFUNqKn9t/tUqd2TKRbR+Dt+8q49iDS6bJKdO4CtzYFVaib8dMHdcJLbDNBvl9Wx
         0QXQ3u/6fkOlrxathsvXB4U0UJ9w150IIZ9N5v+4ngQkQYekWX+QVz6i761xB7SeNde5
         J+8v8FCnX3xr2DPhBomyTNBPRjjfh5/C5le0mOU7JJ6uqtBc9XslfG69N6l9B+La6qNG
         Z1qggRRtbBXhW9NT/Z+P5kzfT4bDyV1U1KfVnGp5oAYyHakOkfVYV0VESRn+RaaprJ8A
         oAPe8owJOt4wBcPVE5mMGfaPVUiPVccOdVqOA+ZVc3EfrVbHm4biIasQaUpsc+i0cEKs
         nAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
        fh=zPHZTkXtCOmhEreoILB6bOeg1RXzb1jPy776b6mupLM=;
        b=cBofEIM8/DAE1ahWq2PNAXmOIH/QGTSwa29LrXKvz6iBr43GvW/wGerRD7bInJbW8I
         pFuw2mPYTPKkjodqfNmtvrlqUVw+22OIWiJROx6KGKY+ndljdE8BobxkVX3iNOzj8VE+
         QZ3rwFDhY7AQDKd8EJl98FvPJD3RDrvwx+dKL/oI7HIQZilmcynaVlqplIHiSDEsk2ck
         z2gv9argPM8cvwpmmOMMjtMBpICNqOtG9m7Vqj7icyIv+KpFbpnq8hh5m+/8BSb7wYKQ
         +bz1OTOdkqTYBZJRGmPuaJbNMghSsOu3/QZIUfWS6v3KdmL1hI8WbVud9ybUocRquvTW
         TcmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791489125; x=1792093925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
        b=Sdg1j1B4Uf4xjQh8Rc5PU9naPaQ/w71JeW+GMA76988UBM3GVvgTRmIAo3XORTMsn8
         6Frbczd3CpSXKKW+eu1mveTaRYw6uTH7PxjC+/BivPaxOET2tZHdK8rrUYUd/VxL607K
         G4gWxBHEkcxxjIXKERDAF92GgMxSlUcSPuaSEl6pna7GH7jmjlY3e3NLVG2hA028N1Rj
         70hSQsrZjFyQCrRvvuI2jFbCGBk0C7Uy2fkjIPQ2YRePRlJcjNpW+EZk06WB6EbWBSLB
         3+mQE6DWu4Fxnf7JZi52fHPT3GSG28W61XFFmAcjuJMWVYFJCgrkjK95XSEJsqj4nvPm
         c5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791489125; x=1792093925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBn8UBl59QaQ8yJvSSYhTj/Sj9vsUATA1ocADrmat4c=;
        b=XUj43LbVFHR/4pqs0hYwagEK9119AG6rXzBQgkQ+oSkX161m2ovkHRYhtenLUL7cHY
         sCa4YWpL/wosl3bddSYqYGGIiPOmqCtQBWpU+57Vzk0djSO6UWPe6L7nzfhkJJi4949F
         huYGQFJT39UxK/9no3nmMuC/jykd6pRIxMcKK+k4VoGj1xpjywoNf536VfykqbR4iUhN
         +E4sRA4O5IMDAZZxjl1V53eej0+787UxTq3TM7vS9xd3m8E0rG0pGMfIehJni6EgkfwZ
         BJGRY6odk4trKysmjesPeqFvj/EGycvOWux1b8gxdcrm1V20q2ZRa5Slsb852VAOZPmY
         u+ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxFgE1Sk0T0NoZGp2D62zJ/8peTqKume4OY9b8smOwGOu3zRKJgcTDOJ4yW12earlQuUB3wsT+EKfI=@vger.kernel.org
X-Gm-Message-State: AFuF++krAEVZAz1sSJ6VD5uN5AaapUHIOcw3rOunM5NnLRo2yuN+TEuS
	7Xxnj3ftAEhiZ1iD68U4eyA49YVGE9Cede3Q3SavAEiRxfPrJEqxhe2hS/bqIhl5ZFitfWZ9GBx
	ndw72YlXTHRzUz23D5g8QPFx+hnFuLv8=
X-Gm-Gg: AYBFou0ifRmeXfBcHgUwkGuZ4k/IU+XN/cXcYjgV72pLfmbC2N9NdRuIJZLPJ8UkE7m
	+ESTJwXYNWOtEjtNDoM8KVNw9Jn7fDcmNF/o+79+RXTlMhROiKkPgQRXWSaCRJoBKXvc0L5PKbE
	abvYZzqm5t5b/ioA/f4cPnT5FUQq8abE6dzwPGr/fx4O4vPCIFJS3HYJ0/FUOieLORoppoaftRZ
	Xi8k+Acn5G28U9Wq0BwWmM6TqvrsYaGUzgkkoqhw0asZs+cWI5YUU0a+td7hhK0rpLD7Ie/YuUD
	nXUPKre4ncPfR7wacB8YQnKwVBihYN2xJ6/uSDIYuYjG6lpENV5Ea/+9Mt+7R2XNV3/D3p/96s6
	fG2W585+8NE7kdvRZ32LWdTa4eOIeHhQmYn2rLlgrSApz+lmzJDtMtxhriAP4P/8II5T1+tcQ4+
	mSoLyQJgy9FAfu8/jwbiF+
X-Received: by 2002:a17:907:97c2:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c317bb259bemr616599466b.3.1791489125110; Thu, 08 Oct 2026
 12:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
 <20261008193356.GA920772@bhelgaas>
In-Reply-To: <20261008193356.GA920772@bhelgaas>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Thu, 8 Oct 2026 15:51:51 -0400
X-Gm-Features: AclHuK_zMRWk7ASXID34xVSxpJcH7wIRiAis5r8LGwSDA4hkaCnUCpps2BIgt-w
Message-ID: <CABZrw2GqV53Th=QNMZa5+hA0TcAJ1vHyPjKgqMykFxhTCp=2WA@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will test the patch on MacBook 16,1 on RC6. Stand by.


On Thu, Oct 8, 2026 at 3:33=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Oct 08, 2026 at 03:23:34PM -0400, Alex Deucher wrote:
> > On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > > On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > > > Alex is seeing a probe failure of the amdgpu driver after the Root =
Port
> > > > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > > > recover from a Firmware First reported Fatal Error.
> > > >
> > > > However all status registers in the Root Port's AER Extended Capabi=
lity
> > > > are blank, so apparently the platform firmware raised a false alarm=
.
> > > >
> > > > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Su=
pport
> > > > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-F=
atal
> > > > Errors causes code paths to be exercised in platform firmware which
> > > > were never validated before.
> > > >
> > > > Skip error recovery on false alarms, i.e. if no unmasked errors wer=
e
> > > > actually signaled.
> > > >
> > > > Note that this will also skip recovery if both the Status and Mask
> > > > registers are "all ones", as would be the case for inaccessible dev=
ices.
> > > > However that seems justified because it would imply either a hot-un=
plug
> > > > event or a Surprise Down Error further up in the hierarchy.  Interf=
ering
> > > > with recovery from that seems uncalled for.
> > > >
> > > > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > > > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > >
> > > Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-b=
y
> > > since he hasn't tested this change by itself.
> >
> > FWIW, I just tested this patch by itself and it works as expected.
> > Feel free to add:
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Added, thanks very much!



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp
