Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440272;
	b=QE6MveYejCmRmsDCycQoyb/heMN0P/aABb/3GsAubjCSizb42+hn6YMNVItfBuJ7TXxv
	 5RET5xXxKNOqf+PW1eJ55UBsogZvXsrZ4NchFUucDxNxKPRRJiqmDgoeh81VXukPIqmLy
	 txMlQ8gp2nIs+w66zcvTLqmoqssvVieD8PlS4UZj5KZRwpyVW5c+Zv2UaGR+DrnpBBibg
	 l1NCh6JMhXVUruoy56Oxk1pd9xFyCDzR8GYVX0/gg6wZGJwlZ77laK64KOVUQFG7IZm1H
	 4KbX+nzQpVpFUGAXqIdyT3bxN7bDQYg0F4b/7XUjff18gf0ZTlZpD/Q7XmZrKo/5EuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hQTMpw8zD5szBflWUqeHKLQyPwSukYsy+dAMyCP/6Lg=;
	b=cWOyVO8KxWbcsuGWRQljPbKW2Bc5RYrIiNvYyyySuI4Mgn96hJ/aOrX68oqSZojgz8Ac
	 yoBCRfdbDu5UWP7tjUOYtF7SbS0nOiN6XyY542D5Es8hw17GS3DaoFiL5S/o4E0pY8ZS+
	 WIQLMWktvb+Dm38YeE3NwPCZryPMMptPVbnXYGvDvIax5bkoSalRGlXjWA/rC/sZBYvLL
	 EuJepePI7Db9ibojuWUFSEHNdjd02XnoczfNGO+diyD5nPz6VGWAOLdieIiyNcXGbMMv1
	 WGuAUXf8m6SozLWvB4ZdsKvqfEQarZGcyLues3mFEF0SgIxR5JXboNUcf1UNTJGHHGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Kp8yjJ5s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F1606A31C
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 20:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Kp8yjJ5s
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso3023188a12.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 13:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792440270; cv=none;
        d=google.com; s=arc-20260327;
        b=YqjxiknUSXFxKsfG3TYbeiISYlTxYQVI9r4esCj8phmhwpfihzT+d8bltKYDzxt/Gl
         a4ChN3HZ4vGgao30u0mID30XJVtUuloXh1ywm4pBVqoAA96jEBi0wysQB4IxT1LLOwuk
         4vNiU7WEmJIzEIixAmSdJArB9y5e5AZtEzvrg9txEoDmuZ/OeeAhxtoSccP1bndYaikm
         YZHiTjAjWkagCI9WrCeLxwfNmZ8jDlsK1AxpKbFFf+a5wfCYDV+RcNXftDyX4VaJuOD8
         eV3t/nn8Zj2p++NDEcVXVMwlIYYKWtUlOsM0mZvfi4SCjW3V9FLkxBFVYfsI2TZj+350
         8R5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hQTMpw8zD5szBflWUqeHKLQyPwSukYsy+dAMyCP/6Lg=;
        fh=ZcfUNZWwgvgPLYQPJYXiwhFD8XpPYvxXsFZ60hlypGM=;
        b=OJWk5/faI4elnxQBhRp+fsccKOejheCrfr8Z46pj6Rqb+l0oas4jt5DU/g/mbrqJo+
         cthDpSK9xzDor8NMaDb/DXBsSTl//908bdxVXAWO0Tnn/CS6fK1XymGpMKAq72PMDqrY
         Al7AUa0rRN+uJRN0kpUNxwDCza2IjyHled5a4YYSUXCRngE127v5HvmNRz8WZTrlLeut
         4kQtYcwvyXDv9uz3l66kuaOZnCb2/RXXupyPIfBdJ5GOI8AgtXeyCPKxoYTKtgLmSSxU
         AUGjtQV75wObgoGcxcBFoxmOl2BJPpw6pCzvqeiR7PBWHb+Rv88aVnaOE3aLAgDASkmz
         VWww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792440270; x=1793045070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hQTMpw8zD5szBflWUqeHKLQyPwSukYsy+dAMyCP/6Lg=;
        b=Kp8yjJ5sDuHWLcUfpMMXLuziUS0mADvUjFleeEia4HL8UtxY8lhj5mkChqbaP3fUxb
         UE/oFvIJiYqSp/g+L/MSoXcnTW6Y2+OPvkqzdJrLePYa4MB4RVAef1DsV0E1c2WJRPIo
         3MFrdei+08DViffq3JQBKIm118tgiCV6qCUbEm3VlcM29H1fzj/lDbv9t4xtZWeRkY77
         MKY//nmwCxCYMtTsLoJzdGL5BhcGWE0aIHufE1g3peHpHZ3AqNzi2zLBvbLNbprYiRTE
         7sJlUREUdqWb/DqyR8SG/zWEpnpaG2bOOO5m1e/pGfbEJrEuVtxK6V1i1Y/gF8I0FB91
         fsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440270; x=1793045070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQTMpw8zD5szBflWUqeHKLQyPwSukYsy+dAMyCP/6Lg=;
        b=O8ot30SSJZxC9kf2tSb/xDJw0pQTeIEGefPPZXG3PQGRtXrPdnQXqngiPDQmsm4Gsx
         IWnegPSvI5PSQ8pKtJc7ZcfTha1lhT6tJaTDBrjM7W8gkYYniJBvJNZUpiL7l8B5DUhH
         G94s0j5xo/uZ5NpRYNOoJ2rnYFVpqrk5oLJxK34MTHTe2v2PDPmffsWqKRKKZzraj7eH
         RH7yRTk6CPXsT7UhuA+dNMSDafTS7HoqrSqwXq3SklLfpfycd5beo6owRt1xEqxue8jv
         j5e94SiWyhysRYHOHxtUu+nTlSotoKzGn7kvSLbX89EX7/6Kr5aAajkgg9gYNfunyogy
         goQw==
