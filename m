Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619C1A9F91
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763135; cv=none; b=afTCHOk2nTUrirZVBHNDsuiOJwejLbL/8zvU91K0spRIYp8Q9siXMK0bImPnmT8NecMDhQW5BJoOLfZmAjM3bQlhDqFB58PTM6TvmL4EsxOQVFT0HFD4DDL33a4zNogaBmUZUXIeMpwMteovyr3vyPdvcJlLpQmuXEScn1vttik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763135; c=relaxed/simple;
	bh=1Y3vWU4/Gx46OWMgl0V6uLO5tsglc91TmNM0hatILyY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=utb9rUSV3ouxs8bfYa1qJ4V03mA3xlJvO4Uwo4fPy/GhGRGg0+h870G0oz9nGoPOt+e2NC+J5xtt9JcvxGWPQvqEDB5QAPBNhpP1GdXYRdGThVKyXS3ovockguOGTVclMo8oJiePMq6kKXGTN9gRaYs1k6aExDnjftJseOONphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=DFTcXGv9; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DFTcXGv9"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89f68634786so13943756d6.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1775763131; x=1776367931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Y3vWU4/Gx46OWMgl0V6uLO5tsglc91TmNM0hatILyY=;
        b=DFTcXGv9tIeDXQjv23dsiG5RuXEwVuMbPt2vqqSV6Io6ZqmgMD+73Dj+JN6gkaSkwj
         kKq6VKNQFZmH7vutJeaOB/K4lqO5ttkVN0m1iPJZh78m0/F2XrZq24SaxrGPLO5Jx91R
         wq8vsR4KNYGpk7CO5Hew93/vnPTVcrIkjDXp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775763131; x=1776367931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y3vWU4/Gx46OWMgl0V6uLO5tsglc91TmNM0hatILyY=;
        b=LZGvNKV5klYAeMlBeX4BfLMh7oqOki+vXb6C3FU0A/PGsdxz0VmfbA4i2dSIEHZ+ZC
         b3NizluvlRW2iQzKa8kJJELfHuLLdByboaYHFv06vgPgYS5W+oDZzYfHHMFKJus5jmRS
         LvYNQYSaDeh5fa87CVcUXAiY/U2SSAFsuWy91/Wr+Ap2lXZuyF4OXDdLJbJx7xYP5Te8
         r8URU+Y41N9Di5kYvQRaHT/xTl/NhJjBn/WgtLH0sdUKhRwIwzM9dgzad/bxLOn2RAcd
         CppbeyWctc+ermV426owXricGOskKKSVJq4CgZgIe1oOhZtz9BqHaFKMSQBCorKO4+ZB
         RWoQ==
X-Gm-Message-State: AOJu0Yz7Q82nEltWuVbE3qZ9I8etOZjPa/1SMV0Ck6C7xjXqnKKm5SZD
	DxxcDabmqo9iI2VbR5WiASTEjhSdM/EW9gcZjyfDTM/nRAd3U3nfYlolLM5z6UFu6sITCBRnUBZ
	EHa/61g==
X-Gm-Gg: AeBDiesP7K9ahfZaU+SCEZClmTZ7aJ2TO3Jio7ROkN2YpTSwT/A9nPqz/E/QscysV5P
	rnYs25rdi90nDW6wariBpgvJniZOU6QKg10b73rUhl5bI5KtBHtujjbYrwmCqfHJUlJjZ+99F9Z
	bFop8FXvYcN/KLwdTAJvArj1ngIjZnIDgdfVv5mMFUNf9q/AwIHtRRGv9cySrRtv2KdLt49wIb+
	s1jjaYBZbmhIvTb0mrsZN+IX9IYTqcXU0XL6CSwIzQmCiYSvw4tERubRSfobiyODdtPSJG13GAv
	X2Se0JcFKywwu2PFzAWY73CiFK8GZ7sIaaft6pMzUWciHXjLamA96AWpwJEb7NrbpheqZkPTUqi
	0VIWIA0v2nLBXqp3ATLH9URWeEmvFWWsTpBggGTUH/PcRHHYxt8ME71ZL8ZUKPSlpavUbfui5rP
	bnuN4ukO2E4KQRz1Cw0TfuB1Y=
X-Received: by 2002:a05:6214:2263:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8ac86220b2amr1486186d6.46.1775763131090;
        Thu, 09 Apr 2026 12:32:11 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db735sm5131396d6.2.2026.04.09.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:32:10 -0700 (PDT)
Message-ID: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
Subject: Re: [PATCH] PCI: release empty sibling resources during bridge
 window resize
From: Cristian Cocos <cristi@ieee.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Geramy Loveless <gloveless@jqluv.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 09 Apr 2026 15:32:11 -0400
In-Reply-To: <f2cf6508-e2e8-d567-66f3-51b094585434@linux.intel.com>
References: 
	<CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com>
	 <4203a8ea-25a3-72e1-c071-db371be045e1@linux.intel.com>
	 <CAGpo2mcyLhY6muz9Zgg3zD=Ux-HT8RXeMvbUi27a+SX=VxCRPQ@mail.gmail.com>
	 <f2cf6508-e2e8-d567-66f3-51b094585434@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This looks very encouraging!

Thanks for keeping me in the loop!

C

On Thu, 2026-04-09 at 16:26 +0300, Ilpo J=C3=A4rvinen wrote:
> On Thu, 9 Apr 2026, Geramy Loveless wrote:
>=20
> > Perfect I=E2=80=99ll get started on these changes, while I=E2=80=99m he=
re, does the
> > other bug create
> > a cascade of problems if fixed?=C2=A0
>=20
> Hi,
>=20
> I'm not sure what "other bug" refers to?
>=20
> If you meant Cristian problem, he seemed to have empty bridge windows
> which this approach should be able to solve without extra problems=20
> expected.
>=20
> If you refer to the resource entries having dangling resource tree=20
> pointers (sibling, etc.), it's not a big problem when the resource
> entry=20
> has been detached from the tree. It has some impact on whether=20
> resource_assigned() can always be trusted so it would be nice to
> clear all=20
> those links on removal (the current remove algorithm shortcuts the=20
> subtree).
