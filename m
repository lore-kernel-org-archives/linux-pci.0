Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD729360EC6
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161498; cv=none; b=DkGyOpoz1NKNmeYybQ+8VTy2LwMHaDjvVZ0+GOl5INmfikXNtz9nAz+1zUJaMBXCTQKHRIlzE+pyvJW3Ap+UulatJxUvSrB2uvand6OZqBhISDjyEwLAtUfJf4f58HplawKS7Bkj3xYkWbdJQOVSW8K1Z93n/nnqs9zGbC7aRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161498; c=relaxed/simple;
	bh=95mxRjDqNTSHCLNZakezlDqZtrlA+TKalrssjKS8WJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ig5uoBkX9hCVw/jDrGTppGdTY5rbnR8M8DiR2mCrTCHhTR9Rv061kZ8isl3M/aKjJpWslddBuu2acWxO//ncUMlb695jguQOD+1UTOmFUrEwGFky3RaJ/HxFHnqGPyKhFYwAxM4iW/wdJgwbOgFTHfuRoSuoP9aSQZXr7TAQNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kU+H7l6l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mal4yl/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kU+H7l6l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mal4yl/u"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GLV43761291
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sTlQaU514TZh0I9qNLZMQjnA34MxvUVMVmFRiUuR5z0=; b=kU+H7l6lzNcVwxq+
	N1jKAwWKju9FhE+1NOVZ3vhGDfWErQHwcj284ovTkHdw8n06Jy/bQUAR295yNBhj
	7UTd9v9dUEj90G3xb9ABbBkeNUskLCAVoQi2tYq5n5rqcD7adLydTCQYBt5RTYY0
	XFLfhUG9VKkPZmQSoJR58ZaZKl4FTDnFDi+dd3/D6CATmudfR2/bjsrDDEc+IeKz
	vQMy1ezSi0anMHRxMmNojp7R4imRnmvszUfEDel5TdffTb/+nCk9apozYyFLm/LC
	eFPN5jzPLSewG2GfI5BoFk8XVLfveFH3osL9HCtP2bL15+mikiHDYBs+2hlKSWD8
	uoeFZw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sj682-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:04:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36b7f696b40so4704988a91.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 00:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781161495; x=1781766295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTlQaU514TZh0I9qNLZMQjnA34MxvUVMVmFRiUuR5z0=;
        b=Mal4yl/uVj8H20EyRmAHAFl6AThw5bDNT3K9b+2d7KfDnmGU6wGKF6m/VxB/NbFlqr
         L/ZnwjNSA09tItO3rI9Z6g3SJ3iEtDmjNhV4Ny/GJGerBYO8ToX0pcrATn601bjBfB+g
         29maCwt7UiyMaVi1BN9lwA8BYvPkIqBNToJgv8wL6tafvcbVH0+LvBs9rkQMwp0c+mgP
         8cDTCJjvzvjqPKTs46Dr34F5rm8XZCVC4RypREcOyqPTYzb39Wgbcpj++d9C5Yg0syhe
         zHj1uWsS0/wa3gc161FqVjPzDIGh31i4fBDIJJse1yY2LLPOqp3tCqyn2pdJiBS8Oqtj
         WP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161495; x=1781766295;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTlQaU514TZh0I9qNLZMQjnA34MxvUVMVmFRiUuR5z0=;
        b=Y+Jtyhg8YLBwS4arZH00+prhan3z4q74WtskNcTf6VqwhF2MBpSFS20g0suAc0VJHZ
         gxNkR8y5KccvqLXXZmPkwQx5vPUSgrsn+ak+x+a/8STO6WdP5GF0qwl+sxpiulpMwh7z
         LzdIjrm7GN5IzkGFG7DImk/QCeNdlrb7NrGZlWL+BASNQgxZgCg95lXp5gaYYFPDlDQt
         CQPqViRvIMx0jsq/+AR+6U+h1lwQh0/fcPqrL4QlylOa+grl8K1fECuBCCZ7E+0hQPNn
         QoO2IHpB50+sI3pkI4U7NsRASWn8/qzJUW8/RK2+wrEzDFUyHyng37GuhWiWsSn3g/oz
         W8yg==
X-Forwarded-Encrypted: i=1; AFNElJ/u9MugeV2CK6B3HI7+vtWfZqUzOsB6qFcU3xkDE1vanR3n2h8sqa8jIPKux36kq2PmIrkozwb1WMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs93PwcGvpXzGvEBKwUyZ64fQX7am615fMZuni6gIHinzMOsdr
	7laeHB4tfQvkTfarhBT8VbHEp34MS6UlOGoNNqnmJwEvwvxDkVJrvBfyrD5l9fMqND5HZgIA4lw
	sDFrRzI042wiCSHleG5Taxn7Qtii12PSLhNU9wiXQvfoSKdjsstM25s9cyHNM0D1GC/peVdQ=
