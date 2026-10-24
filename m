Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806120;
	b=bYAPb7neJcD4ktqypn8aG/U5oEdQXCJ+EsybkqXb/x9eVvnFAuRfvfBKCjm6vNewZsdZ
	 2qFGPQd5nM1LaZSOHwI25cvqePzz8cKLZObRyZBJMbffmoXh1lwAwJB8MH4KV5WWItZYi
	 7CMn4ctxb1KxnqJ7vZmW78tjsC5G9qRTYUSInP5s0BOcrtrI2m9XErKWToYRjtGM4UD60
	 vzEevhrUkVY/cY0zLk/Azp2GE7hx6vcTO2UgDjJqxhXFx1j1PCS5XagZzV9TmLL+JmRUr
	 9lIn+OJ1SrhFvoT4Xn1u6dN13T9oYINwbJyKCpaR5vFXuamSFsdaDuDPk9hiYQWakhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=qeH1FHgicGjvAz+02O19qqIqMgAUZ46ecfWddEW2Mak=;
	b=lzNo4L5s6Xs0WILJ/CqXL/vODkXc1XpUA1r/tln2quSd2LrAWb5VW/3vEKB5S89g9OMO
	 Q5S72abq2Grez7mRb0G9CqlxZvTYtCiEdSb7/ljuoTfD59fBVa1HC5yxk/4fM3fVswzlk
	 F9j6yHg5HCZxVZFX/YH8vYDmbezQxLT/sXnW3tdDazNjWJES2s6NcryqyKBHf0kFj5i7s
	 2x21D9Tbs5xI16mpzN9zHMlJ1yMD50A+SEPtlW9rme8AWLBZmIGoEcy2NfZhB/YkyfoJ9
	 6p7RgcVtKzZnkGgRWBEth26oBASOAr9BOPwCzbqopYFN5lB5y4itup4wHygREgMQwag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AL6KnPUi;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43D606A31B
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 01:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C43D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AL6KnPUi
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso2674791a12.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 18:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792806117; x=1793410917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qeH1FHgicGjvAz+02O19qqIqMgAUZ46ecfWddEW2Mak=;
        b=AL6KnPUieL29OD851tZPuMhJSfajXpP8zoH0sEeBU4uYmBjvXIRPi8CftEMiRVaDgj
         3qdw3NzKLO3X1lHWiTgwtohwDdjlsRsRt21Wu1ArJ0HX90gHtOwlEojZyR+mZKf+gNyt
         Fa1yJN7UVDi/X/SouMYdK+sXdujBY3d9FvifU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806117; x=1793410917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qeH1FHgicGjvAz+02O19qqIqMgAUZ46ecfWddEW2Mak=;
        b=V+4Ys2l6vfqAhRAwrYBNQyEqMQBA+pJR+yxbeASXmCuzyT6HeYknZ1Gms2D4JMsjCr
         nZHkXDbTiNv7K41UyMlSrwSBUq43OVegttrhQ6HzwtSvjvyQpixalpw3D6nDG0iDKtTK
         0DeANJ405dj/kwjpwfuqwglH4bxyRZGpxSChecRbYuRFRikMYNPyRZkXTbNDOQG9iBYX
         myyF8OoH+4OvBoevf+6YPHIWbJtXt0wtMh8YgKb19dqa1kg+JD3PC4JgzlqrUbdjoykS
         vlVrlP1wwdDExb3V90dGKIKHZ2kc/v/DFDflr7HF3cqQw4etYnuUS7QUPZyrY/HkFBYo
         SyAQ==
X-Gm-Message-State: AFq9FYL3FOrW4ZWa7E0dPhLapwVCCngxkpaXUfY3aNLvsiw8gq183hJ1
	WkDsIbEqCKVRBgqZiwSwL+o5BOM5wMD7RMsrUVuXy2Y0Z7Y9Yyan3vYFLMPTwLyeSAFyX/+GBPk
	MRiLvWHE=
X-Gm-Gg: AYBFou2403IzCt38G92yK2JZWmM8T8tY+PwuN8F9cWxVVNU0pSSdZUFd5iyhyMpvv0W
	LnheTi6dkaN7jFgmPORorFvgpfPpSxkVXbioH8nU2/+JNVNfphngkYFH3FN5t76F1hxNxjPcDw0
	eeGdO+pAF+4fdk97ITPGIhhRsekw63ljnuBGEcR9W6AZRdHmmesZ01PotQ+0tSfxVFY/tNY/aPh
	aSx5GA3yiAq+6CJ4HsWq20kNjQLLG8Z44iza8IpFjLERK989+xBF/A70EcRMh7xaIIvY85NU/1w
	ZR2+A6eJTgkjMC1FTUtyE8n9yfWfwJloHyZoxprfqcfvn8jtnNBWZBryml1wpK3JVq6266I9H3x
	2Pjal7RZ5aZu/IOzuwyPHcnCPKrhZl8DdSoxM8qe0hJOCN86gPboIAeA1htXGlmaGN/S95zI3Fr
	jmNLamXUYgTxwk86JSrEBOEkzM9qtQ77Q4NgqYNxNMhkZ5NdStY10kkLj+2NGQJ60pDSc7s0vOF
	Hjy6GUp21wjVZJtRi604EminfEsETGsAdXHV0D0XvCQBS+BDKNnvlbLtMd8GATqbT/0BtZj1IGB
	qFOlaAznliJMPr63GQLwhj+Q4ahuv14=
X-Received: by 2002:aa7:d6cf:0:b0:6a9:8863:ada4 with SMTP id 4fb4d7f45d1cf-6b442fb85c8mr653101a12.3.1792806117342;
        Fri, 23 Oct 2026 18:41:57 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44595e0f4sm323097a12.13.2026.10.23.18.41.56
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 18:41:56 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c46bd7a7345so30537966b.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 18:41:56 -0700 (PDT)
X-Received: by 2002:a17:907:808:b0:c2a:4847:231b with SMTP id
 a640c23a62f3a-c46be5efdccmr59745466b.24.1792806116362; Fri, 23 Oct 2026
 18:41:56 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021224355.GA2571577@bhelgaas>
In-Reply-To: <20261021224355.GA2571577@bhelgaas>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Oct 2026 15:41:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=wioEin24Sm4DM9TFgYw=kH+PR7NHQ_Z5pzk2=AfpQd0qg@mail.gmail.com>
X-Gm-Features: AclHuK8B3O46Wh0EulZdlUpt8bUfci3dIeRGqlrWK7Dq47jxll3Yo4YSYc2JBho
Message-ID: <CAHk-=wioEin24Sm4DM9TFgYw=kH+PR7NHQ_Z5pzk2=AfpQd0qg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v7.4
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 12:44, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - Fix leaks when ACPI APEI/GHES error events overflow the kfifo or
>     mention a device that no longer exists (Priyank Rathod)

There were conflicts in this area that I resolved differently from
linux-next. Somebody should double-check.

                 Linus
