Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325516;
	b=Lur8lYadiCzC9taTM37bmKb+yIxW+eoK5TzR7/f+pXApLfRw7Vc65Ho/5Jz0iCIsb/yw
	 gh7VL9N1lgqXUA/+kvy5hg+Me/ZAWd+5xyX645M//F5F5NGwodAy4KQmDlSjvWSqUxPm8
	 kMR7LMnycH4YQHskPvd8eGIfXNSYkpluH7c98g+F3PTufrc+VQrWPtkR8OJQiYgxkYc3v
	 ecdAv52wysfs0lnk+WW1TZDxJigfjJSCAFl2Y051HL1MnPWCPqfWXNVFOq0rw4iRODGSd
	 MfEOfpyG/WUxafnhSQdisqqC0h2SD+FWsRFRzcCPxY23laMFAAC22S28v2dch9owK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325516;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ur06BcCoPVFOLLgbWWBjmYM6+1B0Y/FtOISCDS4o+nQ=;
	b=kKB549MmRH1zJ1nC9hmD/mqOQn/0szLwlGB7T1pYoxUh4jqrbwk0fr+eOB0RUO5LQIVX
	 x2biXUgdG8bsNoCgUEklUwvrRyaKRc+QCxn6AIqJsF01H3j5c03Cp2loX1uHeNO5X5Okc
	 YcXJOdXzC1qfNH/ePBuwFtFL0ZUr00Sj+wNF6NMc+w0ROs9QA7BGjkELelgr2gFxDh7/j
	 mHxuiOFmoLyCy/Dlpje1zcsCMPc88ReQF3ERYLt3lu2/osQqk/ma3HHprvpSnGvi8HCLU
	 T18RUwv3tBIOsZSkRxioLb8ozUSXhUopf0vAuQcb4o21Sz0sItup66RHwF2et38tjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nb9BYZvc;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAB606A338;
	Tue, 10 Nov 2026 15:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34AAB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nb9BYZvc
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFERNe2865033;
	Tue, 10 Nov 2026 15:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ur06Bc
	CoPVFOLLgbWWBjmYM6+1B0Y/FtOISCDS4o+nQ=; b=Nb9BYZvcDmIF++N47KyGQ6
	sV6OXVOFSzByu10U9mrAyJCsnBmQoPd8nBl7TCjB/OvVR6iQ9lalHJaMyTGdXJVI
	6PEaP9QAMADVWE1Y9dK3TF88PSj8on0OzMQcmit08o05EMI9MuQALgZLn/iXviFu
	2YhH8pxnKoPtA8uvVSHCQ0Bni+0S5g0JGWzlCFL9t8CNXlmPU/k4ExDShf8JsM07
	AjuphtviU/o9ja+oEa4vuEn+GKCBGZ6Sh7buJ/q/4s2fqLTtYbeodYjgGOI1huaR
	wfXz4dVAicdK5nsjUJk7OSb+Dr7ksZjLEXr2JGQiQRqBfK6C4Pk8MDru/JdUF6/Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug65qyw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 15:44:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF4ukE1880658;
	Tue, 10 Nov 2026 15:44:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3320nkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 15:44:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAFisKm21103336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 15:44:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B8FC58061;
	Tue, 10 Nov 2026 15:44:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3308F58058;
	Tue, 10 Nov 2026 15:44:53 +0000 (GMT)
