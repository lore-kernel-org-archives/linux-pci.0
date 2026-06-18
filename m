Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9F2EAB6F;
	Thu, 18 Jun 2026 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823082; cv=none; b=YBTNFnfBCeXEdL7C3c47ItR080Gua8ofEyTdyUgFEvKUe97KJPlF1PjEf+N7BsxncnCSHw8UXJT6S0yj+MT3BL+91SbEd7RwFgVaXMgz0wj3c1eaVeRteAezgwq0Kq0WHPufsq3dWGKKDmx+9YoaFj/Y7Mk9bDo9FjQTCBb2PHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823082; c=relaxed/simple;
	bh=l5JLDiEK6/pZKY9JEXTIipXBfQSTEox/J8MQKHr9eJk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ES6BVfUO1cbGZSojAWm/KOMNqJy9XU9XOpV4iQiP8vqoRKxACpwzT9Slwv2Qe/r7Ej9sK0g/yjCpl86mX7/EZOsnjsF+jJIZQVWvI4AGsfdWQ9yT45iDjOpFDoX8nTtNMhGYNJwgioJndPOpBZ/lSujSojkKRk8h1/1R/qMGSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVNB3F4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVNB3F4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6284E1F000E9;
	Thu, 18 Jun 2026 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781823081;
	bh=oOAbP8xKfm80UZgXYHP5B+5sPPFMH3yupmgzChKHEnE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=YVNB3F4IpVaqNIEyRWzQcHl1KICCcIA9L6mgIY5m20lek5NZg/SpnhjDZdRxzCBL6
	 mrt9nWDumPQFYxCZrbBnIjHij2aUiEU0jhtueWPZ9n5338u/ikb7Xa6NymRG1x1n71
	 nMsSr9PTDIGyKHiUtXONocBc2bksyoe1rDdeGKaMXmS9fasRnY1qzm1L3IGnwNkhc/
	 vvQYW1PlXOWd8l3AHmVf5lQpwAhGqdtA7ImlWog/A9kz+evmuGk0ed2mQNOtGmHED1
	 X+Hxq3TwqWRa8FRDVmhoLo1tPauK2HrD2mqB/UMJszxVnuFUQzb1RJzDiV7aa94Hlh
	 4HK8416vYfP3Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B778DF4006E;
	Thu, 18 Jun 2026 18:51:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 18:51:19 -0400
X-ME-Sender: <xms:Z3Y0atoRo52uuFgHoboTi2O_f6He8BzbF5gDrVrNZRQPv37T5ePi2A>
    <xme:Z3Y0agE93TzbgF3uYthkLgydslnLIG5XpzSZhBc2qX9p4Q9hvstiIdRPw2Ujun_uD
    c3fMlXCW8ECycJT224cqJGRwR6xFdM-o7aSHruHGXa3u0gzR4ywR50>
X-ME-Received: <xmr:Z3Y0avoirJ656aFQoumd8LRkaJtV2ckjs09XA4SpZG02THQWMtdxrNV-x7p43lJ6xbzftAgpkk4rjqr9fB517FhdNcWcSHLiHS4>
X-ME-Proxy-Cause: dmFkZTEfIB1PKX2sBNDnafA1xetF4DastoF8Z48hOiquKqjU/V1t4Mby2DhLkKbXj3sAy6
    c0fmY4j8IX3yzlgO2fjc3oMFMxZN2M92bM+HhZ5omO//3DiEje5u3Wa1YZuJkCy1c/ZfWS
    Fbo1WKPjZd95Ybn9a5+skUso7ODB2M4vIkgq2hP0z3nZn4A6s4w9z+4Aua3bP/y0huKcBq
    J+tdXsv/M9Fyu74m+wxpsBeUCuFbkWvPv1l5awUkxm9cQfsZc2aHIBiHN+3SikH1e2hYoK
    BxGvXgzwdtCIC/BnvDqFbz0zJXPaPUg6hfa4Hivm1HFQ1uS2rbkoj4rzbM3vRtAI7WI/Cv
    VRmi63QXE+29He9YkSsjhCZUsswHxrrQK7SSF/85afioVy7RQ8brNJ/RT5AwrzWLqDvJwv
    6lU/BbroPO/VlueuOJCNOtZjraUcPHJz7v2x2g8BbY9XF1ZYPaxkqC644hCRInN59ZNlGn
    DyDYwU0Td1M9HJ5MHoc/5dJwIaXEztYd1njgTodcvH+QyNuuMf2qPxJ2heCMOqoy2Er9eG
    vctQV8cwDO7qLsBggoLgyK0PMngT4Da51NnFDvZ+nFRA3k+qeEcYzzrjvwllW04oDJUkS6
    voOKPwAYB1lwCaoYIf2x73cPXx9fWm3iYNkV3+8AhH3E9yqoFF7exjd5+Jwg
