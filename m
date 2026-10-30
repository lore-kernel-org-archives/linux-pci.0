Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793365163;
	b=Wk0K1S4OpiTQI3ra0fwgOn4VEEY7WYc5IUcpYJvYe1bWXXsm3ivGWgTSX8lEKNwcPtzE
	 vZz8ZGuEIJyzj11VxrgfQWFV7WjvzJA5vYPAEH3MIqIUFPMp4ZYu8md7Xbl5vZy6x5792
	 d8zZWFKFnoN6cod118MCTkNbZIxsGes8AHOIOqQ4CyO7Q9waR750cWyoEWB1bpzEBcRZP
	 PRpWPnef4g2jqOVHyZMtUbQWOC/phekKviuMZ1psLE6az9S6aRD5/JNtfr08D518VB7rJ
	 Vq//7MrMrA3HeIfJzSHbQYQMD0VwzylZzctpCl7lhwKLD54wzGlfb5bN0nsVCsIzQtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p6R90zdJgmEJTfYgbyUUxOPzWcHXkQ+Gzj39UPrsQEU=;
	b=adDlsGwLZkjtrbVL8TmaqIiLBP9gD+kkVoF5dLgz4pVCQNzdxDbCmHRpITZk7ItgSUd6
	 CGoO2giTVSJqUkJiA72GtaCa6fbgJ49gunGXIOqnYQW3PqQ1iBdWhDk4Bi0pw0YT1+42a
	 cIxXMYv/QjuH/sK/LqxJijirIDsWM7THWGmi9MoSIGB9rRGGj3gpPBOb5tZtp3uJS5btA
	 iO1Uf0axgniWIQAHzP/2S8YfYjLf/VPd0na2Q9j2yDrc4txL8IZUudRjYWYfFT51Unzu0
	 OVlYIe4YgtJJJupztNoV1HyOS3FPSX+xxkXT0PvKBvHeLZCCtAl3CKjAu/BDm/kZrqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nearthlab.com;
	spf=pass smtp.mailfrom=nearthlab.com;
	dkim=pass header.d=nearthlab.com header.i=@nearthlab.com header.a=rsa-sha256 header.s=google header.b=jcg5JOa2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA9606A337
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 12:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71AA9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=nearthlab.com header.i=@nearthlab.com header.a=rsa-sha256 header.s=google header.b=jcg5JOa2
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso3748495ad.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 05:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793365162; cv=none;
        d=google.com; s=arc-20260327;
        b=kyvYz1LQL0oIcaTk7N7d/lKJmG0bL1ChYEInEARZTqquy0T5fN1PZoMUZOHSG6LyZ+
         a/ryltEptJOQL5FDk7I7hoTl09Sg0Icq9th2rj+VXsaw4CjDNj7y2si3gy0qM4OX+bqP
         frQi050cHiAJ2WUd7LQoMHIGFPYSidEYz7OJHfYmQ4Dyx88onBGtchoI9md6CetO8DhU
         lQu8dsCDKmQozOXmu3wYhoqMzde67pTlztQFWkjmKs+zEa//F6M+SgWfeG082hzFPrHm
         yNSBtrie2WdXCDKHAzfRQS9dXtZLASBRQ4UdYamsMS49PPX3AYpodOdiSg6j8Cgvc+vQ
         JgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p6R90zdJgmEJTfYgbyUUxOPzWcHXkQ+Gzj39UPrsQEU=;
        fh=RB+lMrBhIdgGxxr+4inw/qgFZKQIOKVvhVjdrGvOMwA=;
        b=kYSWil9EzXeCxvDdWOPNovYkm1dh45yDTQM4KtSrDE3fbBlWluqjE3d4U4qydHBgLK
         VVoiIYFhJZaUhoa9++VyhsW90Qfc7gPoRX1sUPx4mQ6ZW8xFESaEioEv53B97hQGg8U/
         pheEYFYLgcw3ivpm8TVf4oXFPoyngPxwjpFTzBWh1hWsIiTFtSnBSbUjgMcNvxWzFArm
         2mLi3vm6ZrLHTgRjIcr0o2Xzb1xLL7YlvoZdrYmC1GsK53AY5ese/pXCedmLOAhjScZG
         SU1eMSsDrjYaRryabSVu7JQzJIiKgcCO7PqjAiVkaKDRgNIR1dERqA0O13cl77FkIGmu
         RGxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1793365162; x=1793969962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p6R90zdJgmEJTfYgbyUUxOPzWcHXkQ+Gzj39UPrsQEU=;
        b=jcg5JOa2QriZQ122t9TVaXV1GB6tc/Tw3QkYBp32vfK1VOe4EICNbvzmKRTwP6xHiu
         zr9k9DuEeYHeZ3N4kv1BCoKPOrA6GGTwq4L149qoXSIaeftBk1dfXjx6IsmWAxLBr9Mb
         YVSdAd9khtSVrY6bIJxNGfUP6bSJ0KFI9KPBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365162; x=1793969962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p6R90zdJgmEJTfYgbyUUxOPzWcHXkQ+Gzj39UPrsQEU=;
        b=nq8p4LGC5iSWJqlv5rl3L8if/Dn+nMeyNR7tcdYcgn99JfjxtQEZsADc3ZdUTpeS39
         29JPxOPqQLcHn3WIBruaFFBCz9xW7yG48VY/AXlbEfYBNWqAWvU52aZHAQLv67syRySw
         xxVRHNEfkyNDPneevloFfWGS/ebmZcf95ePRqCtQyO40bQe+655MJrQw38NAbNkJm700
         Wh+dhAGKXIXMzJTKOC81TNsNy7c3uhydUGxa0hNF0ClnwGw6UmzzBKRI+TMCDoGtCThy
         zo+/AtnrUX74EmzqQ0GdDFs9eomkZGORpoIKdoVDz5CC3jBoKoKFvG++UuyRCq3nOvSa
         g6YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEDanijqO+rjDoGO8Tk+9/oXJj+u7qwScyxPRVj0pcc8WOLiqCXHXadz831ex1ISQfvUmpn69XR9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUKq9mmhWsPz3MdfNON5dgJzuOHfhzGQT/6xPmqEI9+jmvbD7i
	LvcuRlJ6TTgHyztuVDf29fwcFWD4mcziaCK5TXGgUkYIy+EILKmPZPEvNob1WYM/5ZXdh3A3+DK
	kmTEH6bp/Ce2/D4xq1I4wYy2FKkuLECvOQCvS5cRltQ==