X-Forwarded-Encrypted: i=1; AKwUvBxSn41F+gQ/gbNQzOBLL5VFpHYOLMnp+uGn+rz56EP5HSBUEttSTc0efF7Tf2t0qPmWRbLOTD8OwnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7v6aFEqo51bVkvpFEI66d1f4ml8rhwRzYqnFlOGOmlPiTlDsT
	6feSZHHc/OPK/9tc0fAO8d/jGL6d0uj+yWLGPIMu/nuW7bfANbFJBCyFmd0zleIXhntCVNb/WMR
	yYUDKhBB7kIkhQoK3tsPFYnwKHaGr9ZJZah5sKZq7
X-Gm-Gg: AYBFou0Cf7DOIcCqQRY7/YjmFCGvxMnw3zqQFgGfsHZVawCYpkBt0tklc6HxpGB94N8
	ysOHr+UtTHcoMZQRZHUmsW+NaXmlVcu9qBx0p0Gkzx3rdJdYqmSElTfqXI/TTpNq3ydFrIntv6X
	N8P6MlpaN514Cu5XMyHy64ce93Zbcy7RrgE6MjJpuMvIq1LtzcL6+k8OUnq6kfQKlWy2e55Ovdk
	vdUM0MLEYxh3bxvP9w1IqJPEcPnDX6er/FXURVQcD9l6sSjwFlkrrO6iFivmaH2uo4NoR+RPFjH
	0LGwcgJa5eirvW7Og0duXJHIwbtOK6z+O0OaA6lD2aXFmXrjz0ZaNoxAEwdwL/ZoEvdiALJU98u
	DsL8W2u6V1GZC6F63imioVwrOy4seA+Qvm7J1XA==
X-Received: by 2002:a17:907:c50a:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c419a93fe03mr613738966b.5.1792440269617; Mon, 19 Oct 2026
 13:04:29 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012114213.1757207-1-mclapinski@google.com>
 <atKGTn7PqaDaednD@google.com> <CAAi7L5eqd0WzxiRY-fj3fB1=zOhYdTJnpR3OGgX27tYLe-SPmQ@mail.gmail.com>
In-Reply-To: <CAAi7L5eqd0WzxiRY-fj3fB1=zOhYdTJnpR3OGgX27tYLe-SPmQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 19 Oct 2026 13:04:01 -0700
X-Gm-Features: AclHuK_QdMDA5Fu_vMSJQvkQhclAigr8I0alQpzs7JjxBDCU-JiFgxcvCjL7XwU
Message-ID: <CALzav=fY0CGYhcKhHMOjt4gWR47JLr_c9EnGOXaZaz9e7OAjPA@mail.gmail.com>
Subject: Re: [PATCH RESEND] PCI/DOE: Poll briefly for a response before sleeping
To: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 1:45=E2=80=AFPM Micha=C5=82 C=C5=82api=C5=84ski <mc=
lapinski@google.com> wrote:
>
> On Fri, Oct 16, 2026 at 10:17=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2026-10-12 01:42 PM, Michal Clapinski wrote:
> > > doe_statemachine_work() waits for a response by sleeping
> > > PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
> > > which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are served=
 from
