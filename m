Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01313451B3
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009303; cv=fail; b=PQkl0UG0H1PVXqOw6qr4Kj4HUlmCeNGqUZtm+rYCo794kktridIoqZWo4mptislhA4xgt8p3yx5/xby0/uZNcLK/325XG7VGL1oR7iEe/GyUUnncAk8GbhrwbF3qXyV574PYiZajumAiFyTG+4thTYEoP8HQcz1HQ9zL0M8PgnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009303; c=relaxed/simple;
	bh=Q0GtZzioBAe1xOAjDbkhlrB1hPU4MmLixdCpyIV7MDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyQ9dKNV2nyH6iLp7RH8s97z5QLTCscK3l2/p+NjFsDy1uc5jTG/mkoH/uZghpOSJ/N7YS0af14phjtD14QdyNSpV5tUeLMfVJtpS2ElT2J4wE9H4T7c9jQa8StjMJKURFmKMVfTnQvCUMoTlFojgvAAJa32O1jwLEtmey0x2dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Lm/Az7wf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Lm/Az7wf"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63NH8hji1998000
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9DPAzRc9hNFtKml/U1KgfOpti+rrtUBR6KtYeiX3hBQ=; b=Lm/Az7wf7xyF
	brokmQfLsNW68y66IP7SZ8nGC1KsXbutmXjSA8cmHA2Jk5qKrwkv66B6NLirRkP7
	QPJwKH1umKEEjOC/XCpEBPz8VR5HvrCHOhrvpKJ8eh9uddFh+K22h5l6zVDTktN7
	jLt8ikr16+iDaTHEYZBdj9EwQNQuPWk9M1lNVPnUjA9qvJyXuvqeoXu9WoHbWI9B
	L0t0VhbSUUEr2S6i4dfX70Bl57EMc2glo6cixMdYzAixPwMAfd/ptjPwyZbZODg2
	Ev/aMiLmg2rES2HuztP8JKZyiegA5AN6JmiDik/5gngMEQiS5J4atlbQWviM1YCu
	HCwba9g+jQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by m0089730.ppops.net (PPS) with ESMTPS id 4dpepamkda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcc59fe0d8so5750050a34.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009300; cv=none;
        d=google.com; s=arc-20240605;
        b=CrjGOjonwHtMCizM8X/r+MhgFsZauHT9lDdGpuDyartedj+m/tGQZaO71OKLVcG/lj
         71djXX78DyTBt+HtGhH550CtO3s7buA+ZPt+h/Lrbpp8dnNNe4VOqGXFg8NSGElyqgEc
         1f6INJy0kCM0xbkJomvUdr4qthIpxWd21ZhBziLrvG3fC/2OYSfU1fDCQMiQKA9x2UkT
         180JwmwEy9+T5IMXMeR7aliRzfD1cUtqPHQDtW0d3Bv+PxELDY0lW7yfCYEHr4CUADw4
         zi+Yk4BpLrQrqyFqVU5WgXdGR27dWgdPPytByt7ypQly0MKjbfS/oJisG1aSKd6agVP5
         uUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
        fh=fkv7hYQsrGW8zkbKQ4auIjUHagKZU97ZQia7WgAZ9l4=;
        b=KWog2Bfcd0Fk7c+uRJ9+Jlo0o5SH3r9mutz/ov1YZa6yq+ItPQEl3SjdOps63TlvlK
         4gxPvP9/ng8gb0Tm4UXkKEl2k2nxs4IMSVZqrKJwxGhLKAKzeo1KCjM5tlHZP1T2c4yJ
         GlGqIHlTpKEVlz3AbgwWP1DpKSrlqIEUAFXkuk6JGju8vr9InePGzErr3r7h3jAwzqJl
         86esoN3t5S/O0kg1JD25fr2ViZcF+8VN63ClCCjcT4nS0vYyDmJgbVT8XbF2RJJPtf97
         mc+Tji2MCnTxi1n2yu/eeVJMLrdXOWp3JlD0EL+24SWRtftl3nhqLyTuoyLtN8WFlk1M
         fTBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009300; x=1777614100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
        b=JxmvQkys/my85xdCw7oUOEg70z8IwZlgp5f7wLjuOjIaNenGbyFQeOfWSioiWFqscE
         1TLx2RCqjI0r+IXFkK6HVYmeUgALNcPFfHxl2BwfX6OUafcye5eP/E/ykhkkzEXkI+vk
         yP7XxhyWcA/6/yCgGF3AEfPSSm7X6g0jLCkSTValxlD+izdcIY1dy8xlsGOdUv3sb9bM
         ANtZm4Y1ZsynHHLVlhPb8V7Dq5NVSTRxA8eYPGON1jyUan1QdOZuTxiDMU8o0NSt6Hmi
         hw/0RjwE6ESE7NCeDrY29hbJsXykiAHAsnW5A6XyHgseH2OEtrIwBTxFv47AvolF3DAz
         Po/A==
