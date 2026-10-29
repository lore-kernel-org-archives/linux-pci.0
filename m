Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793240108;
	b=YHpK6nwYNQT31TLJqnmOVr33OxblonJKkM0BE34BI1eLWUbieWl71Dfa5u2Ez74DPEmx
	 TR49sinQnbuNwTO/9wIOGJJckdBx2ZOXVh0CCmTzANy8KT9J5C2tTbIEBeZ2cT1tnJFZz
	 UGJZVrTt2Jecx2QuBfvOtehtcJzxVJh2jenvcVmucqIeK2SSXXlxwLlFv5dRtz/Wwop3a
	 OKZBmEknPz+7Ze1Omrm1ty6mXq3LXw6+eEfi9hXVvWprelaXIetuiPitAD2/iQrGQVt7a
	 ifzUL5UYPNElpMpoQBHsuyMPJDo/S+Q0LCVkPOryecXHx7jWNI2S08UH+cPjmzgmguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240108;
	h=DMARC-Filter:DKIM-Signature:Message-Id:Subject:From:In-Reply-To:
	 X-Lms-Return-Path:Date:To:Cc:Mime-Version:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=V7i4RlDFWSoW8wBciJiCSsfVygxZnW25vkRz+Gj8oUo=;
	b=yfpuEYXgkNI0kgUdNON5s1laxTpbTr2DwFLZoO1YIwCupoZ0KtmMxfbXztgdl33b9NLk
	 n2bp9PtaXTSFG3lKxfpE0JXiI03ymR25Cd6xkVoCa5owKzEm50XEKZQeBuRojiX+FRZE1
	 bkTvTq18tf6h1cGtuSByucq1ftNIaxu25lS5dRmLvbCBbGsEOGRK4Kt71TAmUtXLBFoAB
	 CsPp7+2OncVJcGGD8gUr6pelm/C6rDYvwe4zISt5uunyaFJ9oAYYAQ3IX4SxF9P6Qagvy
	 5Hd4sotWh1/J8t7zuG1vJq+ZTLweir0VsIu+UVoAWW+W0WAVauJ/c4syQhgPhz6vvCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=n4z7pKfv;
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B5606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479B5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=n4z7pKfv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793240097; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=V7i4RlDFWSoW8wBciJiCSsfVygxZnW25vkRz+Gj8oUo=;
 b=n4z7pKfv/tsaXySsUV9TQxUTNmHQ5jlE4niPTVxd63uEHs6y8VlUa1BLzbmguk6xtY+XK1
 M/Vb+O7cQvP+c0QdyochOqmTqMnKz/Q0nQjGXkCiTi4NgLTesK6reDAB+/oGDxVK+NSHd5
 QQ5gHIalupkc7GALSKLXANwAap349/1EWRsbkLgY6bVVBADVUcaOhNpg58rVP9G3F0dbAp
 Za+imwUQM0cqsoz8gLCp90WOLhixpnl2r1If/l2LZ5/ZelNQsj7jH5C6lU0Zc5WcgITS+T
 0hHaR9HzvdXJSh7I4p/mEwIXvpnJImBZ4+epTPk2rmOQbTUan+LSnaCxZ5zAUQ==
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9ea1a2e5.340e.41d7.bbaa.69129ddcead9@bytedance.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
From: "changfengnan" <changfengnan@bytedance.com>
In-Reply-To: <auIRf1QATQjVDtkH@kbusch-mbp>
X-Lms-Return-Path: <lba+16ae2ac1f+95c97d+vger.kernel.org+changfengnan@bytedance.com>
Date: Thu, 29 Oct 2026 10:14:52 +0800
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>, 
	<tglx@kernel.org>, <namjain@linux.microsoft.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013223543.395054-1-kbusch@meta.com> <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com> <20261028150712.GA16374@lst.de>
	<auIRf1QATQjVDtkH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> From: "Keith Busch"<kbusch@kernel.org>
> Date:=C2=A0 Wed, Oct 28, 2026, 23:15
> Subject:=C2=A0 Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
> To: "Christoph Hellwig"<hch@lst.de>
> Cc: "Fengnan"<changfengnan@bytedance.com>, "Keith Busch"<kbusch@meta.com>=
, <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>, <tglx@kern=
el.org>, <namjain@linux.microsoft.com>
> On Wed, Oct 28, 2026 at 04:07:12PM +0100, Christoph Hellwig wrote:
> > On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
> > > Hi Keith:
> > >=C2=A0
> > > I made some modifications to DIM and then implemented a solution
> > > using the DIM framework.=C2=A0
> > > Based on current testing, the results are now comparable to those of
> > > the previous patch.
> > > Here are the preliminary test results:
> > > https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk=
0bTZwlJP1Hzzdk/edit?gid=3D188992110#gid=3D188992110
> > >=C2=A0
> > > If you agree with this approach, I=E2=80=99ll continue testing and op=
timizing.
> >=C2=A0
> > =D0=86 can't speak for Keith, but I'd really love to see this going for=
ward!
>=C2=A0
> Same! This is a great problem to solve, but I'm just sorry I don't have
> more cycles to work on the cause. I can quickly respin the msix noflush
> pre-patches to address the naming issues tglx mentioned, and we can take
> nvme in whichever direction has the best performance.
>=C2=A0

That sounds good.
I'm currently working on continuously optimizing and testing both
approaches (using DIM and not using DIM).=C2=A0
I plan to update the code and add new data again next Monday.

Thanks.
