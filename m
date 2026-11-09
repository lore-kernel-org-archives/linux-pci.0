Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257348;
	b=YN0Q5lg+XWrhrpTCx9UbuOVMz42LuuB8oWJSihBX5ounnubJvscpLqsoHrwjKbbxZXa/
	 +yHXb40FoA0xm1IAYidyYztg3POBWoVUxekmiQbv6AwZN8tBGY38rmQWe0rFFQKawwPnt
	 erbVJ0HwKRzdjpp1Qm6A5OXg8BFquBAc4qd1NptsgLpa7ZykzmVTKgH7UiB68ia3RIP52
	 imbQN5IoBrudhL3+GPA/Cu8VJ4FQxkvCo/a+mWaQoU25WNLWSLRjVc8uKmtFhY1taZfen
	 DqWcYzzT45hExv/WfqIXPIhh6Kggy5ByV9TNoK2eDgz4KZqmMkqS19ktrGi9rYF3fLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257348;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XISjf9goHc7T2Sl6qjTz090Wgw3MK6CQaGX5dxqO5Ic=;
	b=X8hdWP3tBUKarq+6sWfdhwOHn2SPmqTLxCsPqWe72HIf8JzByEEmPAAHUOBommysfyVg
	 xLY+gQe90vi3SosXNwx8ZkC/ZPzmYkeY+0xx7lFWsnCnP2nZg+8qO19qwq83W2KWL+dgH
	 zVxNH4Xfu9b7QOY3cg6XiEE0Jlnql5eA5Y08t/jEs0rBiSZFH/QNwihz7LNJcuWR1jvFm
	 BaNvUcdNz08SSTREQust90n+W6wapKQHSVWKp0WnCoXBP8ZqZpCN22hE0gpJzYGkPGak9
	 VYqyXnqJ+p8ZOZIhfzzrPlu70GlF54NNZ1Pwrb4agPfRifJAXTKF/CCvtyORlYNtuag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Unev/XDB";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4011606A325;
	Mon,  9 Nov 2026 20:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4011606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Unev/XDB
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9HiCW5027289;
	Mon, 9 Nov 2026 20:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XISjf9
	goHc7T2Sl6qjTz090Wgw3MK6CQaGX5dxqO5Ic=; b=Unev/XDBbS/tKw3dZCjLwC
	bHT8k/20yGuv4wqKlfwmCg1mERBTRE69/EXMo4Lmii67gimtNJe9UjuKXZCHMNom
	1GoZV8SFLSTVwaZNas6TAvu4lmWaKs7YJyOXDukq1ou7dv8f5q1Tfa41Le1mYsJs
	oQCm3lPXT3zuIiT7owN+l44TodCzSa38StiDmebYnELcp9oyb3A/zTWnSGBq4NkW
	eOQsV90eVvugS9inRF1wj+8TdFY3OkQR9uyaKwAn/9L1P3VaV26wu3R6GyvkzGjk
	BrH8N9C2dBnJc4HDV0WQEMS/zGEgwCEz5Opihc7VpPqFLnE/bHs15Ui7B1fWHBPA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuruc4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 20:47:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9J0NRD427429;
	Mon, 9 Nov 2026 20:47:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq3psu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 20:47:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9KlhZl43254072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 20:47:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA7358054;
	Mon,  9 Nov 2026 20:47:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2927E58012;
	Mon,  9 Nov 2026 20:47:42 +0000 (GMT)
Received: from [9.61.242.246] (unknown [9.61.242.246])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 20:47:42 +0000 (GMT)
Message-ID: <114f0d44-3b01-4523-a99c-5654a3a556ba@linux.ibm.com>
Date: Mon, 9 Nov 2026 12:47:41 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/MSI: Initialize MSI-X descriptors in the setup loop
To: lirongqing <lirongqing@baidu.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@kernel.org>,
        Vivian Wang <wangruikang@iscas.ac.cn>,
        Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
        Yuanhe Shu <xiangzao@linux.alibaba.com>,
        Hans Zhang <18255117159@163.com>, Vidya Sagar <vidyas@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Juergen Gross <jgross@suse.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261109031411.2205-1-lirongqing@baidu.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20261109031411.2205-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX2t6L9V1etdr5
 /D9sBlQ5JUc7CNazPgJokKXEcHYxU95fZ0N6FAaP6Dr98B0kTuLmLVeHtQkbvn39E5FcsBjKff0
 YbVf21UrM7Qx1gnJ++fF+nNRqNyPEBA=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af23171 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=zuLzuavZAAAA:8
 a=mqgD3dJQ3uNcEhCF-SYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: od_lFLi87hxz3F77eNJU_-B99vaRVJvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX2AUZ4E1sy40I
 84OLvKjOOFkt0B739TNqSI4xFUAYXZMxet+XbZguhXot/cPEXOe6EzkU0DAKYIySGX0xL97bwS2
 hTbAfRe6AuarwrcIbHrxkO1NPC/QNVZecsooZbiWj79VOUjvDvTS5MhxWBCxktyIbIL9PVgSRw0
 sNyg8H8RmdrQ25zuh/CTqW/wMfjqipNeSw4lkmkvS9urFoVapz4mcvNFohC3OBDVdElj50QqPtr
 JcPN9e+d2xoKguSNX6mgx4hYTrvMtZCjUJHoXhdUmQIy0qTjHG9fkC0cbDEbw9xfcIBl97WWChC
 pz19sYU3qzNllOK2GhUaevAEqjdn6xwrFmAZjjDe0lBQy3/iPWgcTFXOzg/ueukHayEPER45DmU
 tuegi2dJXnBGvLXHShlbZ6eWnI1RMmrF3eiZdk62OPvTSzqE3vAe+fxYE5b9FET6S1cE1llUhbH
 pxF2ZsLx0SD0ivPyVCQ==
X-Proofpoint-ORIG-GUID: Aw92mHiaWDuz8Q02v92sGPveT14G9xv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090082

Hi Li,

On 11/8/2026 7:14 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> msix_setup_msi_descs() reuses a single stack descriptor for all
> MSI-X entries.
>
> Since msix_prepare_msi_desc() only sets can_mask for non-virtual
> descriptors, a virtual descriptor can inherit can_mask == 1 from
> the preceding real descriptor.
>
> As msi_domain_insert_msi_desc() copies the descriptor, this stale
> value can cause pci_msix_write_vector_ctrl() to access beyond the
> mapped MSI-X table.
>
> Clear the descriptor inside the loop to ensure each MSI-X entry
> starts with can_mask == 0.
>
> Fixes: 3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

I think at some point the can_mask attribute was set in the loop in 
msix_setup_msi_descs(). But this was split with commit 612ad43330d9 
("PCI/MSI: Split MSI-X descriptor setup"), so I think the Fixes tag 
should be applied against that commit?


> ---
>   drivers/pci/msi/msi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index a346284..681dd2f 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -638,9 +638,8 @@ static int msix_setup_msi_descs(struct pci_dev *dev, struct msix_entry *entries,
>   	struct irq_affinity_desc *curmsk;
>   	struct msi_desc desc;
>   
> -	memset(&desc, 0, sizeof(desc));
> -
>   	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
> +		memset(&desc, 0, sizeof(desc));

I wonder if we can just set can_mask = 0 in the loop rather doing the 
memset every iteration?

Thanks

Farhan

>   		desc.msi_index = entries ? entries[i].entry : i;
>   		desc.affinity = masks ? curmsk : NULL;
>   		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
