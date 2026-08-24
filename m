Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9070384CD1
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605118; cv=pass; b=jeqG2DYiWfFZVEMqILBmID7b/LTrq1mgoc2IR4329mB8N9EeMPkN6Pdw5/bYduOKRuzWcLI96wS4TCkTPvcAx2VjZQGY/GRJn1QjKlVDOhUuNRfTo/CDp4FWRVV7MEC+rjj2gcqhxs8cCQsVeJ+HvWagrPukVHuNOM0FfMQnr8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605118; c=relaxed/simple;
	bh=SE4va7aB/xOM+N1bTKyWN1WLFId3guI25+YeDBEOFUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM7mYRmlyYgmNWRgK0CIVGaN4uV9cokLQkLG/dZMae5XfayHhjHvkz2A8UeFrVn4z2A9r5lqG436SKzjzaphNUhN1/aZEjjZVm9mbzWoOfzYpmqm4hohoE62jrqq6WIgo41A9t/HbjBQ8dhJx8yeqiwbp4DGKvWHY0EAIEMNS/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nh1gOVhh; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh1gOVhh"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so3889222a12.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787605116; cv=none;
        d=google.com; s=arc-20260327;
        b=F4+EW5JVWLcM8rbVw1ZGUIeTSTpe2fxMw5mvug9vjuFUw6OtUC1nEugIqoYy58swdq
         HdkqHtMrk1g3wHk0/lPce8xmf0tv/CxTFrWu2d7UlyRO4wqflEfK1Bsuh2x1KQQFt/10
         +c/ofx4SQYgQUvrWv8EPvxkN+/kNRrk/JYz/5BT3HmJ5bhvanu5Gs1/PzMNQDk9Pwfce
         +v+9u9SR/bDm3s2UbwZcLQSqT+iDIJfbxstWZxuf/kpv6mjlUREV1xqYv8+WXn3YjW9+
         OmGG7TukRYVFctuE32Fq0NlMViIV1jS4PcTyFPFsPB90CJxYm/XY7O1AH0uIq4xws+Xq
         Dl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SE4va7aB/xOM+N1bTKyWN1WLFId3guI25+YeDBEOFUo=;
        fh=KiaS1+q8r2TCHmq/Dkdm9qIn+TNwovCjKitO1CT0E8c=;
        b=mxCCYbVXfV/Z+92mCGY4nYgLyRAw2XxRDYeY6AV+JxWP2oRiHIPq/zZRT6dNQLryfq
         r2lF6cuXoUI1jwYteOVtzxrDVi96V/RIOy0GY+tztSym0lB83iArP6S1gJ/v/QzVEgHd
         RhnKmdDen8OIuujZTeFOR4uv/EJPKQTX9NhyyBBlxtHlDrQRuoeYZY4GPfh0dJlX0vu8
         yLMPXZpWSPusRJMQQNcPkeYBvXHvHoBs43t1PK4LUODq5fCnCVTtOg21NEtd8DfI70fu
         gML9Y7MfeCJ7Sv/YDfeYUdg4td831t+5ickqSViINF3MNSPzuQkIjixxOXY2pc3+gwkj
         tnQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787605116; x=1788209916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SE4va7aB/xOM+N1bTKyWN1WLFId3guI25+YeDBEOFUo=;
        b=nh1gOVhh1kwOr+xG02y6TkaMNRirUBSNfPx3m4rglk17vfv/K17pUfOVjRjLyk304w
         863f40+YvFUlw5iaE3B3t0yxC+U6GZoI/mo7HMH9bRXbn69OGHTf1AgnQWr9W/1HVN4n
         o2TLvEU4Ub+42LkS3wvR/JNuwlgAZkZgq85X5u3QM3sJMq03MMhhergU0lMwX5UQIdQE
         bG8vvrsQ6nmVjfMSkBbowm1sanIHDDP1HXCpWvwn7iWpeBpC+uHUCjqIp7HCOJbiUExM
         Awh5zU+E1HLfUSaOgDpU2XnztJ/NVOjQ37eMhEUwmkJtGTV1MLGlhS+wXdIzBOsBvKJX
         5aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787605116; x=1788209916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SE4va7aB/xOM+N1bTKyWN1WLFId3guI25+YeDBEOFUo=;
        b=ja2B730KvcK+lU30MT4XkX3mZ7PWeGzVRtFLwh66O1LHF349i71pk7R8HCrEuX4oBH
         dIDlJ+uEHQHISJ0M0iZQOG+s8vqWTCkfW5U0aZ7Ry6osRDenYxDizVc0jYSWhHx8t2FM
         UmDrE9Vdit5kzYXViFsQMRc/B9RMpx6kS8jrOe1L+vDcPERTtHckMYyIqSUImOpCsq9f
         q2ttlws1W3kllzsDdbUCxfGUxKAa16HB5l4KITyYCClDTBk8nvlMzLjhNox7xSvh7p2w
         Nv8Boti/uSn+GHjLKZ/nNhexhUQx68sFUHHM0FwbajVcVO1/SosSdgeZgijj1msjBlIM
         aseQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqbc5HACgri5Dj3ofz+Tz1No1aX6bwEa5wIKszsYqbDveLublqPgG7FwcJ7J+RxjMuY82R6i5k6YKU=@vger.kernel.org
