Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3B255E43
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316242; cv=pass; b=tKQW0FDmfOimJjz22fcECZ//I8+GuOfOBrRfNVsBeKylCVwFXxP9uQicEPK8ffe9NJDMFszDLF7kdMBaz3RhEqIYf1R555XGhnOJ093+YS9tjeC7hzF6YEBLnjFffTQPJI3rDunqz86/tF4oYEJYtDiRqpBRKU5u0QKhmlSauvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316242; c=relaxed/simple;
	bh=DDNNIqkIGd79GFDvWgXKCnKvFpN60AdJ3nOosKMNMyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGMQZCk7Fn6i1EQO0XlHPQ8BaqPsF0gCSOltvtIGK7qaKrXLc34vejVYCtdOrfHTNNTqfr4wOqLs3UtLU0F7uRAO/NQR2yaEzPq47UN2A8g/GsCn5OiK3OPe2t/Ve8qqlAOWBemYD11fO1RgFKqFF9e7VS4nDe61LBbvVDmV+IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UclVOq1t; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UclVOq1t"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7d984096so116260681fa.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 11:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777316239; cv=none;
        d=google.com; s=arc-20240605;
        b=cpUVZLQ02MtE+ukIqoiQ/wB+h//nXmkci0OU3RRNd7TGGZFo+mQhDcUHAzhr6UWkDc
         hHei52CUU1sMNQ00BUyQH40JKvkRH+RexyK8tAbESSnBfGn/vzER6M8bhjng+kB9PXQ/
         LWpZgFifb0zZnrwCQqa7dD//2iEPLnGYPBGpM+X4waiAlFiUnSQAXKM50KMLdmS2o60V
         nDeVpfaHU0Xm2/xWokfd1RhVZe9PBic0O0HciX4vFr5uQaYy9b3jv3FXvcdb9rEoyYBp
         3YIRfqsvnsz/KEeAI6TXFtvqQ5T+FjIJeRB7JPVqmPwFgk7LfLrcvLPiqWGxhHc3QNP+
         tN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        fh=Cpvr9cWYNKu/4Lp2WB6UmhYBKKNqBDk7NNLjyjFYDvY=;
        b=aM5/lcC7rgcRB9eaD+2RVFRg66usEhXV3QhgJ396ZYt4Zlr5gP3PuGUb4PzSKez8RK
         iFS25JM51VPe+sfJU3aNJDTr2DLftOpbPzpiFrQgnzQxnWnAyEYLD55ynMCaJt9gTaQC
         qpnJzX05KIJy5wSSyGnwyjzZqfeX7y6MDLvSO9esk7529NOn75hRSbg8mAipRj7p/P5Z
         EfZR8zOqlVLHVb/1qIxRN+KytCotzn028R7xBN4i0k2YCTEY41Cc53yRl3WljhvvDzSW
         OdBucNhdJs2Uj94RFLWTCfN6CRUwv98VUIMsX8lMTCazvhA4oYDvcekQo5RqXvUbvr92
         6LMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777316239; x=1777921039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        b=UclVOq1td6B5U0mvtxgD4CZ0pGhK6883kjDt84nzaVhA5Lfmv0O4Hk5sjFuTfaoSoZ
         s02Fct0MiWn2RR1lAu/SLpVhys+/zvqSVnGTJHz2/UNyyaEitRJ8EHpBZmsFaGyOxqjf
         t4csL9I8X9hS32t1dp8rcJHRauxr9AGAcx59JbhAHw05+2qeIzL7gnctKWCKubH9HkWn
         7Sva5wtaNUuYrwKUC/yZL1tdzbjQg66KWK7V8+Mk7dVaYR2UFdTtXKX9W25x40wnaYXz
         ATmLcuWAc4SzPkIkzqh8NFeBGwEt6u7fjLLBX+fBYzZ+rM07DT6rst4JIdie1jWN8j1s
         Ddng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777316239; x=1777921039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wr02yN3/yZBXI2xon5jDCKdawxJYqqpUq3piVXy5yYI=;
        b=nr4UZlivdeomKk9HwVZMiJrGC44GZoquer4Iq5GFjtV1Ly9kzDqVDPWOm/vSiwaHFe
         0yqdeAkElqkXzOcXovIRrVjwFCK/Vek+i+U3Q3lAttRdM2si+iEK6lXdejN35XRVuMiz
         5dFUDHODg5xDtyh/K8xvKSBWJ0X2Ei0g3kL+6DmD1F91Pi+/a3L5OzcOunECzQA/Q4Av
         +913jtdo/iUJzivl8X4dbtBDhCmzS3DtwhxhjMKoPHrEbW8xFVxt5v7BR1hZPQ4x53PB
         fg90xN/oPhc0Ui3a5LiTnjMudFc0TLHTEbjFg28e5xsKknLRE0cjcYs2xwnvgwdcJYeY
         oAjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+2oq+moMjf5atgQZ5CNd7bQK+wI4kq7hcdlYZIMG0KCBsHsQKvxBR1rocr3VX62Ees/KRq8BX9SxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEwL2UXW5gMpZvl7Ikfw0nFspm/LBT7AWa+SaydDDkeqzjBtB
	TrqFgFXW3I6EXSD0m+PxA9Ky2BjZI57eulz249ewgaMN8X0zWxe+jN/CXBEm6nwxnhkQ46Yw4m7
	z99+7Bq4JQ5E15PAFobRn3Oi0Wdp8CkCbKr4i3uOz
X-Gm-Gg: AeBDievNW56acOswGhJwyRZE6X+9ySGmVFBKuo9kLoPkh8T2hk0Yh5uBIQZeCOlefIQ
	0xusdjgnhzzgdJocyA0dX62bqXxvDkSK7Ci6Ypz0Zwx38IzvjrNM758ML8tltd7eaeBjdzJWvS6
	OVYujhCeUz0wndjKyTYnL185kmXOSWGXWtX52/okrSJVAtUwNhzgeKtyKw28Mu3KDjBIn7oww11
	Y0Mj5hPj70jsMPcWsrnRlpg1OTWYljGOrwyX7jQjKfVrcGhUJKJPQrqFEC1Sezr9mv4I8O0rPVG
	N9CPG9nYXOxxWOF8KMQ6fA+9iil4zQ==
X-Received: by 2002:a05:6512:3c98:b0:5a4:b18:427e with SMTP id
 2adb3069b0e04-5a7466047eemr34628e87.1.1777316239065; Mon, 27 Apr 2026
 11:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-3-dmatlack@google.com>
 <20260427085725.00005283@linux.microsoft.com>
In-Reply-To: <20260427085725.00005283@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Apr 2026 11:56:51 -0700
X-Gm-Features: AVHnY4IwEsFxMBzAHVS8KxW2Zq56dU7ADRcx7gdZfScIG7qn-IMwc1DMcXI8nOc
Message-ID: <CALzav=di-fMMPgTEzfWagRgXCWox9CB4XiRhZcVAzc3dUzzfHg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 8:57=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:

> > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void
> > **)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!ser)
> > +             return -ENOENT;
> > +
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> This can be left outside the mutex?

Yes indeed. I will move it out in v5. Thanks!
