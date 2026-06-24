Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867536E495
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282754; cv=none; b=lcPxUG1MZPricw79v1CnJS4oivvc3GyytVlDb65ZS71kTukV2xa5LQpkVmd5ZCm8OjIIZDGnY6Zz4UemaEf4WVon2+McKRxF1imSVo9AVhi3wza6L3pVRPiWXXWqcLGbcauNywl+5t0dfbbvxI7bpZqtEDM8BTrddMGjOEBsJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282754; c=relaxed/simple;
	bh=kkeGGzYPAFv+hSAt+PssnSMVqWZmP/h+yd/xDQnPBYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=GUMMyNhUN8kQPpg7H9y+G5DAJL5H03EhkHL1VDJtloHzRMqAmA9zo4oJduG6u+cdBR/GGqxKBVnnBFfkdgAc7DKAIpzxg+K3qr+FP3U8ON5mWZBD8nHA2U7k0kq68ifLkGLYoqruru2kgoI4jb9ZxTaa2Wpz3afGUJjOdnxQRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=az+5u/Yo; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="az+5u/Yo"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260624063229epoutp0121c594992b35b7426fab843716a8be66~78LfFVY-o0436604366epoutp01G
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:32:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260624063229epoutp0121c594992b35b7426fab843716a8be66~78LfFVY-o0436604366epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782282749;
	bh=gCHdlJptgPPRCutW3+PXA89oSW/TTgj5oE//NghhidA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=az+5u/Yo7w0+HYUn+asvfWcAb58uOAOLJCVZh2KmXmQZWpz5CoiNOb9YHJZNVVDiw
	 0v6MreaRks2ZrLnTivDOyCzlKyzKO3u2TyMB1tIL85sEjYCjz6bJy2w/4OmXyn9igW
	 WsxQhjRW+IasdOwurMQqYgNal79zIjFpkiz2GyX4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260624063229epcas5p45c6fe4ae66c36bdd7aeb15bb5898de10~78LenQtu32641426414epcas5p42;
	Wed, 24 Jun 2026 06:32:29 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4glXDD28LMz2SSKj; Wed, 24 Jun
	2026 06:32:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260624063227epcas5p4c3143473afa38b85d5eddca403d89ccd~78Ldb8W7A2605926059epcas5p4l;
	Wed, 24 Jun 2026 06:32:27 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260624063225epsmtip1d570a3c9d6de2cb92616bcd7e65ff6e3~78LbmT1MG1927019270epsmtip1I;
	Wed, 24 Jun 2026 06:32:25 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:51:14 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 4/8] hw/cxl: Add Streamlined Virtual Channel (SVC)
 property to CXL ports
Message-ID: <20260624142114.pvrshhaueuaszg7i@arun-B560M-DS3H-V2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260616182159.6c618a75@jic23-huawei>
X-CMS-MailID: 20260624063227epcas5p4c3143473afa38b85d5eddca403d89ccd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7@epcas5p1.samsung.com>
	<20260609105836.3702787-5-shrihari.s@samsung.com>
	<20260616182159.6c618a75@jic23-huawei>

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/06/26 06:21PM, Jonathan Cameron wrote:
>On Tue,  9 Jun 2026 16:28:32 +0530
>Shrihari E S <shrihari.s@samsung.com> wrote:
>
>> Add Unordered IO (UIO) dependent property SVC to CXL ports
>> (Root, Upstream and Downstream).
>>
>> The following properties are added to CXL ports:
>>     - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>>     - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
>>
>> Note: 256B flit mode property was already added in CXL ports, so reused it.
>>
>> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
>> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
>> ---
>>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
>> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
>> index e82685d1ab..83fb5968b8 100644
>> --- a/hw/pci-bridge/cxl_root_port.c
>> +++ b/hw/pci-bridge/cxl_root_port.c
>> @@ -53,6 +53,7 @@ typedef struct CXLRootPort {
>>      CPMUState cpmu;
>>      MemoryRegion cpmu_registers;
>>      PCIResReserve res_reserve;
>> +    bool uio_capable;
>I'd bring these in with a patch that uses them.
>
>This whole thing is simple enough maybe just have it as part of a commit
>that uses the properties.
>

Hi Jonathan,

   Yeah sure will move this field to the patch that uses it. Thought it would be
   a prep patch for the patch that really uses this feature.

Thanks,

>>  } CXLRootPort;


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_
Content-Type: text/plain; charset="utf-8"


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53357_--
