Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793323C50A
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781748309; cv=pass; b=DclOA2Xn4SJmhA8cSyhNKqPpO820SdhKPb59NTOiRxUltFV4O5g1/MshvvkKziZEqwoX+P41JaxnpJG54tpoGwRWR23EsKr33X60puWg8fd8/JwneHxdMyJSSNfM6X3WHGpIutugHDPVRrfMXCsIC5QpUn2pzYOonLGZOhKNYPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781748309; c=relaxed/simple;
	bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvnR9cnZ98ORD0oXFc7s3X4q7FWSQRNGgDrlyV4BEWk8eu9OC8QR7ghi8/s+1EzatXCkTDNHKmpUNPcGtkCUQt7N1sSiJIHwHTkLs13QyjhwiX5tJ1AboIWjBy71/MD2xqEjxrXXRrNNuM0Ec4OLigmQxdlHdpC1RFzu0BhozOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KySmqt2x; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KySmqt2x"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-695baa469b7so558891a12.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 19:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781748307; cv=none;
        d=google.com; s=arc-20240605;
        b=Kh6hcOHmceSUDsXTacHqo+9Id5tcBMavTr58JNxs7ey8QKHXKAw1MX5NcpfzQF2Lz3
         CgmQDbTH8+XUXLIpvFRkVv2a+Hevx3XLRvxxpVHZp7Lv3VGLJv0IRlEscTqUvb8/JBRi
         6Emdv0mscY7Uw02xUjlfwWNdXlWwUhOzMocwCQBb6WhNMa6Ab2HIikiVbVLny1ENRfyT
         V0yMQoLjeq9EMJY1T6Hy0yXydqZSOCBuw0FqAqUZokNVzSMU9TaD++cdCCHDBFsa/mOZ
         7eq+XNAX1bCy/2n2g5PON9trIkgp6cS0O+4pG5t7ZT28TE2WsbvAgM4SygOqd3Gq2x2o
         aigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
        fh=UHn/Axou0c9zIMtXYNr0QDlWqyQ4B6pksfzHa/U6tGE=;
        b=luHqw0bWRWOZIgS7hsTLvQaEeppw3F8MJdbt84+AYbVxB1kif+LN5rz5Je/UkZS6QU
         /ojFWvB7jpUGo8hshpEmcq9Zc8k64GztmZwTt+eCmsrPXrUerxjlU4Pq8/E4uU7RmudB
         jx04JBf8Zi/vytu2ZQ+ArC7CF3Ue+iUcUirZSZirl9kr1ESL9M8g95FMi+Ngoafgo7Gt
         py8AgoqPEg67za98jgLl1P4Os8GWbMDMz0awmOcVEZjTWdfD8QKUhUCU4JZv1VVKydHT
         H9E4oCZlQhzcZuGKazqr9mMJL3cy8m5xTnUAx6Yzk+PKATvyQa4SDHU5WIXYKxIyX4QA
         Uw+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781748307; x=1782353107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
        b=KySmqt2xehvM2eUoj4Pp1KPKSt1XxIo+WP3pl27yRzCdpQiEtAQwlrJyjOLwzUoeCs
         rqMHgEFe4AcAFXnsgQ+DNzKB9fLnUNeebpN2WFIKrGWgVnsYm9feRz9qGpLU0ZOXngil
         LWnJSOD686K/qVeJ1ps2gcM5efCQsdRE4iKo4C290llAjD/zxhGD4fKL8doWXmOQOw5h
         n36kOE9n5qmGYbQ6OW032sCU4aprf61X9QNCnCk/wiLuqfznpXUeQpX5gw0vxZuV0Cex
         L7oXOWW2COqKY2wyiv/9uR52RGZeadMz7SxeNupOO6ovf1L4LewwNzavOkFFmxdd+dfo
         9xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781748307; x=1782353107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uh7eZP8JDYxXDuPFo9zlO/GeRgtPSOu/j7Z8w6X4Mzg=;
        b=I0F3U7DD+PnU8gUzax5YBrTqxUuSyC2fyXV6m8ExOrNoEcE8tqoemVAmjWCq+CUnGJ
         TLRD35GewJXwyNNf26qnv7CDSRsZgrx870wnbtUbNFuz4AvQm25Tgkbr/f4fOMs5P9lY
         d4ZYTIzG6SORMDa3YFRB4wB4b0uMe8sRD9E++zouzmti9PZ3MWJ7npJYU7675lDlBwVn
         QdZ0hiAh6uHgnX6fQrPp8cdSi3WRK95oHETf6/W9VSc3Nm6553Eod6Uo1j2Rz04OEYzg
         52aTRa44s/GLhzFwGn3inRtI0q18AqPX/wjgwvib7Yhq5RktdaniwGYpqKFZ41Rd3FG1
         vazw==