X-Gm-Gg: AYBFou0o2nba7dpXxwiPAj5zwkZ4UPp76/Eoxk/CMAp+RAMEt0IJX5t1kJD44SOjtMu
	yl/wcB19wVad17LvdicGzoxQI5Yj11+hK5yLvo3xezWLqPN//27uGTw4Jeggckpz7dmugL8sFxD
	8peOaf0qcjzynYhLXbiDPlNnlPsz9atPF2Uv0+0F//gtPfruy/0Jlu9HNtTKua5e9lrcbwkRnIQ
	rIVIntcnMH3nFPiNiCreb1e9mwilqnMuQo0UdOpHh32QEHQlxPHsHgC0zFkH5DX0Rqc2mubdb5p
	HYIoS9GdOiuP9nbQsaedkxpcGeThHAcw1vocuh6hMyJNkaZDbI34Ju5a+NrEBiv1zo7SBWMrwyn
	gBaTHVVQ4hj3IJ4VuV9szU4XSkWETudLoPH5vZg==
X-Received: by 2002:a17:90b:570c:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ae897ccb52mr1922463a91.11.1793365161515; Fri, 30 Oct 2026
 05:59:21 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFg7d9becn9_=ZzNwQ7bSBBNid28t_RnofL-Vb1cZVHVHxS9fw@mail.gmail.com>
 <20261013160612.GA1522005@bhelgaas>
In-Reply-To: <20261013160612.GA1522005@bhelgaas>
From: =?UTF-8?B?SGFuIC8g7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Date: Fri, 30 Oct 2026 21:59:10 +0900
X-Gm-Features: AclHuK_9LSEza9FeIN4_POSl6PnQiLI9XlH_CpYxxAsTk82lmVZT6Y9umW1SJXE
Message-ID: <CAFg7d9a2p2jtGyThS1M=2ZFDX0y5rpSK3H34ZuTz09R5r_ff0A@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, jim2101024@gmail.com, florian.fainelli@broadcom.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Inochi Amaoto <inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, Oct 01 2026 at 21:29, Thomas Gleixner wrote:
> Good. Can you please retest with the updated patch?
[...]
> Any updates on that? Also please provide the source for that test.

The 5-vector endpoint I used before is no longer available to me, so I
tested on the same BCM2712 board with a similar endpoint that
advertises a single MSI vector. Since I did not have time to write a
test driver for it myself, I used an AI-generated virtual driver to
make the kernel see Multiple Message Capable =3D 4 and request 3 vectors.
I cannot vouch for its quality, as I had little time to review it.