X-Forwarded-Encrypted: i=1; AFNElJ8v6XSaCseHhG/yNwpyGVXvFFhOxYW1gPuOPHRTdI4fte76Nfvw5Ep58xsPCvaTyr8WVkIV8IXAne8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqiHcNB1gMX97o8ZQbamYEPc3hJ9tzpel7/SfwJU++91d/IgXi
	kRJztPBvZ7DoWih/t6+mhqPQ+JYGc324FpGH0jPQ30sCwWgCuoBGtFrbuy5LDnMhVDiZSLCUY6O
	gsjEE2sbOXJUMMF8eC0FOCBRVky/18Ti2N1vMlcS4Yc5amEergXqPHiQZzjk9/sz7xP/AkCYwGE
	DuJYaDJ4y8wfQ6+b2X8DL3pkbk0PMuXQv8Mpw=
X-Gm-Gg: AeBDiesaptt7c0XSKTsIlzz01hDH99SJnsl4E8fGx3W763CgabWA6BXH+ZYUAiv/VrG
	/ZqhIqwENu1gspP58HJo3e3Pnwh0sPRY/T7/0nSpjch0PHmHjfrkJecTSOvTsT5/+HMdh1c68CJ
	mBevmBwgvHJWmyc5E7J/mYe65uucbxj3M1yfJBVwZO+Sk3R2HC+OGUfHj1Qup+ifwsgmn8QRsN9
	p4ufmo2XB2/eHUQCRrvCFxoG1pSo8VEM7Jew3+i6ZDjS4qHF+k=
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id 46e09a7af769-7dcdd585530mr8104217a34.18.1777009299914;
        Thu, 23 Apr 2026 22:41:39 -0700 (PDT)
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7dcdd585530mr8104199a34.18.1777009299430; Thu, 23 Apr 2026
 22:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com> <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org> <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org> <20260423224626.GV3611611@ziepe.ca>
In-Reply-To: <20260423224626.GV3611611@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 23 Apr 2026 22:41:28 -0700
X-Gm-Features: AQROBzB7q1PXr8uzLTg3LU7rQ4HbjUzfZl_SYDl7pi8tYSw_JSwSgZ8wHqWD6es
Message-ID: <CAH3zFs3z5WPBygyk+ZZcDhZitj3+e3=sDsyE5ZmL2iwa=Cxykw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
        Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: yj9PDlngPmeFrA3vTsxQob0mYB-44MWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA0OCBTYWx0ZWRfXwFzyCVf52WVS
 /bvPbViitPmI6LbvnQjk058wH0EGs6gAIsz7QbwcmqB6RhMXJMFDmuSQhk/qjjMG4X6nZUJEfKn
 o9xmTR9RReP675b55dMPJRweDPHIArtWYrJku593TONs+UxmsxpNPf+3UkNcNl/xUXf43AoQGKy
 Pj+uiT/Ml0HYHPPqDHE6znNyWKOpsrPE+vSTgr/dd+hwrvR+M5BtPHFhy9SbdFui0QREXFFjh+X
 C44Gb6ZR5TYs0CcF3qd7KkBXgttWPh00IVhkHkgY4jS+s4qyP2eSaGv8hdXL2BJS6pqTqtMhN8T
 kZKmyzq4T4UvBaFdZjKg6FPokl0MI/H8NyrF5dpsp+/n0AYykdz7eKw9StNApsecsKYg5e6Z1bo
 qQd0LkV+ZpxLBcEalltkOIgNngL2Qm5pKQBge1LUHGRBaqn1dxVJbAelCdLGHP6MUTpPon1SDzx
 LKS2Ap5R1aGe++jFJRg==
X-Proofpoint-GUID: yj9PDlngPmeFrA3vTsxQob0mYB-44MWv
X-Authority-Analysis: v=2.4 cv=MIJQXsZl c=1 sm=1 tr=0 ts=69eb0294 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=9jRdOu3wAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

On Thu, Apr 23, 2026 at 3:46=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:
>
> > My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> > unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> > the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> > processing hint.  It would fdget() the dmabuf fd, validate it's a
> > dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> > find the matching vfio_pci_dma_buf via priv under memory_lock, and
> > stuff the provided TPH values into the object.  It would be left to the
> > user to sequence setting the TPH values on the dmabuf before the dmabuf
> > is consumed by the importer.
> >
> > Is that a more reasonable uAPI?  Thanks,
>
> Off hand I think it can work, with the proviso that if userspace uses
> the dmabuf before setting the tph the importer may ignore it. I don't
> think that is a problem in practice.
>
> Jason

Thanks Alex and Jason!

I agree that the separate feature sounds like a cleaner design and could av=
oid
the uAPI complications. For v2 I'll:
    - Leave VFIO_DEVICE_FEATURE_DMA_BUF unchanged,
    - Add VFIO_DEVICE_FEATURE_DMA_BUF_TPH as a SET-only feature that
      takes the dmabuf fd, steering tag, and processing hint,
    - Keep the dma_buf_ops.get_tph callback as-is.
and then the userspace sequence would become:
1. fd =3D VFIO_DEVICE_FEATURE_DMA_BUF  (create dmabuf, unchanged)
2. VFIO_DEVICE_FEATURE_DMA_BUF_TPH   (set TPH on fd)
3. pass fd to importer

Zhiping
