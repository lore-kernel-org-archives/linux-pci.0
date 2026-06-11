Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E830E0DC
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218512; cv=fail; b=IJe4iL7++x59UAuc9MV7N6y/x4D18pKZhi+W5L7JD+tFZAA8+FRekSa0ZW0LXGSercZdnoIfk4DosC0sw/dAAy7tZUid1zcqLdaEUpRpPW4ONyTdjCbS8hiEjuxVDVdu2c6UedcviHEtg1P5Jm5CkNYuBDyDGQpb/zHDs52G9Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218512; c=relaxed/simple;
	bh=TIHi+z0G+5507IUn8zV5xzVcf+lqGAUQi74HLRRwRWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q62Hr54b7XYAk9yP93r0etRELDKPb4H7VmintULBz6Gl5gBSTJyVjO9fdr4Kb/0fzBG7nXk8HdDv06z5zeRgHJnGgIVXMAfBlHZBWRZXEqJ9nnrQ1KDlcMjhwvHSPpYwb5HMun9BVBfAtwo27FKOUuKaDHeZN+BWNlgX8QmNgFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GSoH5Slu; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GSoH5Slu"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BEawnf1447396
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PstN10mGGH+L0A0CuZvfxdqRssEKVpUiOodgdSJiiVo=; b=GSoH5SluoitA
	ZhbhWOwNzZW0wVQslaRzOinRNj0iQBrT8vlZdPN2pSQ81NJhJsM6lrkRBfl65wwB
	Y6XI9NxpND7U3QFlGs/3h9zNcYs5uhOwY47aIU5+EFwN8tL0uJjB3xT4Nc2flLB8
	OuoRY9cJNAxqPnad+ocTYUbkKCVC8IBCfC3SpUi1FJ+WZQob1ge1Jpp9UqjUFdWz
	K1c+zwzcafG7syWDN66Fj9WqXwz7FP2S9x2PYeJbkQE2VqOZpCCSJ1Pi0LPZggjM
	b2aFPVkM2zchaidEebRvMGWAVwnPUS0gkiIJhE8DgZHNoygYJJTbBZkcw54dlUux
	W3AMfKkv+w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78hbdt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:55:05 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6d78299e9so859997a34.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 15:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218505; cv=none;
        d=google.com; s=arc-20240605;
        b=aWepxEldBNvfjxFPhr8K4l4NlguG8cy2OHEauHfxiClRxSQk/BdjLysQu19JloB1w+
         fYdzeNeCc+WrLQGwXVly4pKzelbyqQVM7O+1VbqdubOvkJs/4CW0xvqNbZwBTsqVM4rC
         FqKA/uP2i91BnOVB7Jl+vSydAnw8RZ9+ncb4GBmbRXB4LNfEL5tPimJ0Cyq59dyCXoPo
         0e5AbZqDlArrijOfOJrPf3eqyKHLGuIU7U6BTNg4DQsKPnMg5pKnnJgIe19onEcbCIji
         ru5INZtK5+CUyHr4YRqICiUoOoZaaQ0/5BYQRfWfXZNF/to+PXODqFvoxp11M19jzxiY
         Cxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=YYy1fCwoPtiMDCF76edFD+6WvAo/7l1hbbUr+kdv9e0=;
        fh=UtdQbMPbxID1Hq7Kl7kjS9wNXUqBTpBciDeswT831jA=;
        b=VGDd4jyOn55zOmHLQ7TZ0AIv/x9c6WqxgLIqT22IMSQKlofQZ2pyIxWJyy63645V8N
         Uv2xY1B8fBCfA3oUqveOusTDZdcDpB3txCX/1RjKfsb/0cruAyiKdXNDEBJvvzbXo8JF
         DeuwF+qc9D1AMk5uNA4PoMmi7Pv0hZV8dlrVXO9hE9W7u8xRyNom0tN2msNhq+XYvmaj
         OZPZKpGT2GRbAPVItuskGs6QJL+j0CuulP0a/kC2bfv6bmyrvB6T7Dt8XN5qzA4jOkzF
         tb+RkBH8of3wHrsI8GGHqqOosTHGMAN1x38L3GHMpWmcN15rCB5Zg/EK9Vjat7ULmKIV
         0GTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218505; x=1781823305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYy1fCwoPtiMDCF76edFD+6WvAo/7l1hbbUr+kdv9e0=;
        b=XinoiIWYwwCABZz9XasMpYNiefIEMCgQzF4DONzU6+yQpy07tZWF7jhZOp2sFHXv/C
         4dybuLPlOA+fYYS1y3/JkQl2IAyetKZ/4VAGQaCQgYHwC/S6WPR9yQPg5vTzX7vGosSB
         bQcVhh+b0aUpjzH+h0xSGRFWYu5xicHirqEqHAPSd4HDdLE79hIEToD7zi6MEy2yeGtf
         AUocwKDqScbHsKXFY2o53fiqgGJUrh7OMyWt+AMFP64qEfUS8DPpkeIu/Fh8U9yOv6VZ
         8jwHFVUe5hvI1uxKOjqESLye/PsTy4XUgOiyJS5kk/IFxnqYED5kj9XFozWOlJw/UIXj
         WwwA==
