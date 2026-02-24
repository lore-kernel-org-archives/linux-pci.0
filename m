Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCD2BD5B4
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929308; cv=none; b=a9+bpxbDWN3eX3LCetpNmR0B4RuDtUGzQecJK6+1CNcaT4AGHWComflhb/SUZzq2/K9NAQbjJKo2a8zjIWSKcs8rKDHWqBUgtg78usdSbxZW66oQDMgwh8wIusXTk4PJGwYd4i4iz4/l65fX4dCmFhlRSy12YQtGqvZVjQJDyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929308; c=relaxed/simple;
	bh=7xEZa8uoAbhMwtXaqyajIqhfNmpR/ZMNvcan+/yRrF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QkL20SHOZn9Py8L/6qc2S8MJWtNu8b8PRHq3e6TLOmZhqj7HALQYrgrXf0qXomR3ApOVrBu0ZFhoUi/zuiNJjWmk2FTHd8zU4Md9Sq+gVlHvTVqjl5wsoOrK8bnQyHaHESiDiEFm8Nh0+5soDxIvEyI5E36DVboyE6bt3iq/8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HS8bdqGS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=am9XrAlY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HS8bdqGS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="am9XrAlY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFVY92560558
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M1UlbTvov6ijl612swotAv5UsQX4AvuOmCO2c8PY7QI=; b=HS8bdqGS9AH/OAK2
	b5+T9NOOiFAWCkH2foE79pNIhFsDGpffpDYs8FLEQ6ml0HRxnQPZOPSQES+44Puq
	5GMogxmSEISYNK7Q4JvxY7BNj1w739g3sLufN03k1nvNvcsKJy2Px0FYGtwqFT3+
	JVAQfLOL97ei+t4oxrQMSpExj+lJaQ7fN52GY4NGncsRfe/rk68ewTaqq1iuNcgu
	tpKglna3LwDgB5H6RT7uh+yutGlXvdIVB3s4lSamNh1qt4lUQaK+brklyGjYXs6+
	lMmMjZd2vnoy1I8JpX3+WLZt1scwsYrCaztC4aw6vo3/rtWxGWIZKrE2Fcjhwx6+
	XXm2Sw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e3937d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:35:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f42fad0bso476144a91.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929306; x=1772534106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1UlbTvov6ijl612swotAv5UsQX4AvuOmCO2c8PY7QI=;
        b=am9XrAlYmiGgydK5KwA+epVPyp0UjTKk7TfJ8g9Tg7DjeAJ+EXiqc1DBD3BHGWjINt
         ASay556I63QZ+IYSWm7yUfn+XSM95FGPSjOdUGjL+aXHPIP9yGdVPNrHwOOLhCJR/qj6
         nlBfaodRGMUGjZoITgUhqfLWJvYVM243L0Qr2WRAcO0UnHX3mucCBA7twA5Pz0sRrdrl
         EUr2izXjiNMenMtkkRaVjkvpp/oMi836T0FeIwrvfCfuEfLl/0+pRkyXy8h4BoXtLMKY
         vsDKKDsc/918jE9ooqBq8ESQjEIRknIa2u2r22/3DnRMDB0bZ/sJ0ao8u4S65KKHS/MB
         o5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929306; x=1772534106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1UlbTvov6ijl612swotAv5UsQX4AvuOmCO2c8PY7QI=;
        b=a2nAon/AL2mb5WyrCR40qYOfoZmxoV/hzP0xjGXYvE/Eu8+2rpf+zKukD66KO4gO7F
         /BsQ6Q+MPauf8rSFgCRudxJMi/Cp5opdJqU5yyR/UhI/l+ICmxSKD596YN3z7qKzN5aL
         E63r/EcvRBDhI/xe5mFBY/ohjLed558SqKXb5KTpvkxuEDEXuHRAdMfGvG/AbKpGu8ZE
         UOL4ZmMxSpl2RYn9Lb12g6idZrafe1eJEE8ARPA/M69l9jVpVhPTWAvew49M1xPnmAWS
         TIPJMvPGDaXScCTHgAv6vYOcSB5bUPwCEr37bI6qPYMSMQ8tBrDOzRNCG4onyiGIcsby
         QL1A==
