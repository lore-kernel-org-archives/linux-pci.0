Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803D377556
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928514; cv=none; b=c0ruRYEVj/1ah6LjKJSZV57lR+hBnzaZtqlT8+eIdz5n6GgEYeGEivVUQBpum2nDzSIm2d5Li7Uvob3CQceENo4Cs8Cr366k2A0w8cW9yfnkwu7xdPOSdLoKPPyHqPn0OcFnLn6IP2JkrRL6FtmMdNV+wRoFL4mJRw7/9RgC/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928514; c=relaxed/simple;
	bh=uEjYZ/XehFsqLbbpv0XnDNLQoZ+JPk8zSm65y7wR6G8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tkSPVMhBMVUyf9u3TI7ssY4jKsyp93V04j2QgOhfSMDETOy21HV358/FZtT2uw4Impde1lVZMehxHhWvWCi2w4VuVDWCDyufs/IKxClcYI+YBVealRTs27Q2LGVbGHsMEbYZuRN6RR517PQ0a8w5jCw0hTMuqcfrc2PjeIL2e+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IU7LbsuO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iSptsw8l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IU7LbsuO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iSptsw8l"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFWkL057231
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnZs9JLORsd3/5S5l0NT2vH/Yh64RNDPIyuOJI1p4h8=; b=IU7LbsuOrDD0PFAB
	Hmq6GZNfa5uFbdwXz0+W7DLjsr/PtH4fDxLfiliBo5fK9xXU9TW1IpW5u2ZsCDQV
	59hm/J4BsayGqnzAJN2c6v4Gtd+6pB1y8uFPofRfMDNccp//pIxsX8Hq86ND6mFt
	llk06gYY1kgC5oGitRxUJR08iVNU5YIKmbp8E1BrMoaswSvlk6hhuOUxvz2Zg1A+
	cA8MVAtyeJZaTbbg362rUuMt8Q1gV6ZdZCQeYMKrQtKP5BfpyT11B6GZbDe1nvK8
	SJYBgeBc9iExryVKvWLd7LsPpKn0THyWI2Kn1oEgnK8XeV6JlV4+SGE11qHXybr6
	C/hT7Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch9sa82g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:21:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35301003062so39508972a91.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771928512; x=1772533312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnZs9JLORsd3/5S5l0NT2vH/Yh64RNDPIyuOJI1p4h8=;
        b=iSptsw8lvdlOAIx/Hp62goy3QHEmZfjDL7IqCANr9sXrrEejbTmIsYsMTqkHFueU/Q
         b5QdAvT+WUoOMnuTuH3LclTWJZ/5lb5fVhzbxZ8NoegtneqAL4xd97XCTiAXx1SOSPmk
         FPcWGpIiO2NIGmkIhj+9DbVBybBuBAlYgJFl/Mi+Y9Hj3IUkl4I228Ov5kmKJfn4vtEH
         k03TMQS7MvzstxaO7aRK5ZB+kINZFGU1G8So/FxE+gs7/uC38lXIEST1tU229ZLdIpjU
         vcypDeLPsjKizAnou6pIHs2BYLoLcNMC+it1gfos2PQI6BbwVNDQO6dM1QRVfyBNSQec
         35Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928512; x=1772533312;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnZs9JLORsd3/5S5l0NT2vH/Yh64RNDPIyuOJI1p4h8=;
        b=I0Ymll4QXgNLz5OWXn6KWXWH0PN608w7kG2k9xuCKsajQ355wymDiyX4qMao2Vq6Xt
         w27MYCYJFHgG2aiKJ7D6VKzisgvqXr7Qse4NnPAtyjhUuEWLDfk8yg/pxdD5l7ONCscD
         vlOrcwPlcuEmkTWJ6D4WHXhDP4hYOeBPmqUagS6EkkGre+7pRLu4r6y9bxgblfJCXpbE
         ClS6hRFhrZNrOZ2hkFIbFb3MePmWFdKp5w+WsYvQEBGFSHzh/mr+HjUlWDv5lhtEvvqD
         XsvSKcbTlCfGBfwyOFtIceS8WOAyc7zPferTxO97OG7/VbseM04VqdJystS5bCvsBy+b
         rZ+A==
