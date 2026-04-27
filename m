Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D553D3D08
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300153; cv=fail; b=Mai8imTxLfkU0midfIJQhbXf7gE/EoJ2Mb/qQXd2C3KQ7EPv3bzNE34J/J22oREJD2e9jUEeZXybVnibZW9p+OSqpGnZYFBCRI/9j65NZu0f2Q/n84v+HvOcEMcnwLK7S2zSvaHdXg9HzS3BTy8ewlMpbwc+zqE2YGtUF1LI8ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300153; c=relaxed/simple;
	bh=cNz2WSzENxZIwe3ENOoH+tx49yVa0W2AI9rc1OJhwvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oE7vqIEAEvrHJM6SZ8pRmeKuMUWmj9mQBy635Di2I8w9IpGIJtQMUXm9Xq41AWIs6c8dnS40haiZxr1wFiW8GdwTWbb7oPuhFyXt6M6fH5Qi1GXX1xdaj0Z4HvYqHsljQYlj8enOKheSksRHLNI58oy1eIJ3ckn8BEd/v/W23fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EUDXK0UB; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EUDXK0UB"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R5nYcf031665
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 07:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2UYvqcb6I1B7arRH3pzlLzPrPOKAEH8Y0SQKyqL2jag=; b=EUDXK0UBjzGK
	QKaoX5rIbqufWNaKZdxeAqfPQCkyeDJd2/wFJgapOGZ67xUUMlghtDbf4D/d1LxH
	5K8gn8+RpXX2sydNaWxkc5Fg5ZbqRGAsqwVsCp1OE3OWi5+yquLz/58V0qPoBIMB
	HhedRrHQtQxwKZTwXJUSL7FPjA3ZBGAKGlymgWIYr0yRV3XBk5s5Z4C1y8nt7KML
	jPg8exqznSgbfD7YbW/T/LWbR/ipKX7cSSMzAc4VFZlAkI+faif4DC/D2wB4c7UM
	RbXB1a99Y6RAwk67EGD4OMCuU6JKBc5xh1gQ4EhZCgV4Nyiw1GPLWPY/voT8hSRh
	Zbz3O5ycQA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drua30mup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 07:29:10 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dcc9e6b772so16963475a34.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 07:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300149; cv=none;
        d=google.com; s=arc-20240605;
        b=aff5jECVW81CDFsHN1KgqN9AVxjw/wti2XJ0DTV7LnGDgUmNy21xO11z4d4QLOLDRg
         EzXsnAFNuXaMQ7Ps6X0ls8EP30JOo0BfuN3vaBwNmt2miGTlxcQbsCpyehZ9r9hvHuVy
         xarbkvn3fK0FVeklwnm/+7VaN2SDA1QIpcmnmMIs1zu5WSJNdAXyqGlLbj/ze9MbRn1W
         nwn6jkTDbZX0ISixy+cIyp/RGW7jJcAo0I1NtkrIPlP8IJDLB43PYKXUBSInmVEAYdot
         ghUShpQDKP2QlRoWWa35QAGGIbyOdgfmkIR/Bh+Gdtw6ufkEzgGNHs1G62+EMkoPLm8i
         4Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
        fh=73O7HXWexvlGN0v27GL7NpyJnflfXZr1a+hr/C3Fa0g=;
        b=b3sIZDyrtVmDEH5j3Bg6fbGa5EHqlJHxN2VgVS+Kz8CJuXKVWitoQ4pj1F4McHg6KN
         fMbbllIq8529WjLV8H2g4GBiMLdBD3MxSgEtsJOU5bxE9hNAI/Grp5PXB2g/DZ3PlpkA
         9t/OHHDBnPoYGv6yVO4y1GGSFs3CfHDvd6+arUyVHvIH21Patj4pbOqfBcohypQh/3da
         ylg5vEdEV+1bInkJsM4sp3qpKukOR3lYpmFC344FsLkCuQLIRV3WhiFvrxdBbDoE7Bz+
         ctrn+JB6BZGiGS1Dx22r+QZveZmeO7r1XcQTWQHMjk9B5bbz8QQqLISp4l8DD8elK6e+
         ladw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300149; x=1777904949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
        b=NKEh+eIjrwVjuLowzDQ+p5OXd0VXHKflgOC+zqsqUvbbuKd/vnVEzKufumTnospGfQ
         d5IKnXSPKVuoqXmMmzJxEEqskYTg62z/KusU9zCpQiSA/fjX6d4Hu6RaeQ9IdFV9C6/K
         6Z7MXGIZ9TFPxeOGGxgykqLM7aRi8gTGcFs61fgv6n3im/J5F3nzT21rRh/HlPkO6bKd
         m8sbKa8bfc8SEnQ9FotJzSpmhWworMf/V+nk4e+6Unair9wr63mA/4F5HzZko/MBpDDG
         j7dS36KyCXZn2a+/UP3porKUFUUlw7ISboV22pbjxcb7WgutwzRn+578GaHmbkRuo6mN
         ONHw==