X-Forwarded-Encrypted: i=1; AJvYcCWqf16yL2MIAcdyP9pn1ATPvyuwt0lulcMe6sFe5tilEL28T1XyKbCuXD/8LJFMoFftc79bm90xiKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEgRs9ertlYR0012Tdgw9Jppid+jzM2OtEk0oS+HT/TJs/zK1
	Ivetxvletsm+SG9H9PD5OM/T2BFYwbKaheG/Zxyrw4+Q+BQ0P9V8QapHJbL7m3h7j7IBFPdVhCL
	zJ7fuMObtluzE2jfH9vYCnTKq/JDuO4Vz+p6aV3h+7RUwQtT5Pnua1jLCHrUUq3M=
X-Gm-Gg: ATEYQzyeuPVQ/YZH+AbEsoLg7t2eVPGxuKzEkugfScpCVxCLFJl5ciqjZ4eVcWrVEKB
	FJfjkcptda2gIVu+JHEcjKlhoNVGsn38NHFR3g56BwbPJWYD81QYSAE55DijA0Q/e1La2Z056Kz
	1248vhnAk2YuyMiHNA1VZQvieu1koNkiMvqxUJrtDzUUelBQsNwDZpaATEppBD4aIFPWosAmqqy
	Ji44QT/n8OWW84BRvri4WdEXq6aEhqf9kFqg4wscQuMIIEq7bl8qGu0Km0wC2YRZr+5h4OfqbkL
	di3bBCAscGp9y5fLHTpde17sOb2rytQ2XxAwTpKQZjUZx4FfN5vo3OWiX9l0ITz5C0pm1IexiFV
	dRHG9v07kqLU7hA7Bo+ex8Q8=
X-Received: by 2002:a17:90b:53c4:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-358ae80084fmr11717599a91.11.1771929305538;
        Tue, 24 Feb 2026 02:35:05 -0800 (PST)
X-Received: by 2002:a17:90b:53c4:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-358ae80084fmr11717571a91.11.1771929304954;
        Tue, 24 Feb 2026 02:35:04 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d78a9dfesm1374205a91.0.2026.02.24.02.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:35:04 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <f1f05f1c10c6caf37dd620fa12f508c53536996b.1765705512.git.christophe.jaillet@wanadoo.fr>
References: <f1f05f1c10c6caf37dd620fa12f508c53536996b.1765705512.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] PCI: endpoint: Constify struct
 configfs_item_operations and configfs_group_operations
Message-Id: <177192930173.12333.7729769734066192636.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 16:05:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=UtFu9uwB c=1 sm=1 tr=0 ts=699d7eda cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=nO81vR3YHEYIzYpkiMgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Bmqky7uqD64ISfuK9W8TL9-VSs6m7COL
X-Proofpoint-ORIG-GUID: Bmqky7uqD64ISfuK9W8TL9-VSs6m7COL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX3w1ZAGSiwOYA
 aQ0yOtYVdW/7CXbNu+UgrSJTDKqe/VcZff62uQR1/aib6ooY8DotLl714WBlwhSM+5YU0dC5zcE
 usdftG/1qSo//oWnd6UgserV0R5XKCGKe+O0AvqQv3uQcBBDYFxy0naZXIuiezo77F5MHq2YHFz
 KobUhaMHP1fe1zsxcxuXJ7CmX4jxDLJfi36r0+Ul+y5mjpg8564xw7wmtZuSXADOAi0xT2P3M7W
 Fcej7X88UfSArMP5KNOOBmxmkz4QIJJyj+mYbfBH235GX5pWZWk9SS+VGnugetV7yPHmaatGxsH
 KU1jPp5/jfmAPFof3TlQyE5L17Igy2E/41EfNBDt1/T08oghGYgwNgUXuKrf84T+vU/8BEkue4T
 hdz67bhCcWIDhGqClO2JgMeUKMmp7R5tUqHz75K3amvljcDeUaOhy8zNBkcBeBwYON1Q0P1/Np0
 zauj4fI60Nnf/lq84JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087


On Mon, 29 Dec 2025 12:13:29 +0100, Christophe JAILLET wrote:
> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: Constify struct configfs_item_operations and configfs_group_operations
      commit: f457c18d7904b22f8b6a9c6475161810085c34c9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

