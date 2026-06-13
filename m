Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7E17A2EA
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389386; cv=fail; b=ixsJLNaO/s8XiAr62TiOAOhjvMBalymiaTUwbt9RQVlNC/dSAYW297uvRZWGiIkDnPj0XOVYaEZ3VS6h/b8H5FpJdc5knsN5XQn8GnR+Rd6/5l3VX5eG5be2XvTtRHg9YGjFMwTQ2zL6bWg6tTLOa1zpLotOu0/tQF3qHKArXxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389386; c=relaxed/simple;
	bh=7+UCwdV1ne49cq4fcMibRTQe+zHj7j8TUy7YJPYz0Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQXzmB2+VlTSh8V3y78nj0vFQjk7S+jQO71we89WSf2bf+KtCZAb9BoRkFeLgNXF0dYt4PGGFUK1AC7OZhzmU2bm93NAADM2gPpMcbALa1hmUSnLxmmjGCC1ehQfLmuuV6ReJpHeoXMcv8bHBrAc20FSEfpHo6uCF+/pVRRjnQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RXC4frVr; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RXC4frVr"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DJMIpn1499461
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jwd8bTapbEIKBMHRp+HoohnDcRxDUqI6nQwnmy5apkc=; b=RXC4frVrigul
	2+TPl69gny41YkeXpqOqbJD8TTbXSg8TLF3Mqa8gIyDAaPL1Ca9do2i2HlOHn+65
	CoxCrdgf9qWE8+7MbwigjUdDtdmp1AfYUyFCWoWend8LDbrYFB8tNlx+eS0wmY0e
	XBwyjB+KqTqOCrpMWoYa0NoDEtLtARehii4jUKwa9uklgqAWQAFaJ6LVMcE8YQM7
	alz+Qg7XmM00FAWye9ws7HX8pcHw0/UMPEsTvpByxH2Ie212YLkrrayKib69EdsZ
	UWVGo6QknIJteioPFD+o+4G2J5duEz4k2lDmocBu7Ml/04FaNl4K9dVPzKfy55Vh
	8w9vDSJ9BA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es4qb20m6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e757d8937aso3653856a34.2
        for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389381; cv=none;
        d=google.com; s=arc-20240605;
        b=docNbXrAclGFiQL6eTkf+plpiq8+PoQugSaiiv01Du+JCFP/Pp0WQyKurnPJrR0/6l
         PaKdl05QKozgwjZ0XO1RanrHJi3zQZOpbC1CiMYbZDOvUCo2CxvT8dwjZFE7gAka87ak
         VhFPVPomgEeLBmUgQ/iKoOlxWKGmvjdUu2PnhRQH+io0ezZmthL8nBlVSsfnMc0SHDTs
         UpTmOsSi1I+YOCWxXEVnu0ECrtH+IGk5u90VPDBss+Jgrf6KJ67DjOl+4GQWYaspAUDj
         XfFngQFRtCyxnuEj8vVBMzX9mzMdyUkYp2m+jARyQD/T0y3SMC2VxliFe+20FXG7aC9z
         0eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        fh=aNA8jkTZsuNDJY2eRQrCJdCFMphR77qnnwnCeUfnlxI=;
        b=FzYIq2HTfsWmafe6pSu+1/P0IOX7O3uaMaPRItWK1lz2mkq4WvuXQptJNT7RGyY9yN
         GATU5BjkDG/m8pvwIc62wlssr5u1ADVi1OO9ZXSsnoIjL4x5IgQE7JZfoEuePbgbUFsR
         qv1E7eOyokYk1uQ6T5qU47aQK3bDXZYVLncKRxx+8ADTSRtgcUbVqiQt98LkPE1S6wnd
         Twpf8xxi2e/qW1h836v3mtMaeKnrlzv5Ho9kh24yfg76G6aoIC9xJmtirtrD3K1GT5sA
         4ANiDS956RagIczHRTmfuTbkwBultl96d5AIMSthUv9RGrnGG6zL4SVT94KkYzxa+C8V
         5Dkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389381; x=1781994181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        b=BiCWEdhBG9Cp+I7ImubC8Nl/QMiI/FD0KqF8k5VPrGdMHjcvtoIKp+CKgD8jQDFBB3
         rAQrK9O9vYTI82GteYv5WsMwLfoccZLzooQjR53pVfyyH1umsQKSYmCpkKw/0WKNZsSn
         QY8meDQZjMCkixT/Wlj93oVDHA4HEw7y7nLYetMWPdXutOMLa3R8R50DkUwyaQZFu4wK
         apqQocym5+jNpY72pnvmC6gogKpF46zmDpBoAdIe3RZDQzw9hiCxXYpxw7dhVg6IzmLN
         ILsJG23zd1Ed7oZLJcRy1z+1hzn7N7SD90JTc8WbcxJlJfQcC2sD6xJupI2XNOvOOWqq
         opIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jtdmEO9ZnD7BknaTEp8A2zopxSYRrRTh08kDhkYapZQ8/kt/VyaA9SK6ZnUyQ6AlOlbkR4lmcLpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Jjy8hvvXel4SYlV+ff43nejOU1p4Za85NmGph3xbrs8rAfN3
	a5twhhj0JXq0kYZbGCIynRPzVcpPp5VUbDWVujyRp9dG2mYtEcKgLWX1eJp0A5HdkOWfam5M/0t
	S3LVBJmDySOl4Iag5GgfjpggTwdN05fsHZ1wrjCkGh66Cun4VcDnbnopBeJLOiKw18HFBQwEb0k
	r8kUwIJqxJL6GjJEnoGVI7Lt+EVIS68rhP5io=