Received: from [9.111.22.168] (unknown [9.111.22.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 15:44:52 +0000 (GMT)
Message-ID: <81a1fed9c86e3954b1807f7425f98d210503a28f.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: pciehp: Fix NULL pointer dereference in
 pciehp_configure_device()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Lukas Wunner <lukas@wunner.de>, Priyank Rathod
 <rathodpriyank@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ricky Wu <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <avLsH4a-l_uxlWfU@wunner.de>
References: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com>
	 <sashiko-outbox-168676@kernel.org>
	 <20261109215339.1841223-1-rathodpriyank@google.com>
	 <avLsH4a-l_uxlWfU@wunner.de>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:43:52 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _xJ1m2a1Svgy2rQpS3gtq5qcrweH-1MM
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af33bf8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=AhZ-bqvTIkWdB_Qqr3QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5qnxxBCVhhvRX37NEybGtZxpNOlEjox1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MiBTYWx0ZWRfX82Los6COhTQB
 vpuPlQLuQVZ803DmSRs7ASKbHYoYJM7KbYmGWJ7Hwmrsg6rw+Ifek5+e96BNNN8uEuUkqgyGaxi
 7T8q1pNYt4rz73PKR1vpixgcA+T726DxY8xx0Fjt/RxhhwbeE1mJnNO//JASlvL4r7rxoNCAkmO
 MVMQWZCc7zcHTrDWyaIUpuv9K4U0D0PHXaGExfRq7ZQDj1MKG5eI2RXUjdyM2qLYrgWVIvD6Ygy
 QZXBhptuBRxqgUtDwZYtu6ulxEgnfs79x5pYb+qBXc/7BFzI6l3tjo6NBMLm7EkBTPml29/4sM1
 718OzpaVN9+fa0Ev/WHlnRVNK4woUYOCx3I1Gig9WGo/HrGgqeDl3d8L8jWihhZzv/iGP2rPHJy
 HORfiK2Uqy64C9+VguPfgvDFbZfKJO2jOP6NgNpq21zphTRJ+XolfQyyoU+8ty5vx5ZyZGWBhPV
 /hupKDOAL8IhxbDCg1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MiBTYWx0ZWRfX09NMx5N0fJ5v
 pK2NCx5KU0eaZaJFLvdFfn9TEUKhiIy9h1qfzS4OVmqtdXMqZ+Geok2ME4FPz15ubDjh++6E+K+
 wPM0ltcUI1/XW1PNrvp9M34DSwZVwPM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100062

On Tue, 2026-11-10 at 11:04 +0100, Lukas Wunner wrote:
> On Mon, Nov 09, 2026 at 09:53:38PM +0000, Priyank Rathod wrote:
> > On Mon, Oct 12, 2026 at 10:16:29PM +0000, sashiko-bot@kernel.org wrote:
> > > While this allows devices without Function 0 to be successfully hot-a=
dded,
> > > will it lead to spurious teardowns upon system resume?
> > ...
> > > Could this spurious teardown issue be avoided by modifying
> > > pciehp_device_replaced() to handle missing Function 0 devices correct=
ly?
> [...]
> > Regarding the bot's question above: pciehp assumes Function 0
> > (PCI_DEVFN(0, 0)) represents an occupied slot across all four of its
> > lookup sites -- the -EEXIST check at the top of
> > pciehp_configure_device(), pcie_init(), pciehp_device_replaced(), and
> > the DSN read at the end of pciehp_configure_device() (consistent with
> > PCIe r6.3 sec 7.9.3 requiring Multi-Function Devices implementing DSN t=
o
> > expose it on Function 0).
>=20
> I'm not even sure whether pciehp is actually used with jailhouse,
> s390 or loongarch.  pciehp assumes in multiple places that function 0
> is present, so guarding against a missing function 0 in a single place
> doesn't really make sense.
>=20
> Note that there's a patch pending which moves the cached dsn from
> pciehp's struct controller to struct pci_dev, so the days are numbered
> for the lines you're changing:
>=20
> https://lore.kernel.org/r/20260902133933.2992457-7-terry.bowman@amd.com/
>=20
> Are you actually observing a crash in practice because of a missing NULL
> pointer check?
>=20
> Thanks,
>=20
> Lukas

FWIW we (s390) do not use pciehp we use our own s390_pci_hpc for
hotplug. I'd be interested if this comes out of a real issue or just an
LLM worry too though.

Thanks,
Niklas
