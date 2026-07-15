Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036E443E40
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139198; cv=pass; b=CkYRRuRRHmzeexIeREQQFkSIi6KdAgM6XGSLPlcrde27ASXfI9NG67QU4MXI+8Xd5HbzqbjTdXqJt+3r4JZqiHnsvzCOLBYLRRBJFGEmeiMayk1w3m6RzdlyO53AkVLAHvlSNKiLTFF60Zgt6XKHYcHePSRlqohpCGgMIpq3Vkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139198; c=relaxed/simple;
	bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbUEXdZJeBpKRqoFEDlaVWJW5+mGXhPe1/8IfZn0c0MAh2MqgcaxBbeYiifHm32sZ4kqyzvLIkP54ZD7++DPFsj16jdUzZEYTAlWMjaTOtixlTa5PkzYfV9VlpRFEWfRQ4fNY5mUwcD80r2FKGrmOmgHCqua7tgqIYkmKAsSK3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTIWm3VZ; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTIWm3VZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cac59f8b64so66629595ad.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 11:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784139194; cv=none;
        d=google.com; s=arc-20260327;
        b=EsINRbS8jrOlf+tgsP9F9rUDHHgapRuxRqd9DWkuhm8IExn3ZBF4OLRdCOO4cw0veK
         RIy3PhLgWhLBIV0nXxi+cwRbj7f0IrOi5XtRtOKrVdn35K4216kk3ERL7it+S9ifzGHJ
         lS0ykiVhsBH6FoHPlYrZNR8KXVHY5pzB5/BAjnFloSSs84lZihCiQUNyzvO0ycvFb6WS
         CDWOVtk8+lrC7rWL4Kb4Qo67KEDK5hohUJk2WDUPYTsfCUYFP7yCFGVeno/89QNPNaoj
         3rV/SoFiqtpPsD9eZiNItXwMC33wSwmaC2wGVxSF0ND6LTu5Cs9kKbiWOmiF5ECCNgsV
         4iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
        fh=xLsCp//65jpG41/F7ppwnAWpYcjRq4cwl9/osrJz1k0=;
        b=VY1MqMrtKqQgZakIOmWad/9GC0b8L8Q9IKZ2raO8fvX6qVP++yTL3/G6ZJycOMEEo7
         gAYBrE0NJ+1AqTaEUpbRyxSa55kvW5EU4+oiAQKqNLR4WJ0S6KpYGArdUIi6SQiC4X7q
         UwcJhoQUwzTo6lT3aYMPxWTWPoYrFIt8YoR6LBR+S0XFM8QKjX0WboJEOGKybjMfoCHn
         dZae4i+xZVgaQQe5M9irMeQB7127XDR+8b6hXYvn2rFh1WtLa8L7QJfwv3EcvC8wOaMi
         llMjNJS8U1I3YJiFs7YboqoLVydamPxM6jfEoo6ZZzFJhiWwhneS0pjQnAnsiGVZLGGr
         3sMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784139194; x=1784743994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
        b=TTIWm3VZdzcMxAM9YAR8kvHU7kjJ9hewXfAK/SIgTMmt/kcEc+e1rD7LqwTvhTJ7Fn
         OjkhXCNMSbZXl05Tug95wXA3cTRyOeiFiqZ8UH/tpA0rgGpdU0eH2f8HTIqVp14d2Lwk
         3YSwLSAjM4245pDu+6q8T2L7MHVxld5IlGXDiGpJlenNtgtsGY0lNCcBtiDBQkiLXHT9
         8f/4jTdPJmr2uy8DhaFSEtWzNyZxkmS9phbDNRBKixKpDORN9mWxZyYlTeF52X7W4bfP
         Ss8Vj8saSLLV71afVr6giPOrvgUz/UYuc1EVrXL7lPcTu/0b2lqvOR0i1YgGweJO5+Ms
         szZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139194; x=1784743994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
        b=sKKk8EVVXECR/wIpWp3JHLo3Xpx9mabXXuGAAh3X1x3WloNlUaSdLWVk4aXtR74yW0
         civEEOLL4D0YZgDCN1o/BcgFlD0keDVMwT6kj0E3yYK8cc2js3gTwKQqp8nGr+e6K8zY
         eqIy2XxhUccBjXD+xw4kjQqS8PYSA2S11xHy5Qj88eYzN9rGbbs1wxrqab6yZpYCVbC9
         Bk0tVKynUFfBJpVQRMW34MSSUF7bXoD4PeBsAq0GEfssUnt+ZfEimk6Bx+awEIFjqV0k
         IEgOXNtHtbU6MVH0rPyx2ULsk648H+2q73UGaqOnq5QEnJRsMjk4vZPN1gnbH1R140En
         JPPA==
X-Forwarded-Encrypted: i=1; AHgh+RpjTw4khjQEwwe7XoU0dT2H4F5T9SVrCAGfIUepWEOTBvWcSTOsZ9Z381IBfZSmyuuTpO0L+hxWU7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwssSYgpTFWEMOek0wD079g2EOTvE/6E+ZQJ8rGpTQSyuHYzq0r
	vcu+cyNxKvrpEVa7yM2GeFs4jLByP1Ffp34MDa2tk9CLn8WQfv5HQ1F8rPJZmvxizbuTol6V6cU
	G1JoMPRgZa6jBCzIWqV4/+2TPtDyhm32B70/ulbt5
X-Gm-Gg: AfdE7ckxBqwa4G+YKo0QDnCq8vZ6g6HaaY4ypfqzLGuq9u36JMEo+1j8OWab87RijAm
	Uo9EXHohYqN+i4waO2Q+kr6AedDGCZ9IomMxFspQ581akwfeVafi35w4wO+K5kwVZobIfVW9rFK
	hHfqR/yQT5YLIpHJCxqR2Dq3zm7x2uTVFpCvDi2/5t0O3s2f5A6vA+3mJ0n9U/uqz/BTf8lg1u9
	9Kd1SBLq+9d+EShbtBLQoBfohfd6myD/CmXjAOdPWS9EmUpaI3AF8/ZkezeUrhS7cJzBkJD
X-Received: by 2002:a05:6a20:4308:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3c36c1f1e9dmr3992057637.31.1784139193430; Wed, 15 Jul 2026
 11:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 15 Jul 2026 11:12:46 -0700
X-Gm-Features: AUfX_myjzByVJrMRsslJCPDuFhCRYahAX-J5d0Fnwjil213_UwTGXzV50T-Uvqc
Message-ID: <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
	Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote=
:

> This is based on v7.2-rc3.
>
> These commits are on GitHub for easier browsing, along with
> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
>
> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-m=
map-v5

It'd be great to have this test upstream. I'm happy to review it when
you're ready. Looks like it just needs to be redone to use the VFIO
selftests library and kselftests harness. AI could probably do the
conversion pretty quick :)
