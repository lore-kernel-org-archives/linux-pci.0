Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A3C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CCE21852
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chrXU9y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeLRPmt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:42:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36822 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeLRPmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 10:42:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so14270476edb.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Dec 2018 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KDvi0/RUOb0BP+RUB+LVIWVxkk+9t2zTiIYl0P1QLkY=;
        b=chrXU9y4w991lCWIJLtRXK8D3aKRyg18G73vPW+yEyjfZmbxNvGv/aaP+eTxw6HMvU
         agLHcixJGG+rcYd1n4qLBuj5OjPTqwY8unC9zNXfFDpdUdoZirLZ+oHq0TmS5YBcnfnZ
         zrc6vTrqc1aUkF8fr29NysxCkS9JwiwSIzOZDpWVGrxle6LQjToC/fncK4CB1E8c1oYM
         viFBZA7z7MomQHtjYouV3mwE8dnFSjNyis+PKnt9GOmzkouwwsViKxtqT1OV532bS0vB
         hzZSMfeE2JOswSX9yQI90UKfA+uUODMcQqJolneH/enBeqMa2vDHFiYGVSXGiIUlWi/1
         n9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KDvi0/RUOb0BP+RUB+LVIWVxkk+9t2zTiIYl0P1QLkY=;
        b=Uvju8EtK+Yc6tgYKVGFFT17cFWF22kq8ZG1EfmkMQDn7CUNGsKTBMUW8LZHeoiKBtD
         Mud7HRzQvGHlHtUyJ+2CiLSFbDrAqGiP5MvoRUCrKr5NtckJOG1DGBFBDgiW1EDFScno
         YE4gXgTfBa4FZnWWHBpGZszXFAjrDDQRZ7uSK4HZD6p8h3feoxhSfP1663SHuUC8vaY2
         aH8zWU4TrX8ktnPyXYtZ5YRMHq/f0vbmCHTjjkyUSeyRtEjL1zborZeOGHS4feRSltIl
         F0xuttACFeUrOguJciMfxFFqgEhgjH8LDNjttwrAqkhfga8emKYnVlH9AfxRLn+oUXr3
         g3Lw==
X-Gm-Message-State: AA+aEWb2NVp1jEAtEF8g0dpixcB9a8UqJOf+qFaTJcueGmEicAq4XcWL
        nwMlXYwhj/+S7tC/xImlI+MomIZjfy8OV7xdmEFmmshE
X-Google-Smtp-Source: AFSGD/WffVNwui4eWXKs7KWzm/72uYvMWMf81Y2a68lk81NMbgfrRF67nskqt66UPs6z/7S/YYJF300HwICTr9FWAtU=
X-Received: by 2002:a50:c182:: with SMTP id m2mr16872418edf.139.1545147765870;
 Tue, 18 Dec 2018 07:42:45 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
 <20181218144702.752d97cd@windsurf> <20181218153404.45b038cf@windsurf>
In-Reply-To: <20181218153404.45b038cf@windsurf>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Tue, 18 Dec 2018 15:42:34 +0000
Message-ID: <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated bridge
 config space
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

Thanks a lot for your quick reply and patch, but unfortunately the
problem remains the same with the patch applied.

How can I help to further pin down the issue?

Regards,
Lu=C3=ADs

---
Lu=C3=ADs Mendes, Researcher, Instituto Superior T=C3=A9cnico
Hardware and Software engineer
http://tecnico.ulisboa.pt/

On Tue, Dec 18, 2018 at 2:34 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Hello Luis,
>
> On Tue, 18 Dec 2018 14:47:02 +0100, Thomas Petazzoni wrote:
>
> > Thanks for the bug report! I have an idea of what could be causing
> > this, I've cooked a patch, I'm doing a build test. I of course won't be
> > able to test it as I don't have amdgpu hardware, but I'll share the
> > patch with you for testing.
>
> Could you try the below patch:
>
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/=
pci-mvebu.c
> index fa0fc46edb0c..62468415e063 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -469,6 +469,23 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_brid=
ge_emul *bridge,
>         return PCI_BRIDGE_EMUL_HANDLED;
>  }
>
> +static pci_bridge_emul_read_status_t
> +mvebu_pci_bridge_emul_base_conf_read(struct pci_bridge_emul *bridge,
> +                                    int reg, u32 *value)
> +{
> +       switch(reg) {
> +       case PCI_ROM_ADDRESS1:
> +               /* We don't support the PCI ROM mechanism */
> +               *value =3D 0;
> +               break;
> +
> +       default:
> +               return PCI_BRIDGE_EMUL_NOT_HANDLED;
> +       }
> +
> +       return PCI_BRIDGE_EMUL_HANDLED;
> +}
> +
>  static void
>  mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
>                                       int reg, u32 old, u32 new, u32 mask=
)
> @@ -555,6 +572,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_brid=
ge_emul *bridge,
>  }
>
>  struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops =3D {
> +       .read_base =3D mvebu_pci_bridge_emul_base_conf_read,
>         .write_base =3D mvebu_pci_bridge_emul_base_conf_write,
>         .read_pcie =3D mvebu_pci_bridge_emul_pcie_conf_read,
>         .write_pcie =3D mvebu_pci_bridge_emul_pcie_conf_write,
>
> If that fixes the problem for you, I'll send it as a proper patch with
> a commit log that explains the issue.
>
> Thanks,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
