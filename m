Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574136B05A
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263305; cv=none; b=F0KiRSkSu+HTXEd3xGLpKrD5cbsKOp6B9A55LzBF8tVbmY47G5Z22ZXdWIq/albZVIehdeTw/1cuoNfMgOojoAri62zDEB8He8+1RN+GPRNsSQoCQFH9vcFhFwivDYekbcTDxd7NhnvNVCqy3cKR6x+qQuBYTteZ1myFbFkU+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263305; c=relaxed/simple;
	bh=KToCkKdMXLnoMcD1O0mEwf/a0xSBLAtGfGNwySmGtEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jL4hHdDd+zdIxKJ+CBnVvVpbUUNAtndjH1+x0tJoNd+3PZYFwgfXWZVq0KNtJN5kBbl99NtihMsCrCOR7bZiAbfegK/fMms78nJz1OiD6oUxWN0CnPJjfAfRcCvxKPTZWy5cQv1jNXza7EAp8DiIkPRXhIceMnDD6dmk5pkT494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RB/U0NDW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IF1/ODr+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RB/U0NDW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IF1/ODr+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S6WdVl3590937
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 07:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tgBR7QUXG4sl2GL755Z8Q0KrRPuVcewAQzJ
	Zk9kcF6Y=; b=RB/U0NDW4R4U/AVku2saiRBbNK6eLiuVrsw1JmpBVWUVoXnLkqi
	iJqWqfw0s0fbZRhj8wgJGN6WK2rh159eVXlgIW7ILqC31lzJfIW70c3eVnbTrfh6
	ZiDeJiMJpgK/vArxHwCAzaB+VtsaJ7W+FgE8B7aK+JcYaNiizPzxSu5DnM6z5tDR
	idINFY8UlVcfI9bpAljLJ/QxYob1m44rpvSKvJGLPz0kvn13TmpgPf7Aq9mmXtD8
	gYGCv7pPXPWJJ9esbjwKT8OvU1D3vaPtwmlVvmpjJivByKBkzo9J6p7IFiYc2cw6
	W7oxmNU766fNQFF8X+jxzcCrUFu7qUl6r/g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6gc7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 07:21:43 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82743548918so1988556b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772263302; x=1772868102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgBR7QUXG4sl2GL755Z8Q0KrRPuVcewAQzJZk9kcF6Y=;
        b=IF1/ODr+FAHsxigcfMI9s1ZlPWVa4Gtakwhkq6wFTogqwBOvRm3qQkr8JYqspQs6iy
         BQLM10cmbr8XEgq45S3gjsqrCPKoKZpQQcrtboBWF2IncAXHOPh/uDNWV6k/D1sIRG+f
         dlYj7IV2nVF1v59uBxeiAbvW1BxnK/3sFNHi4PZJIQ/EiaFOJgu4wI/VxN5H22tfbkEo
         PeHKNuzc0mjY06cfltxY8L7r9Hw0ULfvUOZSoUuvcPELuRmjGB49flDUv2Js4M6NrzNA
         ckuEKLXtMnH1nqqNLYNcNJxcRPpuknnPVcPTiSlBFt4sEvJdusF22rgwOik43jnna5+j
         FTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772263302; x=1772868102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgBR7QUXG4sl2GL755Z8Q0KrRPuVcewAQzJZk9kcF6Y=;
        b=IwOl2m9zkU7o4VgsfUF1oDQ0JWsdTKtbQk4ttFfTegaxWPfBY/9GtOtXfD4OdFR1AX
         h5sYCSBtlEW7vqUS3c1xs1fYrLEQg5j4og7LANUtG1mspQDt73RjnYEZmT7MgDNhwZ1d
         5AQ4lvw45tqSxkK8fooWyC00KIwAIfny3aWHlgSBUvWhV3t9NlM2ty9TgqXzGUf4qDTv
         a8FgYgAacj0Xwkf93AuCWFbVjMOiysW3jFrlgzyJVLmB3g0VdVpAoytX5c+SF9WCwIKG
         XPbBfkhAoD9b93FuSy58mKI0F4WZmJ/tucfbY8kySdn1it4+D2K/Q3oXFM4YKGZdIrrf
         3h8w==
X-Gm-Message-State: AOJu0YwiZD77qmKgl+s1Gt1Po0jJ2sIVUlVnuCy12iZ5LfRPmuwehZIa
	E2ZwWCPaaisGvxxZj4gXtL0QdHUyx9CghlM29nfNVuebpUQLBWDvmB2uWwb2vewKeZZTAeHDU0K
	rfUe0YlRoqV9KOuDDCL3nzMrgrBhtAwfTA7BhqG0F3FieccAniXTU0ohcGUu6Cpw=
