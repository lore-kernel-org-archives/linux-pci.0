Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267438655F
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776420892; cv=pass; b=DAac6cgOB9PLiUdqCcOquyC6Ei1CX1wAdI1DaP5f5wDUKY1lnhFLJuVNtXtbA/H4uMHF6PmOyb/gZJsZyIaIZETNCS7Vh5aSX5VXa2XhK5SIjNBnjYLKmxH8mfN1xbBMRLiU0lYEQsPeJ+sTIS18/KdIAnzH0NYr5q7Z5jShQlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776420892; c=relaxed/simple;
	bh=K2TlSkgM3Tm6jsb+/qrjZc7D7La5BWLXkIL14MpPOxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MViSdP2VP7DhJ/S3LQ3PMLbURssmeFSNVlS5wCjEpgGTwuNTX0bhf8EvZqp53qxRQ3LQVBnwgoX1d6haw7GMuKacxSZ/sGe/9Aktlulj3bOgYcWFVwmxXDgyYrUvoA+bWSSXkEydpPclLWyV1vtuGkndKKW2MEA5GNGs4F3bg58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrkN8BQ+; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrkN8BQ+"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296dabef74so544704b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 03:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776420890; cv=none;
        d=google.com; s=arc-20240605;
        b=TDzlNhkiDCOIiUraXf5CeK9FDGKb2WT5OjSzJPOGHcEEsJxBHFaURF0MBjPF7LFWJ4
         x+TMmF5PWrQTTuyWPXtu422DqZylXrhwkoPF0ldGqvk7N8iKlE175eqACd0CVWEsIxkJ
         oHAZO/vWPKW8c/Xf5tYdrwac5fhpmHxj0L0Up9GwZqvnltBx3ktSIF7GQXW/L+JZqIOg
         igI+XOjxBP4VxV4f5r7EjtbaIQ7z1bt1cpj0C/6+aOmliIKRsPoeBtQlctJk8xT1YNIe
         FRqX7Atlt8RIbqks61u6qfjKbpdBcNRwxeFI1Q/Fb4sIULLoIDwRxsz46jw8EhSsNVjg
         TDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2TlSkgM3Tm6jsb+/qrjZc7D7La5BWLXkIL14MpPOxY=;
        fh=TDwJSJ4YxKrYkiko2XBs1HQpZAQ2VmeBdxcrFOmY6xE=;
        b=kky6iVYZ7VNr2ougt1dhnpB1WPZoer4zXN5NlHwzcxcEUTwLywpBynj9dtoDVUfJ/L
         9We96XDO8/FabhNgziZ+teHlwAZzOJ8icVCUTVMXc0NydANg/kQy6mlGiPtu7TBQL3tN
         ToCbI8F7mVjcvgKuBE1mb84Zhacw7igiPktibrKK7o0UqVTERzeZspLXzZT2xCS0sm1X
         tHIeUjXEyFPQsSLcpTC9y55lmLKFEg92cj/I89eajLD+HSwLpVYs3v+cN0NcX9bUVc5c
         RghEAe65mbYH3/WSGU2fTCbLOPAYmBpABUeN+jRiLRiRFBQZR/3nJxBPoKcZTvqN9hxF
         /K7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776420890; x=1777025690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2TlSkgM3Tm6jsb+/qrjZc7D7La5BWLXkIL14MpPOxY=;
        b=FrkN8BQ+8jpeV55TfcIYSXJhqBq8CGfpoMcJFD56pDbXOIxVPPc5d0mkLIBwTJgChY
         AwISbIP2mnYMftl2HSRsqn+8Avq1V9aq86F4jmPgzt/ySYrJfON400fxAHQCH17GfWs1
         D67c3ZaX5HA4UKSE1+cf6sZBqPosToKAf8iwd1C/XhvRCcwrBbcdyaGQx+h8XzH/6ZtX
         DmsZuIYTKgN4ZfhBaVXPEgFTD36K36D85Rsa/fQth4PDjDDB16e8QgrHddWgBaGJ2Bs+
         n4+mOfsb9zphgoYxq3mH5i4y3DwUqd7P2RrxNairP1DtbL7QD8yEPyIK6HBEvY818o13
         Uk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776420890; x=1777025690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2TlSkgM3Tm6jsb+/qrjZc7D7La5BWLXkIL14MpPOxY=;
        b=JtrZI+EvushcsaxV2hH7SKsJKnZ8dfChPJl68VgeJSeBYp63HD2Wc6C6sNeAd1emZ+
         X1ZmKeDKovLFAMJ6f6KfVzWOw/zkZiDUmOwLVUh3yPEkz4C2wV93jp4b2uMEsAqUQxUC
         XVvxp7x9hrwzncEg/v3+ZQZ4/Q+6f9g6FyqbWgz6BKyJPSjp2/lSa/kALjQpcAymqblC
         SJlvzuehA9e2ApVvDWTYSaLm22QSsVGyiY91tSOPoU297YlWZjNiFYCpiVuC60vMh/qN
         NGAO4RTWYRGm3XL+Oqnctz/ZN6be6LxJ5LsxsFDa3zWZgj75XGWGGp+jF+D8eB/ygKzA
         PqHw==
