Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3887390609
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115563; cv=none; b=eXXjbTKeyFrOjk93RWaAXb4UO4rNN/RfQ+PsR0/0nG2o9QHe9g7VILbdLx85GqNwOIiVNCxoXO+cu69f59D6NwwZYo0EetWzKTjkLRuLcb6unpFjj1da+CSLxgrgl7fPTPvaEySOXQcJItoBjC5Xo5Rc2fU7KjZBUL08O0TiBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115563; c=relaxed/simple;
	bh=3WyWG7mlJmk4dTS9WKu8lTcjWQLyuU1B4DkfUKS3UPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO9xe+k7wmvwBh5zVpVaECmYOBFw/OnxfV90iVG/9KzFvqErb5pKg/g+j8AbrtFKl9+JgznjcT5aPTZXl2BcN4SuPWCy8DrKq0iOVwe9RKLqGaGTz8a0U+hZPqVjjomfjTH9V4LaHiXXFo/Z4AyTDs8td4Pmk8d7wOfKPhi0wxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUJZMN8b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdLFDeDo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUJZMN8b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdLFDeDo"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59CVV3786638
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 08:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	63b8/Eyb31YE8fxcYSbZ/UmhGcOjsVSMSWNSmeAo0+o=; b=cUJZMN8bweLcdOP/
	mkdL1tUu8YH+jdj9Xg6gCtK4K5UG/DI6suSBe7dBGlBUdyUgMrgJeML4aD2WrGCK
	gx7Fp8w6la4QLXrKnXjHJRbl/Fqf8M1UVJnLeCG4+Kv65xZBD8LsSt2MsSFgE22s
	H4f+MA+yFXhPS7mUcjrxiDghbp5Zj5qG5zjnBpl1+6cA/ElFsne/C4Ft78uMf1ip
	PpA3vReL2d/x6hkWVKxZ48chi3ckCjgJAUhn9ADLEEfTEIIe9cdQw17EBPksMRwf
	Z/v1aCRSbZmpu1yq7UQ6gWgsPr0Jfh5jgS/igTpPmy9WPWuZ1eKkWXhu8Yer7mGt
	rO1RmA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewkmed9w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 08:06:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157f453a27so656958285a.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782115560; x=1782720360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63b8/Eyb31YE8fxcYSbZ/UmhGcOjsVSMSWNSmeAo0+o=;
        b=LdLFDeDosv8WEUolSNmk4sXC4J008urb/meBhPCyFArpaWmnKJQkXl3QdstMZQYfhI
         kT7nLjDYExcuUdwc5A5hnJYCrvlQnyG8xD9vlFydmHO6tH+qTimB/G3+s+SHnljewwAw
         W93v9j+5fCfC4CkEb2SVZX8tRJCrWjySVW3nzd6D4VyxlomoXCo7c6oFqIwOpuBR8lKr
         0wDgPmIGH77dsLE1dyecOUBsqSFhWvl3tssXMOqAzvxwXN4nr46PzuCgx2lMrr+wsRXt
         cxQjL4Knnu7qquEgilxyI1aVx6MsJ2vCUvfVF97EB6TVViRr+80gBnSZ3vN8+UxFqU9J
         wM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115560; x=1782720360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63b8/Eyb31YE8fxcYSbZ/UmhGcOjsVSMSWNSmeAo0+o=;
        b=BvIzAFlsTGDvXq2PlrqPG2Iiv5J14QB8+VgjdkHS99+d39pnpWd28268Sojhk5/xiV
         5Y2iDSGwViLUWmV4OuhqpPIlGuXogPHgmwTM5hFA35WrMebKxCLlr3VrEC3mR9mZMzte
         wGKKroc1mGRbN4e7CDoVz5hWxtQrgbvpOSgKqXrD2KMCBeibz1PxoP576E1jH/aL7ZC5
         XVez4cGj+nlC7aCmG207Pdf0pSZ5sFn9rTFyzRaY4hjxBLWIhAm+LxQkb5NS8SvIWBvu
         vcdoICL7ZZODLAXaGW3lO6lxhDJw4QAE9uo0ORU7770neYFqjl2HewgYa1dfA3CIYHBW
         1Ehg==