X-Gm-Gg: ATEYQzy9P1jw+d111rUgmfsT9MuTnVOa6cWYqLWV561kabYD4IIssH9jTQ8fh+Qr9GL
	eOmaipSZo7TvT72NNmkuwCfO7dEgB1aKPLWTVw/IUO9BzRNVGBd8KGtGGC9wUqICtnToJ+nSrGz
	y9ELheOf5+h1/aiX6z4eeLikSCrl2gnDvnPlSbo/Na8v9bsttzxTWtysl2sRijUH8J+IgKqiYEi
	3219L+esIk9kbmfEeAUZIdQVK/vaMuS0te0NYEJNWE2V/FCm5riArtAWgSMTdM0yg9ciZm1EmAN
	ACd3dSCaY3UisuCtryV4lPwpUva6lNj97npwbV09oYrnIz9QzGHBKS/k/TSSCfbyP+BVU7DNhlX
	7DgCj0sFAsjiZGQrwsOrYDXAOSBXRFAq6AS6RV1wl24/xHg==
X-Received: by 2002:a05:6a00:2e04:b0:824:4a22:ec02 with SMTP id d2e1a72fcca58-8274d9e62d2mr5050052b3a.42.1772263302188;
        Fri, 27 Feb 2026 23:21:42 -0800 (PST)
X-Received: by 2002:a05:6a00:2e04:b0:824:4a22:ec02 with SMTP id d2e1a72fcca58-8274d9e62d2mr5050032b3a.42.1772263301585;
        Fri, 27 Feb 2026 23:21:41 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:1e32:bdc:2454:2ed6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a048615sm6946659b3a.52.2026.02.27.23.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:21:41 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de,
        kwilczynski@kernel.org, mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Shuan He <heshuan@bytedance.com>
Subject: [PATCH v2] PCI: Remove redudant call to pci_proc_attach_device()
Date: Sat, 28 Feb 2026 12:51:29 +0530
Message-ID: <20260228072129.10445-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QkLf2TIV5fx9cRY62NYhxAohPK2-4fRV
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a29787 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8
 a=k4fLOqHC652wtFX-wEMA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDA2MyBTYWx0ZWRfX/CXk4NJdXh5X
 OglylHVJ+Ykx1F3uEinEp1NEr62P8Pfc3YiZigmXF/OVvJfoE1eIcJr2GpY99JKZQfNf6xHE0bu
 GnhoB90voYzkwA/N9B1cKMCoTNQ/65MZ8ZaB5p+ABgy+KKPzqHAdhlZT2uF1zyfsjxY0ta3p4SW
 4mBRitqtIRtWkJX/JZ11b9r5034Sif4y9+DOrVkcOkOv27Yap14LBQdEMD5aXdaNGb0oqrhy3Bs
 LlwptHtGWWyM6Rr78DwZG+lPvXPANPdXLqQ0TE72xjhcOoSYQoEe5TRQDWUvgJFT0gzncX+QSYX
 uTJb3dgQTkA/Le66rMtHTNPi/OkxaOERoWKKcH9tfogfPiuNIkXlJyVwVEBPwWaEOsOSCAQfL79
 1xcCwfVMO+/n279MhnXSUxHP5x/sZBnWuZ81u1ueiC7aH44fAkGV9moEVaJPfTpu5dhW7Bnx8P2
 LzrqJPPkDmX6mk2CR0Q==
X-Proofpoint-GUID: QkLf2TIV5fx9cRY62NYhxAohPK2-4fRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602280063

pci_proc_init() should just initialize the top level procfs directory for
PCI devices and let pci_bus_add_device() add the device specific procfs
attributes later.

But it is also calling pci_proc_attach_device() for each PCI device. This
causes a race condition with pci_bus_add_device(), which may run in
parallel, calling the same API, leading to the below warning spat:

 proc_dir_entry '000c:00/00.0' already registered
 WARNING: CPU: 2 PID: 179 at fs/proc/generic.c:375 proc_register+0xf6/0x180
  proc_register+0xf6/0x180
  proc_create_data+0x3e/0x60
  pci_proc_attach_device+0x74/0x130
  pci_bus_add_device+0x42/0x100
  pci_bus_add_devices+0xc6/0x110

Hence, remove the call to pci_proc_attach_device() from pci_proc_init().

Reported-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reported-by: Shuan He <heshuan@bytedance.com>
Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

* Dropped the sysfs change as it is supposed to be replaced by static resources
  change.

NOTE: I don't know if there is any reason to call pci_proc_attach_device()
before pci_bus_add_device(), but it definitely causes a race.

 drivers/pci/proc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..de894ae70e9a 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -463,13 +463,10 @@ int pci_proc_detach_bus(struct pci_bus *bus)
 
 static int __init pci_proc_init(void)
 {
-	struct pci_dev *dev = NULL;
 	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
 		    &proc_bus_pci_devices_op);
 	proc_initialized = 1;
-	for_each_pci_dev(dev)
-		pci_proc_attach_device(dev);
 
 	return 0;
 }
-- 
2.51.0

