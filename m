Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1F471249
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806047; cv=pass; b=Y4MkJ4TYUKgEQA/86hWjdacq7lD1dzEDw2nbgDhFhXnkdghhr8Pqqf3AW5AV4+b3/Avjk29GJlGJm4svcyQzE5qH6N2cc+UbQRi97w7JWkuZpvZwDtR6TLv/CHAdHak1ZrMLNwIS1Cc5nIGKzd8XUT2qoq2/Um5Bi/xxn8zGafo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806047; c=relaxed/simple;
	bh=W+yrOJzDyJ5PqiI4NfkV+QKWr+nkMYZHtZnIaIFG8QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaDnACz14jUPci6kvATevXK2T/r4T3KMJ7vnIlXbyEfaIQF7PDhOrb3UcwgCwxIq5sUO7u9UjcSy8A7Ax1s/UBnBTTeqDD97wPneSzPW87B83I76tlbrqgRImlkkaSjmkKh4OqSZbMjzrj1bK+IrAw1sRyx9m30XZcVboAGNki8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpqNwz+U; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpqNwz+U"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so9308a12.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 04:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791806044; cv=none;
        d=google.com; s=arc-20260327;
        b=g+fP7S0EHQPRwmSbYYm5/hS/6VI0L4Z2V2FQ7TLT55w1aH69sFI3RSh5hNZtGI9l7F
         W1IZFgbZZ3mKT7fWqFEacSEID7cTGg+Pqm4r7scdifu8FkR5nXX3azt8ax95Mzsiv4TQ
         Ly7Vwf2G0h3gGPxh0JWJQa2OLN9+seXoO7fHlEZDLt5kcL6Up4A6w2nMxtYUr1KHvLOh
         2dcoLRNxIueYeDZ64LBLZowSfj4HZ+Yr3m59oS6McfY4zlJqX3Q8QsJzlc9z1AceVoBr
         z5xERM/p/5QiPYIkuJ0EauDzBFa/WG3UF0ZFcI+GiMggmTAbMsllAcIVuOLIOqLTCjn3
         dvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X0xFSevncYFBAZwCKQnA0WXvbjVSUftRrMQuoOTk7P0=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=YXXOF7zHyDVdgraaVM9y6hChMrKHVwiFFjGkvUsTcvmAFRbUXsYZ4RdaX6uNSrMywZ
         p84gm4t9v/p7fS8V0DzRkrSdLiSxCvw4ds4AsFrIcrp96Oh3Vsofo+TSjPyQX7PISpV3
         /cfz1FecZvOdlWUZLzOxws/AEu79NpERmWFjNQg/Ahxl3rWNsKU+vr/FVbMn/qvsOhOm
         xqqG0HzAqmd5N8boeL4bw9Yi/VGbkGEXaz+Jb3atnkY1CIL+FXmG5PB9hsOFykruclpu
         hOQl4MSdSeYO/+VztkgXWC/mZygmozsK3uTO2wAdrvMmXHpZ4mMRXFL3vDmLcB4692u2
         nKlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791806044; x=1792410844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X0xFSevncYFBAZwCKQnA0WXvbjVSUftRrMQuoOTk7P0=;
        b=qpqNwz+UeLqVpecSARtyEwOLNtdAT9OlUK4lk+0v5Pd3OHPnnDi+enXRiy4OVlMJSx
         fYtcd3ckN8X6LR4HM0BAODyD6gCsTIsAkHEUiSPGE2w3Xr14qHvRhUqQS8iNtw6eVhR5
         Us9yXzmaXToo5bD4tuEBw5WwnsPXA+W5dAXgPzLguOTuceNQvUoIJ8NIuax2M/zJtx/2
         RmNXodks4MO32o3b2X09GRGeHxRHrTcbOAFRFVN/b48hHFeyEF4jw2KIBK64CiDhoAlS
         9YeAwuNBl5SoAsm+UTt3U2JeY5dZFvRdawbeZt7Lv9OZh+VRLnLI4O8skcHsXZ7gcG0/
         +eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806044; x=1792410844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0xFSevncYFBAZwCKQnA0WXvbjVSUftRrMQuoOTk7P0=;
        b=qEc4vsRjp9MtOEzjL9fB6cK7DodIr9WK6/LbQylH1mfEIxkjSuqTRsWP84NP+7h/t/
         o1/IGQ8CXr6hNcxfV5ofgozKIDXZWZXvK8eFLcz3NexLXC28GgDYBk07q9erQ21mg18m
         Otl5T4ZM86CaFcVKXOPEiCwFcYy8hrEnLLrl2imIUqoi4gS1qtlSLeDbW8dgUZz5PBdY
         YTcvyHhvVIx9rxmhs+KO53aqmRRwm9wDu/sw9y7xw71lZq3pRk07s1Uk8gsQf0KuJPcg
         qDOBN9tMefw89Bp/BY3ckG1IHcbYI0hbXqrloGy+2MdHuof2QJZ2GqsfM9Mo77KobMTb
         SeQg==