X-Forwarded-Encrypted: i=1; AFNElJ9c1MW01X3Ev6jp4gJguP3doYP/8zEpk1q48s7/IKH/aiqFTTnR5ToR2d/koUNndobVQAJqB5JiBqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFB0agpOa4DluELXo5NVi3qDhOjJbt4PIX6JY9s+U+YzVf4B0
	owUV0f9pCzUoTNxOeACe6TjiWAMvFDQ1GRobQf57Wv75hbE9JhEgUVfgEIAg4kmvSKCsB3tCgkm
	9d6D7k0khwV0lM7FKpWW80o0YoL0+wOo=
X-Gm-Gg: AfdE7cmfwVkzyAMTOmzjhRZ5VK0eYkgQXqtC48CeecpA4Op9TNYKkQ/MdVbn2Eeneqb
	UI6joWp+siRZI8D630ZG1QWC0Cg/Xk0u8LTXXCpJ1Nu1jWN8u+za1FqnUvCCd6q5Wn9QtJs1Rxg
	dy15IbD6JiHxHG8X2qHNamd2XEIpUqp80Zz+uC1dsRhADQqUvjY5U4gDeP9eaqINBo3tpCWrwq8
	/+Zf2xu7jgNpeir7IQL4Awpfw7llOHTDT6L2vYjUN3M5keQvB1g5WYFoggiL64y71NmNzKxjMKA
	5Gnp2m3h+nMqMXqR40O2IXRx3Xk=
X-Received: by 2002:a05:6402:528a:b0:689:b30c:421a with SMTP id
 4fb4d7f45d1cf-695ba1b22cbmr1043888a12.0.1781748306691; Wed, 17 Jun 2026
 19:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508031710.514574-1-alistair.francis@wdc.com>
 <20260508031710.514574-9-alistair.francis@wdc.com> <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
In-Reply-To: <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 18 Jun 2026 12:04:40 +1000
X-Gm-Features: AVVi8CcEcPCPlTkWNTLD3VXO0gTKy5uNbpMM9S8kJ68bCzeLwWNcsIIDADOjRnk
Message-ID: <CAKmqyKPc4hMYg5ARw3RH8KJwWfk-1CMT5zqnVrbhtdT1X3Z0aA@mail.gmail.com>
Subject: Re: [PATCH 08/18] PCI/TSM: Support connecting to PCIe CMA devices
To: alistair@alistair23.me, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-cxl@vger.kernel.org, djbw@kernel.org, 
	linux-pci@vger.kernel.org, jic23@kernel.org
Cc: alex.gaynor@gmail.com, wilfred.mallawa@wdc.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:56=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, May 8, 2026 at 1:18=E2=80=AFPM <alistair23@gmail.com> wrote:
> >
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > In the next patch we are going to add a PCIe CMA TSM driver, as such we
> > need to ensure that is_pci_tsm_pf0() will allow us to connect to CMA
> > capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
> > support.
> >
> > As such for Root Complex Integrated Endpoint (PCI_EXP_TYPE_RC_END) we
> > also check for the CMA DOE feature.
>
> @Dan Williams this is the patch I really need your thoughts on.
>
> The current upstream pci_tsm code only works if IDE or TDISP is
> supported, which isn't true for CMA support.
>
> This patch works around that, but the more I think about it the
> hackier it is. I have a local change that reverts this and
> updates`tsm.c` to work with a DSM (`->dsm_dev` is NULL), but that
> doesn't feel right either. Do you have a better idea or how to enable
> a CMA TSM driver?

Gentle ping on this. Any thoughts here?

Alistair

>
> Alistair
