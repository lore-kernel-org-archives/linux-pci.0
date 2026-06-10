Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38A33FE15
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109457; cv=none; b=rvN+b0Xj/fke/cc33SpYWkwjUaeJRO+QPW/Auo3pN22014Wr1+YH0q1+pVqFcx8yFwgp0nrSQ8RuFNEybmLTlJgyBrSscqODzB85QDXqoJjDOPkZtOgEYq6MD2MuhlIEOCI9a4xe3sgKoJPpwClLCMtFACHX3UeiUkxv+vKOurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109457; c=relaxed/simple;
	bh=ENNw7YEAGnc/LAU84JitTes1YFDalSce2sLjj833HZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SzQqNhrsrSRkV/9Dqe79fkkmKnkx/tNQvf9gUVWEyiY/4fOPOgurWXPBKjQLvgg4a29mTuRL19w+vmoXyWcDs/yR7VHfSWzfE34o4wjT59e2w4PEVDsAGjh0e7erUVlLG+1ytXMLT9QLEHnlenj9WJ9PDFZFPMN1khVYNDswPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4xagzc9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iJXRGNdy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4xagzc9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJXRGNdy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AFwqhM2042139
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S8RdfqWX6fIqgJGJX0i1xNJBu3AEuSVVWlXThSE8IHo=; b=A4xagzc9pvh6b6XR
	u8a82yCMorY4laHnLkyefbMSHAgI2dTzEEI6FamfpOhS6YJSmPvP9LiwQoCcxe4z
	QNCn2FGPbBGlpIyrwusjhBYj6q0dO6GIBcuVxqFAs/znTE3BBx07CwD7tFcdBdY6
	FznLzw0PmIx/tXAwwxdM9d8dQKvlKAOMdk8gypZXTJOZIKRx9O1EeBQR9olLF8MB
	MjQbMUYG1CwFejfTRvfG63bPXhH4LRtlwp+qvsfQSJrUUBKFGNIqhGOcCqOHeu6I
	/jlQ3LWwvOCtb+WKgLSlFKPEgbcOnNSQQ9qHL3Af0ml1UZta7yTTdHoReWSjQJ2A
	tCXftw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epukev6fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:37:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c20f7581so73517755ad.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781109454; x=1781714254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8RdfqWX6fIqgJGJX0i1xNJBu3AEuSVVWlXThSE8IHo=;
        b=iJXRGNdy+e/e21eX6vk/65jA1nNfXoJaN99dxOGXOccCktMCXqhnnk10lK1V2iiRk6
         d4S+Ad2O3oafeWpMvCngdtw1hUrUCV2x7btEMru9CE+sfDGNiAxTgD1wQga7kn1DYxNu
         2j5bURAm1lohfUqwkZfLAGJk1Y+O4/B9WQ6mIBaV4uNHjcZV5S7tbH21U770iiEQ8PeO
         apVb3mYpOEm68McnHZeJqo006fQHqo8AzInNI97kOwhdAwtimv+8vmUtqmH9aoEHk4nH
         ek+6P8D3znzN8YSBSC2pnNQ7kTlQNljDQbbwsaztxJhR89wvE6DHQwPdehpEiyk4ngWx
         e8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109454; x=1781714254;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S8RdfqWX6fIqgJGJX0i1xNJBu3AEuSVVWlXThSE8IHo=;
        b=Yb3JcFoXWwOYlCmtfOGhrOleKD8vbm1XNtQCDuO07oEG7ltxTC47Ga9h8UJ9XUC8um
         0rNLW10xLYnAzqvnb9AUs3xfMpwAcjtz1Za6MJsW9f9+zAX399MyRDvlGy6yiGJnh9eX
         R07qN7tipER8+5u2/LtFgM4hoEaB8fNeCyfWfjB767jCwOS8eYN281ey5kr5HZK+aZJR
         +5hMa8OG/WNoX03IB+ClclLq8PlcvMgyRcctzTL5PFPCWvOY3J9zFVyLBei2082KKPWr
         OjTInYgj4jaA+A+JMdic1n6pohOA/LiWhNiwTVtHqM88/sW6IhnZK1Pdb2U7KdiypBxg
         EobQ==
