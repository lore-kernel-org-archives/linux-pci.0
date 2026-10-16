Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F599348C6B
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 20:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183533; cv=pass; b=ag/NuwyIkEp38xHKNSDhGdKXNm6qG6q5UrfMaq7BNpptsihjsSK/Rhww8m8MzOdQsRHKKS+xc9fF5BQzq9WzusUeWEhkjCSOCWkoEahpTJRqHD01Yq4JG9h9Z51p3ltA+uCTYCrs6UOVOF8HiULq8whRzy6jQTOeRJe5YSSQnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183533; c=relaxed/simple;
	bh=w7JWyGZgHnZCAXoncz6LsZsA5BNgjOZNNNQ+Gy3++CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpOgqMMKLEWCgpHfA6+yHkkHLZ9WAVadXUq4f1qrCpQF5PCYlCVBHVzEkm9yKThrYhL7SxliyWdd3jwlj6qd3CiVrw83JbgEms8TagLL9yVYuGbUjh6Y1OtJhSwbRN+/5Omv/0q1YBx/paoSsHMDq/cn7Ff6j4EVGlqZ5FaGCv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oUDjoBO7; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oUDjoBO7"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so3435a12.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792183529; cv=none;
        d=google.com; s=arc-20260327;
        b=EQpOoBk4Xhuss5xxaLh1SRRq2i/G0yY7NFwuwPvrP4BnnBjTc+klJN71FPsvWRYHqp
         dLdhVBqgroVHLKgDFtaHsOt7uocyWgIpcjLCWBtMBqWRvQACbjr7+C4K7vPAB/9Zq97Z
         tp5eoxQDJYdHrM4ACq3WM+y9kufqizzXeYlmHSII4a4jdKKrKfCXq0ivbizJmtsSpTWm
         zmXTbqXX2v8cWP5QhMHQya3J1MCj7JIwSCN1oNHYQJm99AxlQAHyXj6CW9FS+54bki0D
         6Qp+Mtn+hE7yiLb9U7+WZfRx8i+1Pe04Pb4nBhYPFHgCoyt/M5FA0QWCJeZY5Tr/LW0b
         +SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03NCNpz5syFo1Xi0u7EMykw+dKPD9aN2iwbA6vJW+Ss=;
        fh=Cvs4pkYTtcHuWMW2FnVY1DEKeSFr+yFxWy1PmN4u0a8=;
        b=ciDrSkFtlTukU5LRMlJ5S3RiS7ZDOkVgSI430tvQqf72d2byMq5zcnB2r3L10/1/fz
         +o5DbEqlA/Ush1ruk6bASwlPNJzcx9ycshPYP6n5JGv1GOCP1pE8iTxPE4q9V0iF2Iaj
         DZgOJ1BxFZnW50BAlKNc5320oOgQKVJ6zK8SL7LKABgt+We6MK/qHDubr3b0cq11tOjp
         cOkwdw992NTZt/bPmi/cXSG5xY+zGRHJAso8Rn0NNzLDGZVh3pZvEKnoT3Oiml0FLryG
         iRgtlDBzT0qVG5Gxiu49iIrhw4tWnlMAXxCkmT2MDoxq6so3gLlytsFddam0jpz8D1rC
         MkPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792183529; x=1792788329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03NCNpz5syFo1Xi0u7EMykw+dKPD9aN2iwbA6vJW+Ss=;
        b=oUDjoBO7duICncwbCaZxWoozEseHLEJYmdaHso+GoltA9+8o98+95pXhv8Zf0bIOe3
         FfwyU7MjMh+I54Xuk+YlLhM2ORaBHZgOTIZ8MbrP4KR+WoCM2K3pwyd4GikDklWBlUhs
         +pr2UnUpW3H+XB6APm1dyz8stWF2q4egAkh9wMmm23fvOlEephPpcZOulpuJCE5WK0J7
         rDUBv4bWR8GGW0q6WRSFGwb16c89FtpHcCcPZyHEJDagom8MuE2hDPpTSBpgWKcIqQXL
         hndIFgPY5LiyXaQIY53zhaF7VCmRifcw2rbXWy7VnxsdnQM4U5dsmj5EZY1FIyI35GP4
         SlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792183529; x=1792788329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03NCNpz5syFo1Xi0u7EMykw+dKPD9aN2iwbA6vJW+Ss=;
        b=kiuvcCxk/efdTC2r9vMWOA585XMfO+P/MS3+jC5SrTAJ+iODsHpunSURhnI/8o9Jbr
         utGxleC4wBAPuBwdUGa5NbDxgFrrlUsdu3kCIIDb5Drc233tL3G1yQyG48bzC2NzP8O3
         lyZopW37NWzb2Mv9AnE2LkoZMz+e+wgD4w9fY6p/7GZA3RDZhxbZogGr2VfDXT7FsPO+
         eLBIbL/Pxd1zEA1ocRWqm3DCn76wnm7Gj+h5T3d9z/QnAgMfL41lijBoKuw6EyyZj3DK
         WyviSnNMHB8wlgJpgDRhYSlvm20qUnGnTpj9+0nNdaLCI2meS/PozbBynj50WNBO/9AN
         k4HA==
X-Forwarded-Encrypted: i=1; AKwUvBwkDnqqLaGSbMZ1gpZL/kBajXmHamHpGAylY7CPZE+50Dw46Sx5tuVQqblKpH0u4VPgd9cNIcY8Olg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaZI2kHkrPLSOKZuAQ2QOtWiBxZaGNdWZTZiE/So1b9p8AK523
	BlGj0V1/+fKM/AjqymkwC8X0/bGwmI1yvvFkDK8iGskJvWb+Ew7GE1bnVGyEg6XMbU2Ko/Fvu6m
	VRdlO5Xdnjig9bnaAZsU9NT53tKhuqNseBjKNAzMa