> > > the device's local mailbox logic and typically complete within tens o=
f
> > > microseconds, so nearly all of that sleep is wasted. Every DOE-capabl=
e
> > > endpoint pays it once per supported feature during enumeration.
> > >
> > > Poll with usleep_range(20, 50) for the first ~2 ms before falling bac=
k
> > > to the jiffies-based wait. On an Intel Emerald Rapids system, time sp=
ent
> > > in pci_device_add() for a DOE-capable endpoint drops from 41.8 ms to
> > > 14.0 ms.
> >
> > Does any of this remaining time come from pci_doe_abort()? I see that i=
s
> > also called during mailbox creation and has the same call to
> > pci_doe_wait(). If so, maybe the poll logic can be shared.
>
> Yes, but I'm not sure if the poll logic can be shared without making
> the code worse rather than better. I'll look into that.
>
> Also, I'm planning on skipping pci_doe_abort for preserved devices so
> it was less of a priority for me.

I don't think that will be effective. A Live Update may have any
number of preserved and non-preserved devices. We should try to find
solutions that work for both types whenever possible. The less places
we need to sprinkle pci_liveupdate_is_incoming() the better.

>
> > >
> > > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > > ---
> > > I was asked if I can do this with interrupts instead. I don't see a w=
ay
> > > to do that during device enumeration that won't collide with the
> > > drivers.
> > > ---
> > >  drivers/pci/doe.c | 28 +++++++++++++++++++++++-----
> > >  1 file changed, 23 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index 6b5d9ba8e969..5e93d78a1a97 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -27,6 +27,9 @@
> > >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> > >  #define PCI_DOE_TIMEOUT HZ
> > >  #define PCI_DOE_POLL_INTERVAL        (PCI_DOE_TIMEOUT / 128)
> >
> > It would be nice to also fix the HZ=3D100 issue, in a separate patch
> > within the same series, since you are updating this code.
>
> Okay, will do in v2.
>
> > > +#define PCI_DOE_POLL_FAST_MIN_US     20
> > > +#define PCI_DOE_POLL_FAST_MAX_US     50
> > > +#define PCI_DOE_POLL_FAST_TRIES              40
> > >
> > >  #define PCI_DOE_FLAG_CANCEL  0
> > >  #define PCI_DOE_FLAG_DEAD    1
> > > @@ -487,7 +490,7 @@ static void doe_statemachine_work(struct work_str=
uct *work)
> > >       int offset =3D doe_mb->cap_offset;
> > >       unsigned long timeout_jiffies;
> > >       u32 val;
> > > -     int rc;
> > > +     int rc, tries =3D 0;
> > >
> > >       if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > >               signal_task_complete(task, -EIO);
> > > @@ -525,10 +528,25 @@ static void doe_statemachine_work(struct work_s=
truct *work)
> > >                       signal_task_abort(task, -EIO);
> > >                       return;
> > >               }
> > > -             rc =3D pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > > -             if (rc) {
> > > -                     signal_task_abort(task, rc);
> > > -                     return;
> > > +             /*
> > > +              * Exchanges are served from the device's local mailbox
> > > +              * logic and usually complete in tens of microseconds, =
far
> > > +              * below the jiffies granularity of PCI_DOE_POLL_INTERV=
AL.
> > > +              * Poll for up to ~2 ms before falling back to it.
> > > +              */
> >
> > If tens of microsecond is the norm then is polling for up to 2ms
> > overkill?
>
> I guess. I can do more precise measurements and tweak this value;
> however, I can only speak for the device I have on hand, so generally
> I prefer overkilling it.
>
> > > +             if (tries++ < PCI_DOE_POLL_FAST_TRIES) {
> > > +                     if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flag=
s)) {
> > > +                             signal_task_abort(task, -EIO);
> > > +                             return;
> > > +                     }
> > > +                     usleep_range(PCI_DOE_POLL_FAST_MIN_US,
> > > +                                  PCI_DOE_POLL_FAST_MAX_US);
> > > +             } else {
> > > +                     rc =3D pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERV=
AL);
> > > +                     if (rc) {
> > > +                             signal_task_abort(task, rc);
> > > +                             return;
> > > +                     }
> > >               }
> > >               goto retry_resp;
> > >       }
> > > --
> > > 2.56.0.385.gd3acb90ef8-goog
> > >