X-Gm-Message-State: AOJu0YxLKz+DAsqOHOhh7ObMVW5aBsGLwLGIcAomdrqveXb76mvC/oKr
	LI3a5ArWkCSPr7JAJsA6nfB5k34g00fC2qkYVRzBx8POuHX4rVeDHvWMvhDRHIeIshLp6Q37bx9
	pbtoI2FBGIp6zzWxNhJBO3PzLBbjhR+q49FgjP/RdpzD4mHC4rMs1Qe/AFnQV1u8=
X-Gm-Gg: Acq92OGLf2/gzjHacqYwkSBiNufwtwUt2nM5A7lVoShRU5W9TEiaEWVHR4iKY10k/yK
	c1wCZo8AR4w9i0xsdywXsRdC6xe4o1Z9vE5y/8tBKbDFomb3/Ji7ApCwvFBfbTaOgRaNiSbvA05
	j7A13DLFwjMOW2K+SpeIWNsum4wxDQGNlPWRq09GXMr/L/T9GRaIZG1aYAU3xB8sE4qOaM6iK1b
	NTVygoYpUk/k7fbugYz1AfaM9+egWGMXqOaFc/0ih+Qa8MiD0eTzx+GGHVeROqUab1qgxyGIoVa
	YhQk2ASO2qbt6ywfcRl9SDvf3vz5WrAmJzfBi5RXKRDq9iCL2wyKkS6hW/fLHw8QJD6i3mx5H3r
	X/XW/V4ZCa5V3KNHhhzxY9Kzn6ZoUayo=
X-Received: by 2002:a17:902:f606:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2c1e810e153mr300902525ad.26.1781109454156;
        Wed, 10 Jun 2026 09:37:34 -0700 (PDT)
X-Received: by 2002:a17:902:f606:b0:2bf:9760:b963 with SMTP id d9443c01a7336-2c1e810e153mr300902105ad.26.1781109453617;
        Wed, 10 Jun 2026 09:37:33 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.195.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm255605665ad.80.2026.06.10.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:37:33 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260521091256.15737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260521091256.15737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2] PCI: rcar-host: Remove unused LIST_HEAD(res)
Message-Id: <178110944858.12000.2016000239061925100.b4-ty@kernel.org>
Date: Wed, 10 Jun 2026 22:07:28 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfXzOXQDy6yzpLq
 m1TKabLQhsJo1MEUVOT8Js+xB3ZMH9ThgjMHKnEtGrqx9CpPDhtJI0lnphtvjoYCZY8gMw6F9PA
 VhX6vZEDub8RxpzvaNGK6jBXsny5l3EkI02XmjFD30h2ffAMlsMpDpWHJuP/xLsnf6SuQ/FxdwM
 Lvv48A9MU7LD6DVfWSvYJDrRuyLJHwa6JvfIUv19cc5tGh81hwynITTK21AMl2dMIoyRwwUKlKY
 L5fHoes8AQfuwho7lXavtmcYfi11c+HZt07agB0JW5b5VEnbbCHaMHH2wJ3bsHjdYSCOCRx0Kie
 Qs61bvwSI273viZu2FF0F5xA3Lb0DdyvaYu9b2pz4nXGar5wrS3d12cWAkXIpKBtdnB5zs9sF+z
 UhCes2u48hD/0H+cCWJ/92FhFsQS1U0/q5CRteeiSNnxggTwM+3hRYFSE+Ju+d8BMfmRZLquhFJ
 CGOKiIkx9MB8CK+o7Vg==
X-Proofpoint-ORIG-GUID: EW-uBa576dFGyczwM3SD2eUZ8PZplmq_
X-Proofpoint-GUID: EW-uBa576dFGyczwM3SD2eUZ8PZplmq_
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a2992cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=n8UK4BQKCdfH/t0JQ2luxA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=0bM4ZPZhBOE8UCOzjv4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100156


On Thu, 21 May 2026 10:12:56 +0100, Prabhakar wrote:
> Remove the unused LIST_HEAD(res) declaration from rcar_pcie_hw_enable().
> 
> The macro instantiation defines an unused 'struct list_head res' variable,
> which conflicts with a valid resource loop-local 'struct resource *res'
> declaration further down in the function, triggering a compiler variable
> shadowing warning:
> 
> [...]

Applied, thanks!

[1/1] PCI: rcar-host: Remove unused LIST_HEAD(res)
      commit: 6ba90ce2069ae923b0ec787aebdf2d786e5d2a58

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