Kernels: rpi-6.12.y (6.12.93) with KASAN, built with no patch, your
first patch (v1) and the updated one (v2). I ran five loads with
PCI_IRQ_AFFINITY and five without, both with the port's MSIs on the
brcmstb MSI controller and on the BCM2712 MIP, which is an MSI parent
on this tree:

                                 no patch   v1         v2
  brcmstb MSI controller
    KASAN report                 no         yes        yes
    allocs OK, affinity          5/5        1/5        2/5
    allocs OK, no affinity       2/5 (*)    5/5        5/5
    free calls to the parent     3 x nr=3D1   4 x nr=3D1   4 x nr=3D1
  BCM2712 MIP
    KASAN report                 (**)       yes        yes
    allocs OK, affinity                     1/5        2/5
    allocs OK, no affinity                  5/5        5/5
    free calls to the parent                4 x nr=3D1   1 x nr=3D4

  (*)  the original brcmstb leak
  (**) not run

  BUG: KASAN: slab-out-of-bounds in __irq_alloc_descs+0x158/0x460
  Read of size 8 at addr ffff8000053a68b0 by task insmod/599
  ...
  Allocated by task 599:
  ...
   kmemdup_array+0x50/0x88
   msi_alloc_desc+0x88/0xd0
  ...
  The buggy address is located 0 bytes to the right of
   allocated 48-byte region [ffff8000053a6880, ffff8000053a68b0)

The report is caused by the patch. __msi_domain_alloc_irqs() passes
nvec_aligned (4) to __irq_domain_alloc_irqs() together with
desc->affinity, which has only nvec_used (3) entries. alloc_descs()
then reads all 4 entries. The fourth entry is read past the end of
the array. If the data there has no CPU set, the allocation fails
with -ENOSPC. Without PCI_IRQ_AFFINITY, desc->affinity is NULL, so
this read does not happen.

On the brcmstb path, v2 still frees one vector at a time because
brcmstb on this tree uses pci_msi_create_irq_domain(), and neither
IRQ_DOMAIN_FLAG_MSI_DEVICE nor IRQ_DOMAIN_FLAG_MSI_PARENT is set.
The MIP behind this port has 8 vectors, while the switch ports use 4.
Therefore, the MIP path works for this 4-vector block but not for the
original 5-vector endpoint, which is rounded up to 8.

The test module from my earlier report is below. I bound it using
driver_override and loaded it with min_nvec=3D1 nvec=3D3 affinity=3D1.

// SPDX-License-Identifier: GPL-2.0
// TEST-ONLY Multi-MSI exerciser. Bind to a PCI device via
// driver_override and request a parametrized MSI vector count to probe
// brcmstb/core accounting. nvec: max vectors, min_nvec: floor,
// affinity: add PCI_IRQ_AFFINITY (triggers the managed-affinity path),
// request: request_irq the granted vectors.
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/interrupt.h>
#include <linux/irq.h>

static int nvec =3D 5;
module_param(nvec, int, 0644);
static int min_nvec =3D 1;
module_param(min_nvec, int, 0644);
static int affinity;
module_param(affinity, int, 0644);
static int request;
module_param(request, int, 0644);

static irqreturn_t msi_exer_isr(int irq, void *data)
{
        return IRQ_HANDLED;
}

static int msi_exer_probe(struct pci_dev *pdev,
                          const struct pci_device_id *id)
{
        unsigned int flags =3D PCI_IRQ_MSI;
        int ret, i, n;

        ret =3D pci_enable_device(pdev);
        if (ret)
                return ret;
        pci_set_master(pdev);

        if (affinity)
                flags |=3D PCI_IRQ_AFFINITY;

        n =3D pci_alloc_irq_vectors(pdev, min_nvec, nvec, flags);
        if (n < 0) {
                dev_info(&pdev->dev,
                         "msi_exer: alloc(%d..%d,aff=3D%d) FAILED %d\n",
                         min_nvec, nvec, affinity, n);
                pci_disable_device(pdev);
                return n;
        }
        dev_info(&pdev->dev,
                 "msi_exer: req %d..%d aff=3D%d -> got=3D%d base_irq=3D%d\n=
",
                 min_nvec, nvec, affinity, n, pci_irq_vector(pdev, 0));
        for (i =3D 0; i < n; i++) {
                int irq =3D pci_irq_vector(pdev, i);
                struct irq_data *d =3D irq_get_irq_data(irq);

                dev_info(&pdev->dev,
                         "msi_exer:   vec %d irq %d hwirq 0x%lx\n", i, irq,
                         d ? (unsigned long)irqd_to_hwirq(d) : 0UL);
                if (request && request_irq(irq, msi_exer_isr, 0,
                                                   "msi_exer", pdev))
                        dev_info(&pdev->dev,
                                 "msi_exer:   request_irq %d failed\n",
                                 irq);
        }
        pci_set_drvdata(pdev, (void *)(long)n);
        return 0;
}