X-Gm-Message-State: AOJu0YxNF0cXhxvhlQ6FneJldOPzQdHkMx/vUiJrjXux0BslFwHu6QPA
	GkPSwAN1ANjlxPBFRcG6w1I57Octyx7To/WQFb8yiMhWApolUJlSePFVhHxBIVU/7xV7FvtG0BQ
	akj/1RBpaSFflP5/StZI96vtEPP8v5FJCmovJRJKXcTHOCHBfC4CiYdaWMA/92CI=
X-Gm-Gg: ATEYQzyQZm2QjqUjkaPpK8nV6RofMX1ckGLTSgiwJC4sAHWfguaNVM10kQmImbTGB6M
	TCVS1uT8PcB6EcQEu7sAWYcFSUGBPDIMQX8zxSWAlbA+3Z0heOHpIaYa800oOIdyS5ma+pXpMcU
	fWeL8+10SVraDJ8BvGxtE3UMZLgFeqTalehVdZtsNit43fSRzq69LNjN2q2hVwQ8QomE1fbVMiK
	cQgJd8gqib0xtre6BWoaqcL7gVELSu8QiJbac1SdFZYO2nsUkwYvKCX2Qg+bZWqikmp5Hr8Imzq
	2LaYQZd24V5HbvYSq5ir8aA/QANX+hT6PKrhP8e3EjJvZjliE+2Ktlfig87N2TCYKokjk38Ks8o
	urNinh6eA/a2P0Ix7Wy7cn+E=
X-Received: by 2002:a17:90b:4d11:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-358ae804f90mr10156748a91.13.1771928511824;
        Tue, 24 Feb 2026 02:21:51 -0800 (PST)
X-Received: by 2002:a17:90b:4d11:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-358ae804f90mr10156733a91.13.1771928511229;
        Tue, 24 Feb 2026 02:21:51 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af701c7bsm9605940a91.1.2026.02.24.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:21:50 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        cassel@kernel.org, Frank.Li@nxp.com, Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
In-Reply-To: <20260217063856.3759713-1-den@valinux.co.jp>
References: <20260217063856.3759713-1-den@valinux.co.jp>
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Doorbell-related fixes
Message-Id: <177192850650.7284.5708606131647741554.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 15:51:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NSBTYWx0ZWRfX4eUYYC6f5CDB
 fIqpGqmJliugtwbHN5d7l3fM4pXgN92Cocoo4pU28esV8wnrdWJQufClChpf6tXs2Nv9epmhUbO
 Pm3Ksx6cbZ51eKQTb9qalX2VawT20T+4g2V6AkP9suwhvNnpMpcwQGVKVMc/sgNx2g4+IwybN6z
 x2/YnSSjGcMLjddRb5OKzPG5DIj+vD3B+ZsjCqmcVefmxRxWrs6SN1AmfKVQdBum9Pua7OV5Tk6
 dR/lqLqmw63+LTfTx0fvfHLCUXE2WoxoE8OPqnrkjy6/cFeYGVTxmAzI7Z/zJ36EmN2dN1gDcAn
 odi47CnMV4YVGh+7CSAIsZ9TFAcmrqvMYUKWfMbLvKOQ3/sGQLRN2tM72surKy+78tS3C1CABTI
 HqToEnN8tp71eRCBlCChU/hzky9XqP68qwdrJleqC9q8SJOEH6aYNR2M8wHZESn9CvZn18IhA8F
 RZVhh3kSAfUHh8i7U6g==
X-Proofpoint-ORIG-GUID: QB_qo-mcGREue5b2dlE6uC40PfMVjgW-
X-Authority-Analysis: v=2.4 cv=e7ELiKp/ c=1 sm=1 tr=0 ts=699d7bc0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=GccvDg418-FT051PfnEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: QB_qo-mcGREue5b2dlE6uC40PfMVjgW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240085


On Tue, 17 Feb 2026 15:38:53 +0900, Koichiro Den wrote:
> This is a small fix-only series related to the previous (v6)
> doorbell-related series:
> https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/
> 
> These patches address a few independent fixes in pci-epf-vntb,
> pci-epf-test and pci-ep-msi:
> 
> [...]

Applied, thanks!

[1/3] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
      commit: d61ad1bf4cd447f023eaf801dd836ce2c8d579dc
[2/3] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
      commit: 18b1650d6850040ebe7612504b9cf5e86dd48d84
[3/3] PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
      commit: 53f49de2df2790db085d1ddf3a2251fd7b1d960b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

