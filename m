Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429A53A8B2
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181294; cv=none; b=GF1vDg930+FFBjnMTBXM0JGTjZRJFiSsU3BVeArtlcd6xe4kLZNzRwWRmniALTe5yv+bLGd1+KY4IbP6Q7OxRm6Z95l9kapCwDr0uafdZqMASK9M80bPmVvId8Asr4da6mjH18g0I0z/WAA1r7DhYQFbVM1xqZX4WWk2M9Y6zK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181294; c=relaxed/simple;
	bh=kgDsSQbr7da8IFbWQK538zmsUj06/QCBCRpfgbtijPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BurCMoa/hjuuDujoJiYnqGLB4eAT+vwvx1nKKYd65ghSJqtGPBsy6FQIIBGhgV4tVQrcu+5Qg+RINvaXC/e5aj20Uy/bZ9YdKYetAAuokYsOne9j4qbg4li7dwBl1QscLCWmXDEyHrye7urx986mVnGEsHAahx2YoPDs3JAZ3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ByMAJO21; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHXxFYS0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ByMAJO21";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHXxFYS0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTh0d217677
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 16:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	syJmSg1jd2+OqFENPatOG6ZxGNllzRDnmvLVWXY/WFw=; b=ByMAJO21i0WkgepC
	qBLMYPmSBPFnmTAa6Ql/4NM35PeW+vJ1ZmXLA4Z+PcAcD3IcefYrryJfkp9RpQud
	nfLrdiR/V+ZX7jaC/2FTKvW4IOn8+ZD3s4SodQ3g+yTJAGDZdstDWYXuyDJD47TH
	EqjGNNbeREImoXWBHJKmPfKB6QLOX6fVQGf9sAXRvPQEE/1ZxC/TeBHB2eMbG8Dq
	cVy1kI5KTvitLZec/Qdn8q0mjSU4Be6kRbneE0Lz/dBj5TsflBz1NUvYQ6aDYd8i
	dvg194gDNqBINzt6srKx5t/SoakUcWwy0B3ENudjTRgMb8LUKb3MPgPuJuFTfRiF
	X7bATA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb61f2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 16:34:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so755968a12.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790181278; x=1790786078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=syJmSg1jd2+OqFENPatOG6ZxGNllzRDnmvLVWXY/WFw=;
        b=XHXxFYS0OIgSwZ3Hgu5dwxlv1eGOolZwVrikmo+FgI+mtn+prHFAts1SDSbELqzveN
         JONp/qCxCqGb7LcF6YDyp/991WrRPi5na24wcjkuDwqOZGCHtmB1w7D7qULrcKng/FIT
         ncZ9tR6RQq1dFqj4IG5OHzO6YkRNgSxmr0O1o6RSOFtjR875qMN+1AhXei5kPQBkBUCQ
         GWcNPhNlxbU4uoKqq8OyVioUcwmzqJenX6gtbZIjJC9AIPXS0QQgDSPY1PeCopMFcamf
         Pn9uvvvURZXH0EtGtb4eKs3z3gtQL4IIGvfyhyTWpPqaSGkt7JI7ilDIIqHzTR0taNuQ
         JGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181278; x=1790786078;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syJmSg1jd2+OqFENPatOG6ZxGNllzRDnmvLVWXY/WFw=;
        b=CvYcGdXM3Sm1MnNi/GtGNLcdTvrwPgzGJdx/bvBSX7Rxe9s0yk/QW1MSdd2C9+bqei
         ByA2GQCeU+4RKfkOQ2idUwaGtwxC41AeShdXuGYeXQ/yRaGZIxnfB4yyTN19mdq8OYxr
         wmwrmr41BEzIqD71QAmDqS8VHnm6YhLnGppu9oUHBWTv6WEfSo2cf7q7yJU4APZmTgzt
         +CUWZHqt7CsK75/HKYa0wYs3DXZPrXJ+OlxWPvY+0bAzDIz6Po1XAYcHompGcLNmBlUS
         MUlu5evXxTvNLn98YrNKSpQwMiCfIbwJiyF24bqzWg7mX4U3In+0Izdkv0DVuwHyjvao
         m7Tg==
X-Forwarded-Encrypted: i=1; AKwUvBxFUN2sU//PI837goRAbOrzTpJ8DgL+At0rnvFRhskPIwJg9I8+M+GMVBDP6vViGrgi59v4COFK8tg=@vger.kernel.org
X-Gm-Message-State: AFuF++nvf5mZcpM1kJzKI8Ot/Hxh/mvShPwNpIKIZo3+SmIE2FsfhMGV
	I+GFVvu+alNOG+kh7jgLLM7lXO3QWdE2JVpMUI3FK+QbxYXQg5tvVVb+2BooliYBO4gf0x5/CeC
	q1KPr/SFIbRb73eW88NFuNaao94dRhCq8hHQWPy7k0WY67japREwudl/gE390qMI=
