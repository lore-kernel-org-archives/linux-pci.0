Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0FB2D8771;
	Thu,  9 Apr 2026 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704023; cv=none; b=Ifhm52uxyl3HbUeg8+3HZO2AdurBTOdymHtq4ocv+0u+kHyxv6HoMLCogezGlmXS8dI8a5dLxuWTiMV+EUgktidYesnpuA5BlqIZX3hmlI/bzpPNd1/dw+8lLlHFzSIhftP89uDObsgnPcBEA1tHQ0jOkogACL9ISOPKUgs/lCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704023; c=relaxed/simple;
	bh=vgcs+s2hAEj0KOk55CwsWzOvcDv7IY47IEQLXA4ZjbA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4FwUmvrpG7lqGFftW8JQqE/ngYslixLdKucGXQYaGKZJoxU9qAkuEG9yCSmCbxlnoXk/NKi+6q1aS/7KQ8WMFPbM6mpk+f9OJqalWInV6P/ELujsToB74SuPFojVia6PNO6Jm8vQQQs26/sOfk8mm2fLoP5qkwMypfLCSJLKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lUHZnTcY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lUHZnTcY"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NZmMc2130827;
	Wed, 8 Apr 2026 20:06:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=+d9wGmw2K++XBVxY0LsPVfDGY
	1UPJjiLMhPwIg5M2MI=; b=lUHZnTcYme/O7re5ca7So8Gh+PWUhz10TJFSnagQQ
	UUqn72hbK0HuETzk/Uazan6W9j5tJG5p3v4TLW6PfupHh8tqdx8+pl1ZvRxOPNRA
	h7Zl7j03nYVFmNvkqAqTz+fKFGrS3hjiAHKb3GYTzaCeP/pJSsPjC5tCjVZY2z71
	MuEhvQ2a1wylTIf9djycZdLaW5aUkha6JooD4J2xYJKLojwQZzYWS6h2hJE/Ma5U
	5xbf8MrOHdZsM1BLDZwArvgUWSbBO5lmoe+MUDo1zS78wjCe6qvAHb+osYgr5WKU
	w3RSn/dhLssY6IG9FuiG3CGJ4JsP4617dLxD7u85yJgPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4de0u40c5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 20:06:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Apr 2026 20:06:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Apr 2026 20:06:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 73EB93F7055;
	Wed,  8 Apr 2026 20:06:54 -0700 (PDT)
Date: Thu, 9 Apr 2026 08:36:53 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: clarification: PCI device not getting enumerated
Message-ID: <adcXzcz2wWJFw4d7@rkannoth-OptiPlex-7090>
References: <abojekUtFrMxM1RB@rkannoth-OptiPlex-7090>
 <20260401193215.GA229749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260401193215.GA229749@bhelgaas>
X-Authority-Analysis: v=2.4 cv=KpN9H2WN c=1 sm=1 tr=0 ts=69d717d1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=Mma5G_rpxiGzhrjlnXEA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: TPmHKYeuoo_oeydzfh12obX5npgvy9Aw
X-Proofpoint-GUID: TPmHKYeuoo_oeydzfh12obX5npgvy9Aw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAyNCBTYWx0ZWRfX274VxwBUH/IY
 jkuNOWmcmFQeWqtbbLEIk0EevxwuHq+IcZzaN4sbD3yQC+Uxfa9MEYEDr+YVoP/TfzWgsLHX8A0
 SFw8aMQ1h32nhYj/S96CiDsl1voTe7nsQfOZmZqkvGD7gd9Ohq7aoRSQmr3jDlZOsObwL7iO3Dj
 SpJrE38MMPgdMh2sSKND5VmneT0DW1KQ3sNJji8cvznOckjmcqnld3TvxnwvRQfO2vekf+BiB3d
 ufRyXURHTfaI+8eqEjVoLSnDiVj5ypc1aAHxpsOFTx4LuLNQfyWd+2IOOGBAjC+hc+1F0HblKoT
 eNbh+ed7Fa8Svzil+tycdEH3vcq+w4M/s1l9qgMxO/yTdhIHghgDTJ02rCblf/nlteVBC2PawJ5
 qcm43S4rxOsdfFD7dUXO9gAgNMJIPDMwsMi1ut7ZVHKOoBpEZNeHWVEcnLcHPxqUdSJGGKVd3Gq
 hrk8JjKD1w47hSeiIvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01

On 2026-04-02 at 01:02:15, Bjorn Helgaas (helgaas@kernel.org) wrote:
> [+to Vidya, any thoughts on this?]

Bjorn, Vidya,

If i revert below 2 lines of code from commit 7246a4520b4bf1494d7d030166a11b5226f6d508,
PCI device gets enumerated.

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 45b71806182d..c96b2de163b5 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
        if (IS_ERR(cfg))
                return PTR_ERR(cfg);

-       /* Do not reassign resources if probe only */
-       if (!pci_has_flag(PCI_PROBE_ONLY))
-               pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
        bridge->sysdata = cfg;
        bridge->ops = (struct pci_ops *)&ops->pci_ops;
        bridge->msi_domain = true;

Commit message (7246a4520b4bf1494d7d030166a11b5226f6d508) says,

   " This also obviates the use of adding PCI_REASSIGN_ALL_BUS flag if
    !PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources() takes care
    of reassigning the resources that are not already claimed."

The statement says that PCI_REASSIGN_ALL_BUS is essentially redundant (unnecessary).
Let me know if there is any other side effects, else i can push a patch with these
two lines reverted.