X-Forwarded-Encrypted: i=1; AFNElJ9magbVW3jO8KpHTHbTyM1NJvdqyWUiBf6EeNve7ASsnxxyPQJETCCirmY4g+6OYqPALbmrvcEnepE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiklicrwyTMXSt2r6UkAq1LXdsrsSBs33mr1AqAkk/TFg654md
	RvmTcplcdiS11Bke2+kFlF1RNEsJdTtuhbwqeOB/Jc4O3JSf6Rfa1Mx389JqJrBGlYG81NmsnLt
	Wi1mazGIqYGUPj7j4sx00pFhbTNzS8OZ/5xT3ICL3vQ==
X-Gm-Gg: AeBDievfP/cAouT5YVr4aapjum1QjrZVnPMzuLLnFRaZGQaIJx6tnuBzGVzFtQ6K06L
	jmt6B1ciJEdQG12h19tbJezP8QkVw5zzGDo6DyHoQ2QvkoYkhqth7T5r3wMYWHTE5SB5IacaJGl
	BxEBpLHQ6cakmKmmR25JOZxt388UjZCAotkjlSWSiDY3rnlfCgc7jb4KpbCL9Q3QNbwfpu/6iDB
	q2IWNwqEJsN+FrUf4G3DyvzQlBoo6Ws0s6tQMo5MH7DVF5ddag3TI/+PSslUj+1wSXEUZ+YHoff
	MOqmgc4GDCQy4t1fxGVfhcS9SNufzibjpWI1RCut4jQ2G9pXmgxLJqQg+mfPMyO93CzIYPN3QUk
	=
X-Received: by 2002:a05:6a00:bb91:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82f8c902072mr2229892b3a.25.1776420890379; Fri, 17 Apr 2026
 03:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-eswin-v1-1-a4991725b5ca@gmail.com> <gs3kbuwifduoa3gdhyxpg25tl5kifmlxdavgjgyxmihyt4hmr4@bcwz36emppw6>
In-Reply-To: <gs3kbuwifduoa3gdhyxpg25tl5kifmlxdavgjgyxmihyt4hmr4@bcwz36emppw6>
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 17 Apr 2026 18:14:39 +0800
X-Gm-Features: AQROBzDlDLlBdaIlCsEpEtFegpe7kI1oCn4ClUBEX9xj_7PdK3gRdUSJdHmwlPA
Message-ID: <CAN4SLj2BwACgt-doo6g3KTApC9Rjwm15jSvyWBp3gOysp0Og1g@mail.gmail.com>
Subject: Re: [PATCH] PCI: eswin: Fix resource leak on dw_pcie_host_init() failure
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>, Yu Ning <ningyu@eswincomputing.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 5:35=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> Error path is really messed up. On pm_runtime_get_sync() failure, it shou=
ld
> go to 'err_free_ports' and on dw_pcie_host_init() failure, it should go t=
o
> err_pm_runtime_put.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
Hi Mani,
For pm_runtime_get_sync() failure, it still needs a pm_runtime_put().
So it doesn't need two labels here.

Best regards,
Felix Gu
