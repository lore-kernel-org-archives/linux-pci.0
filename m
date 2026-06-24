Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8D392814
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285790; cv=none; b=QqSzmfFHtdrgoaYL4SAALb5hjyNlOxlhWYWBWGzSHWkOL+Vdc+O+b6+Zvu1Al+AaEuOx4ccgXeP0TIynBurQStuZgX8qqc/KJ3d2CQLbqVMIvNymVv4mfH8fL4Zg+IXQZtTtj1HBwUN58jTlx/M/G01eiUIUpYfqYKbn68N30O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285790; c=relaxed/simple;
	bh=lA8XugXxIRBOfwWF4lTMDZXTDxQT7NQ6VY/WywWoxsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JIdEEr4Kj8fG3ei87JM92Ha0/ePFgvzzfAsOPRk95Gfab+1ZuNvJr9vl2c3OkJkn9kWSMpb96T1k1EMBTps5WRpyHrxIgQD8IMYQAQC1pfBOJKz37/UH/o+/9usSJBKMmdM7/J7uaA7lvVEJ8Bs9VQLR5vsQLscGaP4oeWVvFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qmuTmiKs; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qmuTmiKs"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260624072303epoutp04dea882dc22bcaefcfdbcc015180fd9d6~783o0zaFx0397603976epoutp04E
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260624072303epoutp04dea882dc22bcaefcfdbcc015180fd9d6~783o0zaFx0397603976epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782285783;
	bh=flLJaw24vmZ5PebTC58E7dtIGLM3IzPX1gG/gt3MsWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qmuTmiKsI/7UqkYmMIIRHeXZHhD7s5OglItSd/TpiqRps4Fs5ZQ7ZDVwIJ1Gu9d9u
	 nRU2HgPQgDrAuIeHFaQDdViiboWt2g3H5MzSd39g66n1DP5hGGRrYJfE07CEVgAT1G
	 3cJsfzw4sSRzKMWMxVVqCuCm6He/2KNumU885N2A=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260624072303epcas5p4986c5350b4fc8c415b99dea6d3edeaad~783oPoHT80772007720epcas5p4u;
	Wed, 24 Jun 2026 07:23:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4glYLb0fVNz6B9m7; Wed, 24 Jun
	2026 07:23:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500~78w7XEGjh3274332743epcas5p2b;
	Wed, 24 Jun 2026 07:15:22 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260624071519epsmtip15f129b67667b670f0ad884ee1fbec427~78w4wroEL1366013660epsmtip1K;
	Wed, 24 Jun 2026 07:15:19 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:34:27 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder
 registers
Message-ID: <81412691.21782285783075.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260617154521.520191-1-junjie.cao@intel.com>
X-CMS-MailID: 20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<20260609105836.3702787-6-shrihari.s@samsung.com>
	<20260617154521.520191-1-junjie.cao@intel.com>
	<CGME20260624071522epcas5p204780f40c1b17535fc2568f2d32ba500@epcas5p2.samsung.com>

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/06/26 11:45PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Tue,  9 Jun 2026 16:28:33 +0530, Shrihari E S wrote:
>> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
>> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
>>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>> -                     UIO_DECODER_COUNT, 0);
>> +                     UIO_DECODER_COUNT,
>> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
>> +                     decoder_count : 0);
>
>CXL2_UPSTREAM_PORT is an enum constant with a non-zero value, so
>"|| CXL2_UPSTREAM_PORT" is always true and the type check collapses
>to just "uio" -- every type that reaches hdm_init_common() with
>uio=true gets the UIO bit set.  Presumably the intent was:
>
>    (type == CXL2_TYPE3_DEVICE || type == CXL2_UPSTREAM_PORT) && uio
>
>I haven't proposed which types should be in that set -- patch 7 sets
>crp->uio_capable on the cxl-rp, so a root port may well be intended
>here too.  Either way the current expression isn't gating on type.
>The same applies to the UIO_DECODER_COUNT line just below.
>
>Many thanks,
>Junjie

Hi Junjie,

   Thanks for pointing out. Will rectify it in the next version of the patch.

Thanks,

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_
Content-Type: text/plain; charset="utf-8"


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53746_--