X-Gm-Gg: AYBFou155f1mMKHTTy6mP/DqOJayKgqjj60f/BmRn+vFneU752VtdXWou7I/qZBG3Jf
	buWFAL4t0Xk2mUYgwUwijteUcdXajmxmzNMTsJaeydutoz+u/FbzkqvqY8sKtCGHvDfMgLdnSv6
	k2CAZOfk4KtpycPrEosvjNHyBvsWQgIMTR13zQEF1sKUJ5jmRVi/qlr5RG/Zp6i97lmAbYefC2Z
	YqDPPCQ+1i1F/uVTk2P3TLjrCFUJVTD0RJfJP/5dh4QWXV73VMN4R3ZZthu6W9acoQ5tqb/5pdJ
	QS2g2BGwRsDRBHW/S0gnqwSWzO2rcTBATG20F56Eu4rOC4wAu2x4SijN2ww0ro0pQkCn9RDWmgZ
	9H83EI33cdEKu/ILHIOUvB1JI9n589dM+xuQi6INF/lT/PGrFqpBAk+3FI2wYYdw+xV1sO+2DEp
	AUmwpW9Aqr1vbj6VTnaS2U
X-Received: by 2002:aa7:cd52:0:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b3ad90b370mr2852a12.7.1792183528706; Fri, 16 Oct 2026 13:45:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012114213.1757207-1-mclapinski@google.com> <atKGTn7PqaDaednD@google.com>
In-Reply-To: <atKGTn7PqaDaednD@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 16 Oct 2026 22:45:17 +0200
X-Gm-Features: AclHuK9TobvuzpulXhszilDKlYekt3FFZzWTrchifXJqQVbqZiZZYgBDRTMbwuQ
Message-ID: <CAAi7L5eqd0WzxiRY-fj3fB1=zOhYdTJnpR3OGgX27tYLe-SPmQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] PCI/DOE: Poll briefly for a response before sleeping
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:17=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-12 01:42 PM, Michal Clapinski wrote:
> > doe_statemachine_work() waits for a response by sleeping
> > PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> > which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are served f=
rom
> > the device's local mailbox logic and typically complete within tens of
> > microseconds, so nearly all of that sleep is wasted. Every DOE-capable
> > endpoint pays it once per supported feature during enumeration.
> >
> > Poll with usleep_range(20, 50) for the first ~2 ms before falling back
> > to the jiffies-based wait. On an Intel Emerald Rapids system, time spen=
t
> > in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
> > 14.0 ms.
>
> Does any of this remaining time come from pci_doe_abort()? I see that is
> also called during mailbox creation and has the same call to
> pci_doe_wait(). If so, maybe the poll logic can be shared.

Yes, but I'm not sure if the poll logic can be shared without making
the code worse rather than better. I'll look into that.

Also, I'm planning on skipping pci_doe_abort for preserved devices so
it was less of a priority for me.

> >
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > ---
> > I was asked if I can do this with interrupts instead. I don't see a way
> > to do that during device enumeration that won't collide with the
> > drivers.
> > ---
> >  drivers/pci/doe.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 6b5d9ba8e969..5e93d78a1a97 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -27,6 +27,9 @@
> >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> >  #define PCI_DOE_TIMEOUT HZ
> >  #define PCI_DOE_POLL_INTERVAL        (PCI_DOE_TIMEOUT / 128)
>
> It would be nice to also fix the HZ=3D100 issue, in a separate patch
> within the same series, since you are updating this code.

Okay, will do in v2.

> > +#define PCI_DOE_POLL_FAST_MIN_US     20
> > +#define PCI_DOE_POLL_FAST_MAX_US     50
> > +#define PCI_DOE_POLL_FAST_TRIES              40
> >
> >  #define PCI_DOE_FLAG_CANCEL  0
> >  #define PCI_DOE_FLAG_DEAD    1
> > @@ -487,7 +490,7 @@ static void doe_statemachine_work(struct work_struc=
t *work)
> >       int offset =3D doe_mb->cap_offset;
> >       unsigned long timeout_jiffies;
> >       u32 val;
> > -     int rc;
> > +     int rc, tries =3D 0;
> >
> >       if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> >               signal_task_complete(task, -EIO);
> > @@ -525,10 +528,25 @@ static void doe_statemachine_work(struct work_str=
uct *work)
> >                       signal_task_abort(task, -EIO);
> >                       return;
> >               }
> > -             rc =3D pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > -             if (rc) {
> > -                     signal_task_abort(task, rc);
> > -                     return;
> > +             /*
> > +              * Exchanges are served from the device's local mailbox
> > +              * logic and usually complete in tens of microseconds, fa=
r
> > +              * below the jiffies granularity of PCI_DOE_POLL_INTERVAL=
.
> > +              * Poll for up to ~2 ms before falling back to it.
> > +              */
>
> If tens of microsecond is the norm then is polling for up to 2ms
> overkill?

I guess. I can do more precise measurements and tweak this value;
however, I can only speak for the device I have on hand, so generally
I prefer overkilling it.

> > +             if (tries++ < PCI_DOE_POLL_FAST_TRIES) {
> > +                     if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)=
) {
> > +                             signal_task_abort(task, -EIO);
> > +                             return;
> > +                     }
> > +                     usleep_range(PCI_DOE_POLL_FAST_MIN_US,
> > +                                  PCI_DOE_POLL_FAST_MAX_US);
> > +             } else {
> > +                     rc =3D pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL=
);
> > +                     if (rc) {
> > +                             signal_task_abort(task, rc);
> > +                             return;
> > +                     }
> >               }
> >               goto retry_resp;
> >       }
> > --
> > 2.56.0.385.gd3acb90ef8-goog
> >