X-Forwarded-Encrypted: i=1; AFNElJ8f/xcXuvKDoSQ0HM3nN9ocIwnW/v53v5kSwuq2s575sL8eUDgGta4UQA6abVMyJS0ip48X8vuMZwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYY3tvxKZDXi8ekvdX9lwaeQ0e800we01rGcn4cuikyFl0wVJ
	ZpVHzIbV5oFX0jlkbdTZPvp7wU4mNFn0QoEodEU7otQJi067JwjQPbBwB99rW0Vayu1MYv0F5TX
	3MYLVNMaqDe0ynnJjOW0VrvzJRH3fPX0mzAqWSy2XOnozbIflDIRCf70q1pkHwpapjtEOpip5Db
	eR4A54Ke/oLGFk8SWgnnG8t6AVFjeBolnY3gY=
X-Gm-Gg: AeBDietDalxIlLcgr25N5Opu2qObf8d9wxmOkMAxG++1XOzXUW4FgIG00jR3Ayq+gQi
	/307fJsi7BV4KWlveRRGoL4ypy3YZSqg3DDx4YKFdIu/CZ4ePUxJtwA3xpox501DgzXL2/6UAln
	DP3Uv8ZCbLpxYhOQMmtWClFw0w9fwgYMomvPjlPaGhmgwYm9pWBGNsdipGDsPP3wviODcP1KUdZ
	+2EyrVu+JqlUqRRWb4bMd8h9TKjyg==
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7dc95525104mr20499569a34.6.1777300149210;
        Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7dc95525104mr20499546a34.6.1777300148671; Mon, 27 Apr 2026
 07:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com> <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260427133746.GJ440345@unreal>
In-Reply-To: <20260427133746.GJ440345@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 27 Apr 2026 07:28:57 -0700
X-Gm-Features: AVHnY4JY-sO0J_s7LFL2WwzvQxcK7s_leO-HiTQgItvSXPr8LTKeRFwdBSndRaI
Message-ID: <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
        Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: rbNb-WFPK62gKCLzKdx8sdAh1T1mw8iA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1NCBTYWx0ZWRfX0wsvxYBipHsL
 v2dYzBAcZ3wJfj97qrzkWTnMx4iZf6IxdLCCxC4CdQZo4ZNocRFXpdB7qNRDZqLB9GRarXPfYL7
 WIMJ4qV5hpe46ITYgOtpQadJu+QzIKp7yORvMEeFigiqr4qRxalJEwvsxC9Vz9XnTmdgLBMQ8Gb
 IpDMrfxCTisUrwCbT3KxaajUZ3Pn5C+L4mmsIusdYZcwCcJbi93MMQhqK1xVj7nK7VM1Pe7ukag
 37VdZlPOBonJsK+k1/dcl6QdwQFPSHk9ZuZgZU/MAmx0HLPZzzXAEmjJjsu+D9fLg5OkMdD/sj4
 UGRee5p1weKMOWBjE0/OSzAvq3g1BDaQDm8CvAfPpeoCcsBZxWUEnTSzpSWAsP2J31QyE8/RAgZ
 xyxK02x1dKo49zZvITQJ9+WdEjUzjhdVrl0ahAYG1jpsoMMqbMd3L8GfMDX9uA0LpG16SeCj+DA
 +lZ2s1EK5eUbZWn6bCw==
X-Proofpoint-ORIG-GUID: rbNb-WFPK62gKCLzKdx8sdAh1T1mw8iA
X-Authority-Analysis: v=2.4 cv=UYphjqSN c=1 sm=1 tr=0 ts=69ef72b6 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=jaC9V5GCrIjCCUt1bV4A:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01

On Mon, Apr 27, 2026 at 6:37=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > On Mon, 20 Apr 2026 11:39:15 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer.
> > >
> > > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > > using a flag plus one extra trailing entries[] object for the optional
> > > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > > metadata.
> > >
> > > Add an st_width parameter to get_tph() so the exporter can reject
> > > steering tags that exceed the consumer's supported width (8 vs 16 bit=
).
> > > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-----=
--
> > >  include/linux/dma-buf.h            | 17 ++++++++
> > >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> > >  3 files changed, 89 insertions(+), 18 deletions(-)
>
> <...>
>
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index bb7b89330d35..a0bd24623c52 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> > >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_=
CLOEXEC,
> > >   * etc. offset/length specify a slice of the region to create the dm=
abuf from.
> > >   * nr_ranges is the total number of (P2P DMA) ranges that comprise t=
he dmabuf.
> > > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra tr=
ailing
> > > + * object after the nr_ranges DMA ranges carrying the TPH steering t=
ag and
> > > + * processing hint.
> >
> > I really don't think we want to design an API where entries is
> > implicitly one-off from what's actually there.  This feeds back into
> > the below removal of the __counted by attribute, which is a red flag
> > that this is the wrong approach.
>
> I believe removing `__counted` is a mistake. In my proposal, the intent
> was to adjust the meaning of the storage object based on the flag bit.
> The size of the array should still be represented correctly.
>
> Thanks

Thanks Leon =E2=80=94 you're right that __counted_by should be preserved. In
your approach, when the flag is set, the last entry in the array
carries the TPH data, so the effective DMA range count is nr_ranges -
1.

That said, after discussing internally, we're leaning toward
introducing a new VFIO device feature with dedicated TPH fields (as
Alex suggested too), to avoid overloading vfio_region_dma_range with a
union that changes semantics based on position.

Would you have concerns with that direction? I'll post a v3 with the
new approach.
