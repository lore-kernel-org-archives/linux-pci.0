Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451263;
	b=Q0nmv2UjuPNpw7dhSnl3JFQcCu02z09PUwMX7k7ZbmS2/Mk9kRICYyukuXLIoLAaKSGs
	 Mx8CndqlqbFM0ewlqG6zbc58dXjmyiQuOUJTVjfwsj9965S+fd2mOB2nvnzT+FpPv4MV5
	 8u6ytyHlxd4HG1/lzfRRHZyQzstDLCYmvmXC2QTXVJg6m1jAC7a5A7wH8BfbhX4cU5Kq4
	 D+u7dWdgTiGAHqf90J6YDRm0Ig0fLc56w5qU/tJC3IFbZevACx3kFNiKPCiv2uFQHOQyj
	 gvn4nTnZIdL0k3vQs0asRAr70WFqZ/HBcL82+1493xk9f2wRryHu7i6ARzXP1hU7JVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
	b=ExjzwryU1JT2KsKC9oLCAkqPUp5StNZsanEzDjfbBHi1zoKwYnBM9+oRG8ISK9Pc2kB6
	 8dy2ytb8thGEqZ3o1a6X0GdMYVBbRLXc7jdt6jBwmDjkroh/hYChN7czDocM2Not3l5zW
	 9i4Nv0inbG0rsEkjxMTCzBCiu7GeI04vlfB2/ePjob7sYUzoUgWEvc9tEFr1N+ialAWR9
	 NWN7BXevo91ZNUvYWl5eeWhe4eYAVutGp78HhywRk19WXkDfWGk5tFI5X7xPSuJ+21vqD
	 kZS3pGMkm8xH3TpjmRxQdA2+APShDncA+5YdSoG6VwajuHHFx9QTKcXiJiEQfja+fXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLLFt0C1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C5606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 16:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F4C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLLFt0C1
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5365d26ccbdso43879481cf.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 08:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795451262; cv=none;
        d=google.com; s=arc-20260327;
        b=rRqw/rTNBzaMQ0RbhtxrRXMOZwYWW4Am5zb8KqfRq7Jw+2ih5FBFwN8SB95vIyTx3Y
         vYA87NEVvuNOrIeHdKoFZDSMAZJaj/Z0kF/DHMwhDYGNg9W8pHWqjQ6CcwKOtHBX5NXl
         d4F+VtRUU9KvlKc04AvG+C5mxCGxximtuM/SRoPT8sQKPA5m1smnhzGYyY8JP2NCTRPv
         TOqeUbzz+gFCGqeLRP2izusjUnqTHccv/94+uVdTLVIHEKzHqrLL1KoP8WBss09/wZJ9
         8zJKcwAhx2lnkYkwty5EDy3A2vWP+uoJD5U//ywSAliDkTfQo4+ja3jzxRXx3IxcINSK
         6sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
        fh=t1scSvpbA7bbk9tVeerzH74KpIcLCbce02a9+v6BoyA=;
        b=rWrejcw3MXX/+aKtNOOqXMzvMKa+dIX+Y26XLX4haK95mCsYK/6Y+BshKGGO38FooJ
         Ldch8dfSex6ZY4N/wByaV3o803XncGRGkTAnrA1YzEcrXKqVMGktS3F82HCGavlrKyfT
         t0o0BxdQBpFLa0qZD0l2ZEvlFo5pNHkpPLUJ/P8qYxP+pKAgvl0313R2PtcPKgaRa/Bg
         O4FTKyzjbo39mIFTxiGAHdtQC43p4Wk3PM0jH4CJQEvaF5rqPq2Lq6qhMJO4oXaBF3Kf
         3fjUTHlucUKWcwgnwly89CauwcKqE51Gw3oXQePanJvas8zgd2p5HkeDi2veFTF52hei
         EJAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795451262; x=1796056062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
        b=jLLFt0C1tUxuzmq1/dAe3AizY26009ud2oEFFwgb6/BOL4L542gMsBL3pJRtL6iq2v
         Uc+MNqdDJE4FLmnWZ5bECDKnpt1Q354qkZK0NJPf6wxjDXiZOGBcEDbFfNH1dHefJY6J
         EGcBbEhfeaybNqvnV22+WqA/6NFra4pzNtmFzJUiFu4dJnj7AwIEPtPDA2VLYLIb7/u7
         DBeRwxnxHiZaSDn0mApye8nobpijGcq3rnyNXh7/3Rmnad1TQN+aJFSvCo5EFSJGjAv5
         sMi1AvSBUjj1jKNN15rILP7IgC7bbcc5qGJ2ojhuLvC3KO8z6/MVUPjHKsYxeG4Rks9E
         ZFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451262; x=1796056062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vB3psAisz6oN/RnCKU/w6FpM8F0jva1/kUicZCF7qx4=;
        b=PWrR5zzEJ09fOQI6AnM9fLCNxAObWM2fl3zOUjgTfQzTjO+WEEx29Lo3NhU6b/BeIp
         T2/KWMmYmYT8eTMkNJaN1L8AWTfTMq1/wAMOAsoJQUtuWuIDAH2WjOL15QILc9AJ3F4M
         x1i0ICDg/joeJ5KqCQtl9bvlThH6HTdCkq3DmqfpjvNBlii/zTmsqtfLtxVGoqMrSkzS
         IYus/MdsOLqJCo4j98v7BFDtpILLfWxUIh4uIPOK+BDz/oglWWBvMVmHqVqbrtAv1Xo6
         4UgjiFZdZQ3wdW14TVA9c7dBvgdLBtFBY32wDGw0Ovxr7Bh88AvdFr1+troxcS4Pv5hO
         UQEg==
