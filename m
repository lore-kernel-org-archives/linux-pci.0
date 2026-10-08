Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619083CB2D5
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487428; cv=pass; b=b2nwYcPFiUo90jjAI6as9XA7zFSfDtl3IAqQbWnalm3QKbTUhFaDoRzgo8IN8C6XimWhFuvcE6yQ+MlHMudaZQQp1gqXtzzUtv/wjcCFSzGkUC5dnOxspf7zWFWgH5N4JmfL6tsni0C8gaLdC8R1vsyNwsKTu7eOk0dWoY4YeWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487428; c=relaxed/simple;
	bh=KMMomwKvXX1s+5K48/TSR995Mfl2OYwJus46ARmF4Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUukfVIHRzApoTj8EDLEJnBHEBbyWSt+YgrQQymxiKdOWOb3vh6h+Egmz5iVaeVPpDrKqsyIyt8z/w9jAmx8OGjtqWtjzscYbOznRllcY9vNbs7HFR7Yqfw/lLGa7Fh3fYSwb0Z2xfSKnVI5bNcLzPJ95Svfsg3ujx+f9Maqj3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAXSp/fi; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAXSp/fi"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535dd9a601so23188eec.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 12:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487426; cv=none;
        d=google.com; s=arc-20260327;
        b=jJUiyQAku39McAu7sq9tA8Xw1omF7C1c4prNAPyGO1U/AbjatPTQWUfznspNntdNh1
         MTvU23ClkV5glykW2/xAVA1tT5GVUkB6MAKDaKEvXYU/Hpa6DLxDITczRE19ucT+VOzz
         mGlFdwH3RIJVThptpQnbptPdGjHuQ4KO7qA7/TXyf/oqxIOYxde03Jnv76PcMwGUDwPx
         L00EDRpNRNLI72kg6nfNNYKaNRzWAq3f/pXeAP7bQM4ZVKR7kr+R9wB2C88NOVLzXaqn
         fOJ4a/DLYqqj06mmX7glb9PVTB1oybGSgQsk3JZ0Vf02XWNkZj6PBUxyggsp22CUhh7S
         NZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
        fh=FJ06no5L6AWK6ncoeKRee23qPT6nsyIEM6YOHQvgIeE=;
        b=dMOwtVhAx9XyZJeR8LdtvWEvSWgenVWULhy5W/A35Dz5sTChY38zCsQznCQgwZ+UCj
         1k1gLIav4HKrv+eJnVpUycy+7/EyWDT1jS6BGHMRokvjb3BCTyehzjQ1z6x8LlkxpVb0
         dQX+PPMKpS803JjYtYMGdK/fLqS01gasW0SihC1ivyYimS9sjEVD/qCN3qsIS00u1D5+
         1MacuyH7NcPEyQgMI4iEnwWWtZvdf16nMnB0wpcyaUwpJT/UD9m86JbKWUTr13VC0ZTs
         ydcD8ievhlH2eMCL9h+jNxnn1iJksIoej76jPa1oDRck+UTmC8jThvcH+VrKx8MSS2QJ
         iMUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487426; x=1792092226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
        b=LAXSp/firnPkUmEWWUw69+aMMI25un2iEzRNxwulR8RXBZSv/6ZHLuXtnYfgWp2d72
         bGdoPTOICVG+388UJq+opPZ++NZ8jcNt4zKjuOjLb8NFtDsqBbCFMlcLB+DhNbSMgJLi
         Pigs1twEOFdnfblfpoKzSyo+ck0IsMlA5FWnj3O+XdXocIwebeDtXG26aAifH6y8g3BT
         XoKcSxRe4ZTFrtx18yH4ZWxcJVrzrMEMGRKjvH2YDR15vJaSTskvLZYBetA6VR67kz8Q
         aVcWrsanHptbIMwOZgtL0/TTMfY439cY3pda8akmVxHTqCgDGJWSU/WOY3oZb7TVeTx6
         55ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487426; x=1792092226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHO6i2IO1cdf5Kp1Y2GcYe9pGO81oa3PqBFRgoAXgiI=;
        b=YkQ6bJHbdrVEr0McP7+uy+bDhzXwVKbaWHsZESHzTPMb1Il8fQ+9fUcbq91cZqNRQC
         ju8+fx3fNGEKjAY9mtkvoUnN3IZ+urRGPb0LxCaC3gES9AFAwz+GdKionQul2bUxzYK2
         lA49yOq2B2eE0v4cKDPtwcgrgRat+/V3Is/mVywvtEtQCk2799peETmG+YIBXFxGGbmM
         h/dGnMcCZNiK8Sv2pMY4kvFfdctVcBZl9yq8cUT3a9GNJtLw7lfQkhUdcPHSdUa0HTdH
         Sl7VRttXFJCuPvylLNlfXinjlrUxNk+te5IasR02qST+dy5rYDtsnIXD+cFOOg4FfW35
         OpgA==
