Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0D329371
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881637; cv=none; b=YAIz+3bbUKm820B7x+7N/iYkhTm5vg6wICm4Y6oIxqO7ydDfvxlj9O0rOV0wqP2+GBihhp8AK1J1DdaiJigtCmjoD5h0RjfP7dpqWH5771Dt2/0jttdckSnCxTIx7IyfGXUm2pBxCBctgif0deLMQ30VNo0ivozd6WyWC+6XgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881637; c=relaxed/simple;
	bh=dMLa2VYP/PqPEUcCpyM7jnuBrS9W2+TKtxxruMHDuUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RJN57bjsb2RJ56ksf7Zan6nuVG0VFMUwKNtsGQdqfas0dpQTQEXeNP7NFVk+lqGSJdT5Y/k4ow+rV6jptZ7fV/Hmsj95X4K00gavNrEalQcbo+rAwSH7/j0nkInrJZkrZRisBiExWeYeEJOv/kb4rB5kYCHKwKlXGRpQjDxbC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDOLbHxF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bgG5CsLl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDOLbHxF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgG5CsLl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tQZ83933552
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 04:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ypUJVco4RwGJyHpVc41I03vkPMyV8IAN0BOqiUBV+Yk=; b=DDOLbHxFgi84nH1S
	KFU2Xmyq1/y7uqjr7zQFXvT/jmGiXMgTYjeTB9bJNd9fF9q/1zZlNMUINyjm9QM5
	leOiOrIeawjgLamAqK2vpHUvWg8DuvHPQUfJU/qTRTeXVY/mrny5infY0kBih+j9
	yiyFBobMkE2J0iYjQV4fg99FxC2TxaKn4O2PG7AiJtxbsBI8BFR6G75g7p6sedzI
	1x+VKD2BEymCZDU8nQsVlkq0hRGXmxHl68RZO750EY6r14HdH97jtg1zbv5FYDW0
	xoRmHzG6fq+7zU7DqejXa9GczHXojvOd245Bx8nvpJuTDBbXLyRbB4JnoiDkzikl
	6sc0+g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0bb5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 04:53:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30eec544cc2so1030350eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 21:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782881634; x=1783486434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypUJVco4RwGJyHpVc41I03vkPMyV8IAN0BOqiUBV+Yk=;
        b=bgG5CsLls/0hq1ykxHUqOGoHGmsrn95HcA6c8ml5LXczACvHBTmt4Zuf7vS3jRNTBe
         nIedvHDfQQjuryzZ74q14WUZDlb54ojpiBsR+pimrGMLunD42bNx0X0tuuJjbP3j0Qep
         5kXmbU6h0JlcvYfiXp6rTElUFJ2bE4Hj4xQy5mAejq7t+9xNwotH0nAmjTpBukzci0D9
         /f7Y9P68FXmojNDACo42qfwFn7cwuctpmI9UVlILldihf4SbmB9B2ehd7sTPDs9vKqBr
         0FjFGCmvn5/DloH4ARea+JseL811MBE1kj61P9Y00slnH0qG/j4Jqvoa0H/5huXqYvUz
         Femg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782881634; x=1783486434;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypUJVco4RwGJyHpVc41I03vkPMyV8IAN0BOqiUBV+Yk=;
        b=bx0nqW1zJ1B/6PJhiwbeL3x7uVuEirKPSnNRkxMDG9HG6cJfqSCd/HTgFpQjGuOVQb
         FIV/7OnA/Lhwoq3DNUb259Iksf7Sk5cA2o/GoKBfPNObyX9ddR6bl88V1JUChD/aZS88
         Zx5wAsVDLeFtFTdAhm/9r7yBZYjc09kVXFPoud46Mk2RphZJfy2vflzzp0RZHVBEIGro
         CJFBUh6Qt08y3q4G7mPHup0kFy2QP+8sHb2F3WaDCUDmzjR9beqdU3Pg7xxNgJ1HFkpi
         s7Ji9s5vvhCljXt99FPGhDd91rFGJak9DM3ZNdhRfkOc0K+iP+wMBsCoRB92uCO1Ws/q
         whnw==
X-Forwarded-Encrypted: i=1; AHgh+Rpq/TEplx2+xH84CibqQk1yOsXVptt8mzjnMLXG+LW/2dQ6HgKuLFFW6Aw63AbzjvEjp5rDDeWMWZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOJMAQGYQcGYVpnBpP+3lkULAZarvAgguamsRbqAizvo1bVWZ
	J9aztESKgVKwMeh9+SYpqK0xhtUWjQAJAI9dIFmHS4sTf3y2lyfrDHxhZ2ird4pnrwV5WvAWntU
	IRFlEkE+8P0ZeblYMeRkGnOGNveItvhZig7b10pYtxmeHxG7GMbFqF9EQ5dRKdLc=