X-Gm-Message-State: APuU4Z874rkLX25Tv1tFtdzWZZ0Ap1h9Ni/A8ApsEyHTatuhCPPZCzSs
	n0xcpDwdbKI99DpWvSwXUasnoHCE2DDX96uA6Fbj3xaCak9+EPiImBxL5bIJW3nTiuMTI8JxcXL
	tEfBq22+iSoBDH5+zsOU8anO7/XOXH9k=
X-Gm-Gg: AZFdTZcnj8RQY6i5AfN52NieJD1z/hGvefHNWGh3hrV71NdWeuTOVvFq4wiTiQ89kw5
	wwBznXDkuxeIVZWF1AuFCO19gObWNGY/DdWs6WyJxll4NvtPJljcEUKxl3Cch4gcgvLxs4hZ9sF
	uKon0tGK4EEsGvlKCKb7HPyF6nIiYE3vH7Y5IKQQ/g+73js7J0laYK5oW0Od0CkTpRWx+AqmSVP
	AY/KHOmiP7AdEvb+tDA/rGn7IVj/Miv0rH8BRZi7tHRc7Wd9Bnz5K4M9UBfNFjhtbOGtjRjIQhQ
	uxhwz7MZUMusO+x7S6/YbvUbyzlCTgCyJhaRDyk2fdDia8UPBf9wORM6FtHJ08Qdh7VsPmh9JkK
	WO6+dUoOhesmKdxW6OEgv3ucgDEwiqwZFx8zMNjyK30QPTyu8l18s7r9+HfH8Dpv8xNubdnPUqq
	tWC2W8fwkBUn6iWlogb0FBHn8cyaFSrjtVjwkrLrZG6XFEs0Z/2XTHGBURCIM=
X-Received: by 2002:a05:622a:2609:b0:55d:6ac2:ceef with SMTP id
 d75a77b69052e-55d768a3013mr222786721cf.2.1795451262262; Mon, 23 Nov 2026
 08:27:42 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029192032.1325629-1-thepacketgeek@gmail.com> <CADvopvYQDLx81gDFNR8MAg9E010K3yJNEByAwawQHFahRYiXzA@mail.gmail.com>
In-Reply-To: <CADvopvYQDLx81gDFNR8MAg9E010K3yJNEByAwawQHFahRYiXzA@mail.gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Mon, 23 Nov 2026 08:27:31 -0800
X-Gm-Features: Aa3M54or1N6jhbFLhNPl69WhIQyJD3OfJsyAOFV4LpBHefX5dDm7mu41jxBLzCc
Message-ID: <CADvopvYBODrxGbO1B6YRWeyAanBPd8MPa9Obat0SuGD7HNxJYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 11:35=E2=80=AFAM Matthew Wood <thepacketgeek@gmail.=
com> wrote:
>
> On Thu, Oct 29, 2026 at 12:20=E2=80=AFPM Matthew Wood <thepacketgeek@gmai=
l.com> wrote:
> >
> > Many PCI sysfs attributes that read from config space are using kernel
> > accessors that don't wait for pci_cfg_access_lock() holders before read=
ing:
> >
> > - serial_number
> > - max_link_width
> > - current_link_*
> > - *_bus_number
> >
> > If userspace attempts to read from these attributes while config space =
is not
> > available (e.g. during a reset) there's no telling what values will be
> > returned: All ones, zeros, or garbage.
> >
> > Looking at attribute addition history it seems like this was an oversig=
ht
> > instead of a specific decision so this series tries to resolve the attr=
ibutes
> > above to match the sysfs attributes that do use user accessors: config =
& vpd.
> >
> > Patch 1 is a prerequisite for the rest of the series. The kernel
> > accessors these attributes use today skip devices marked disconnected
> > but the user accessors don't, so switching over alone would make the
> > attributes start sending config reads to disconnected devices. Patch 1
> > adds the same pci_dev_is_disconnected() check to the user read
> > accessors.
> >
> > Note: That check also affects their existing callers. On a disconnected
> > device, VPD reads and writes, VFIO config reads, and VFIO writes to
> > PCI_COMMAND now fail with -ENODEV, rather than returning ~0 data or,
> > for VPD writes, timing out with a "firmware bug" warning.
> > pciconfig_read() fails with -EIO, and the sysfs "config" file and
> > /proc/bus/pci still return ~0 data.
> >
> > Changes were successfully tested by continuously reading sysfs attribut=
es
> > while a reset was issued.
> >
> > Changes in v2:
> >   - Patch 5: check DSN read errors in serial_number_show() and return
> >     -EIO instead of an all-ones serial number
> >   - Collected Reviewed-by from Keith Busch on patches 2-4
> >
> > v1: https://lore.kernel.org/linux-pci/20261025000836.58294-1-thepacketg=
eek@gmail.com/
> >

Hello,

Checking in again on this, is there any feedback or concerns or do
these changes make sense?

Thank you!
Matthew