X-Forwarded-Encrypted: i=1; AFNElJ8733t5gDPC/5KNUqC74dBM3jA1FtCGgtrg9n8bPfscHzB1iJ4noHZlYY76CWt3CDObPgAasc3mEk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfl/ffHTvAlfPdWISORhc6XNB3lk/n0BLLu0pwY7wSAcqhlaQ4
	cHVxpgKqSgH11XLdCixVPQTmC2dEzpLR2izMZJIpLJ4FwqHeeUiJhv0kGp7WFW6i6+Qk/SXUpMr
	XRTR76hBNT59hFW1uJOTcwvCYVxs1B0PeXQ0TYNogHWjovy0swrNlS4vM4pQoTfk=
X-Gm-Gg: AfdE7clJYLYnq1N4b9W6uzqtD9IC77nM2vyY8yE4/fwB65kB9EU7raEZNCi6KUYHzMc
	QZ1uLWeS8xMum43iogj9eoDgsZgCB3OWHRLiPk3Hr4WwZ0Y6nCnL+hYfHVL+Fbl0Y5y4RftcM1q
	+Th3FxZigP2ywHxgU4irEbJIRCFmNbV8pCq5tiSAhA4H46NtFr5cqKVic8pz/sKg8Ipk9VWGHv6
	IzPUXzW9ZST+pWMIx7msio2ViZOK4s98un1vBkdkRlb0y3yM1wdjlPr69WdMfdBIFAtZQYp/h8r
	jK+vp6I81D6RB9xyZZyrv/ut9JziH3+u2EZIfzZxpFb3oNZwLgvg4PT59JEzcoqawRCDstVrbEN
	f6rFcJUCvl/+Wga6rXgbRTrwoNoSDrZKqRQ0QjTM=
X-Received: by 2002:a05:620a:4483:b0:915:d322:c47b with SMTP id af79cd13be357-920d1611869mr1865544985a.13.1782115559924;
        Mon, 22 Jun 2026 01:05:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:915:d322:c47b with SMTP id af79cd13be357-920d1611869mr1865542085a.13.1782115559267;
        Mon, 22 Jun 2026 01:05:59 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm24040371f8f.23.2026.06.22.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:05:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v2] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
Date: Mon, 22 Jun 2026 10:05:51 +0200
Message-ID: <178211554552.11059.10528035877623470920.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
References: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX22D4NxMX1JRz
 v9/jPnqbwgXk7tnwGRW3Pjf8CdWclEDedJJR0urfbmcxKMKWgLGT1Ssm5h60ASPvuaynis5PBD/
 J+Qt0lgczIVVx17xTA8ie+aVAXS6YolUWrVAU9NsAdvId6A2y5X1ybc9BHy/3VE+9nIXk/5SDoZ
 yVM6ztvdYmZ9cWZ45kBECYWudx8o/4H97dgwRvkJL8QMahcL2UabFywfjtV8fdDiIBYOPhZtgLr
 95B30yV3Uj3vKNmMSqDzSnO+s4pbueEeb8KyZFS3wuvo1NaI1CCmTQJS3F3Kh5rusJWQzj72Ob5
 iWzMK0yAjjEitYK/uF9mhKkkbH2Thi0RNsBZPZE2OOc/Xr6djGX1UOVMbRUY4i8LaTacnHamjDN
 xNIDJywEiA6JVU8w9OVhkZxBrQXbN0wdBdgmM+sW2Qwk7njMGVy1eLwdfuuiVK/8T30LJ19LzVF
 7jipxFLrLcR8ZNSngGw==
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a38ece9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KhnnDi8VfUj6Ww44RVgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 6um8o942e4RogYpKWXmTEsDoJiLyJEGF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX1dG34h+xsf2V
 O+cdVq9RDzrhhJT8pqKhQ6KlM6k2UmUScF0gTqcl+1BkX0bVBs+WDXIverOdILiAbcYwvLiU4ha
 YWgUt0TiApYclPvr+a3EnmZS6wqgMt4=
X-Proofpoint-ORIG-GUID: 6um8o942e4RogYpKWXmTEsDoJiLyJEGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078


On Wed, 17 Jun 2026 20:00:55 +0530, Wei Deng wrote:
> Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
> 0x1103 (WCN6855) before 0x1107 (WCN7850).
> 
> 

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
      https://git.kernel.org/brgl/c/251c8e86539aefa88980b3dccee7d8ae4974af06

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
