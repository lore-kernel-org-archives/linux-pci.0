Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793931855;
	b=xnvAC7XhAaKTBrBhdHLtSuYstt/zciFAxq1WYrzrrnIyS+exBE/BqQ2LMBeMQGEy671R
	 M6jagHFwxQAdYVFhHQshGRevUnTpGVi6M6y3TYL8wWsdUV8sQImauvWk3p5EhAdLnyDVT
	 knmUyiUUmSJaSC7DcdDkPv9nbMh4Z/VqubWbZm2vznXBsZ3/jOJ+9cGimewAAzclIIqIf
	 VKeh00l0mRCxf3RbbW1bsyNr0UePkoEzfFnhmy1Law5Ukf5Z/F/i/t/GP9XSbutluQ7dX
	 lzaJhGRk9+Y2xcZh97eT2HZGyXCC6tF8J0m6TJAY92flVuaAJCAmQSgVLk1QyBzOrWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7Ugtj1Uw2rabVbTscYaPUmGxT9EXsnqmeQYId8bSE0Q=;
	b=OCCjeRlEhWyDrm9RNAuEPHA11sTiga+UtcSY/B31zVcL4l6lR8FDpfCO/UgPkNsp9RqY
	 6W5/5wNv5nxcWpzNdAG0cm8o75dJrHspBHlziWEcWXmiDkhRaw5ugKjUGh79ecImVXouk
	 sB2YkxuNLkHR/fQ2Cb5cy6Q1QtWZBPbFh4G93ZOpD2IHJk2513gdAbM/I53mn3da9AWqu
	 1fwYjEWkUWtck+nrsf7/ibt7x/g7AjbWTgi1oNTi8jIsQHpzEOy0TAKnxhuLyNaXFBe89
	 Ey+vP6nTc1InP+ItGLQfPOHo8Yn9cLL79CSDg0V0U5Myg2ZFOccCw5DyO8Q+gQ62CGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YTHsjCBr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LY11YBYC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2648606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 02:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2648606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YTHsjCBr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LY11YBYC
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NerDj1170896
	for <linux-pci@vger.kernel.org>; Fri, 6 Nov 2026 02:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Ugtj1Uw2rabVbTscYaPUmGxT9EXsnqmeQYId8bSE0Q=; b=YTHsjCBrSkDAcgcz
	EA2Jc5n25P1pHJr7+FSsz6LnY1GHZChUM6w2OtsA9L9MfpNBl0FvmxzSn0LwHDyC
	9D7b9+2IYUQKzj31PnBpFAdSd1LOaZeyBjlmtHw36CnDpyUVDY1Ein/UQD6l6okn
	9scx2PwUm5n3FofiGdPhTBBDpGCQRZiAt4mt8oiPNLj3kemen9w4gMzitZ8OLWgT
	DZlzmCq9ioddFakz7nigf5kScGHe9R3cjYbu3XFMEOGVgDOtZTRfXXKNmEATZ9Od
	zu+zH1xy9kUe1f/c4b5oNPumIc4dpML4PfzgSuXsFsiqzTzFdsAbsgFIt3Zg8one
	T2OmGQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa8fqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 02:24:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adad90c894so261137a91.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 18:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793931853; cv=none;
        d=google.com; s=arc-20260327;
        b=W79hyUvtW+XRGF5hEPt63s6pl46IqMiQwUJ/EO13wBkWqTtnyE6XGRBZT43bis1JlF
         HhgkE/tG26ZuNHQ+9Kh7LKys10M73qua4gXSqu58U6F74xMJJ5oiRP1KnsIgrKzUtqYZ
         UufcHgF1EI2Ryb7Du1LFEjnfZ2FDsCr0a79bLsyk+NVGt29gi75k3h31VMGeZkgPflJn
         mUmKbZj0xb0sysQ1KHWDRO3vp7YFWb6wrAjag9TU+syEM/RT5tXk3CHcPifL2WLM9uov
         5FskKzilR1tqS8oj7idbtMFiBrTVTb15LjDtZ2HHvk55UEBemDXb6xMR7kwNNZsxogE7
         uPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Ugtj1Uw2rabVbTscYaPUmGxT9EXsnqmeQYId8bSE0Q=;
        fh=kOd75Fg8dCdktO53kJyMBU34sY0g2IFizw24oULonyk=;
        b=Z9Ev+PiQqQbeY3FrqNVzEy6sZ21bFP/vXQaiOhfL0TeHLVPANAC5kPS9Bxs6l1598O
         0TW8qU+vFQeTarZvkF8ZwMvVGwMMpKQq/3T63WY/Wfi88cscmhA2nL+iPfz1yfn0CsCa
         3T/LeMRjVtf3kgsJWCnzfPO9ejQ76zJn5fY2cxEuLJd6aOkhfLN9rmaJm6EZTzR1VdHR
         3r9NGjDLBg5uYuc1sLX6MVWbKK3nLAdjgbLvic59YBH+xuxsEbGjSjpPVqVDOTIaj7a5
         MTuzfX+7OCbvhjwQBSM1l6epEH+njP3l1M571u6u9gFqI2zW+NPe1s42bFFyRzHpU04e
         2Jsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793931853; x=1794536653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Ugtj1Uw2rabVbTscYaPUmGxT9EXsnqmeQYId8bSE0Q=;
        b=LY11YBYCeWWof1YFWAWAzfGu+sKDz+EoowTfBNUiGpU2YsdcEom9EPD279Dbyvqkfb
         JD9Qq+f8dgUeSIAkqPWkuCpHeFxA72pOMfrkHrQly3o3LiPge26ao2tWa5+4WBFyZz8J
         CUo+BSF2EfABPozK/IWqWtGf7CUKO+PkGYnrh9hPoM1LJiH/CgCOtRW9OakPGTsyR4WJ
         jTk9wWQ3wp2kFA48sNm3Vz+gwepvaihLkE6f214tDoqWfQnDmGlcKWG+9rHcZZAyZZ1/
         4NtbtZT2qUFo5GNd6JaHUWvjLkxxT3Vcgq+uuAk8j2XUw0sFCZKqrGjXSoMP8hLlQqfM
         A1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793931853; x=1794536653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Ugtj1Uw2rabVbTscYaPUmGxT9EXsnqmeQYId8bSE0Q=;
        b=UXmXNulMeAHWmsD++SkA+JgFrputBdMKLSUTOqpzwZiXGI8Q7OjZeWIyNOxfxpfqFB
         pVJkylspbl0NWgCVj6EG1JZ7Tm4GvUFPCr4JAxinszBO8vt+q1reOFUyKp/0xRIWQbiz
         7cmUoFHI2L6SQvwadSibw5aHw7Wjn3ySUBmPWXsFygrS4mQ65+gIdFqqD94jIX+nDcye
         zGNUESqT3+O2HLlmlnu/h4UwMl5s2Y3IEyRUxDwc0frAjDn+GX7YMKkHjyzr/Ovpje98
         7bM0vil+h8Dcc+NwgpIwNlMpB8jK1ORn/TLljDpDuxu1T3m14VrGX10MjsUgX+jtk7tW
         kxwA==