X-Gm-Message-State: AFq9FYKNxq9ibjMZRg4WC+KlpCHNJ5EjaZVBKBmNZ4Ug24PyEkqizYJY
	hP3gmcRonw6IRBs3UoJUG12gDMkr5KdLeVofaQpo/GREwDfiVHUVeKvnCpj22gPP3NcQZmYZQWd
	1eZ8joep9KtxwM9pY4Y/zhaY5P9LwKRQMXWpIHVM5RqoRfZcmNvz92oW6
X-Gm-Gg: AYBFou3i6KRAQFAXExZJhDNMBV+3bseWsXfCEvqwLfzZb5hcGvYR8qfTsJhA1DN84TD
	PKsxs39Yciz/i3DLU1dix1uTojN8711s0od+BuNLjU0ZqWP4AaTD+xXkSzzNvS9pu/p50xpjQq7
	htf7xM+bRWxIJamJ6sStG6nXQwRHaKEaANMJgYIWcunIFHen38JMaXxg0dJGrAtNdH5WBKpV6vC
	VyqNRu0VHtbBYIlehY4ZzulE3DKAa5How2yUTsarwItFOBGlth8hIo5iXGb3V18AaIx3SbZLl3G
	uFiYp4Omr6a6mNveU3R6ye1O3K87kC3kgMZhOlhu3+D5ne8GR101vT1RCnfTjTcr2/3etEQ6+Sx
	AYtFoEfMH0w==
X-Received: by 2002:a05:6402:c4ce:10b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b19883993fmr48978a12.2.1791806043720; Mon, 12 Oct 2026
 04:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012114213.1757207-1-mclapinski@google.com> <sashiko-outbox-168028@kernel.org>
In-Reply-To: <sashiko-outbox-168028@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Mon, 12 Oct 2026 13:53:52 +0200
X-Gm-Features: AclHuK_IudBD0PSNt8K_aewjV-AkAYybXJ2qyIG4OhunkQvG5CHoSq9_LjtJiv0
Message-ID: <CAAi7L5eN7p42d-5tEgGkhBUDCw7Q2gWfys9qLvqp5yMbfLJnBA@mail.gmail.com>
Subject: Re: [PATCH RESEND] PCI/DOE: Poll briefly for a response before sleeping
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 1:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] pci/doe: CPU busy loop when HZ=3D100 due to PCI_DOE_POLL_INTER=
VAL=3D0
> --
>
> commit 16e5277536bbca37386848082d18257e2ffa71dd
> Author: Michal Clapinski <mclapinski@google.com>
>
> PCI/DOE: Poll briefly for a response before sleeping
>
> doe_statemachine_work() waits for a response by sleeping
> PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are served fro=
m
> the device's local mailbox logic and typically complete within tens of
> microseconds, so nearly all of that sleep is wasted. Every DOE-capable
> endpoint pays it once per supported feature during enumeration.
>
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 6b5d9ba8e9697..5e93d78a1a97e 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -27,6 +27,9 @@
> >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> >  #define PCI_DOE_TIMEOUT HZ
> >  #define PCI_DOE_POLL_INTERVAL        (PCI_DOE_TIMEOUT / 128)
>
> [Severity: Medium]
> When HZ=3D100, does this integer division truncate to 0?
>
> If PCI_DOE_POLL_INTERVAL evaluates to 0, it permanently breaks the fallba=
ck
> sleep mechanism.
>
> > +#define PCI_DOE_POLL_FAST_MIN_US     20
> > +#define PCI_DOE_POLL_FAST_MAX_US     50
> > +#define PCI_DOE_POLL_FAST_TRIES              40
>
> [ ... ]
>
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
>
> [Severity: Medium]
> Does passing 0 to this wait function when HZ=3D100 trigger a tight spin b=
ug
> instead of yielding the CPU?
>
> Since wait_event_timeout() immediately returns without sleeping when the
> timeout is 0, this regression results in a tight CPU busy loop spinning o=
ver
> pci_read_config_dword() continuously for up to 1 second during enumeratio=
n
> for affected hardware.

Yes, but it's a preexisting issue.

> > +                     if (rc) {
> > +                             signal_task_abort(task, rc);
> > +                             return;
> > +                     }
> >               }
> >               goto retry_resp;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012114213.17=
57207-1-mclapinski@google.com?part=3D1