X-Forwarded-Encrypted: i=1; AKwUvBw3f2leUqH5bOldvTr9qb3TygqErFxoskxtOeDtfo2d06p3ddcBQtYVAb3YoeHhDaMClA1tNDxP5cA=@vger.kernel.org
X-Gm-Message-State: AFuF++mHmo9UP3Zns3onbqGl7oZwXdMwXmiIDD8KkIK2CBuwnI9o3yaF
	fXRNK85N/awHGw8sM02+/I7/q/8YOGA1uHKMNld4q+iJjM4ysw/uDphPY/xoZB+dQki+2OGbRzE
	1S3eKyHUyWL0BpqUDfKZEnEF0DLcUCW8=
X-Gm-Gg: AYBFou0KLTiRtLNLeWearbzw8MfmYgyS3gC/3+03Eqjezm6R2DAzBnwqeDMuoQeW8Pg
	jUoL48pDC+I84oqzJ8iZPyaSpD5w1Zj99RrxxkJf+yhPyTGXbDKM3MNagiOdTK60WFZLQRbiO/V
	8YgUsq39Re30mtO5lXSWlYvyxQLW/GC8m0p2SJVFZAhbDa/jNCuSJ3QgdYvtdu26jNDt+tf33kU
	+D4/qb/fBu2Nu38eTlnmRBXyqfq47s9CM8cfcSQfG64C2Mu7im6aGSnR5J0RhP5nAxJ4VlY1l7z
	gQ33Tt6MwkNLsXgS9k1wsRx24wZkFDQwl+w3yZyxp/rdLkolDUiYAZCw7zoi93z5pIF2yodxEre
	e3PgDWfTjxzLxbMSeq+Yhn3lf5T6uvD+44Ek/5HLrrg==
X-Received: by 2002:a05:701b:42d3:10b0:14c:f3ae:c1a1 with SMTP id
 a92af1059eb24-1657b80bf6emr6467363c88.0.1791487425985; Thu, 08 Oct 2026
 12:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
 <20261008191705.GA917105@bhelgaas>
In-Reply-To: <20261008191705.GA917105@bhelgaas>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 15:23:34 -0400
X-Gm-Features: AclHuK-jV3SbZUxMOMQXs-rSTId7Jf-E2wheC8RGkrqRF9AJfJ4NNMx1Hsaj4Lw
Message-ID: <CADnq5_P_y-6Ra4Swoxz-CmL1Q3nGhM3RVJUAB2iw1E1D-r1cjQ@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Jason Perlow <jperlow@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Thorsten]
>
> On Thu, Oct 08, 2026 at 02:26:00PM +0200, Lukas Wunner wrote:
> > Alex is seeing a probe failure of the amdgpu driver after the Root Port
> > above an AMD Navi10 GPU has been reset.  The reset was performed to
> > recover from a Firmware First reported Fatal Error.
> >
> > However all status registers in the Root Port's AER Extended Capability
> > are blank, so apparently the platform firmware raised a false alarm.
> >
> > The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Suppor=
t
> > Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> > Errors causes code paths to be exercised in platform firmware which
> > were never validated before.
> >
> > Skip error recovery on false alarms, i.e. if no unmasked errors were
> > actually signaled.
> >
> > Note that this will also skip recovery if both the Status and Mask
> > registers are "all ones", as would be the case for inaccessible devices=
.
> > However that seems justified because it would imply either a hot-unplug
> > event or a Surprise Down Error further up in the hierarchy.  Interferin=
g
> > with recovery from that seems uncalled for.
> >
> > Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> > Reported-by: Alex Deucher <alexander.deucher@amd.com>
> > Tested-by: Alex Deucher <alexander.deucher@amd.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
>
> Applied to pci/for-linus for v7.3, thanks!  I dropped Alex's Tested-by
> since he hasn't tested this change by itself.

