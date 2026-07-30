Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF2463B6B
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437685; cv=pass; b=Qy68hHBzm7cWp1ffc+gBTGzcFsleXgCqjXJoWflGvCsvHl3NgpUhNUGgao2e+jauP9pS+wRjr6fhn9txkraCsEQgc7osHRaorVVJw1+KDnENi0DSr0ilGR5mNJl6M0eIrLrM0HE/JfX5OtGtAt4PJ4PngAIsijaie47CXHBSUrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437685; c=relaxed/simple;
	bh=IkiGNHJjuO9hKYHK/tR6r4ZiK3H5t1JWZZSj7hulEqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLZJlmuFSW0R/N4c/loOfh+EJGRtpm84XoHoxqQC1OKsi/8oqEryBcU+kQRcjKIOcaeQzNUzhuNbsrX3wynmQkkx4EdhSfiJPoZQ73mBezscekl1iltDZT0lR5iQJ8pqTha8MVWChfc4M4oYo9Qa0VkFRAVDtGZ+x6LFSBTscz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp3Ts9jr; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp3Ts9jr"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15dd4b9132so12163066b.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 11:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785437682; cv=none;
        d=google.com; s=arc-20260327;
        b=h8tCU8Vs7E6xjm26BTMWfanQuv9GZhAmFukTc0P9GRB+mGHgkCjp0e2l8kw7WFJAO7
         i9nCqprIhi5X17IE+ozTC5a6y/6rcB1RMO4IQpvifqCLCZycIMPIkYTfjBnliQqg85ST
         XJd0VeONkiM/3mRdUHKzzlUAtd37WPT/bk9eohBiKpbnRbMztkPqMgmnOZPhfwLZhmKT
         lcxzWYD2FfmFFYzftk6EZ43HaX22XXmVR60VnF51kcfCkoI1o//3HkadQHOX++p6yeef
         nkGwJaKOCHvv0R/WhNGFVhTdLkBjjWJ6Sedm4HXI+s9AV+CT77NqhJoYF47uwbeGJ8XT
         OqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u97Ilxc+wS2K+t2W8mxBSQTwx/SU+RUBSrYOhBVp320=;
        fh=GScZpHgj1eDqBM1l3DkTQLFkQUHm4JUfi624depeMGU=;
        b=DZ48kHOtqitB6sy2b3DO9b2JG6N6Icu4RZXCk0xNgU2R3HowPxRSjmw4z3MZ5V7XV3
         cNrI12nnQQa6bj2w/C/7lHP4r8zkBhbaLUKVO2l/01wmNpfPHiVS0b8YCwfnt+AbpuMr
         g7lmHik0XCfYpyDQE7YxBbUd3YdxOzIogPeMsukphnfQ065Up/4+Zn2+RMWj7ymMs0Ju
         1NDyambktkCsxxWGafzBeKlhx4sx26DCDCFXzwcbbnMArYWGeCqrYphyqOrZpBsBFH9T
         KOpBFd0zEfU6rgldEvf9Qv7KIYDlOgpVZhwTEQtjywbqtIIR2T1IyqUwqehGPvEAiYgs
         cRgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785437682; x=1786042482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u97Ilxc+wS2K+t2W8mxBSQTwx/SU+RUBSrYOhBVp320=;
        b=Wp3Ts9jrkV0IUSCImp9wUfMTrD1RLPHd7SrAxntsPRP11x1qWs+AwlHOjMEShE8sxu
         LAKf1sCuqM+nqvZJMWQqRV7MXvBINr5m41ZFAF1A26ElB7RG8GLvK39RSGvo3e9URljw
         39oGmRJ8MzpGvUbEq27kZVnl3trpgscNjTc7pcLhVzu8uOQIwoziEVHJTYFRQYMt++0B
         5Ju/0aTuxiDtsFZC/3CHkQfNtGWOZc4xgABL8YQNlqCvef5u1hfukJSP2mjAZt6+DrLK
         2AtKsoOALWhvFt1+BKV8EoJmjyaK7fnvckzUPilYYtKBT1QkTQj/SjO6vs1SKbR0QYXS
         NELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437682; x=1786042482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u97Ilxc+wS2K+t2W8mxBSQTwx/SU+RUBSrYOhBVp320=;
        b=AxAIX3IGR56+KZxo44VELa2GQPMuDMRzCgkvtglJUlvY/dpvcDb30DHByJumf2Ufmu
         NCVWTNcJL5dVduOhlVFQ6lvwHeekzDLJg769Sptutw76j2+6sxCj6ZMdRBTRG0vqvu4V
         eDfFnLajjtMuJ7fQ+6nhXmGPBCxyYm3s42FAnYmmYy2iU/tVrGJgODEphPbIXTsXwFQU
         IjxAi8sIk7TtBxwF8VKi0oC6b3e6WTCY1punjC26CXPqLzazzMSMN3iMKpkHlHG/oJDJ
         QkSNv9QsCPzbDTXWJDqfUuAfM+nmATriiPxotEU7OSsckjY6KTtwKrl0wBkLppUdKmu8
         RJJg==