X-Gm-Gg: AYBFou2QfSzsG5VfZ2VJk7IhZwBChaMIKsakXno85E9ltI0eycSWcPc+dS9mYmnIcRB
	gH6MFX0cnC7WYqEMyhJxC5qN2N7O6x5POsFBWxQuUdInbI5CpQoRbcdTjN97Ar7UnhOYMg3jnEK
	Hm/Egkk3Sfcq7wkztKwnv+yq0QJzb/WlNWlSP/BXV9ej3Dhj1KVF7yOUO7ax+kwfTGNg2Hwf+zh
	Yg0gw4Uctq4qssh0D5ArJLYTMRaQ7iuTwJtIUTcRS3zcW8NLA60NAVq4O/I/43PltgntOMrsDrl
	+sP1pNIED/AK0dC6BfXggyQn6JxYSV6XQsNXLnHXjZ8fKpi7DTEO+RFj4YAfd6S66vk+XmldrbK
	tPUu3dXl/F4qasQj5JqQckPHfw4zsAe+W97VPTwPmfdGiMmVnxc4Z2tLLjsK2EKFX
X-Received: by 2002:a17:90b:2803:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3a07e53ff81mr2827005a91.24.1790181278484;
        Wed, 23 Sep 2026 09:34:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2803:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3a07e53ff81mr2826960a91.24.1790181277942;
        Wed, 23 Sep 2026 09:34:37 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f0915sm1427960a12.21.2026.09.23.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:34:37 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:34:33 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy?=
 =?UTF-8?Q?=C5=84ski?= <kwilczynski@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring
 <robh@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will
 Deacon <will@kernel.org>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH] PCI: iproc: Use __free(device_node) in
 iproc_pcie_msi_enable()
Message-ID: <20260923093433.00006cab@oss.qualcomm.com>
In-Reply-To: <20260922210839.3765444-1-fuad.tabba@linux.dev>
References: <20260922210839.3765444-1-fuad.tabba@linux.dev>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dAXMqPfUZOQ1RRjapQwoINFTgkTD0GMw
X-Proofpoint-ORIG-GUID: dAXMqPfUZOQ1RRjapQwoINFTgkTD0GMw
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab3ff9f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=b3CbU_ItAAAA:8 a=lkVW872q3F1hLcTO0fsA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NSBTYWx0ZWRfX53dmOzHVcRdb
 25gAPsMQWuQ2O+WBri+WBDODjqsb3HV7TATqF2hpzXMdzvJh3weIbXhyOUSk/+tU5R0v6xJ4lTW
 Bgh1EWz8vHggX5vPrRI1RNXUr2NRd3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NSBTYWx0ZWRfXynemLFgxeq99
 fA6u8ox6TsMz6ggMSWeLVobGewPzVdctUv6dkMBvKJn67/flFPimgzIXu85OppqSdxP7kUwn4AK
 8XnJUhj4Ax/J86HeYwy55HG/0aCiC2B/AoLBwj9pWWCUViLMDuT6084hg3ewWDez3EWurTDSbqU
 FP/lpWNWA6Z3XhMX8swNPjzN12+bUXAAamjKljdXtbLsCQpqCdcX0/ZTLvi9Qaype4HVQYh/66j
 VcHdLrUECXdIe5PldY4w2EMDvXvTW0t0AQOS7cMzNftr4dVUu39FYBhUCx7nfOAMMZwMxkqVv/6
 NHtc69M0XcZSmsOnLj/xT9cTgSa7jxF6tXDMZJyMxxfxcrt8hITT/pky9sjuz/Lc8W4zE3IZ/hR
 BIs8Myg9+3cfY7Vxsaw1F8K+OdLgqC96FmdianYEskvwvktC/M6qMcWnpEaBCHvweo3cPXX/c9y
 In9vZhOeLmekMcXkWrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230065

On Tue, 22 Sep 2026 22:08:39 +0100
Fuad Tabba <fuad.tabba@linux.dev> wrote:

> Declare msi_node with __free(device_node) and drop the out_put_node
> label and its goto: the scoped cleanup puts the MSI controller node on
> every return, as the label did.
> 
> No functional change intended.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Link: https://lore.kernel.org/linux-pci/61488ddc-b346-4ba3-b32a-e972a3bd75a4@mailbox.org/
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Hi Fuad,

See the guidance notes in cleanup.h.   Linus has stated a couple
of times that he really never wants to see = NULL pattern miles
from where it is allocated.  Best you can do here is shift
it down to immediately before of_msi_xlate(). It is fine to declare
variables with destructors like this inline (i.e. not at top of function).

Admittedly if the scope shown here had gone a few lines further this
would look less bad!


> ---
>  drivers/pci/controller/pcie-iproc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index afb3aa38ac6bb..b4f4e6e1d4b41 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1338,7 +1338,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
>  
>  static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
>  {
> -	struct device_node *msi_node = NULL;
> +	struct device_node *msi_node __free(device_node) = NULL;
>  	int ret;
>  
>  	/*
> @@ -1357,18 +1357,14 @@ static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
>  	if (pcie->need_msi_steer) {
>  		ret = iproc_pcie_msi_steer(pcie, msi_node);
>  		if (ret)
> -			goto out_put_node;
> +			return ret;
>  	}
>  
>  	/*
>  	 * If another MSI controller is being used, the call below should fail
>  	 * but that is okay
>  	 */
> -	ret = iproc_msi_init(pcie, msi_node);
> -
> -out_put_node:
> -	of_node_put(msi_node);
> -	return ret;
> +	return iproc_msi_init(pcie, msi_node);
>  }
>  
>  static void iproc_pcie_msi_disable(struct iproc_pcie *pcie)
> 
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780