X-Gm-Message-State: AFuF++kDqbZU9bp41i+8xc1plZXE66oadXltYoXdQPx+qBBlGs2gs2VV
	kzOW9Fo2ZaAmq4MTVTDFDpE92XwnGLZ9XEfHqTZArzLgwePC3lNFJBdv4qvjni8Vhdu16F9NsRI
	F5ZLkYo3LSOeUMrMUNkKh3zsrJfWfbVPJVxQ+nmpRY+yw51kJyQ4NHCkWZ3M=
X-Gm-Gg: AR+sD13sgo2df/TdLA58pb+hyPTTn8saVZp3/olF7lPtgpR2T1NfS2SApwQ4MeREefA
	fdkzq5vUx3vl0CU6Ojr5dRYT9GaGDYdsX/O9IMTPA8G3Xq+spl4YE01sc75stKbywgsAQFQ6R8G
	b3fMNjgCqEC74FqBre1UkmVfiB0eYDywnXy6yknDqmvC0iKZ9Z3+ncEpTTIYAiyfq655s5fKHWs
	NALspsTrqCxamfnTr1AhS3ZtlHWbKiT7huviQcWltEs9gTxdgS+WwK7Zc1itaNvbJ+VLtV0amOh
	4PVnxRhnSMbTFVCGmWRQujZpTVvK7SQjzPt/UGxL4dUKdw==
X-Received: by 2002:a05:6a21:1583:b0:3c4:511e:26ab with SMTP id
 adf61e73a8af0-3cd2fdb9115mr56456138637.3.1787605115573; Mon, 24 Aug 2026
 13:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821221610.3570722-1-dmatlack@google.com> <20260821230620.fcpmn7radmwnfnh2@pali>
 <CALzav=dOumVYvjShjHHd1fydKMO1OX2w-ps4HEH5kBU7_3AVzg@mail.gmail.com>
 <20260824173635.tqbivfr6l7pvi3qh@pali> <CALzav=c5WY4MQ4PzOTkuYA-eDv_cVWF74L4dd46smiZjPzsPLQ@mail.gmail.com>
 <20260824203447.hycxzhoqso5k7wvg@pali>
In-Reply-To: <20260824203447.hycxzhoqso5k7wvg@pali>
From: David Matlack <dmatlack@google.com>
Date: Mon, 24 Aug 2026 13:58:08 -0700
X-Gm-Features: AcwNN1XfYtEJhKCKZZS_06uinckJPlioopsZ5K61l_RlVK4Wx0idulq-pggBiXY
Message-ID: <CALzav=e=LBeaWkTa=P3H6CYHcM7HZQdpgB9OKYP3vyNN1OoCnQ@mail.gmail.com>
Subject: Re: [pciutils PATCH v2] lspci: Determine bridge window address size
 from bridge_flags
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:34=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Monday 24 August 2026 13:22:32 David Matlack wrote:
> > On Mon, Aug 24, 2026 at 10:36=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.o=
rg> wrote:
> > >
> > > On Monday 24 August 2026 09:24:33 David Matlack wrote:
> > > > On Fri, Aug 21, 2026 at 4:06=E2=80=AFPM Pali Roh=C3=A1r <pali@kerne=
l.org> wrote:
> > > > >
> > > > > Hello! Thank you for taking this issue. I briefly checked the cha=
nge and
> > > > > I think that this is the right way how to address that issue.
> > > > >
> > > > > Anyway, it would be nice to provide some example of config space =
of PCI
> > > > > Bridge (lspci -x) which is affected by this issue and have it in
> > > > > pciutils/tests/ directory.
> > > >
> > > > Ack, I will incorporate that into a v3.
> > >
> > > Feel free to send it separately. No need to have it in this one chang=
e.
> >
> > Sure, I can send a 2 patch series in v3 if that's what you mean?
> >
> > By the way, since lspci parsing of the pciutils/tests/ directory would
> > use the dump backend, which does not use PCI_FILL_BRIDGE_BASES, it
> > will not exercise the bug fixed by this commit. Is it still worth
> > adding the test case? I am happy to send it, but I'm curious how it
> > will be used.
>
> I see. Those flags cannot be read from the PCI config space and they
> need to be provided by OS when it is doing enumeration / setup of PCI.
> So lspci -x dump outputs will not provide them.

lspci -x will provide enough information for lspci to determine the
bit-size of bridge windows. But when PCI_FILL_BRIDGE_BASES is set,
show_hypte1() ignores the flags in the config space and uses the
OS-provided flags instead, and that's where the bug was. So when
testing (./lspci -v -F tests/bridge-window-sizes), it outputted the
correct bridge windows with and without the fix.