FWIW, I just tested this patch by itself and it works as expected.
Feel free to add:
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,

Alex

>
> If we're confident that this also fixes the MacBookPro16,1 power-off
> issue reported by Jason (it would be ideal if you could test this,
> Jason), maybe it's ok to keep eddba19b8b5f plus this patch for v7.3.
> If so, I'd like to add Jason's Reported-by and link.
>
> But if we're not sure whether this fixes the MacBookPro16,1 power-off
> issue, I think we'll have to revert eddba19b8b5f for v7.3, then squash
> it with this fix and try again for v7.4.
>
> As far as I'm aware, the reports are:
>
>   https://lore.kernel.org/all/CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW5=
3m_ThtUQ@mail.gmail.com/
>     Alex's report for AMD Navi10 and Vega20
>
>   https://lore.kernel.org/all/CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R=
7rME35_Q@mail.gmail.com
>     Jason's report of power-off issue on MacBookPro16,1
>
> > ---
> >  When applied to pci/for-linus, this will cause a conflict during the
> >  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
> >  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
> >
> >  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
> >  and move the pci_dev_put() out of the if-clause (so that it gets
> >  called if pdev !=3D NULL but err =3D=3D 0).
> >
> >  If this is all too complicated and/or late, I can respin on top of
> >  pci/aer or v7.4-rc1.
> >
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index d8dcd238fda1..922a726a52a5 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer=
_recover_entry,
> >
> >  static void aer_recover_work_func(struct work_struct *work)
> >  {
> > +     struct aer_capability_regs *regs;
> >       struct aer_recover_entry entry;
> >       struct pci_dev *pdev;
> > +     u32 err;
> >
> >       while (kfifo_get(&aer_recover_ring, &entry)) {
> >               pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.=
bus,
> > @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_st=
ruct *work)
> >               }
> >               pci_print_aer(pdev, entry.severity, entry.regs);
> >
> > +             regs =3D entry.regs;
> > +             if (entry.severity =3D=3D AER_CORRECTABLE)
> > +                     err =3D regs->cor_status & ~regs->cor_mask;
> > +             else
> > +                     err =3D regs->uncor_status & ~regs->uncor_mask;
> > +
> >               /*
> >                * Memory for aer_capability_regs(entry.regs) is being
> >                * allocated from the ghes_estatus_pool to protect it fro=
m
> > @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_s=
truct *work)
> >               ghes_estatus_pool_region_free((unsigned long)entry.regs,
> >                                           sizeof(struct aer_capability_=
regs));
> >
> > -             if (entry.severity =3D=3D AER_NONFATAL)
> > -                     pcie_do_recovery(pdev, pci_channel_io_normal,
> > -                                      aer_root_reset);
> > -             else if (entry.severity =3D=3D AER_FATAL)
> > -                     pcie_do_recovery(pdev, pci_channel_io_frozen,
> > -                                      aer_root_reset);
> > +             if (err) {
> > +                     if (entry.severity =3D=3D AER_NONFATAL)
> > +                             pcie_do_recovery(pdev, pci_channel_io_nor=
mal,
> > +                                              aer_root_reset);
> > +                     else if (entry.severity =3D=3D AER_FATAL)
> > +                             pcie_do_recovery(pdev, pci_channel_io_fro=
zen,
> > +                                              aer_root_reset);
> > +             }
> >               pci_dev_put(pdev);
> >       }
> >  }
> > --
> > 2.53.0
> >
