Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCC22A1D4
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878399; cv=none; b=i9jU82M1ybnjKpYhUqIVbwt7GA+nwxIZx2g8lCoV17/JP5qq1Mqu4M5qBWvkqmxGDfll5YD711kq28QDC6+kZaW2HNZPQz80YarcOsSQs/Yw1rXTW1D1S88DJEqGYAfvy7EgIFR06tTc64loyWR3lJYjl9PYKTS4XSNsIjG4PSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878399; c=relaxed/simple;
	bh=95gzVVmt+pw2w1ewq3IbkhXHmC7ClllvwdDzT6KAVs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwS206x0x01LQSjBROnMuCfPrXYZouIgUvyFOjzdASmWyLeGNFBKJJjFAUosQsbqNu2PtrB5Yr28mJofvem2tWUOuz+WeLSL4czMxhRCJPjW9UsHr2b39yO7rEC1Thp8Huc3v3TbParoaVC95mCElWLsrtl8mfRbvsxBveZpviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7L2ScIl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VQAOH+j3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7L2ScIl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VQAOH+j3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DNcv147384
	for <linux-pci@vger.kernel.org>; Mon, 4 May 2026 07:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KCWGn2uzwamB2rWwC+/Q9KFgMXFAeWM7XXqwwI7+OpQ=; b=f7L2ScIlzgUsnpyR
	VfiAY+btzU06ihT9wy6Bci1LzEHY7s61RGfpJ53JPMrFVFHpQVYR0oH/oBskIZ/8
	25xCyzCnD/cRUoXJOeGts5uvW/GmGxo5aUwYCkgiwW38Sjqu6IoUAEETcNX1Hzg9
	1YJw0HrXG/7OYfbWR1rOfgSsgILeAPMSewfoADdhDSt0uklFxOYgokZW5kS1f25K
	n3vybFNrOew5sK58srARoN8cQ8hGiNb153gQ2HCizr5h2IJQmiu8fVE95XDvcpye
	A0DLHw+Vup9CbRNvAB16k+rvDmRWXr64APNXIxpTjx/1wizdOLnB+Oht5LNYFGwG
	Y/leVA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw8uxmq3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 07:06:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36514eb1194so2877409a91.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777878396; x=1778483196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCWGn2uzwamB2rWwC+/Q9KFgMXFAeWM7XXqwwI7+OpQ=;
        b=VQAOH+j3S5KNAlq2IPA77tRDfC5TWL+kyR5ykIRP2cayFvbl+vcOtGhPvQynjzgJ1B
         Ol6enwWEr3kA/9qqS6TKluwAzLvT68SG7buLiH8CLt7HPGOsOocW21LqQjL2iFu1i30R
         /G1mSewzTjV8Af89AE4teJ3CwIl6jKifaYtZDzMkzH/pRK9X808zHjVUBcVKxVmX4diq
         ITWb/VvmlCiyqPifbRpay+Elzwn0SjSBWCVpMBFWNKBCdoCCePGJLmGAtr/anaU9ZiEm
         /W0igFOsKI33E2nrfrkXYhh2oNXFeZPZRia9JlohCfDanuLGwINVi9fEun7dVy3iDlOx
         t+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777878396; x=1778483196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCWGn2uzwamB2rWwC+/Q9KFgMXFAeWM7XXqwwI7+OpQ=;
        b=dEp0v7ZsLSSIdrc0ZTQ97cFkhjYA74dHoUChCd7FiQUNrH1Lp3eI9YI1UMcACcnpZN
         +/2uL17QNlZiCaej7k3PAzLUK3WJ1GM1F3PyuvNW6ZXpG2i7igsHkLHC/OfK/hyx6dye
         K355lh2LE/0dMVGRPhdtk6N+yN3yzvRLN1uZTXID3xwF8cLvRX+20WZyTcJPFXBYEXcj
         /o159lrTeU7TROpIWkwCb2h+0e5SOiTcDhhzZ7kj0bgZTbrNBZZKeg7D4Zq5l7ihCN7t
         W+7Ifhs1D0R/VObqCPKfFLxZGahv3X1o0MpYlouL3vE9m5TjprvW9Es5mvenRb/1pmK5
         SHDg==
X-Forwarded-Encrypted: i=1; AFNElJ/pIHAzOqWGhRfpf13V5dWpYSHLqbwlGXeSn18xiWiFY/DTV1iTz7z0k9hCUjVrkwbk3sjVKc8z+bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuP2514seNXCxjMQ9GO2UvD2JtDPSCt/tz/zuY7LiSEtLQHww8
	+ubYmqwPO+C/s7924ugIJCS9Y5vxyjqmtP9vEqXRjcdSwihkAFnZR3D3ORL6lxYTAxaF+sgjo2O
	3ed1PdDYOHlMtdk6ecAffvTI+TCrFFgd3TwILyUxOuForjJD41gZe/jOb9nzIzdw=
