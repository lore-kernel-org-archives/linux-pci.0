Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2C2D5925;
	Wed, 14 Oct 2026 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952336; cv=none; b=ZhGZJ99KXs3EWzogbX97WGstqFhByPuchJw66YRScfA9WzYy9PUt+bzA3ExhJLIQrPm3IZlUcc4PXRRzuxDARcXep/43uty/EwGjGQxM3be6B2tCa/MtqQblMxhLnG7+f6jHWqDw7ll1wQdngImZAbWTeYiGElv84W8hwBlGdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952336; c=relaxed/simple;
	bh=8+58wiOo43I2iU82vmumknZjOd7wo9z7euS8go2Lzxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqcXDD4UCcRos8364fPFW+2mazpZJFK3s5qd4++O3WAEKRwV1FkIilstFfO1yw5cYHV+9Ks+ifOjR9s8CVi0jPacgd3Pa7sMdbDB31SwMCD41tRffwW7mjP1tzWy0lBcsDJsCtmWYB8pWlE7GZtmL81dtsvHVCttfMR8gYCH+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=AfQk+Haw; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="AfQk+Haw"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E428hh1545680;
	Wed, 14 Oct 2026 04:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=8+58wiOo43I2i
	U82vmumknZjOd7wo9z7euS8go2Lzxg=; b=AfQk+HawqPAJL8Jy6C8TlDllXHGMQ
	XtboD8xhP9jpZ5bmx4tsu2mNYJihZ1m+PQSrQn9fUAhZ3KVhmyyrGUZv5vjQldye
	2pdbBtc5+LrqL38WqxAUbOaRDkWPGfn0YnDdq53PEa8Y0Rft7LU/hrTe4dksZ1BO
	5ULHd33vqCzS7jGVWdnXWGf5nsj6xp/WEEfHLdkX3ZVoqRu7KpHA5wsUQJxNz5Un
	psthCu/Nf769f965s4bIHC4/MdHzWNFS8Lk7cBnjQPCQ8JCaH923YKEJoJIwpQzT
	8ju3uaoZv+Ht4dLid45I95GpPzWtJI7wQvOITncU9zRDbSO5h6Zb2St0Q==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4h9vb0mfb9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 04:31:53 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 8B2BA12B65;
	Wed, 14 Oct 2026 04:31:53 +0000 (UTC)
Received: from localhost (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A9DD680045E;
	Wed, 14 Oct 2026 04:31:52 +0000 (UTC)
From: Keng-Yu Lin <keng-yu.lin@hpe.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.liang@hpe.com, david.chang@hpe.com, s.collins@hpe.com,
        jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
        zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
Date: Wed, 14 Oct 2026 12:31:50 +0800
Message-ID: <20261014043150.1094480-1-keng-yu.lin@hpe.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <80c964e1-30d3-4b09-aef8-08c04e119e79@amd.com>
References: <20261012104645.975190-1-keng-yu.lin@hpe.com> <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com> <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com> <20261013060957.1023448-1-keng-yu.lin@hpe.com> <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com> <d11aa70c-4753-4a28-9955-990c45649677@amd.com> <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com> <CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com> <80c964e1-30d3-4b09-aef8-08c04e119e79@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JulkP84C c=1 sm=1 tr=0 ts=6acf05b9 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=NPsBfiTOBCC47sjfuuIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX6tLCr7jutP4j
 vocYi4QbYunmJznLKri6L88923yHnswUsq4D5OfqNt/OHBtgBdTmB5vd7EkDi/75wAjjTSa1qOc
 Umqwx7RJ1FMHzm7DP+opzj9bRmzPgffcr5+sP1jWz69skNHGmi/wIhWzphGOAA4kZUCGtCADmSD
 msrkW9f2flGpp1fPQSocpaKCsVI8TWYsHrb8MoIy75Md5MiqVImnQhVYJmZ0on4rAFEYQL/Nl0c
 NyIdKmv8ILcNMkAkCbYUteF8YtaFIEwfHkSdzzOVfy4FtpRqDjpwOKkkVv4pR5pASoOJNRwrfob
 AoInzS0SMT7N3GerussoHE/uUSLssjQleA8X9s83i9KoBY0OP/1vSjXWu3eNQ8aGA4nZZY2sr9l
 wsQapLtejfBJU0DQ+iCE5pbw8AVQ6lDcn9557FuSt74TXngh2jnlJ/0cHcX1+5dc7ZNPD2uUwlU
 jx+IYBZKoNqkAdUatug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfX23tSs7ft0hh+
 udftIeBSSOkuo4Od95GeIAiouBG755OjCS6SK0B5CO+T63lR2kuSGa9Oig2tBJZRBCm+17ZCGe1
 YlsdZW9sANqps7wXA1/jWt90y5tDW5w=
X-Proofpoint-GUID: dZZOWu_SzVpTCl4Pypx3qFGIeE-nhqvb
X-Proofpoint-ORIG-GUID: dZZOWu_SzVpTCl4Pypx3qFGIeE-nhqvb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140017

Hi Rafael, Mario,

I tested this sequence on AMD Venice SP7 and Turin, with debug
prints added. Both systems saved a vmcore and rebooted successfully.

There were no BAR writes from this path on normal boot. In the
crash kernels, only the cleared xHCI BARs were restored: two on
Venice and one on Turin. All readbacks matched.

Rafael, would you prefer to send a patch with this sequence, or
should I send v3 with your Suggested-by?

Thanks,
Keng-Yu