static void msi_exer_remove(struct pci_dev *pdev)
{
        int n =3D (int)(long)pci_get_drvdata(pdev);
        int i;

        if (request)
                for (i =3D 0; i < n; i++)
                        free_irq(pci_irq_vector(pdev, i), pdev);
        pci_free_irq_vectors(pdev);
        pci_disable_device(pdev);
        dev_info(&pdev->dev, "msi_exer: removed (freed %d)\n", n);
}

static const struct pci_device_id msi_exer_ids[] =3D { { 0 } };
MODULE_DEVICE_TABLE(pci, msi_exer_ids);

static struct pci_driver msi_exer_driver =3D {
        .name =3D "msi_exer",
        .id_table =3D msi_exer_ids,
        .probe =3D msi_exer_probe,
        .remove =3D msi_exer_remove,
};
module_pci_driver(msi_exer_driver);
MODULE_LICENSE("GPL");

Thanks,
Sangwoo


2026=EB=85=84 10=EC=9B=94 14=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:06, =
Bjorn Helgaas <helgaas@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Oct 13, 2026 at 05:47:49PM +0900, Han / =ED=95=9C=EC=83=81=EC=9A=
=B0Sangwoo wrote:
> > Hi Bjorn, Thomas,
> >
> > > > Good. Can you please retest with the updated patch?
> > >
> > > Sangwoo, any update on this?
> >
> > Sorry for the silence.
> >
> > I have not been able to retest yet. I have several work items on a
> > tight schedule right now, and I am currently working on a different
> > board for another project, so I cannot get to this at the moment.
> >
> > For the KASAN slab-out-of-bounds report, I will follow up within
> > October.
> >
> > For the retest with the updated patch, I cannot give a date right now.
> > I am sorry about that.
>
> No worries, just wanted to make sure we didn't drop this.  I have a
> note to follow up again later :)
>
> > 2026=EB=85=84 10=EC=9B=94 13=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:=
47, Bjorn Helgaas <helgaas@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
> > >
> > > On Thu, Oct 01, 2026 at 09:29:27PM +0200, Thomas Gleixner wrote:
> > > > On Mon, Sep 21 2026 at 18:05, Han / =ED=95=9C=EC=83=81=EC=9A=B0Sang=
woo wrote:
> > > > > I tested Thomas's patch on the same hardware setup with the 5-vec=
tor
> > > > > MSI endpoint. The patch was applied as posted on top of 6.12.93
> > > > > (rpi-6.12.y).
> > > > >
> > > > > With the patch applied:
> > > > >
> > > > > - The MSI base hwirq remained at 0x8 across 200 driver reload cyc=
les.
> > > > > - The driver got all 5 requested vectors on every cycle, with no
> > > > > single-MSI fallback. Multiple Message Enable remained at 8.
> > > > > - The brcmstb inner-domain mapping returned to baseline after eac=
h
> > > > > unload/reload, with 12 mapped while the driver was loaded and 4 a=
fter
> > > > > unload.
> > > > > - A kprobe showed one allocation of 8 vectors followed by eight
> > > > > single-vector frees, with nothing left over.
> > > >
> > > > 8 single vector frees?
> > > >
> > > > Seems I got something wrong there verus the bulk free. Updated patc=
h
> > > > below.
> > > >
> > > > > The MSI vector exhaustion issue I originally observed no longer
> > > > > reproduces with the patch.
> > > >
> > > > Good. Can you please retest with the updated patch?
> > >
> > > Sangwoo, any update on this?
> > >
> > > I don't see this patch in linux-next (next-20261012), so I don't thin=
k
> > > this will be fixed for v7.4 unless something moves it ahead.
> > >
> > > > > I also observed a KASAN report with managed affinity. Using a sma=
ll
> > > > > out-of-tree test module bound to the same endpoint and requesting=
 1..3