X-ME-Proxy: <xmx:Z3Y0am3XZ1etSLHQRR7R2uY3XxJetXfZp9oKutmX98J58VZxt2Bq_A>
    <xmx:Z3Y0agsg9pjMQW5a2MFO4OmYeBE2TBHfljyDDG5TyiaoXHwUp7GMMQ>
    <xmx:Z3Y0avGNgmu5x1s75bUs7NJYj9XQ6XDKGeH3QluPk9KPAinOuuTAyw>
    <xmx:Z3Y0av3aClHYWRL7r90DtWzvBF8FtxMvTt1tDd3P-FgCKoHNB2WQRg>
    <xmx:Z3Y0apoyrE9vUkfS_qo0zGNuIkXzFQA1daMUf3W6znTJk1Gvjmsovt1G>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 18:51:19 -0400 (EDT)
Date: Thu, 18 Jun 2026 15:51:18 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alistair Francis <alistair23@gmail.com>, 
 alistair@alistair23.me, 
 linux-kernel@vger.kernel.org, 
 lukas@wunner.de, 
 bhelgaas@google.com, 
 rust-for-linux@vger.kernel.org, 
 akpm@linux-foundation.org, 
 linux-cxl@vger.kernel.org, 
 djbw@kernel.org, 
 linux-pci@vger.kernel.org, 
 jic23@kernel.org
Cc: alex.gaynor@gmail.com, 
 wilfred.mallawa@wdc.com, 
 gary@garyguo.net, 
 bjorn3_gh@protonmail.com, 
 benno.lossin@proton.me, 
 aliceryhl@google.com, 
 boqun.feng@gmail.com, 
 a.hindborg@kernel.org, 
 tmgross@umich.edu, 
 ojeda@kernel.org, 
 Alistair Francis <alistair.francis@wdc.com>
Message-ID: <6a34766613a27_299c3a1001b@djbw-dev.notmuch>
In-Reply-To: <CAKmqyKPc4hMYg5ARw3RH8KJwWfk-1CMT5zqnVrbhtdT1X3Z0aA@mail.gmail.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
 <20260508031710.514574-9-alistair.francis@wdc.com>
 <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
 <CAKmqyKPc4hMYg5ARw3RH8KJwWfk-1CMT5zqnVrbhtdT1X3Z0aA@mail.gmail.com>
Subject: Re: [PATCH 08/18] PCI/TSM: Support connecting to PCIe CMA devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alistair Francis wrote:
> On Wed, May 20, 2026 at 3:56=E2=80=AFPM Alistair Francis <alistair23@gm=
ail.com> wrote:
> >
> > On Fri, May 8, 2026 at 1:18=E2=80=AFPM <alistair23@gmail.com> wrote:
> > >
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > In the next patch we are going to add a PCIe CMA TSM driver, as suc=
h we
> > > need to ensure that is_pci_tsm_pf0() will allow us to connect to CM=
A
> > > capable devices. These devices don't necessarily has DEVCAP_TEE or =
IDE
> > > support.
> > >
> > > As such for Root Complex Integrated Endpoint (PCI_EXP_TYPE_RC_END) =
we
> > > also check for the CMA DOE feature.
> >
> > @Dan Williams this is the patch I really need your thoughts on.
> >
> > The current upstream pci_tsm code only works if IDE or TDISP is
> > supported, which isn't true for CMA support.
> >
> > This patch works around that, but the more I think about it the
> > hackier it is. I have a local change that reverts this and
> > updates`tsm.c` to work with a DSM (`->dsm_dev` is NULL), but that
> > doesn't feel right either. Do you have a better idea or how to enable=

> > a CMA TSM driver?
> =

> Gentle ping on this. Any thoughts here?

Apologies for not replying to this sooner.

A Device Security Manager (DSM) at a minimum provides device evidence
validation and retrieval (CMA).

So my only comments on this 08/18 patch would be why is:

	pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_FEATURE_CMA);

...limited to root complex integrated endpoints? That capability could
appear anywhere.

No need for ->dsm_dev to be NULL, it reflects the truth that the device
being connected also hosts the DOE mailbox.

Perhaps the discomfort arises from the fact that CMA can appear on any
function while IDE and TDISP are limited to physical function0? I agree
that needs some fixups to convert the "pf0" naming to "host". Where a
pci_tsm_host is any device that knows how to speak any of CMA, IDE, or
TDISP.

In the case where a device has CMA on multiple functions, ->connect()
hould be allowed. It only comes into conflict if function0 supports
TDISP and has claimed all the sub-functions before ->connect() is
attempted on a sub-function. That seems a rare corner case.