X-Gm-Gg: AeBDievG1QKgxzzRRmM95dECPMm1d+azW+YnQxiD9hvq3WY5Ko94kv0aL0VReUvrY8n
	RDH3n4LBrjYeTffhxrU9V9SdhFUppJhMzVSHnYLsYzM9JTjbXVYggxid5eqUwMljvUaYQPMpa23
	VIqCbHX2+Zcq6PC7/LvFUzh0HyZ/BUqyAbZ/LnXm0OyH6sWtZ1C8Iw9xrE4bRt4bKa09xvm+npD
	/4U9sBuQJADDFR2VRZHB6DqscbNoxy0i5qWl/R8moYOn5DdfRM6/3yV35VpZ08ozg/aCmrwxdpD
	0yJnUm/+uWgR6rswgj5qhkp9F+mSIcOdm73vOPxDi+XtKxHh12P/JwTuo27QZZwmRv3WRs8hRU3
	2WExPuMOte03VKEIGu+TrFOT436kSAr1mEQY/mhXOYgdJtkDnGabBWFQ9lsRb9tYeiQ==
X-Received: by 2002:a17:90b:35cf:b0:35b:e4f8:7b2b with SMTP id 98e67ed59e1d1-3650ce8ef42mr8906528a91.18.1777878396366;
        Mon, 04 May 2026 00:06:36 -0700 (PDT)
X-Received: by 2002:a17:90b:35cf:b0:35b:e4f8:7b2b with SMTP id 98e67ed59e1d1-3650ce8ef42mr8906494a91.18.1777878395886;
        Mon, 04 May 2026 00:06:35 -0700 (PDT)
Received: from [10.92.193.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be00b175sm12883779a91.9.2026.05.04.00.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:06:35 -0700 (PDT)
Message-ID: <ffd59407-c65c-4f99-a587-3b968f9c82c5@oss.qualcomm.com>
Date: Mon, 4 May 2026 12:36:29 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCI: qcom: Add D3cold support
To: Steev Klimaszewski <threeway@gmail.com>
Cc: bhelgaas@google.com, bjorn.andersson@oss.qualcomm.com,
        jingoohan1@gmail.com, jonathanh@nvidia.com, kwilczynski@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
        will@kernel.org
References: <dd4dc11e-338a-4d13-9830-095a93187f4c@oss.qualcomm.com>
 <20260504041407.289464-1-threeway@gmail.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260504041407.289464-1-threeway@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i9WtOW198gUUBfALxJ6ZhFhq0Bis1sO7
X-Authority-Analysis: v=2.4 cv=QqxuG1yd c=1 sm=1 tr=0 ts=69f8457d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=oJpzRAQ81oZ_FtZBIQYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: i9WtOW198gUUBfALxJ6ZhFhq0Bis1sO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA3NCBTYWx0ZWRfX2cuocv9ctsKB
 BVuexseHM33AQlDgzXEz+mQ22xZX8AOJ/N0npgTkxW5Bi0o/X2szdKhP8pNQ3wvflAD0mZ0LQ0f
 0CS7bklx+xf/VHyyB/u/vV4ZBroh82GM0P8A4JAwLCWJtnpcNL/YL8cVqRNdQio3K2FXTYP+SY9
 VlSSBRTxIQ4vmJftj9Si5cWRQR11gdLqyZwMxArK89vcfXcGsjFB7PvGTPKQkx6tOCALq6W/kAr
 5TKvCI2nllyXTTmkbdyq5nucYmQF2WUPa9YY6o6g4EbaQrhRt12WcSWXiFh6BdVS5K+pM6xdQQe
 5fP3yEcCDzRabKMAE5XwzDWc76swEzUax2V7S/4LKf7zONQeO5o7LxVI/rRD5/9EeWrBfaC+INv
 +qyDXiL4n+GXf/kxAM8kx7O+n2K0kauT36Zmqc8wZMdxBE93LnKXlzbSYnKFf6egJHWCtnzMas/
 634GjlBEQLB3luMlS8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040074



On 5/4/2026 9:44 AM, Steev Klimaszewski wrote:
> On Sun, May 3, 2026 at 10:37 PM Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com> wrote:
>>> v4 of this patchset *boots* along with Mani's patchset, however, v5 does not,
>>> and unfortunately, the machine does not seem to get to a point where I can even
>>> get logs from it.  Do you know what I might be missing?  I have *not* attempted
>>> to remove the nvme drive and boot off USB to test it.
>> This series, will not have any impact on the boot, this series comes in to the
>> picture only in case
>> of suspend and resume. can you share your platform details and kernel you are
>> booting with.
> Oddly, it seems to, because if I simply go back to v4, the system boots.  I'm
> using a 7.0 kernel on the Thinkpad X13s (SC8280XP).  The sources are at
> https://github.com/steev/linux/tree/lenovo-x13s-linux-7.0.y (with the v5
> applied).  PCIE_QCOM is built-in to the kernel.  Not sure what other information
> is needed.
Hi Steev,

I made mistake in re basing the code, can you try below and see if that fixes
your issue.
I will send this in next patch series.

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1327,7 +1327,7 @@ static enum dw_pcie_ltssm qcom_pcie_get_ltssm(struct
dw_pcie *pci)
        struct qcom_pcie *pcie = to_qcom_pcie(pci);
        u32 val;

-       if (pcie->cfg->ops->ltssm_enable)
+       if (pcie->cfg->ops->get_ltssm)
                return pcie->cfg->ops->get_ltssm(pcie);
 
- Krishna Chaitanya.
>> - Krishna Chaitanya.
>>> -- steev