X-Gm-Gg: AfdE7cn6m1GNAf3ispJVN6+FuIPw1wEt4Z6SIXPrEyIZdDR1FnPM3IUxz+/Dmgf7BD5
	p8mZ4jjnRupNSea4drI3lO4oI9h9OuD6UpN1jd78hm5rCIybHEp8mUr96k/W7+mPqygf4x5isrO
	NaD61EjdCaNnM3oHJ6z/SuyyvdvNAjEjWPaef9yAExwuGIOY704baqNTXSel796ELejwu6cRLwX
	o3EEI5AfZDhIQzpkYJY9JlVetNTLlNbS69hs2foR6ZsQhsU/kbLzLX25qTKqlAuZ+CXYbfsSppH
	zXexqN+oe2rBnVwfiaCDcX4Jbbd8aeDID/dqLWez/w5Q410Ea4nIc38d2RGQK2nabwKY0lM9saf
	rTJRQ7KaSZj1lLZS0J57yjPVdcaWkRA==
X-Received: by 2002:a05:7301:fa10:b0:304:e2a5:689a with SMTP id 5a478bee46e88-30eff2c0caamr156974eec.21.1782881634386;
        Tue, 30 Jun 2026 21:53:54 -0700 (PDT)
X-Received: by 2002:a05:7301:fa10:b0:304:e2a5:689a with SMTP id 5a478bee46e88-30eff2c0caamr156895eec.21.1782881633117;
        Tue, 30 Jun 2026 21:53:53 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2cd21bcsm29818457eec.0.2026.06.30.21.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:53:52 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Sherry Sun <sherry.sun@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Christian Bruel <christian.bruel@foss.st.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260616164049.3656435-1-arnd@kernel.org>
References: <20260616164049.3656435-1-arnd@kernel.org>
Subject: Re: [PATCH] PCI: imx6: fix building against host-common
Message-Id: <178288162893.308055.15975539371195000505.b4-ty@b4>
Date: Wed, 01 Jul 2026 06:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NyBTYWx0ZWRfXxKvJXqm3ow89
 yYiHb0UuTcgW17rfzqoGBShpiFlRE1qerF9Ti/j8GUcUiLAiyrnhQVFP4sYYuzyjtYp+ZSNo+rk
 HTJDbnrUvdCeSQKbc+J2Ex8nX4fJKUdPi5o8n68jnBiTQOdIYpB7YVeC1/IO0GRGneTochzTTXG
 jxKNNrvVzoD5HOaxLzi2xJxITza6mg9629rOHYD/xehRlqMoz+O/srB8GH74o6LLcKsZhvEzV19
 u0rMdeaW/CwsSHeEK8EdP4CvO8BMze80FDfG0iOQdyUi2vAlPz44pE4L80IVKgTOUrUx0Ngd5sZ
 tqQgUBxJMVMxk2pRYG6w/YWboCukbU3SyZGU8amd9+kkygsOZzDBr0qPzlRYhMa1/9XA1V/zVmQ
 Q927fb4PBxkpU8QoqbvZHnqo4W95UZ2twaV9Awj9G29l98y9uHrORIFpas4I+V9fqBs+02IaFHn
 rbWEfl8nJZQq3ogAOmg==
X-Proofpoint-GUID: WUouJvfwqxfiFajfvsEOqw8J4kjiepLq
X-Proofpoint-ORIG-GUID: WUouJvfwqxfiFajfvsEOqw8J4kjiepLq
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a449d63 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=CXayKEnAXEfI6EZxXbkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NyBTYWx0ZWRfXwRcF3v5io9q7
 MXkgju7JJs8ndaF1fmrOjafvHF/NNDsiBzu0aL/NgHbjWq+AE14B86bigjvqxTQYd//ATAfPf4U
 OFLwBk+EDLyanZs08HJy8rkIrwnzpA8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010047


On Tue, 16 Jun 2026 18:39:59 +0200, Arnd Bergmann wrote:
> When CONFIG_PCI_HOST_COMMON is set to =m, the i.MX6 PCIe driver
> fails to link. This can happen when only i.MX endpoint mode is
> enabled but not host mode, which would indirectly enable the
> host-common driver itself.
> 
> ld.lld: error: undefined symbol: pci_host_common_parse_ports
> >>> referenced by pci-imx6.c
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_host_init) in archive vmlinux.a
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: fix building against host-common
      commit: d4e0984f12ea958e0f2def90ddb1e193a896932b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


