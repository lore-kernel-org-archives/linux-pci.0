Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3443E4507
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048355; cv=fail; b=Al5l3/fEhJSAYKcYwBVBkUgmMx2h1HXFD84Kfx4pFJnKAw9ltskaXNKyAs69a69/MwAmTadhChvdG6qjyuWEJMWQO9Ww7ZlsnLXttf2Ft0x/TsdvzvGFWNyfdppL4Ecv/UZOfxuEYG24lDX3RlAS3H9IaQhQpfe4jOBvunyMIDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048355; c=relaxed/simple;
	bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBm+uW5dyA9qXPMmkGspoADXcj7YMeUdN90Mr/LOhSQAFeyVrQOESM6Zcl4dCwt/FJpjnH8SJPyKvDkARBOTbzOZG7btn0hj74/BdL3amZt4zi23xLcijL7xGj4Cw7oj4mknpdv4asywEDrdWwZgDmcMBfcm+KTIAgN7deZNRNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GcJ+PaQl; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GcJ+PaQl"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659HkdJ13131435
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 16:39:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GJd2gJZmlAgFMCFkHrHwJ2yIaE6MPUQzzzENfnpUb+A=; b=GcJ+PaQlVJQW
	/QiaOOTC0nYPA6Pp1uWg5Nw0lxfOPK46wy3QRjqt6HHI/s8hYflLqOpkQeAGxxLh
	hoyKhwGK2JX4YooWC50qu5EDWSMax2nyL/oD/rrE9huRAKUD3dcFOCQPD6EbqIBe
	/w0OyjcqD5OfnfePJGKHwyaQUFmf3+Tzo3fYXQ5XrBU7OcozGO9AnrRjAwvSdxcY
	Crl7znQ4/d1k0Z7Rho184bTWuJJxHxuMZzLmmMtWby4mzLYkfL9hkRHA6cnRmNak
	77cxz9A7UldkmH6wLB52VlDZREdWuq79DRuezb/llSLMmzA0JKqEm6HamQd79ptg
	ldQYgc2yiw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epqhcj9nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6f01486a0so11913587a34.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048352; cv=none;
        d=google.com; s=arc-20240605;
        b=Gh0jjrjhmzemaeahXGCJrDJzcpOl5OD0as83odfepedpn4qUFt+/cw1hpodPQEpn1n
         wUcdLxUUrgAcBeQd0Pl7gj8tw9v9jE2nz0vWfkYCsmK4RhHeXBInaYmeeH3ukAN5XmZ+
         Rvpso9iELkozXvRynpD6p59A1/z9IDL+RXUM83Za7xE0wQ51y0cbQjw3DdR05tvzZy5+
         mQUk9VRE8hb26bQVC/zMHkeG0s0n5HLrcHWo6mKd7a7rfPw9Na3VWJFkboyKLOui8Df7
         xUKpjqtE7t5MI1iYZMcX/G1vopEmHEprfdQbk2GrcEsZ037ubYOCEEywcFIqYrmrjsON
         TX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        fh=DhPXi8QdSvSN56Bx1ncuQS1Aelm2Dk3cJOHjB2o8S78=;
        b=KVP/mubGnUhNvaf12mgjwT4eISjZLKZY8KbJc1nn9aLLiBNsjlYEzITFYy0qViZSG/
         ggz+E7b9B7VxvFVmucoL5h6obUpz27Ik0g5iRmllMPnxGUKBXD7daZiQLu9kBRAySJrB
         1j4ca+ZfNwVA56+NALI6pylx952iwMvCCLIMUkMaUkL+Mr9WlA2t9L2o6EzA6sKZcAx7
         M741WRaPklw43c48Jg4scFfsVr5YwwktgOnMLbIfWXLvP6AAwyUp6kj4X5O3g1ly4jrN
         B7+UwSboSS5oDBVZrNgcVqsAMiKRfbSJcyeaQqbzPD9NLgENT1vYArV34cwws5Y0yEU0
         E4DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048352; x=1781653152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHRS+sWMPwoxZ0n+tLXpfsQUcezlTBJw4Sj0yHIKfGE=;
        b=dmWSFlALYC54imvHmUf+D6k+fP+GlsQ6PAx4Sy1R6OqCOuQXGbIn/mPcjZXIYW2o/t
         Ia2PyJ2uKUxqyt1VKXlpzivdy3PK4VfGOM0Ow10ra1lXArBZx9GniVEzre+KRVey/jCV
         FOpEvaRQaE9rH8F60hIPUcSC9wPV9Wkt1ofEjxdAiyvkQsLBejsLSaLOf4qSYK8mWLF0
         0LXDDSioVaBSSYMIdhg7XhUtxgEdfJEt6eRQKiNhG5yDtOvz2IA5CqxDO4gMBpeJh+l8
         LxzF8ABhH/9xGSeelR8kGOo/m1FKiWf9XkqSthAu6AiNjBHCgKqS//YpAc8aP6XkmY6t
         GkFA==
