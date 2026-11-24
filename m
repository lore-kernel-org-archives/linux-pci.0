Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515962;
	b=nLhNzi2j5nLWjpnA2vxRbLBBjuvhtHOB1bQKgnuYYwGSdE9NCvmY19ec+qSrXQ19dN76
	 FCzYCFj1ktadrClgkwYIxi9HS5vp7rXgCbI/6okq5wytJUVHSTjLddsff4iATMOcVIlz1
	 HZZEnhEBi9T5FNPz9KHfirkZkQCf3VSXDvCUIY9HiBgL8M6r06S52fxZAxHuwXrIYMkqe
	 lnU8FGfzDVrjHgeYtSrT2Lr9LOtEk/LCseU7tktpQmuV91qNU9S0acUgMIH/A/YFGemwM
	 anfyVg56XG6IEu4NUd8aUdJpNXCDGhmntYJWQ/kF5nE8jPWCTQGWQArbYY8Wvq7YL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515962;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:Date:MIME-Version:User-Agent:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ppb1EHpkxbvkeggRpQgY95jSFgmFV3PzI9Lwdk5DQV8=;
	b=4yUHKHfvIKqpQIKbViKIApF3whOnb/T6yRkL040cWyT5VKnoLo95CBlmO69ViQGJpEB6
	 w7pFcBgw1cmWjWGDU1qxBTvLDQE8riGTsNkjMUrkQa/R2fHBi/LlpputaRJDLk69XqJyq
	 ILOqFkzKVUs3Bt/F3ArCzyWrJWo0/D45TFu24RH0gEZeT8zScAVjCRJeMjKi9f00RC9GL
	 MOpkRLi2X8ZQsqDmJhF3zs4O0xc3FT1KWye8vASJ9tu39NB/dF8WABLI0vheZz8p3gJ1X
	 Tu4HrYJg/Mx7oqqWeOHryGqfnScy2EVlnqKDqExkEagp8BfF+BpZ10nIuoQpNlTwrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="p/f6d5yS";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A0606A31E;
	Tue, 24 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 991A0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p/f6d5yS
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO34prW3826216;
	Tue, 24 Nov 2026 10:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ppb1EH
	pkxbvkeggRpQgY95jSFgmFV3PzI9Lwdk5DQV8=; b=p/f6d5ySt0WsJI8+63o4Ix
	PzNFWfPimc6YBcDYMGppCKvqbw2MEhMzmUMlwuU1OlvFv6gchHCt1xzixZwZOmxz
	jnXVeoTk6+z65NrkImjDZDKu6bi8ZgErGMiKKs1N1zC6w5Lqo2tUU7n679/gTuun
	3Y4Sba3y0kj+mPH0kXYVcXPDiOJdWMaeYjQuHJGH3af4YRGfkHQ1UbHfI2WhuWsw
	6H46ibw0OWKiTRik+ePa3MByamYvKRPhNTKbh/SvAEWknF54h2CP0SLX29URbHFZ
	G086L6vpD822wpAsSODcqmpApTGxF0IPTRvJN10Hg3rqmp4nSSTp2OHaJQ6WdPIw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g377r4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 10:25:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8lmug1669444;
	Tue, 24 Nov 2026 10:25:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3quft155-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 10:25:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOAPoWW27460174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 10:25:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE1D658055;
	Tue, 24 Nov 2026 10:25:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B3A75804B;
	Tue, 24 Nov 2026 10:25:48 +0000 (GMT)
Received: from [9.68.2.134] (unknown [9.68.2.134])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 10:25:48 +0000 (GMT)
Message-ID: <75ecf413a6b4fb0bd63c497c6158d905c7be0d08.camel@linux.ibm.com>
Subject: Re: [PATCH v1] PCI: Ignore Immediate Readiness for Samsung a826
 device
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lukas@wunner.de, mjrosato@linux.ibm.com,
        gbayer@linux.ibm.com, Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty
 <nj.shetty@samsung.com>,
        Judy Brock <judy.brock@samsung.com>
In-Reply-To: <20261123225006.GA1117350@bhelgaas>
References: <20261123225006.GA1117350@bhelgaas>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:24:46 +0100
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b056631 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=b3CbU_ItAAAA:8 a=VnNF1IyMAAAA:8 a=5cfTYtoU5gFdIZ-Mf1MA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX2hSX2b97P1xi
 vdcog0MZsxtuluu2SepdBKPAjZx8rK2NNfNh/hS4zqm89ktXQEwWxpbhvlHXj+/M+YNPEYoUT+F
 bqFve7Uja0ubcNCbrMPEJ4RsXNRLTcg=