X-Forwarded-Encrypted: i=1; AFNElJ85ShOFPO6nsLCKtJ1TACIl31IMNGMm9+QuarqMlq68rRZq6JQ+9k3Xzb1i3gY0oDKddKda1Zcy57k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ar5bXNqkKJdhy3lx3h/eTVJY+ojX3sob2Rq/6l18FnXr9doR
	PHT1niYsCPepLC/ZQql/ff7C+xs+YJICy7UdYE/ahROqK9VuPDW6u6nJY1r1+18nsLW91WK9shX
	OxFDYRb6hl+W58wqDNmGQs5olbLGN5B3XvZuDoG5raEhvq6OKS+Omc6tFIuGHFRM72EWGvnagJD
	QGfL9B1qyjMMkSt3gH1g+t1Z7TyQuIf+J6taM=
X-Gm-Gg: Acq92OGg15Lp7/GgPDCv8v0QhcH+zCRDn3CVw/Dpvc6g5mEMlK6+KCU9QNYiEUMECsw
	bFSitDNB/F+As7pnPYAAyZLIRfZ2Im1+cWq57dDMy8Q7lusmy1iYs+t1cPm0Lo+vK509H09fn5N
	aQO4bpKwJNJU6ycJDskFpw3Ie92daB1X+GPbVoK7z15moNFBwrTnxjisUvq2p6xPZ0ec24I67YU
	QeDP1uWtDWuA6CfJCULMQ==
X-Received: by 2002:a05:6830:3e01:b0:7e6:f9e4:539b with SMTP id 46e09a7af769-7e7846e89d4mr84838a34.9.1781218505372;
        Thu, 11 Jun 2026 15:55:05 -0700 (PDT)
X-Received: by 2002:a05:6830:3e01:b0:7e6:f9e4:539b with SMTP id
 46e09a7af769-7e7846e89d4mr84824a34.9.1781218504891; Thu, 11 Jun 2026 15:55:04
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-2-zhipingz@meta.com> <20260611202559.80EF21F000E9@smtp.kernel.org>
In-Reply-To: <20260611202559.80EF21F000E9@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:54:54 -0700
X-Gm-Features: AVVi8Cec0xPin_3Tu2bkuOl2uwNE0xNjryiPQU2XmmSIcyBQ5hzh3oLNXw3MBdo
Message-ID: <CAH3zFs1U92oXZse+8h5rKNrfWmtqt3SeCRJa8D9O8R02chnwTA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: MXEN5kYmscn6PydpGMXrTKGFPvOGTRDA
X-Proofpoint-GUID: MXEN5kYmscn6PydpGMXrTKGFPvOGTRDA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfX5nbZYbwMgafm
 O+um/n9M1CCysE3Eh3vAnROTICI+CX+peUiRkLOpzYof/aU5XMomop1ew91nQXsKrd5vulCMBE9
 oMvDgx6wbmCrBDbLQUc9O6VuDybHbFoG+53gh1I5VEEzswnBP0Qa5nTwJbsAQAtJvvU+d2R+Ufw
 mmaaAcIZ3w2ytRsFKtIDGzn+ACmcgQ/RdvVAI+k6Hx8vi/4gHlyPYsunMw6V8zqyIWUkQtXVV8a
 b6dCWs7+3TDfa9GbkcKtvF/xLBGOuTmP0XRWnbTEzpQEKbsWXfz3CwGiFGcdm9o2w6g46kdWQwT
 a7vNMb1uJ9foWOihBmf07NAZ2JQl6cOCK+UovfFebv+biq/0n4Cbg5IlNtiMvRZ2LU2i3OaJCAj
 feZ78pMemW9Bq7nGx/cnnogq3TVK9S4eFVK3bR3MMkWUrmsDmYjcxHrPVj9HGBbF2fVXol8c641
 VAwVcQzfqHuUFFP1yIg==