X-Forwarded-Encrypted: i=1; AFNElJ8VF8XzsU+wflf2AxIOA6wnCmWSdU/C6XW9oyYeva9xU4QA7HETwqhtpdqfBoiSe6/TWs/yUV5GiuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2z2Q1wYIDPqnFgGrPwRfr38vJFxBVc9p80RecZbQtMXpaa2WG
	Yd96o3o1OxIL4r7IdkKEG2eV+ti+dWVgai4JioivvEZzXEvf2S+w43morvdHDqDJV70vhhRZJhq
	wk3RDnt0dPnvGG2f7ujnJlZc5yL0DAR+S3XjxCTB99wdAAWCyB1mT1rgIcBIU0yp56utw9lzVJl
	ac4BRkitX5mrAZLYTE0qYIEyddpW+hmvI6KakZ4fJGplM=
X-Gm-Gg: Acq92OE9CQfAIK50D5HFhOv4q1Ng051lGSnXt0t4pRX15lsvFRC1SSsg/O0WnZ0Quvm
	bh5JEG7k08exGxi2jYUq9+swM5Lvec5TNPVLmtJ9JwIyLN2srPRCg7GGYIVBA4Ku0olSmc5RPWX
	mYXw+KMamrSe5Kh3YGCjawIG/STIaMS6g8edfKum4DBZ8UjcbegFjNrVQK0pksaOOmrAeQGvUuW
	mQdCb4Z6xdBeMTDFpDdbM1W4frhyw==
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id 46e09a7af769-7e751abe2fdmr3883344a34.19.1781048352072;
        Tue, 09 Jun 2026 16:39:12 -0700 (PDT)
X-Received: by 2002:a05:6830:6108:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e751abe2fdmr3883310a34.19.1781048351521; Tue, 09 Jun 2026
 16:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-3-zhipingz@meta.com> <20260609195612.GA85322@bhelgaas>
In-Reply-To: <20260609195612.GA85322@bhelgaas>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:38:59 -0700
X-Gm-Features: AVVi8CfvpQJ6ajVUxnazmY-1cK1d-x3MxGzuw2_lfYAMYCTtvbg2jMZaGu0O5NM
Message-ID: <CAH3zFs0u7qJ9JsfweOw_r0FqNUpixLvawZKp9pUTcWWQN6nZjw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 5CwKGA2VAzPRV_fvjpBjqTbg-ZUkZ6Ef
X-Authority-Analysis: v=2.4 cv=L4ctheT8 c=1 sm=1 tr=0 ts=6a28a420 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=earV_t7fcAfV2sAEFq0A:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfX3jbGi+0HFrKm
 51UxgLHXnWjwkB7+8x9EWavvzKtWPtVDuuY9TSzqMRphaIiJ9+oskcadWIMI3HTQAgRdiuPROek
 Ewk9AEELY0i3Gc80LNoeeOTc7X1NyQik6yVZu5ah0ztij6fJvbXHeLWi3EI2KZBg+vQJs7m8JPq
 slCtqrk7ht3fjLNc5YzjKxqWePXNLGbqqWMyNDNeZhV7jU1yKg8YRPBewTGmnmUACboelge1n4O
 Kv+fk+oCMIsPE5ecDDG2UiMU3cUN8oGN4e2YUaxInxHWxd4QZxjh3lncwbVJ1KTzHylgoQdRJw5
 I6nZMbZtrI+C9JDGAzQdVM7U0ceOcuOhCHBTdxpuM4Ttrw+OLya6emMvyHlfhRqx42TKSmQRIPN
 PbsGaRJju0CbYIWrxTiTK9GPEH1vTAlNoWvyGjcpb0C6FaHMPZJGOD0I8mh1G3cTLvwLC4F7g0o
 eM92lmuyMiAj0H98Maw==
X-Proofpoint-ORIG-GUID: 5CwKGA2VAzPRV_fvjpBjqTbg-ZUkZ6Ef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01

On Tue, Jun 9, 2026 at 12:56=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> >
> On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals, and
> > pcie_tph_supported() so they can test whether the device exposes the
> > PCIe TPH Extended Capability without doing the same.
>
> s/exposes/advertises/
>

ack, will fix in v7.

> > This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> > PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>
> Update subject line to match capitalization of history
> (use "git log --oneline drivers/pci/tph.c")
>
> s/expose/Add/ in subject.
>
> ("Expose" suggests that the interfaces already exist and we're just
> exporting them, but these interfaces didn't exist at all before.)
>

ack, thanks for pointing this out!

> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> With the above,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

Thanks,
Zhiping