X-Proofpoint-ORIG-GUID: CWBO14JG1GfsrE8nWMloMr56Ia7k87IW
X-Proofpoint-GUID: eHFWGVpvKwDRKFWIS0PkwxT56iRMWgc6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX5a1WWDUauVY/
 csaSY7Oe4n3iA8gb9BNyk/TnbmcVUcDQBhQJeoxrzHg0C4aL/OjIdeeBD0WfsrmdW0vcL3EhBOC
 ZOfrH+YXRANcKZ2Jqcqfolr+vosYb+13lf0fCtl4XtcT7mpfGo5rEFV7+zmKjzEO7ueoKJAAEpm
 yS93OOk6FwVaU6H3UFtUF9mb3FhaH/aM+mg/Vdwy/JZGyiNdGEy6hdSCaTdDjH5faLp8vabaCuH
 UKO58ZF2nlaGmDObFuI1YzDsswaOZbn/a6Wt3S34v4b2y5P75IjYdlL0PB4dpH1ih2oFL2UYjba
 2k2aUPyUNE2DyC9bs95Y5Tb8pr+RliJYAMTAsx/68ctSWWyZZRygDwTSnAzRqpuuK5jX1EZrfIE
 JqIaNNjW/XjubEE3OThO8Lo7BwZzzRRtzRQmIEQve0E3CEly1Pol7CG0uTZkXO53e4dzLF0WsOQ
 WqXSGPsyNOtsoclO6ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240039

On Mon, 2026-11-23 at 16:50 -0600, Bjorn Helgaas wrote:
> [+cc Kanchan, Nitesh, Judy (scraped from lore Samsung NVMe traffic)]
>=20
> On Mon, Nov 23, 2026 at 01:53:08PM -0800, Farhan Ali wrote:
> > The Samsung NVMe SSD Controller PM174x [144d:a826] advertises Immediate
> > Readiness, so pcie_flr() doesn't wait after FLR, but the device isn't r=
eady
> > yet and config reads return ~0 after the reset. This happens with
> > firmware version SNA6SNA6 or older.
> >=20
> > This was seen on s390x with the nvme driver bound, by resetting the dev=
ice
> > via the sysfs reset attribute:
> >=20
> >   # echo 1 > /sys/bus/pci/devices/200c:00:00.0/reset
> >=20
> >   nvme 200c:00:00.0: Unable to change power state from D3cold to D0, de=
vice inaccessible
> >   nvme nvme0: Disabling device after reset failure: -19
> >=20
> > Ignore Immediate Readiness on this device too, so pcie_flr() waits.
> >=20
> > Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs=
")
> > Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4a02fc80755d..11c3b45afe78 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5790,6 +5790,7 @@ static void quirk_no_imm_ready(struct pci_dev *de=
v)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_re=
ady);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_re=
ady);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80e, quirk_no_imm_re=
ady);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa826, quirk_no_imm_re=
ady);
>=20
> We already have:
>=20
>   996a59519af2 ("PCI: Ignore Immediate Readiness on Samsung PM9D3a NVMe")
>   0f8b5d90d179 ("PCI: Ignore Immediate Readiness on Samsung 990 PRO and 9=
90 EVO Plus NVMe")
>=20
> I wonder if something like the below might be safer and avoid an
> ongoing series of quirks.
>=20
> The spec (PCIe r7.0, sec 7.5.1.1.4) says that when Immediate Readiness
> is set, "the Function is guaranteed to be ready to successfully
> complete valid Configuration Requests at any time" and "software is
> exempt from all requirements to *delay configuration accesses*
> following any type of reset."
>=20
> I thought that meant Completions for config requests would always have
> Successful Completion status, but I guess one could read it as "device
> must respond with a Completion to an access immediately after reset,
> even if the Completion is RRS."

From our testing and also as mentioned in the cover letter[0] of
0f8b5d90d179 ("PCI: Ignore Immediate Readiness on Samsung 990 PRO and
990 EVO Plus NVMe") Samsung did fix newer firmware to exhibit the
behavior the current Linux code expects.=C2=A0

That said, I tested the change you propose and this too fixes the
problem for me on s390 and it's certainly cleaner than a bunch of
quirks. I also made sure that we don't get otherwise failed reads which
we then turned into 0xff=E2=80=A6f, so it looks like the device is indeed
completing immediately just with RRS. And yes, I can see how one could
read the Spec like that though I too would have read it to mean
Successful Completion.

Feel free to add:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas

[0]
https://lore.kernel.org/linux-pci/20261011163249.18479-1-gruhlke@mailbox.or=
g/