X-Gm-Message-State: APuU4Z9G/NlrcgwNOzZR26dSN0BGk9/ByOHfnzHXa5ujUQ+Gzbvxb0F1
	bQ8eAAg6Ivm7Ilnbh5EhzRkKzV5I49V9An3bOxW0eunRCL5n743FY5EEmM8yb4+4+6otndscP2H
	s1qpeXAm8PTeIOxOGHWBxg3bdMMX+Vkop1U7qwbgq0K5Og9wpuZW6gyaARIwh75+w10W5Do7C9v
	yEtuORTPHTD5k7kcYwyeUIWARCFOmcK7VkgzDERg==
X-Gm-Gg: AYBFou2+fERqy1MdJhPsKaTq8/CXM9RLkjp2RzIcsyswRBP9QLkFNb15qEwQN+CJ6We
	Yc3/m5JFask6Grcic8xrxmASHCYC6lckDrWzWJOne6WkrzYXJ6MreqPap8aVIE8nbl7Yf+LxUD/
	3AcKA3C7kJMmkcCfnpxoP4oviPIDZgVHqPYBrkrQ0WCbItmHzmBvrAirC3bQ==
X-Received: by 2002:a17:90b:5410:b0:3ab:5832:727d with SMTP id 98e67ed59e1d1-3b0db6e7fa8mr1028648a91.35.1793931852742;
        Thu, 05 Nov 2026 18:24:12 -0800 (PST)