X-Authority-Analysis: v=2.4 cv=L98theT8 c=1 sm=1 tr=0 ts=6a2b3cca cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=37eGqx-N3tBcJSbcPa0A:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMCBTYWx0ZWRfX78BQ5K6hKxS3
 NwlV0GhZaBsuslH9xnYqlRYw/o1kkJ5maC9n/lJ4141+nQ2Pvh49cKxEjsPxsDm/rpDF0thFOi1
 sFTQd2lJFvi3YZXfoKhvu0IzDhjfIug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On Thu, Jun 11, 2026 at 1:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Out-of-bounds read in UVERBS_METHOD_DMAH_ALLOC handler due t=
o missing bounds check on user-supplied cpu_id.
> --
>
> commit efb72743b37fe4c5005fca2d75b36ef50832bc6c
> Author: Zhiping Zhang <zhipingz@meta.com>
>
> net/mlx5: free mlx5_st_idx_data on final dealloc
>
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
>
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
>
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers=
/net/ethernet/mellanox/mlx5/core/lib/st.c
> > index 997be91f0a135..7cedc348790db 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev=
, u16 st_index)
> >
> >       if (refcount_dec_and_test(&idx_data->usecount)) {
> >               xa_erase(&st->idx_xa, st_index);
> > +             kfree(idx_data);
> >               /* We leave PCI config space as was before, no mkey will =
refer to it */
> >       }
> >
>
> [Severity: Critical]
> This is a pre-existing issue, but does
> UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC) in
> drivers/infiniband/core/uverbs_std_types_dmah.c lack bounds checking on t=
he
> untrusted user-supplied dmah->cpu_id?
>
> drivers/infiniband/core/uverbs_std_types_dmah.c:UVERBS_HANDLER(UVERBS_MET=
HOD_DMAH_ALLOC)() {
>     ...
>                 ret =3D uverbs_copy_from(&dmah->cpu_id, attrs,
>                                        UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
>                 if (ret)
>                         goto err;
>
>                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
>                         ret =3D -EPERM;
>                         goto err;
>                 }
>     ...
> }
>
> The dmah->cpu_id is copied directly from an untrusted uverbs attribute
> without value validation.
>
> Since cpumask_check only emits a warning if the CPU ID is out of bounds a=
nd
> does not cap the value, could test_bit compute a bit offset far outside t=
he
> bounds of current->cpus_ptr?
>
> Can an attacker exploit this to read unmapped kernel memory (causing a ke=
rnel
> panic) or infer the contents of kernel memory by observing whether the
> syscall succeeds or fails with -EPERM?
>
> --
> Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.dev/=
*/patchset/20260610193158.2614209-1-zhipingz@meta.com?part=3D1__;Iw!!Bt8RZU=
m9aw!-yx89CgOVvF9E6-bX3TWkgI1oBHKqqBP1C88LmgmavxlZKHEFJdEeW7gwHdiVC2U2gzS3R=
GnvW_CiJNQVwxS$

Not relevant to my patch series.

Zhiping
