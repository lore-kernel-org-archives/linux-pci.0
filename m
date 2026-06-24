Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6763876C7
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282568; cv=none; b=lDgjTsi8zgu9M/OIzbiXGQOzcunLbjitv3jYXvRAcclRJPTTRnCmyvto6hdoon40U0cUNiOQZBeUagaIqf0dMHsa9C5a6tL3xt5NI4btCuN03mdyfZlyrBhPasIq923BilV4a8JlmY3fBqq28FCLWtj7Jswh4BTJjG2oYhkI1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282568; c=relaxed/simple;
	bh=JFlu3g8MSBvaztrq4JDaDpChgd+ByrRmcK3c0K0oYtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=NwBtbI2LYBalJIYSu+e5q9DjmVwf2btoBHZ99bq0DQl+HmLGV131bBYZsco+y6l+lb0/WYQOAH+qYHx4CEirx7AdvraLfwEenbdSLo6n59TSXw6aql6ywb2mciSQOjVV/i6LT3/d6tSLf636WV+amRE49GACXzADXQ7oCORkHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=STU/FO3m; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="STU/FO3m"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260624062917epoutp021a538f5f9c66e2dfbb30916690444eda~78IsjNTWM2824828248epoutp02t
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 06:29:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260624062917epoutp021a538f5f9c66e2dfbb30916690444eda~78IsjNTWM2824828248epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782282557;
	bh=bMS8K56VmMhlkYOs76iSLytYgBZfJhEXGAFPnTRB858=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=STU/FO3mr8eaLYLhYWgDgpIWfZPNyBp9pmsk7cLKX6+to7cE04HXzXrapkkP8Lrdz
	 3lz8EgR4SLoRpulX4nRDAjb3qzXpei6rD3ZzQ3VvCGViE1bHblLJJ/kaaar9ZbnHaH
	 rXUWO8nK1DK8COyGGIsJQRNFKdWB9vmzFKRpkUOI=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260624062917epcas5p4aa00448c504e08879ab7c408a69e99de~78Ir45e3N0934509345epcas5p4n;
	Wed, 24 Jun 2026 06:29:17 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.87]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4glX8X3Dwvz6B9m8; Wed, 24 Jun
	2026 06:29:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260624062915epcas5p39f8859af5665acb4dc7b8ba7beb3bd43~78IqvVnvm1577415774epcas5p3Y;
	Wed, 24 Jun 2026 06:29:15 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260624062914epsmtip24934ac2d15482865c5fcc6b3fcdc6c02~78IpPNfJT1926719267epsmtip2V;
	Wed, 24 Jun 2026 06:29:14 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:48:06 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 3/8] hw/pci: Add SVC capability and UIO properties to PCIe
 ports
Message-ID: <20260624141806.5g4yub6kby6cnsh7@arun-B560M-DS3H-V2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260616182029.3dc0af33@jic23-huawei>
X-CMS-MailID: 20260624062915epcas5p39f8859af5665acb4dc7b8ba7beb3bd43
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422@epcas5p2.samsung.com>
	<20260609105836.3702787-4-shrihari.s@samsung.com>
	<20260616182029.3dc0af33@jic23-huawei>

------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/06/26 06:20PM, Jonathan Cameron wrote:
>On Tue,  9 Jun 2026 16:28:31 +0530
>Shrihari E S <shrihari.s@samsung.com> wrote:
>
>> From: Dongjoo Seo <dongjoo.seo1@samsung.com>
>>
>> Implement the Streamlined Virtual Channel (SVC) extended capability
>> for PCIe ports (Root, Upstream, and Downstream). This capability is
>> mandatory for enabling Unordered IO (UIO) traffic as per PCIe 6.4
>> specification [1].
>>
>> UIO functionality depends on two key prerequisites:
>>   1. SVC support (SVC3 mandatory, SVC4 optional)
>>   2. 256-byte Flit mode support
>>
>> This patch adds the following experimental properties to PCIe ports:
>>   - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>>   - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
>
>That doesn't feel like naming that will stand the test of time.
>I think it needs to mention svc4 in the name.  Or I suppose we could
>do something with a single x-uio-svc parameter taking values.
>
>

Hi Jonathan,

We thought, 
   - it would be more technical if we add svc3 and svc4 in the
     emulation parameters and
   - would be readable if we advertise the field as UIO mandatory
     SVC (x-uio-svc) and UIO optional SVC (x-uio-svc-opt).

cool will change those to "x-uio-svc3" and "x-uio-svc4" in the
upcoming version.

Thanks.

>>   - x-256b-flit: Enable 256B flit mode required for UIO
>>
>> Helper functions are included to manage UIO traffic gating and SVC
>> configuration. This change lays the groundwork for UIO emulation in
>> QEMU.
>>
>> [1]: PCIe 6.4 Specification, Table 2-46 (Streamlined Virtual Channel)
>
>I'm currently out of the loop for PCIe specs. So if someone else could
>review against spec that would be great.
>
>>
>> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
>> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
>> ---
>>  static const TypeInfo xio3130_upstream_info = {
>> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
>> index 1bcc734649..a6b1b8a6cf 100644
>> --- a/include/hw/pci/pcie_port.h
>> +++ b/include/hw/pci/pcie_port.h
>> @@ -37,8 +37,29 @@ struct PCIEPort {
>>
>>      /* pci express switch port */
>>      uint8_t     port;
>> +
>> +    /*
>> +     * This field declares Streamlined Virtual Channel (SVC) capability.
>> +     * Per PCIe 6.4 specification section 7.9.29, a pcie port supports
>> +     * upto 8 SVCs, in that SVC0 is a default one, SVC3 is for UIO traffic
>> +     * and SVC 4 is shared by both UIO and non-UIO traffic.
>
>What actually goes in there?  Is this literally the SVC capability content?
>

Yes, this is the SVC capability of the port and is a bitmap which will be
populated based on the emulation parameters of the port.

>> +     */
>> +    uint32_t    svc;
>>  };
>>
>> +#define UIO_MANDATORY_SVC 3
>> +#define UIO_OPTIONAL_SVC 4
>> +
>> +static inline bool get_uio_mandatory_svc(PCIEPort *port)
>> +{
>> +    return (port->svc >> UIO_MANDATORY_SVC) & 1;
>
>Could just define the field mask given I don't think you ever care about them
>being the numeric values themselves. If you need the value defines later, then
>fair enough.
>
>If you do switch to defining fields.
>	return port->svc & UIO_MANDATORY_SVC;
>and rely on boolean cast from non 0 to be true.
>
>Also, do we want to route those two defines through the kernel uapi/linux/pci_regs.h
>and then just make use of them in QEMU?
>

Actually these are not registers, just a macro definition used to denote SVC3
and SVC4. These definitions are used to enable/verify the bitmap declared
above (uint32_t svc) and I guess routing from linux/pci_regs.h is not
required.

>I kind of assume you have some kernel patches as well as this qemu support so
>it would form part of that?
>

Yeah, we are peparing kernel patches and will be sent out shortly.



------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_
Content-Type: text/plain; charset="utf-8"


------uxXJsHHh-Fg65yNB0vIi5XNifLwzhKyLgsuI88_8PeeXN_vP=_53308_--