X-Received: by 2002:a17:90b:5410:b0:3ab:5832:727d with SMTP id
 98e67ed59e1d1-3b0db6e7fa8mr1028623a91.35.1793931852347; Thu, 05 Nov 2026
 18:24:12 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com> <auyUXp1Fgk2yC7fZ@debian>
In-Reply-To: <auyUXp1Fgk2yC7fZ@debian>
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 10:24:00 +0800
X-Gm-Features: AclHuK9Rpj-OrZYtfA6ZG0BJAkiaIq_2tj00BWz8R6NqylmkPXjbVoBwgnAlwNc
Message-ID: <CAFkd8hu2aLp_MGbT3Lt0wv96sUQ705fBsaa_sn3P1_XUuruKYw@mail.gmail.com>
Subject: Re: [PATCH] PCI: qcom: Power on pwrctrl devices for firmware-managed hosts
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com, krishna.chundru@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, deepti.jaggi@oss.qualcomm.com,
        yadu.mg@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Wrloji03pIlpFtfAap6-zK2KEWqhbHyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAwOSBTYWx0ZWRfX6DbQte25Rgvh
 R222V4IvCreU7t2lw+UQZzYgtwhOrQhrXUjWJ+eoEioilkLJzJra0OanYH01COleBjBnlo+7jEP
 EcnStKB/Z3kxL5w7v0LgUdix0VVvRyRHnSUOuDhic14dcM2DfgqQMs9B6nH75fxUmdB7+MGLYtH
 0tx6EKldvDp0Jhoe2AZ3OKV57EJdvepHYqw1Ef2YqcnEtE8SsPaFyOcKlnpgBNxg4Rzk3NUyB5i
 sU/KMRmJpIVbqzSK2BdF4DbYBtToCVGDkCgRPD1U7hW9vQZ8RRNEuCnaEls6OeNAni+PVtjtQXO
 pXprWhSaS5faYo6iKcxLoHBVeNsbsNuRLlNgeDQbMfDauGXpj96W+V4YMU1IYYO45Jmk2ZN8+u7
 lM584sIaz8LHYaHiUf0DjqvpG18BzG4UPA6sQO1TaRFHq7GlnpT6K2XKUS8HUeUFjG2B/F0ouWe
 CuiLfvq9n9CS2odhK5w==
X-Proofpoint-ORIG-GUID: Wrloji03pIlpFtfAap6-zK2KEWqhbHyz
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aed3a4d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=zdetyYl-RAO8K0uE0e8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAwOSBTYWx0ZWRfXyTsZJGh9k/P0
 U2zSm/9Dyk3PYUcwpoMiVqGdwcHpsoljICvTol6x/PtJ36hwJme3nJtKX5F93p4DnsNg1K1pXCA
 gMXGc8WrGZlbR7DV/1439CIrJKyQ1po=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060009

On Thu, Nov 5, 2026 at 10:37=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Thu, Nov 05, 2026 at 06:15:21PM +0800, Zhangfei Gao wrote:
> > commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
> > on/off, destroy APIs") switched PCI pwrctrl users to explicit create an=
d
> > power control APIs, but only added the calls to the regular DesignWare
> > host initialization path.
> >
> > Firmware-managed hosts bypass that path and probe the ECAM host bridge
> > directly. Endpoints already powered by firmware, such as NVMe devices,
> > remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
> > such as WCN7850, remain powered off and cannot be discovered.
> >
>
> NACK. For FW initialized platforms, FW should power on the Endpoints befo=
re
> booting Linux.

Thanks Mani for the clarification.

  To confirm, for a firmware-initialized PCIe host, is the platform
  firmware expected to perform the complete board-level Endpoint power
  sequence as well, rather than only initializing the PCIe controller?

  On this platform, WCN7850 requires PMAU0102-E GPIOs 6/7/8 to enable its
  power rails and GPIO10 for WLAN_EN. Should firmware assert these GPIOs
  before Linux probes the ECAM host bridge and keep the Endpoint powered,
  including across suspend/resume as appropriate?

  If so, we will drop this driver change and coordinate the required
  platform firmware update.

Thanks