X-Gm-Gg: Acq92OHORQ7uuJhK5vrwRcM2f8EVKKxcmIzmpwvVccd9+/3IeMWFFDI9Xdq4g67N8fd
	BqFYkm1E/St3FxpTw+qfF8oIMlZbk3BzslUgwnP5hWN06FaETJ6dZF2GVmrphavw4nUhDm2W6oP
	dq9m0rdq0hbyvogwoU/AI0KAaDWQu0Bb1P31veEiDyaGv708OOUO8kVrnhxwZF1WdQ6ySwqJOoU
	IDRkwzHmJBZGx+vA30a98oWjDM1gi6/YzAQZOhTk2jaqWFp+hYKhdWe+90cst99FONr0jECs6MB
	3c4kJeOnlRc8YjSvGlQbcSqr3aAKHaLf+l4jwZwmnjQsrVXowBMjZf7DAaz7FuYv6nGTzp6zWCF
	pcfXuJ4QFxVeOntV8G1LGuqrIuzx7E2I=
X-Received: by 2002:a17:90b:4ac9:b0:368:78da:803 with SMTP id 98e67ed59e1d1-377a4bac7cbmr1783026a91.12.1781161495444;
        Thu, 11 Jun 2026 00:04:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac9:b0:368:78da:803 with SMTP id 98e67ed59e1d1-377a4bac7cbmr1782996a91.12.1781161494892;
        Thu, 11 Jun 2026 00:04:54 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.195.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843383197e5sm919120b3a.52.2026.06.11.00.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:04:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, a-garg7@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260521161822.132996-1-18255117159@163.com>
References: <20260521161822.132996-1-18255117159@163.com>
Subject: Re: (subset) [PATCH 0/9] PCI: controller: Add missing rescan lock
 around root bus removal
Message-Id: <178116149168.6097.17122011010784833278.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 12:34:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2a5e18 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=n8UK4BQKCdfH/t0JQ2luxA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=voW3oXjDJGY4xtGQt-EA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: WhY3tvxBO1zHheetijI_cQMpNpYYuR4m
X-Proofpoint-GUID: WhY3tvxBO1zHheetijI_cQMpNpYYuR4m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2OCBTYWx0ZWRfX46kQ4Zrqe74R
 zw3E2J8lbLL7p+ueaWI/VlpbH8Z2Dj8luj44DpzL6VBkk8irqPVnxDOdpEF++e4zEsdOJR7Kqur
 3ecCnSDsNj9jbtOTmWZh5uBtOuMDZnPaPVeaekEqWWOlG4XSOLJyCGUxV6uYv4Z4Deb2CDtYCGA
 1zgs0s/b5Mw5tMVovLVkvjHJ87HgsU0gzJGYdIeMtFECLTjz2xndsfF5O07TSnep7+f0r4yMjcq
 on69TvKenTOh6FoqpvqBi+j8VXjmoybWYAnzGOSFc8bJ8VkXN01U/i7eqeMqGtmtinPApYDtIrs
 wL2IOwBydn+VrAZIRJ6zG5RWS4BqMif8aPiTjCW7axYS2EixES3FcadzYasEoBHSbakdnmMUgAh
 lTDFbVcPIYLaRzuJNBjGwnBVDbiqNMgvIB+MJHtJWLDI40R8YHVv1TDpM4kY04W97XGlyYTuvX0
 izhFCjKrCRCHLAC8guQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2OCBTYWx0ZWRfXyEpUyjer9Cfy
 IP91C0RV7mj/zyEOLvTI49ICFsGJNCtcvseygAeyxDciVKiuMHSMvmPTPVDJh4kifN2mRyIMfEN
 XRxAkze3Xtwp4IQteJdhi4e45aXhhng=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110068


On Fri, 22 May 2026 00:18:13 +0800, Hans Zhang wrote:
> Several PCIe host controller drivers call pci_stop_root_bus() and
> pci_remove_root_bus() without holding the global PCI rescan lock
> (pci_rescan_remove_global_lock). This can cause race conditions with
> concurrent PCI rescan or hotplug operations triggered via sysfs,
> potentially leading to use-after-free or system crashes.
> 
> This series adds the missing lock pairs to all drivers currently
> exhibiting this pattern. No functional change other than proper
> synchronization.
> 
> [...]

Applied, thanks!

[1/9] PCI: cadence: Protect root bus removal with rescan lock
      commit: 3bc5dbef170b1f715f13102fce22a5db921f893a
[2/9] PCI: dwc: Protect root bus removal with rescan lock
      commit: f47cc36e63dc9b8f20c3404c701a7aed105938a2
[3/9] PCI: altera: Protect root bus removal with rescan lock
      commit: e2557f2705760101e794ba32a08586b2ab35deb2
[4/9] PCI: brcmstb: Protect root bus removal with rescan lock
      commit: 435c29e2af6aeaf1e115db179020ef0869cfd205
[5/9] PCI: iproc: Protect root bus removal with rescan lock
      commit: 95cb96f6693ffc59a620379d74ab6f0efe65218b
[6/9] PCI: mediatek: Protect root bus removal with rescan lock
      commit: abd23e96d429551f92febd7f5d4a9a63d75c5f74
[7/9] PCI: rockchip: Protect root bus removal with rescan lock
      commit: f4e77bd57d9bf799bdfc125644838918128c0537
[9/9] PCI: plda: Protect root bus removal with rescan lock
      commit: e94a7411ee6d3c81039e960e9c92dcee03699031

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