X-Gm-Gg: Acq92OF5GQ08l6Z6/NhQ3nN8bkjNdNGmn0urK3P5J/oG5vOqctQUi6QVo1fK6EQmMAJ
	HMbMsTl/ejbeagAXJQ4wr+ekqsmFjzXqzqd4x6LWaJsGg+qEdbEBeOaIiRrXqe3s0ubx4uQiC0u
	8qAUvzLdD+dHIvAkrjPjXyfQG/7hclqubRPWB0osldq6ysYdYTjVI0+78BBcxiC1s7Xmt8a4hqa
	5RQbkmQmaN+KSRn0h1ZgA==
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id 46e09a7af769-7e7846b44b2mr6299914a34.8.1781389381592;
        Sat, 13 Jun 2026 15:23:01 -0700 (PDT)
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7e7846b44b2mr6299886a34.8.1781389381161; Sat, 13 Jun 2026
 15:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-3-zhipingz@meta.com>
 <20260612105248.7d8431f2@shazbot.org>
In-Reply-To: <20260612105248.7d8431f2@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:22:49 -0700
X-Gm-Features: AVVi8CfDNU1g_5HOJkneMc79yczUqiaSKei6CEAn7F8ZvFdakbFhyfrfCnrLCmw
Message-ID: <CAH3zFs0+zF2JQMpVZMM9ndh+07KE1ULQNOkKrLozWq+_kRdMyg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: MDOmUa4jF2Aq65UoSeGmXGO5fKMhZYMZ
X-Authority-Analysis: v=2.4 cv=RLOD2Yi+ c=1 sm=1 tr=0 ts=6a2dd846 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=JzgkHKIk_dV2mhMsj_sA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX00+I2kEb7p4u
 HR7MW7N8kf2P2iTNfOGthLx5wVeH9IawPjAB/yC/Ykj7vAItfWqV7nfhKJ8Ys8BM8XAxdhiTyxq
 dVOH/un63c19FTPXGofmCAbFSCaK+go=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX+zelwnEW+bz7
 eLc4NdSHswQeIxjZfkjl505doyEu79EiyKuseGjSC3RYzmwC4NKgZVdhCv+sSUgPJqiwNWTWKq8
 IqU4xVRnLgTuVZGhXYGSayohGtZ7bXGJYWwj8fskOHmOdFTzSIYDos26GLD2QQ0ydQhT3hr9Ax/
 k6NgEC+UPAVXfoPy43E0yscN/vFmLET0YvYE8wMe4Ac1JwgKN2TKuHKU2ch6uf8tG9tRvH9UAiR
 H8S28xQ9E78UW7/iw4Kpn8xr1SPhFhRTq80ZIOFW8v6xEl+hbd5ELHan3Ms5/a571p28KaSZOxm
 tAv8ZrmIm2VFbEqbHftw4jgSUUCDpP4joLLr18nUiGpRo17OMkbUaqf+vaNjyKJemy/MECRgmFJ
 eP+hFXk5ase+gB/356FnBzF/v+B+mttOlFg3jiU6Cmn6yRqziNfWcyMYtH7Ld9nR5g4vqAnDXjO
 9qRAr7gC54IEA9Murhg==
X-Proofpoint-ORIG-GUID: MDOmUa4jF2Aq65UoSeGmXGO5fKMhZYMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01

On Fri, Jun 12, 2026 at 9:53=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:17 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> > a device acting as a completer can gate on the "TPH Completer
> > Supported" field of Device Capabilities 2 (bits 13:12,
> > PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> > state. Fold the reserved 0b10 encoding into NONE so callers only see
> > the defined values.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> > callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> This is carrying forward an ack for v6, where half the interface here
> was dropped and changed shape.  Thanks,
>
> Alex
>
Good catch, will drop in v8 and request from Bjorn on the new shape.