> > > > > vectors with PCI_IRQ_MSI | PCI_IRQ_AFFINITY, a request for 3 vect=
ors
> > > > > resulted in:
> > > > >
> > > > > BUG: KASAN: slab-out-of-bounds in __irq_alloc_descs+0x158/0x460
> > > > >
> > > > > Requests for 5 and 7 vectors were capped to 4 on this 4-CPU syste=
m and
> > > > > did not trigger the report. I have not checked this against the
> > > > > unpatched kernel yet, so I cannot tell whether it is related to t=
he
> > > > > patch.
> > > >
> > > > Any updates on that? Also please provide the source for that test.
> > > >
> > > > Thanks,
> > > >
> > > >         tglx
> > > > ---
> > > > --- a/kernel/irq/irqdomain.c
> > > > +++ b/kernel/irq/irqdomain.c
> > > > @@ -1610,6 +1610,17 @@ static void irq_domain_free_irqs_hierarc
> > > >       if (!domain->ops->free)
> > > >               return;
> > > >
> > > > +     /*
> > > > +      * MSI device domains are capable of bulk free.
> > > > +      *
> > > > +      * CHECKME: Are all MSI parent domains capable?
> > > > +      */
> > > > +     if (domain->flags & (IRQ_DOMAIN_FLAG_MSI_DEVICE | IRQ_DOMAIN_=
FLAG_MSI_PARENT)) {
> > > > +             if (irq_domain_get_irq_data(domain, irq_base))
> > > > +                     domain->ops->free(domain, irq_base, nr_irqs);
> > > > +             return;
> > > > +     }
> > > > +
> > > >       for (i =3D 0; i < nr_irqs; i++) {
> > > >               if (irq_domain_get_irq_data(domain, irq_base + i))
> > > >                       domain->ops->free(domain, irq_base + i, 1);
> > > > --- a/kernel/irq/msi.c
> > > > +++ b/kernel/irq/msi.c
> > > > @@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struc
> > > >
> > > >               ops->set_desc(&arg, desc);
> > > >
> > > > -             virq =3D __irq_domain_alloc_irqs(domain, -1, desc->nv=
ec_used,
> > > > +             /* Make sure a MULTI-MSI allocation is power of two *=
/
> > > > +             unsigned int nvec_aligned =3D roundup_pow_of_two(desc=
->nvec_used);
> > > > +
> > > > +             virq =3D __irq_domain_alloc_irqs(domain, -1, nvec_ali=
gned,
> > > >                                              dev_to_node(dev), &arg=
, false,
> > > >                                              desc->affinity);
> > > >               if (virq < 0)
> > > >                       return msi_handle_pci_fail(domain, desc, allo=
cated);
> > > >
> > > > -             for (i =3D 0; i < desc->nvec_used; i++) {
> > > > +             for (i =3D 0; i < nvec_aligned; i++) {
> > > >                       irq_set_msi_desc_off(virq, i, desc);
> > > >                       irq_debugfs_copy_devname(virq + i, dev);
> > > >                       ret =3D msi_init_virq(domain, virq + i, vflag=
s);
> > > >                       if (ret)
> > > >                               return ret;
> > > >               }
> > > > +
> > > >               if (info->flags & MSI_FLAG_DEV_SYSFS) {
> > > > +                     /*
> > > > +                      * This only exposes desc->nvec_used and igno=
res the
> > > > +                      * overallocated MULTI-MSI ones.
> > > > +                      */
> > > >                       ret =3D msi_sysfs_populate_desc(dev, desc);
> > > >                       if (ret)
> > > >                               return ret;
> > > > @@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struc
> > > >                       continue;
> > > >
> > > >               /* Make sure all interrupts are deactivated */
> > > > -             for (i =3D 0; i < desc->nvec_used; i++) {
> > > > +             unsigned int nvec_aligned =3D roundup_pow_of_two(desc=
->nvec_used);
> > > > +
> > > > +             for (i =3D 0; i < nvec_aligned; i++) {
> > > >                       irqd =3D irq_domain_get_irq_data(domain, desc=
->irq + i);
> > > >                       if (irqd && irqd_is_activated(irqd))
> > > >                               irq_domain_deactivate_irq(irqd);
> > > >               }
> > > >
> > > > -             irq_domain_free_irqs(desc->irq, desc->nvec_used);
> > > > +             irq_domain_free_irqs(desc->irq, nvec_aligned);
> > > >               if (info->flags & MSI_FLAG_DEV_SYSFS)
> > > >                       msi_sysfs_remove_desc(dev, desc);
> > > >               desc->irq =3D 0;