X-Gm-Message-State: AOJu0YzsjO98MpstTtFzVXbj96Lu3zgw6y7kZUMZ/Mx59K5rfOrzpCWV
	i70haRCU8wGzaqiUR3vG+4JHBAyBDHKAuvc4Vy7vVfiy16sLp6Gi2qByvz2u0lj17pvWi4AoypY
	t/r0Ur30/uW1uSowZtbZjEnPReFqTyTIJXz0CYJw=
X-Gm-Gg: AR+sD1001sTd3Embg0xGplib1ZtyganLc+L5sbheQgrDN3GXkdJX0f5ha+OgbDds0Sk
	oHio3S1T6wJxDze/06pzMW0ijMovl0UOJwjTFvYZ/x9LBjGFb3XPNovRpYIKIkSnOkXorPd86X0
	23w1xhkk6Te2d9fU593htCeUPzOx+5vqbdjPQZx2PoVsS/NMic2t2MYjYka8C3CRva4UGXOZjQw
	sGqIONGHuTXYJ0rC0lLoBUBPTW5sKyBxlm+pEFEJGapQDYsvqN/ugkADxqP2y40/lr96LS+J/wY
	WPuvtJ/ThVvrniaZJxj40dNL/9yoIDQzlwHmKgNwcIw++g9AyLWKmtOlbkHkgwr4bLLClf8VyA4
	JAXYsBLHXYSHJgZwaZkFLtB2CmZyGH36x/wMLYgFz8JLNqPDpczTA+TwkUuygUhaGZtq4ymTmOi
	IW2mQEQH/ZieBaGoS8KUgEZM82q5hTToMc8pCSrhKmMxkFt54oLFHNfyQjVPbBClWJdg==
X-Received: by 2002:a17:907:3cc4:b0:c1a:5d49:f9d3 with SMTP id
 a640c23a62f3a-c1fa5845675mr174898466b.47.1785437681452; Thu, 30 Jul 2026
 11:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716205811.800920-1-rosenp@gmail.com> <g3gtckpqgacw44jqqb5hb3oejpelxvbba47tdwsvksxbbskygp@mcwtsbypoyar>
 <CAKxU2N_f1nN4Oo94V9MY6Q-wp66j=3kodfMs0BeXVGB9XivvNA@mail.gmail.com> <5ea47pp3ctiieqahn3mkcg3dqrlmwdgdjyv6pa65qmjuqop4lb@tbax2lojuwkr>
In-Reply-To: <5ea47pp3ctiieqahn3mkcg3dqrlmwdgdjyv6pa65qmjuqop4lb@tbax2lojuwkr>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 30 Jul 2026 11:54:29 -0700
X-Gm-Features: AUfX_mwQA3n8phj6W2IouoFwXDxL9pe2fUfCvfsSUCFuG6D4skJUDTBpP3OqTjk
Message-ID: <CAKxU2N-2Vj1pugC_L=jhMS06CA34_-a-txZCrAoUtrRwFQ1Stg@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Michal Simek <michal.simek@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:48=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Jul 29, 2026 at 11:18:15AM -0700, Rosen Penev wrote:
> > On Wed, Jul 29, 2026 at 9:00=E2=80=AFAM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Thu, Jul 16, 2026 at 01:58:11PM -0700, Rosen Penev wrote:
> > > > Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev),=
 0)
> > > > in xilinx_pcie_parse_dt(). For an OF-backed device this is equivale=
nt to
> > > > the previous call, but uses the generic firmware-node API.
> > > >
> > >
> > > What is the benefit of using fwnode API for OF only driver?
> > I get conflicting information. Apparently of_irq_get needs a call to
> > irq_dispose_mapping but fwnode_irq_get does not.
>
> That's not true. fwnode_irq_get() becomes a wrapper to of_irq_get() if OF=
 is
> used. So both needs a call to irq_dispose_mapping() in the error path.
I don't see  irq_dispose_mapping() for fwnode_irq_get() in the codebase.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
